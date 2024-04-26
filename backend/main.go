package main

import (
	"context"
	"fmt"
	"os"
	"os/signal"
	"time"

	"github.com/go-playground/validator/v10"
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/compress"
	"github.com/gofiber/fiber/v2/middleware/cors"
	"github.com/gofiber/fiber/v2/middleware/etag"
	"github.com/gofiber/fiber/v2/middleware/healthcheck"
	"github.com/gofiber/fiber/v2/middleware/helmet"
	"github.com/gofiber/fiber/v2/middleware/limiter"
	"github.com/gofiber/fiber/v2/middleware/logger"
	"github.com/joho/godotenv"
	"github.com/monzim/go_starter/cmd/app/handler"
	core_handler "github.com/monzim/go_starter/cmd/app/handler/core"
	"github.com/monzim/go_starter/internal/app/util"
	db "github.com/monzim/go_starter/internal/database"
	core_repo "github.com/monzim/go_starter/internal/repository/core"
	cValidator "github.com/monzim/go_starter/pkg/validator"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
)

var (
	port = 8080
)

const version = "__gq0.0.1"

func get_port() string {
	port := fmt.Sprintf(":%d", port)
	if val, ok := os.LookupEnv("FUNCTIONS_CUSTOMHANDLER_PORT"); ok {
		log.Info().Msgf("Port: %s", val)
		port = ":" + val
	}

	log.Info().Msgf("Port: %s", port)
	return port
}

func init() {
	log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stderr})
	log.Info().Msg("Starting server...")
	log.Info().Msgf("Version: %s", version)
	err := godotenv.Load()
	if err != nil {
		log.Error().Err(err).Msg("Error loading .env file")
	}

	if util.IsDevelopment() {
		zerolog.SetGlobalLevel(zerolog.DebugLevel)
	} else {
		zerolog.SetGlobalLevel(zerolog.InfoLevel)
	}
}

func main() {
	ctx, cancel := signal.NotifyContext(context.Background(), os.Interrupt, os.Kill)
	defer cancel()

	postgres, err := db.NewDatabaseConnection(&db.DatabaseConfig{
		DATABASE_URI: os.Getenv("DATABASE_URI"),
	})
	if err != nil {
		log.Error().Err(err).Msg("Error initializing the database connection")

	}

	redis, err := db.NewRedisConnection(&db.RedisConfig{
		RedisURI: os.Getenv("REDIS_URI"),
	}, ctx)
	if err != nil {
		log.Error().Err(err).Msg("Error initializing the redis connection")
	}

	if util.IsDevelopment() {
		err = db.Migrate(postgres)
		if err != nil {
			log.Fatal().Err(err).Msg("Error migrating the database")
		}
	}

	app := fiber.New(fiber.Config{
		AppName:      "go_starter",
		ServerHeader: "go_starter.monzim.com",
		IdleTimeout:  30 * time.Second,
		ReadTimeout:  30 * time.Second,
	})

	app.Use(etag.New())
	log.Info().Msg(os.Getenv("ALLOWED_ORIGINS"))
	app.Use(cors.New(cors.Config{
		AllowOrigins: os.Getenv("ALLOWED_ORIGINS"),
		AllowHeaders: "Origin, Content-Type, Accept",
	}))

	app.Use(limiter.New(limiter.Config{
		Max:        100,
		Expiration: 60 * time.Second,
	}))

	app.Use(logger.New(logger.Config{
		Format: "[${ip}]:${port} ${status} - ${method} ${path}\n",
	}))

	app.Use(compress.New(compress.Config{
		Level: compress.LevelBestSpeed,
	}))

	validate := validator.New()
	validate.RegisterValidation("ISO8601date", cValidator.ISO8601date)

	api := app.Group("api")
	v1 := api.Group("/v1")

	api.Use(healthcheck.New())
	api.Use(helmet.New())

	app.Get("", func(c *fiber.Ctx) error {
		return c.SendString("Welcome to go_starter API! current time is" + time.Now().String())
	})

	handlr := handler.CreateHandler(validate)
	coreRepo := core_repo.NewCoreRepository(postgres)

	var conf core_handler.SpecificCong

	conf.MapBoxPublicKey = os.Getenv("MAPBOX_PUBLIC_KEY")
	conf.WeatherApiKey = os.Getenv("WEATHER_API_KEY")
	apiHandler := core_handler.NewApiHandler(&handlr, coreRepo, &conf)
	apiHandler.SetupRoutes(&v1)

	printRoutes(app)

	ch := make(chan error, 1)
	go func() {
		err := app.Listen(get_port())
		if err != nil {
			ch <- err
		}

		close(ch)
	}()

	select {
	case err := <-ch:
		log.Error().Err(err).Msg("Error starting the server")
	case <-ctx.Done():
		log.Info().Msg("Shutting down the server...")
		redis.Close()
		if err := app.Shutdown(); err != nil {
			log.Error().Err(err).Msg("Error shutting down the server")
		}

	}

}

func printRoutes(app *fiber.App) {
	if !util.IsDevelopment() {
		return
	}

	log.Info().Msg("Available routes:")
	for _, route := range app.GetRoutes() {

		if route.Method == "GET" || route.Method == "POST" || route.Method == "PUT" || route.Method == "DELETE" {
			log.Info().Msgf("| %s | --> %s", route.Method, route.Path)
		}

	}
}

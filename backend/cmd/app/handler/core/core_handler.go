package core_handler

import (
	"github.com/gofiber/fiber/v2"
	"github.com/monzim/go_starter/cmd/app/handler"
	core_repo "github.com/monzim/go_starter/internal/repository/core"
)

type SpecificCong struct {
	MapBoxPublicKey string
	WeatherApiKey   string
}

type ApiHandler struct {
	hdlr *handler.Handler
	repo *core_repo.CoreRepository
	conf *SpecificCong
}

func NewApiHandler(handlr *handler.Handler, repo *core_repo.CoreRepository, conf *SpecificCong) ApiHandler {
	return ApiHandler{hdlr: handlr, repo: repo, conf: conf}
}

func (r *ApiHandler) SetupRoutes(route *fiber.Router) {
	base := (*route).Group("/")

	base.Get("/ping", r.Ping)
	// base.Get("/location-name", r.fetch_location_name)
	base.Get("/fetch-by-radius", r.fetch_place_by_radious)
	base.Get("/fetch-by-others", r.fetch_by_others)
	base.Post("/add-location", r.add_new_location)
	base.Post("/add-review", r.add_comment)
	base.Post("/add-experience", r.add_experience)

}

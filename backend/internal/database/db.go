package db

import (
	zLog "github.com/rs/zerolog/log"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

type DatabaseConfig struct {
	DATABASE_URI string
}

func NewDatabaseConnection(config *DatabaseConfig) (*gorm.DB, error) {
	dsn := config.DATABASE_URI
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{
		Logger: logger.Default.LogMode(logger.Warn),
	})

	if err != nil {
		return nil, err
	}

	zLog.Info().Msg("Database connection established")
	return db, nil

}

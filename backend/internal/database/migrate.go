package db

import (
	"github.com/monzim/go_starter/internal/model"
	"github.com/rs/zerolog/log"
	"gorm.io/gorm"
)

func Migrate(db *gorm.DB) error {
	log.Info().Msg("Migrating the database...")

	err := db.AutoMigrate(
		model.GeoLocation{},
		model.GeoLocationReview{},
		model.GeoTravelExperience{},
	)
	if err != nil {
		return err
	}

	log.Info().Msg("Database migration completed")

	log.Info().Msg("Database setup completed")
	return nil
}

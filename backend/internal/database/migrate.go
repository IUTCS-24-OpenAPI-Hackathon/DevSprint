package db

import (
	"github.com/rs/zerolog/log"
	"gorm.io/gorm"
)

func Migrate(db *gorm.DB) error {
	log.Info().Msg("Migrating the database...")

	err := db.AutoMigrate()
	if err != nil {
		return err
	}

	log.Info().Msg("Database migration completed")

	log.Info().Msg("Database setup completed")
	return nil
}

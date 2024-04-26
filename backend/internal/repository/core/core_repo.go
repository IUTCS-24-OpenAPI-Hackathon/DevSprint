package core_repo

import (
	"encoding/json"

	"github.com/monzim/go_starter/internal/app/util"
	"github.com/monzim/go_starter/internal/model"
	"github.com/rs/zerolog/log"
	"gorm.io/gorm"
)

type CoreRepository struct {
	db *gorm.DB
}

func NewCoreRepository(db *gorm.DB) *CoreRepository {
	return &CoreRepository{db: db}
}

type ICoreRepository interface {
	SaveGeoLocation(lat, lng float64) error
}

func (c *CoreRepository) SaveGeoLocation(feat model.Feature) error {
	geoHash := util.GeoHashEncode(feat.Properties.Coordinates.Latitude, feat.Properties.Coordinates.Longitude)
	fbBytes, err := json.Marshal(feat)
	if err != nil {
		log.Error().Err(err).Msg("failed to marshal features")
	}

	geoLocation := &model.GeoLocation{
		GeoHash:   geoHash,
		Latitude:  feat.Properties.Coordinates.Latitude,
		Longitude: feat.Properties.Coordinates.Longitude,
		PlaceName: feat.Properties.Name,
		Country:   feat.Properties.Context.Country.Name,
		RawData:   fbBytes,
	}

	var existingGeoLocation model.GeoLocation
	if err := c.db.Where("geo_hash = ?", geoHash).First(&existingGeoLocation).Error; err != nil {
		if err == gorm.ErrRecordNotFound {
			if err := c.db.Create(geoLocation).Error; err != nil {
				return err
			}
		} else {
			log.Error().Err(err).Msg("failed to get geo location")
			return err
		}

	} else {
		log.Info().Msgf("GeoLocation already exists: %s", geoHash)
		return nil
	}

	log.Info().Msgf("GeoLocation saved: %s", geoHash)
	return nil
}

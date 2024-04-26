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
	GetLocationInfoByRadius(lat, lng float64, radius float64) ([]model.Feature, error)
	GetLocationInfoByLocationName(locationName string) ([]model.Feature, error)
}

func (c *CoreRepository) GetLocationInfoByLocationName(query string) ([]model.Feature, error) {
	var geoLocations []model.GeoLocation

	err := c.db.
		Model(&model.GeoLocation{}).
		Where("place_name ILIKE ? OR country ILIKE ?", "%"+query+"%", "%"+query+"%").
		Unscoped().
		Distinct().
		Find(&geoLocations).Error

	if err != nil {
		log.Error().Err(err).Msg("failed to get geo locations")
		return nil, err
	}

	var features []model.Feature
	for _, geoLocation := range geoLocations {
		var feat model.Feature

		if err := json.Unmarshal(geoLocation.RawData, &feat); err != nil {
			log.Error().Err(err).Msg("failed to unmarshal geo location")
			return nil, err
		}

		features = append(features, feat)
	}

	if len(features) > 0 {
		return features, nil
	}

	return []model.Feature{}, nil

}

func (c *CoreRepository) GetLocationInfoByRadius(lat, lng float64, radius float64, limit int) ([]model.Feature, error) {
	var geoLocations []model.GeoLocation
	radius_meter := radius * 1000

	log.Info().Msgf("Searching for locations within %f meters", radius_meter)

	query := c.db.Model(&model.GeoLocation{}).Select("*").
		Where("ST_DWithin(ST_MakePoint(?, ?)::geography, ST_MakePoint(longitude, latitude)::geography, ?)", lng, lat, radius_meter)

	if err := query.Find(&geoLocations).Error; err != nil {
		log.Error().Err(err).Msg("failed to get geo locations")
		return nil, err
	}

	var features []model.Feature
	for _, geoLocation := range geoLocations {
		var feat model.Feature

		if err := json.Unmarshal(geoLocation.RawData, &feat); err != nil {
			log.Error().Err(err).Msg("failed to unmarshal geo location")
			return nil, err
		}

		features = append(features, feat)
	}

	if len(features) > 0 {
		return features, nil
	}

	return []model.Feature{}, nil
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
		// if err := c.db.Model(&existingGeoLocation).Updates(geoLocation).Error; err != nil {
		// 	return err
		// }

		return nil
	}

	log.Info().Msgf("GeoLocation saved: %s", geoHash)
	return nil
}

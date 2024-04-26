package core_repo

import (
	"encoding/json"
	"fmt"
	"sync"

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
	GetLocationsInfoByRadius(lat, lng float64, radius float64) ([]model.Feature, error)
	GetLocationsInfoByLocationName(locationName string) ([]model.Feature, error)

	AddNewReview(comment model.GeoLocationReview) error
	AddNewExperience(experience model.GeoTravelExperience) error
}

func (c *CoreRepository) AddNewExperience(lat, long float64, experience string) error {
	geoHash := util.GeoHashEncode(lat, long)

	// check if location exists
	var geoLocation model.GeoLocation
	if err := c.db.Where("geo_hash = ?", geoHash).First(&geoLocation).Error; err != nil {
		if err == gorm.ErrRecordNotFound {
			log.Error().Msg("location not found")
			return fmt.Errorf("location not found with geo hash")
		}

		log.Error().Err(err).Msg("failed to get geo location")
		return err
	}

	// save experience
	exp := model.GeoTravelExperience{
		GeoHash:    geoHash,
		Experience: experience,
	}

	if err := c.db.Create(&exp).Error; err != nil {
		log.Error().Err(err).Msg("failed to save experience")
		return err
	}

	return nil
}

func (c *CoreRepository) AddNewReview(lat, long float64, review string, rate int) error {
	geoHash := util.GeoHashEncode(lat, long)

	// check if location exists
	var geoLocation model.GeoLocation
	if err := c.db.Where("geo_hash = ?", geoHash).First(&geoLocation).Error; err != nil {
		if err == gorm.ErrRecordNotFound {
			log.Error().Msg("location not found")
			return fmt.Errorf("location not found with geo hash")
		}

		log.Error().Err(err).Msg("failed to get geo location")
		return err
	}

	// save review
	comment := model.GeoLocationReview{
		GeoHash: geoHash,
		Review:  review,
		Rating:  rate,
	}

	if err := c.db.Create(&comment).Error; err != nil {
		log.Error().Err(err).Msg("failed to save comment")
		return err
	}

	return nil
}

func (c *CoreRepository) GetLocationsInfoByLocationName(query string) ([]model.Feature, error) {
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

	// get reviews and experiences
	wg := sync.WaitGroup{}
	for i := range features {
		wg.Add(1)
		go func(i int) {
			defer wg.Done()

			_hash := util.GeoHashEncode(features[i].Properties.Coordinates.Latitude, features[i].Properties.Coordinates.Longitude)
			reviews, experiences, err := c.getReviewsAndExperiences(_hash)
			if err != nil {
				log.Error().Err(err).Msg("failed to get reviews and experiences")
			}

			if len(reviews) > 0 {
				features[i].Reviews = reviews
			} else {
				features[i].Reviews = []model.GeoLocationReview{}
			}

			if len(experiences) > 0 {
				features[i].Experiences = experiences
			} else {
				features[i].Experiences = []model.GeoTravelExperience{}
			}
		}(i)
	}

	wg.Wait()

	if len(features) > 0 {
		return features, nil
	}

	return []model.Feature{}, nil

}

type CombineData struct {
	Features    []model.Feature `json:"features"`
	Reviews     []model.GeoLocationReview
	Experiences []model.GeoTravelExperience
}

func (c *CoreRepository) GetLocationsInfoByRadius(lat, lng float64, radius float64, limit int) ([]model.Feature, error) {
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

	// get reviews and experiences
	wg := sync.WaitGroup{}
	for i := range features {
		wg.Add(1)
		go func(i int) {
			defer wg.Done()

			_hash := util.GeoHashEncode(features[i].Properties.Coordinates.Latitude, features[i].Properties.Coordinates.Longitude)
			reviews, experiences, err := c.getReviewsAndExperiences(_hash)
			if err != nil {
				log.Error().Err(err).Msg("failed to get reviews and experiences")
			}

			if len(reviews) > 0 {
				features[i].Reviews = reviews
			} else {
				features[i].Reviews = []model.GeoLocationReview{}
			}

			if len(experiences) > 0 {
				features[i].Experiences = experiences
			} else {
				features[i].Experiences = []model.GeoTravelExperience{}
			}
		}(i)
	}

	wg.Wait()

	if len(features) > 0 {
		return features, nil
	}

	return []model.Feature{}, nil
}

func (c *CoreRepository) getReviewsAndExperiences(geoHash string) ([]model.GeoLocationReview, []model.GeoTravelExperience, error) {
	var wg sync.WaitGroup
	var reviews []model.GeoLocationReview
	var experiences []model.GeoTravelExperience
	var reviewErr, experienceErr error

	wg.Add(2)

	go func() {
		defer wg.Done()
		if err := c.db.Where("geo_hash = ?", geoHash).Find(&reviews).Error; err != nil {
			reviewErr = err
			log.Error().Err(err).Msg("failed to get reviews")
		}
	}()

	go func() {
		defer wg.Done()
		if err := c.db.Where("geo_hash = ?", geoHash).Find(&experiences).Error; err != nil {
			experienceErr = err
			log.Error().Err(err).Msg("failed to get experiences")
		}
	}()

	wg.Wait()

	if reviewErr != nil {
		return nil, nil, reviewErr
	}

	if experienceErr != nil {
		return reviews, nil, experienceErr
	}

	return reviews, experiences, nil
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

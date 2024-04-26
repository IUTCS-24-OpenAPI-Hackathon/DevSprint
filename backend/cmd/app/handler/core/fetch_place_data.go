package core_handler

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"sync"

	"github.com/gofiber/fiber/v2"
	"github.com/monzim/go_starter/internal/model"
	"github.com/rs/zerolog/log"
)

type place_data_request struct {
	Limit     int     `json:"limit"`
	Radius    float64 `json:"radious_km"`
	Category  string  `json:"canonical_id" validate:"required"`
	Longitude float64 `json:"longitude" validate:"required"`
	Latitude  float64 `json:"latitude" validate:"required"`
}

func (r *ApiHandler) getLocationInfoFromApi(Category string, limit int, Longitude, Latitude float64) ([]model.Feature, error) {

	resp, err := http.Get(fmt.Sprintf("https://api.mapbox.com/search/searchbox/v1/category/%s?access_token=%s&language=en&limit=%d&proximity=%f,%f&", Category, r.conf.MapBoxPublicKey, limit, Longitude, Latitude))
	if err != nil {
		log.Error().Err(err).Msg("failed to send request to map box")
		return nil, err
	}

	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		log.Error().Msgf("Error while sending request to map box: %d", resp.StatusCode)
		return nil, fmt.Errorf("Error while sending request to map box")
	}

	var resBodyBytes []byte
	resBodyBytes, err = io.ReadAll(resp.Body)
	if err != nil {
		log.Error().Err(err).Msg("Error while reading response body")
	}

	var res model.MapBoxFeaturesRes
	if err := json.Unmarshal(resBodyBytes, &res); err != nil {
		log.Error().Err(err).Msg("Error while unmarshalling response")
		return nil, err
	}

	return res.Features, nil
}

func (r *ApiHandler) getLocationInfoFromApiAndSaveToDB(categories []string, limit int, Longitude, Latitude float64) ([]model.Feature, error) {
	var db_features []model.Feature

	var wg1 sync.WaitGroup
	for i := range categories {
		wg1.Add(1)
		go func(i int) {
			defer wg1.Done()
			res, err := r.getLocationInfoFromApi(categories[i], limit, Longitude, Latitude)
			if err != nil {
				log.Error().Err(err).Msg("failed to get location info from api")
			} else {
				db_features = append(db_features, res...)
			}
		}(i)
	}

	wg1.Wait()

	// save the data to db
	var wg sync.WaitGroup
	for i := range db_features {
		wg.Add(1)
		go func(i int) {
			defer wg.Done()
			if err := r.repo.SaveGeoLocation(db_features[i]); err != nil {
				log.Error().Err(err).Msg("failed to save geo location")
			}
		}(i)
	}

	wg.Wait()

	return db_features, nil
}

func (r *ApiHandler) fetch_place_by_radious(c *fiber.Ctx) error {
	var body place_data_request

	if er := c.BodyParser(&body); er != nil {
		return sendResponse(c, Error, er.Error())
	}

	var _limit int
	if body.Limit == 0 {
		_limit = 5
	} else {
		_limit = body.Limit
	}

	categories := []string{body.Category}
	_, err := r.getLocationInfoFromApiAndSaveToDB(categories, _limit, body.Longitude, body.Latitude)
	if err != nil {
		log.Error().Err(err).Msg("failed to get location info from api and save to db")
		return sendResponse(c, Error, err.Error())
	}

	db_features, err := r.repo.GetLocationsInfoByRadius(body.Latitude, body.Longitude, body.Radius, _limit)
	if err != nil {
		log.Error().Err(err).Msg("failed to get location info by radius")
	}

	var wg sync.WaitGroup
	for i := range db_features {
		wg.Add(1)
		go func(i int) {
			defer wg.Done()
			weatherRes, err := r.getWeatherInfo(db_features[i].Properties.Coordinates.Latitude, db_features[i].Properties.Coordinates.Longitude)
			if err != nil {
				log.Error().Err(err).Msg("failed to get weather info")
			} else {
				db_features[i].Weather = *weatherRes
			}
		}(i)
	}

	wg.Wait()
	return sendResponse(c, Success, db_features)

}

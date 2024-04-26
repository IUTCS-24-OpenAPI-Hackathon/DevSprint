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
	Category  string  `json:"canonical_id" validate:"required"`
	Longitude float64 `json:"longitude" validate:"required"`
	Latitude  float64 `json:"latitude" validate:"required"`
}

func (r *ApiHandler) fetch_place_data(c *fiber.Ctx) error {
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

	// maxLat, maxLong := util.MaxLatLngInRadius(body.Latitude, body.Longitude, float64(body.Radios))

	resp, err := http.Get(fmt.Sprintf("https://api.mapbox.com/search/searchbox/v1/category/%s?access_token=%s&language=en&limit=%d&proximity=%f,%f&", body.Category, r.conf.MapBoxPublicKey, _limit, body.Longitude, body.Latitude))
	if err != nil {
		log.Error().Err(err).Msg("failed to send request to map box")
		return sendResponse(c, Error, "failed to send request to map box")
	}

	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		log.Error().Msgf("Error while sending request to map box: %d", resp.StatusCode)
		return sendResponse(c, Error, "Error while sending request to map box")
	}

	var resBodyBytes []byte
	resBodyBytes, err = io.ReadAll(resp.Body)
	if err != nil {
		log.Error().Err(err).Msg("Error while reading response body")
	}

	var res model.MapBoxFeaturesRes
	if err := json.Unmarshal(resBodyBytes, &res); err != nil {
		log.Error().Err(err).Msg("Error while unmarshalling response")
		return sendResponse(c, Error, "Error while unmarshalling response")
	}

	// // convert the features to a jsonstring
	// features, err := json.Marshal(res.Features)
	// if err != nil {
	// 	log.Error().Err(err).Msg("failed to marshal features")
	// }

	// get the location hospital, atm, hospital also

	// save the data to db
	var wg sync.WaitGroup
	for i := range res.Features {
		wg.Add(1)
		go func(i int) {
			defer wg.Done()
			if err := r.repo.SaveGeoLocation(res.Features[i]); err != nil {
				log.Error().Err(err).Msg("failed to save geo location")
			}
		}(i)
	}

	// get the location data based on the coordinates rounded

	// for i := range res.Features {
	// 	wg.Add(1)
	// 	go func(i int) {
	// 		defer wg.Done()
	// 		weatherRes, err := r.getWeatherInfo(res.Features[i].Properties.Coordinates.Latitude, res.Features[i].Properties.Coordinates.Longitude)
	// 		if err != nil {
	// 			log.Error().Err(err).Msg("failed to get weather info")
	// 		} else {
	// 			res.Features[i].Weather = *weatherRes
	// 		}
	// 	}(i)
	// }
	// wg.Wait()

	return sendResponse(c, Success, res.Features)

}

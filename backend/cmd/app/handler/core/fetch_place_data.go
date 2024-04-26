package core_handler

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"

	"github.com/gofiber/fiber/v2"
	"github.com/monzim/go_starter/internal/model"
	"github.com/rs/zerolog/log"
)

type place_data_request struct {
	Category  string  `json:"canonical_id" validate:"required"`
	Radios    int     `json:"radios" validate:"required"`
	Longitude float64 `json:"longitude" validate:"required"`
	Latitude  float64 `json:"latitude" validate:"required"`
}

func (r *ApiHandler) fetch_place_data(c *fiber.Ctx) error {
	var body place_data_request

	if er := c.BodyParser(&body); er != nil {
		return sendResponse(c, Error, er.Error())
	}

	// maxLat, maxLong := util.MaxLatLngInRadius(body.Latitude, body.Longitude, float64(body.Radios))

	resp, err := http.Get(fmt.Sprintf("https://api.mapbox.com/search/searchbox/v1/category/%s?access_token=%s&language=en&limit=15&proximity=%f,%f&", body.Category, r.conf.MapBoxPublicKey, body.Longitude, body.Latitude))
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

	for i := range res.Features {
		res.Features[i].ID = fmt.Sprintf("%d", i)
	}

	// get the weather info about the places

	return sendResponse(c, Success, res.Features)

}

package core_handler

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"

	"github.com/gofiber/fiber/v2"
	"github.com/rs/zerolog/log"
)

type fetch_location_name_request struct {
	Longitude float64 `json:"longitude" validate:"required"`
	Latitude  float64 `json:"latitude" validate:"required"`
}

func (r *ApiHandler) fetch_location_name(c *fiber.Ctx) error {
	var body fetch_location_name_request

	if er := c.BodyParser(&body); er != nil {
		return sendResponse(c, Error, er.Error())
	}

	url := fmt.Sprintf("https://api.mapbox.com/search/geocode/v6/reverse?longitude=%f&latitude=%f&access_token=%s", body.Longitude, body.Latitude, r.conf.MapBoxPublicKey)

	resp, err := http.Get(url)
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

	// decode the response
	var res map[string]interface{}
	if err := json.Unmarshal(resBodyBytes, &res); err != nil {
		log.Error().Err(err).Msg("Error while unmarshalling response")
		return sendResponse(c, Error, "Error while unmarshalling response")
	}

	properties := res["features"].([]interface{})[0].(map[string]interface{})["properties"].(map[string]interface{})
	full_addess := properties["full_address"]
	name_preferred := properties["name_preferred"]
	place_formatted := properties["place_formatted"]
	normal_name := properties["name"]

	return sendResponse(c, Success, map[string]interface{}{
		"full_address":    full_addess,
		"name_preferred":  name_preferred,
		"place_formatted": place_formatted,
		"normal_name":     normal_name,
	})
}

type Status string

const (
	Success Status = "success"
	Error   Status = "error"
)

func sendResponse(c *fiber.Ctx, status Status, data interface{}) error {
	return c.Status(fiber.StatusOK).JSON(
		map[string]interface{}{
			"status": status,
			"data":   data,
		},
	)
}

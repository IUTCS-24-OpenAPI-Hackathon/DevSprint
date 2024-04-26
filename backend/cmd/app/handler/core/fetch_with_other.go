package core_handler

import (
	"github.com/gofiber/fiber/v2"
	"github.com/rs/zerolog/log"
)

type fetch_by_others_request struct {
	Limit              int     `json:"limit"`
	SearchLocationName string  `json:"search_location_name" validate:"required"`
	Longitude          float64 `json:"longitude" validate:"required"`
	Latitude           float64 `json:"latitude" validate:"required"`
}

func (r *ApiHandler) fetch_by_others(c *fiber.Ctx) error {
	var body fetch_by_others_request

	if er := c.BodyParser(&body); er != nil {
		return sendResponse(c, Error, er.Error())
	}

	var _limit int
	if body.Limit == 0 {
		_limit = 5
	} else {
		_limit = body.Limit
	}

	categories := []string{"hospital", "atm", "hostel"}
	_, err := r.getLocationInfoFromApiAndSaveToDB(categories, _limit, body.Longitude, body.Latitude)
	if err != nil {
		log.Error().Err(err).Msg("failed to get location info from api and save to db")
		return sendResponse(c, Error, err.Error())
	}

	data, err := r.repo.GetLocationInfoByLocationName(body.SearchLocationName)
	if err != nil {
		log.Error().Err(err).Msg("failed to get location info by name")
		return sendResponse(c, Error, err.Error())
	}

	return sendResponse(c, Success, data)
}

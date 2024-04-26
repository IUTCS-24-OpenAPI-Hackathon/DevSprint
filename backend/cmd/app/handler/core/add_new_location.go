package core_handler

import (
	"github.com/gofiber/fiber/v2"
	"github.com/monzim/go_starter/internal/model"
	"github.com/rs/zerolog/log"
)

type add_location_request struct {
	Address     string  `json:"address" validate:"required"`
	Latitude    float64 `json:"latitude" validate:"required"`
	Longitude   float64 `json:"longitude" validate:"required"`
	Country     string  `json:"country" validate:"required"`
	CountryCode string  `json:"country_code" validate:"required"`
	Postcode    string  `json:"postcode"`
}

func (r *ApiHandler) add_new_location(c *fiber.Ctx) error {
	var body add_location_request
	if er := c.BodyParser(&body); er != nil {
		return sendResponse(c, Error, er.Error())
	}

	loc := model.Feature{}
	loc.Properties.Address = body.Address
	loc.Properties.Name = body.Address
	loc.Properties.Context.Country.Name = body.Country
	loc.Properties.Context.Country.CountryCode = body.CountryCode
	loc.Properties.Coordinates.Latitude = body.Latitude
	loc.Properties.Coordinates.Longitude = body.Longitude
	loc.Properties.FullAddress = body.Address
	loc.Properties.Context.Postcode.Name = body.Postcode

	if err := r.repo.SaveGeoLocation(loc); err != nil {
		log.Error().Err(err).Msg("failed to save geo location")
		return sendResponse(c, Error, err.Error())
	}

	return sendResponse(c, Success, nil)
}

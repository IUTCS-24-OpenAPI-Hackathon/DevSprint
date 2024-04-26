package core_handler

import (
	"github.com/gofiber/fiber/v2"
	"github.com/rs/zerolog/log"
)

type add_experience_request struct {
	Experience string  `json:"experience" validate:"required"`
	Latitude   float64 `json:"latitude" validate:"required"`
	Longitude  float64 `json:"longitude" validate:"required"`
}

func (r *ApiHandler) add_experience(c *fiber.Ctx) error {
	var body add_experience_request
	if er := c.BodyParser(&body); er != nil {
		return sendResponse(c, Error, er.Error())
	}

	if err := r.repo.AddNewExperience(body.Latitude, body.Longitude, body.Experience); err != nil {
		log.Error().Err(err).Msg("failed to save comment")
		return sendResponse(c, Error, err.Error())
	}

	return sendResponse(c, Success, nil)
}

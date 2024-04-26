package core_handler

import (
	"github.com/gofiber/fiber/v2"
	"github.com/rs/zerolog/log"
)

type add_comment_request struct {
	Rate      int     `json:"rate" validate:"required,min=1,max=5"`
	Message   string  `json:"message" validate:"required"`
	Latitude  float64 `json:"latitude" validate:"required"`
	Longitude float64 `json:"longitude" validate:"required"`
}

func (r *ApiHandler) add_comment(c *fiber.Ctx) error {
	var body add_comment_request
	if er := c.BodyParser(&body); er != nil {
		return sendResponse(c, Error, er.Error())
	}

	if err := r.repo.AddNewReview(body.Latitude, body.Longitude, body.Message, body.Rate); err != nil {
		log.Error().Err(err).Msg("failed to save comment")
		return sendResponse(c, Error, err.Error())
	}

	return sendResponse(c, Success, nil)
}

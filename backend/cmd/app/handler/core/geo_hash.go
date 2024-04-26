package core_handler

import "github.com/gofiber/fiber/v2"

type geo_hash_request struct {
	Lat  float64 `json:"lat" validate:"required"`
	Long float64 `json:"long" validate:"required"`
}

func (r *ApiHandler) geo_hash(c *fiber.Ctx) error {
	var body geo_hash_request

	if er := c.BodyParser(&body); er != nil {
		return sendResponse(c, Error, er.Error())
	}

	return sendResponse(c, Success, body)
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

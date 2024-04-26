package core_handler

import "github.com/gofiber/fiber/v2"

func (r *ApiHandler) Ping(c *fiber.Ctx) error {
	return c.SendString("pong")
}

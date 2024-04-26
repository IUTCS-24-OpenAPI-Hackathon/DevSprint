package validator

import (
	"fmt"

	"github.com/go-playground/validator/v10"
	"github.com/gofiber/fiber/v2"
)

type WithID struct {
	Id string `json:"id" validate:"required,min=36,max=36"`
}

type With16ID struct {
	Id string `json:"id" validate:"required,min=16,max=16"`
}

type ErrorData struct {
	Field   string `json:"field"`
	Message string `json:"message"`
}

func ValidateBody(c *fiber.Ctx, val validator.Validate, data interface{}) []ErrorData {
	if err := c.BodyParser(data); err != nil {
		return []ErrorData{
			{
				Field:   "body",
				Message: "body is required and should be a valid json object",
			},
		}
	}

	return ValidateData(c, val, data)
}

func ValidateData(c *fiber.Ctx, val validator.Validate, data interface{}) []ErrorData {
	var errorData []ErrorData

	errs := val.Struct(data)
	if errs != nil {
		for _, err := range errs.(validator.ValidationErrors) {
			errorData = append(errorData, ErrorData{
				Field:   err.Field(),
				Message: fmt.Sprintf("the field %s is %s %s", err.Field(), err.Tag(), err.Param()),
			})
		}
	}

	return errorData
}

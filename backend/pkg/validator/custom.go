package validator

import (
	"time"

	"github.com/go-playground/validator/v10"
)

func ISO8601date(fl validator.FieldLevel) bool {
	_, err := time.Parse(time.RFC3339, fl.Field().String())
	if err != nil {
		return false
	}

	return true
}

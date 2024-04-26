package handler

import (
	"github.com/go-playground/validator/v10"
)

type Handler struct {
	V *validator.Validate
}

func CreateHandler(validator *validator.Validate) Handler {
	return Handler{
		V: validator,
	}
}

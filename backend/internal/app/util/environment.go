package util

import (
	"os"

	"github.com/rs/zerolog/log"
)

func IsDevelopment() bool {
	state := false
	environment := os.Getenv("ENVIRONMENT")
	if environment == "development" || environment == "staging" {
		state = true
	}

	log.Info().Msgf("Environment: %s", environment)
	return state
}

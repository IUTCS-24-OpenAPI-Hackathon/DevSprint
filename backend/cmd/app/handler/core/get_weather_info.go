package core_handler

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"

	"github.com/monzim/go_starter/internal/model"
	"github.com/rs/zerolog/log"
)

func (r *ApiHandler) getWeatherInfo(lat, long float64) (*model.WeatherRes, error) {
	resp, err := http.Get(fmt.Sprintf("https://api.weatherapi.com/v1/current.json?key=%s&q=%f,%f", r.conf.WeatherApiKey, lat, long))
	if err != nil {
		log.Error().Err(err).Msg("failed to send request to map box")
		return nil, fmt.Errorf("failed to send request to map box")
	}

	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		log.Error().Msgf("Error while sending request to map box: %d", resp.StatusCode)
		return nil, fmt.Errorf("error while sending request to map box")
	}

	var resBodyBytes []byte
	resBodyBytes, err = io.ReadAll(resp.Body)
	if err != nil {
		log.Error().Err(err).Msg("Error while reading response body")
	}

	var res model.WeatherRes
	if err := json.Unmarshal(resBodyBytes, &res); err != nil {
		log.Error().Err(err).Msg("Error while unmarshalling response")
		return nil, fmt.Errorf("error while unmarshalling response")
	}

	return &res, nil
}

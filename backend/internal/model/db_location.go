package model

import (
	"math"

	"github.com/google/uuid"
	"github.com/monzim/go_starter/internal/app/util"
	"gorm.io/gorm"
)

type JsonData map[string]interface{}

type GeoLocation struct {
	GeoHash     string                `json:"geo_hash" gorm:"primaryKey"`
	Latitude    float64               `json:"latitude,omitempty"`
	Longitude   float64               `json:"longitude,omitempty"`
	PlaceName   string                `json:"place_name,omitempty" gorm:"index"`
	Country     string                `json:"country,omitempty" gorm:"index"`
	Distance    float64               `json:"distance,omitempty"`
	RawData     []byte                `json:"raw_data,omitempty"`
	Reviews     []GeoLocationReview   `gorm:"foreignKey:GeoHash"`
	Experiences []GeoTravelExperience `gorm:"foreignKey:GeoHash"`
	TimeCommon
}

func (u *GeoLocation) BeforeCreate(tx *gorm.DB) (err error) {
	if u.GeoHash == "" {
		u.GeoHash = util.GeoHashEncode(u.Latitude, u.Longitude)
	}

	return
}

type GeoLocationReview struct {
	ID      string `json:"id" gorm:"primaryKey"`
	Rating  int    `json:"rating,omitempty"`
	Review  string `json:"review,omitempty"`
	GeoHash string `json:"geo_hash,omitempty" gorm:"index"`
	TimeCommon
}

func (u *GeoLocationReview) BeforeCreate(tx *gorm.DB) (err error) {
	if u.ID == "" {
		u.ID = uuid.New().String()
	}

	return
}

type GeoTravelExperience struct {
	ID         string `json:"id" gorm:"primaryKey"`
	GeoHash    string `json:"geo_hash,omitempty" gorm:"index"`
	Experience string `json:"experience,omitempty"`
	TimeCommon
}

func (u *GeoTravelExperience) BeforeCreate(tx *gorm.DB) (err error) {
	if u.ID == "" {
		u.ID = uuid.New().String()
	}

	return
}

func (u *GeoLocation) Distance_KM(lat, lng float64, round bool) float64 {
	dis := util.Haversine_KM(u.Latitude, u.Longitude, lat, lng)

	if round {
		roundedDistance := math.Round(dis*100) / 100
		return roundedDistance
	}

	return dis
}

func (u *GeoLocation) Distance_Me(lat, lng float64) float64 {
	return util.Haversine_M(u.Latitude, u.Longitude, lat, lng)
}

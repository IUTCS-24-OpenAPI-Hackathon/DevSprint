package util

import "math"

func Haversine_M(lat1, lon1, lat2, lon2 float64) float64 {
	return Haversine_KM(lat1, lon1, lat2, lon2) * 1000
}

func Haversine_KM(lat1, lon1, lat2, lon2 float64) float64 {
	lat1 = lat1 * math.Pi / 180
	lon1 = lon1 * math.Pi / 180
	lat2 = lat2 * math.Pi / 180
	lon2 = lon2 * math.Pi / 180

	// Radius of the Earth in kilometers
	R := 6371.0

	// Haversine formula
	dlon := lon2 - lon1
	dlat := lat2 - lat1
	a := math.Pow(math.Sin(dlat/2), 2) + math.Cos(lat1)*math.Cos(lat2)*math.Pow(math.Sin(dlon/2), 2)
	c := 2 * math.Atan2(math.Sqrt(a), math.Sqrt(1-a))
	distance := R * c

	return distance // in kilometers
}

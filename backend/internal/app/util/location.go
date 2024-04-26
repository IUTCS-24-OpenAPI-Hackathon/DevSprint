package util

import "math"

const EarthRadiusMeters = 6371000.0

type Location struct {
	Latitude  float64
	Longitude float64
}

func deg2rad(deg float64) float64 {
	return deg * (math.Pi / 180)
}

func rad2deg(rad float64) float64 {
	return rad * (180 / math.Pi)
}

func MaxLatLngInRadius(lat, lng float64, radiusMeters float64) (float64, float64) {
	// Convert degrees to radians
	latRad := deg2rad(lat)
	lngRad := deg2rad(lng)

	// Calculate angular distance
	deltaLat := radiusMeters / EarthRadiusMeters

	// Calculate new max latitude (considering north and south)
	maxLatRad := math.Min(latRad+deltaLat, math.Pi/2) // Limit to max latitude (90 degrees)

	// Calculate new longitude considering wrapping around the globe
	deltaLng := radiusMeters / (EarthRadiusMeters * math.Cos(latRad))
	maxLngRad := math.Mod(lngRad+deltaLng, 2*math.Pi)
	minLngRad := math.Mod(lngRad-deltaLng, 2*math.Pi)

	return rad2deg(maxLatRad), rad2deg(math.Max(maxLngRad, minLngRad)) // Return max longitude
}

func HaversineDistance(lat1, lon1, lat2, lon2 float64) float64 {
	φ1 := lat1 * math.Pi / 180
	φ2 := lat2 * math.Pi / 180
	Δφ := (lat2 - lat1) * math.Pi / 180
	Δλ := (lon2 - lon1) * math.Pi / 180

	a := math.Sin(Δφ/2)*math.Sin(Δφ/2) + math.Cos(φ1)*math.Cos(φ2)*math.Sin(Δλ/2)*math.Sin(Δλ/2)
	c := 2 * math.Atan2(math.Sqrt(a), math.Sqrt(1-a))

	return EarthRadiusMeters * c
}

func GetLocationsWithinRadius(center Location, radius float64, locations []Location) []Location {
	var result []Location
	for _, loc := range locations {
		distance := HaversineDistance(center.Latitude, center.Longitude, loc.Latitude, loc.Longitude)
		if distance <= radius {
			result = append(result, loc)
		}
	}

	return result
}

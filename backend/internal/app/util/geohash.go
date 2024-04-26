package util

import "github.com/pierrre/geohash"

const (
	DefaultGeoHashPrecision = 12
)

func GeoHashEncode(lat, lon float64, precision ...int) string {
	per := precision
	if len(per) == 0 {
		per = append(per, DefaultGeoHashPrecision)
	}

	return geohash.Encode(lat, lon, per[0])

}

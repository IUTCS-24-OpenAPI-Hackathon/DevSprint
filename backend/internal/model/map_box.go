package model

type MapBoxFeaturesRes struct {
	Attribution string `json:"attribution,omitempty"`
	Features    []struct {
		ID       string `json:"_id,omitempty"`
		Geometry struct {
			Coordinates []float64 `json:"coordinates,omitempty"`
			Type        string    `json:"type,omitempty"`
		} `json:"geometry,omitempty"`
		Properties struct {
			Address string `json:"address,omitempty"`
			Context struct {
				Country struct {
					CountryCode       string `json:"country_code,omitempty"`
					CountryCodeAlpha3 string `json:"country_code_alpha_3,omitempty"`
					Name              string `json:"name,omitempty"`
				} `json:"country,omitempty"`
				Place struct {
					ID   string `json:"id,omitempty"`
					Name string `json:"name,omitempty"`
				} `json:"place,omitempty"`
				Postcode struct {
					Name string `json:"name,omitempty"`
				} `json:"postcode,omitempty"`
			} `json:"context,omitempty"`
			Coordinates struct {
				Latitude       float64 `json:"latitude,omitempty"`
				Longitude      float64 `json:"longitude,omitempty"`
				RoutablePoints []struct {
					Latitude  float64 `json:"latitude,omitempty"`
					Longitude float64 `json:"longitude,omitempty"`
					Name      string  `json:"name,omitempty"`
				} `json:"routable_points,omitempty"`
			} `json:"coordinates,omitempty"`
			ExternalIds struct {
				Foursquare string `json:"foursquare,omitempty"`
			} `json:"external_ids,omitempty"`
			FeatureType string `json:"feature_type,omitempty"`
			FullAddress string `json:"full_address,omitempty"`
			Language    string `json:"language,omitempty"`
			Maki        string `json:"maki,omitempty"`
			MapboxID    string `json:"mapbox_id,omitempty"`
			Metadata    struct {
			} `json:"metadata,omitempty"`
			Name           string   `json:"name,omitempty"`
			PlaceFormatted string   `json:"place_formatted,omitempty"`
			PoiCategory    []string `json:"poi_category,omitempty"`
			PoiCategoryIds []string `json:"poi_category_ids,omitempty"`
		} `json:"properties,omitempty"`
		Type string `json:"type,omitempty"`
	} `json:"features,omitempty"`
	Type string `json:"type,omitempty"`
}

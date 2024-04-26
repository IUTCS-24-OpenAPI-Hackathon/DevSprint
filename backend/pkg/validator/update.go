package validator

func UpdateStringField(field *string, value string) {
	if value != "" {
		*field = value
	}
}

func UpdateFloat64Field(field *float64, value float64) {
	if value != 0 {
		*field = value
	}
}

func UpdateIntField(field *int, value int) {
	if value != 0 {
		*field = value
	}
}

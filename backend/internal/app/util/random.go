package util

import (
	"time"

	mathrand "math/rand"
)

func GenerateAuthCode() string {
	return generateCode(6, 6)
}

const charset = "0123456789abcdefghijklmnopqrstuvwxyz"

func generateCode(minLength, maxLength int) string {
	mathrand.Seed(time.Now().UnixNano())
	length := mathrand.Intn(maxLength-minLength+1) + minLength
	b := make([]byte, length)

	numericCount := int(float64(length) * 0.9)
	for i := 0; i < numericCount; i++ {
		b[i] = charset[mathrand.Intn(10)]
	}

	for i := numericCount; i < length; i++ {
		b[i] = charset[mathrand.Intn(len(charset)-10)+10]
	}

	return string(b)
}

func GenerateRandomCode(length int) string {
	const charset = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
	code := make([]byte, length)

	// Generate the random code.
	for i := range code {
		code[i] = charset[mathrand.Intn(len(charset))]
	}

	return string(code)
}

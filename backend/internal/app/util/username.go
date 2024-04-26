package util

import (
	"crypto/sha256"
	"fmt"
	"strings"
)

func GenerateUniqueUsername(email, fullName string) string {
	input := fmt.Sprintf("%s %s", email, fullName)

	hash := sha256.Sum256([]byte(input))

	hashHex := fmt.Sprintf("%x", hash)

	username := hashHex[:8]

	username = strings.Map(func(r rune) rune {
		if (r >= 'a' && r <= 'z') || (r >= 'A' && r <= 'Z') || (r >= '0' && r <= '9') {
			return r
		}
		return '_'
	}, username)

	return username
}

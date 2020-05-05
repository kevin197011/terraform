package utils

import (
	"strings"

	"github.com/google/uuid"
)

func Uuid() string {
	return strings.Split(uuid.New().String(), "-")[0]
}

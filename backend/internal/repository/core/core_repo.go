package core_repo

import (
	"gorm.io/gorm"
)

type CoreRepository struct {
	db *gorm.DB
}

func NewCoreRepository(db *gorm.DB) *CoreRepository {
	return &CoreRepository{db: db}
}

type ICoreRepository interface {
}

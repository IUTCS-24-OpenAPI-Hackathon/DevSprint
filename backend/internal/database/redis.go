package db

import (
	"context"

	"github.com/go-redis/redis/v8"
)

type RedisConfig struct {
	RedisURI string
}

func NewRedisConnection(config *RedisConfig, ctx context.Context) (*redis.Client, error) {
	addr, err := redis.ParseURL(config.RedisURI)
	if err != nil {
		panic(err)
	}

	rdb := redis.NewClient(addr)
	return rdb, nil
}

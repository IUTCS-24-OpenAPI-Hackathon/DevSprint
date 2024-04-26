package core_handler

import (
	"github.com/gofiber/fiber/v2"
	"github.com/monzim/go_starter/cmd/app/handler"
	core_repo "github.com/monzim/go_starter/internal/repository/core"
)

type ApiHandler struct {
	hdlr *handler.Handler
	repo *core_repo.CoreRepository
}

func NewApiHandler(handlr *handler.Handler, repo *core_repo.CoreRepository) ApiHandler {
	return ApiHandler{hdlr: handlr, repo: repo}
}

func (r *ApiHandler) SetupRoutes(route *fiber.Router) {
	base := (*route).Group("/")

	base.Get("/ping", r.Ping)
	base.Get("/geo-hash", r.geo_hash)

}

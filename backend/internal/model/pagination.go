package model

import "fmt"

type Pagination struct {
	Page  int `json:"page" validate:"min=1"`
	Limit int `json:"limit" validate:"min=1,max=100"`
	Order int `json:"order" validate:"min=-1,max=1"`
	Skip  int `json:"-"`
} //@name Pagination

type PaginationResponse struct {
	Tot   int64       `json:"in_total"`
	Total int         `json:"page_total"`
	Cur   int         `json:"current_page"`
	Next  string      `json:"next"`
	Prev  string      `json:"prev"`
	Data  interface{} `json:"data"`
} //@name PaginationResponse

func CalculatePagination(option Pagination, total int64, name string) (nextPage, prevPage string) {
	if option.Limit <= 0 {
		return "", ""
	}

	lastPage := total / int64(option.Limit)
	if total%int64(option.Limit) > 0 {
		lastPage++
	}

	currentPage := int64(option.Skip/option.Limit) + 1
	if currentPage < lastPage {
		nextPage = fmt.Sprintf("/%s?page=%d&limit=%d", name, currentPage+1, option.Limit)
	}

	if currentPage > 1 {
		prevPage = fmt.Sprintf("/%s?page=%d&limit=%d", name, currentPage-1, option.Limit)
	}

	return nextPage, prevPage
}

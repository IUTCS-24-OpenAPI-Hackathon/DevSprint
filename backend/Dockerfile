FROM golang:1.22.1-alpine3.19 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o app

FROM alpine:3.19.1

LABEL org.opencontainers.image.authors="Azraf Al Monzim" \
    org.opencontainers.image.source="https://github.com/monzim/kepathalo-backend" \
    org.opencontainers.image.revision="$(echo $SOURCE_COMMIT | cut -c1-7)" \
    org.opencontainers.image.created="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

WORKDIR /app

COPY --from=builder /app/app .

RUN echo "PORT=8080" >.env
EXPOSE $PORT

CMD ["./app"]

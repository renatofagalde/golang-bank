#build stage
FROM golang:1.22.4-alpine3.20 AS builder
WORKDIR /app
COPY . .

RUN go build -o main main.go \
 && apk --no-cache add curl \
 && curl -L https://github.com/golang-migrate/migrate/releases/download/v4.14.1/migrate.linux-amd64.tar.gz | tar xvz

## RUN STAGE
#FROM scratch
FROM golang:1.22.4-alpine3.20
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/migrate.linux-amd64 ./migrate
COPY app.env ./app.env
COPY start.sh ./start.sh
COPY wait-for.sh ./wait-for.sh
COPY db/migration ./migration

EXPOSE 8080
CMD ["/app/main"]

ENTRYPOINT ["/app/start.sh"]
#build stage
FROM golang:1.22.4-alpine3.20 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go

## RUN STAGE
FROM scratch
WORKDIR /app
COPY --from=builder /app/main .
COPY app.env .

EXPOSE 8080
CMD ["/app/main"]
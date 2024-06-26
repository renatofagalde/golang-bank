postgres:
	docker run --name bank-postgres  -e GIN_MODE=release --net=golang-bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=oraclE44 -d postgres:12-alpine

createdb:
	docker exec -it bank-postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it bank-postgres dropdb  simple_bank

migrationup:
	migrate -path db/migration -database "postgresql://root:oraclE44@localhost:5432/simple_bank?sslmode=disable" -verbose up

migrationup1:
	migrate -path db/migration -database "postgresql://root:oraclE44@localhost:5432/simple_bank?sslmode=disable" -verbose up 1

migrationdown:
	yes | migrate -path db/migration -database "postgresql://root:oraclE44@localhost:5432/simple_bank?sslmode=disable" -verbose down

migrationdown1:
	yes | migrate -path db/migration -database "postgresql://root:oraclE44@localhost:5432/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination ./db/mock/store.go ./bank/db/sqlc Store

.PHONEY: postgres createdb dropdb migrationup migrationdown migrationup1 migrationdown1 sqlc test server mock
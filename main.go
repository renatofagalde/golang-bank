package main

import (
	"bank/api"
	db "bank/db/sqlc"
	"database/sql"
	_ "github.com/lib/pq"
	"log"
)

const (
	dbDriver     = "postgres"
	dbSource     = "postgresql://root:oraclE44@localhost:5432/simple_bank?sslmode=disable"
	serverAddres = "0.0.0.0:8080"
)

func main() {
	conn, err := sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(serverAddres)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}

}

package db

import (
	"context"
	"database/sql"
	_ "github.com/lib/pq"
	"log"
	"os"
	"testing"
)

var testQueries *Queries
var testDB *sql.DB
var ctx context.Context = context.Background()

const (
	dbDriver = "postgres"
	dbSource = "postgresql://root:oraclE44@localhost:5432/simple_bank?sslmode=disable"
)

func TestMain(m *testing.M) { //m -> main
	var err error

	testDB, err = sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	testQueries = New(testDB)
	os.Exit(m.Run())
}

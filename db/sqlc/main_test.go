package db

import (
	"bank/util"
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

func TestMain(m *testing.M) { //m -> main
	var err error
	config, err := util.LoadConfig("../..")
	if err != nil {
		log.Fatal("cannot read the env file")
	}

	testDB, err = sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	testQueries = New(testDB)

	os.Exit(m.Run())
}

package db

import (
	"bank/util"
	"database/sql"
	"github.com/stretchr/testify/require"
	"testing"
	"time"
)

func createRandomAccount(t *testing.T) Account {
	arg := CreateAccountParams{
		Owner:    util.RandomOwner(),
		Balance:  util.RandomMoney(),
		Currency: util.RandomCurrency(),
	}

	account, err := testQueries.CreateAccount(ctx, arg)
	require.NoError(t, err)
	require.NotEmpty(t, account)

	require.Equal(t, arg.Owner, account.Owner)
	require.Equal(t, arg.Balance, account.Balance)
	require.Equal(t, arg.Currency, account.Currency)

	require.NotZero(t, account.ID)
	require.NotZero(t, account.CreatedAt)

	return account

}

func TestQueries_CreatAccount(t *testing.T) {
	createRandomAccount(t)
}

func TestQueries_GetAccount(t *testing.T) {
	var account1 Account = createRandomAccount(t)
	account2, err := testQueries.GetAccount(ctx, account1.ID)

	require.NotEmpty(t, account1)

	require.NoError(t, err)
	require.NotEmpty(t, account2)

	require.Equal(t, account1.ID, account2.ID)
	require.Equal(t, account1.Owner, account2.Owner)
	require.Equal(t, account1.Balance, account2.Balance)
	require.Equal(t, account1.Currency, account2.Currency)
	require.WithinDuration(t, account1.CreatedAt, account2.CreatedAt, time.Second)

}

func TestQueries_UpdateAccount(t *testing.T) {
	var account1 Account = createRandomAccount(t)

	var arg UpdateAccountParams = UpdateAccountParams{
		ID:      account1.ID,
		Balance: util.RandomMoney(),
	}

	account2, err := testQueries.UpdateAccount(ctx, arg)
	require.NoError(t, err)
	require.NotEmpty(t, account2)

	require.Equal(t, account1.ID, account2.ID)
	require.Equal(t, account1.Owner, account2.Owner)
	require.Equal(t, arg.Balance, account2.Balance)
	require.Equal(t, account1.Currency, account2.Currency)
	require.WithinDuration(t, account1.CreatedAt, account2.CreatedAt, time.Second)
}

func TestQueries_DeleteAccount(t *testing.T) {
	var account1 Account = createRandomAccount(t)
	err := testQueries.DeleteAccount(ctx, account1.ID)
	require.NoError(t, err)

	account2, err := testQueries.GetAccount(ctx, account1.ID)
	require.NotEmpty(t, account1)
	require.EqualError(t, err, sql.ErrNoRows.Error())
	require.Empty(t, account2)
}

func TestQueries_ListAccounts(t *testing.T) {
	for i := 0; i < 10; i++ {
		createRandomAccount(t)
	}

	var arg ListAccountsParams = ListAccountsParams{
		Limit:  5,
		Offset: 5,
	}

	accounts, err := testQueries.ListAccounts(ctx, arg)
	require.NoError(t, err)
	require.Len(t, accounts, 5)

	for _, accounts := range accounts {
		require.NotEmpty(t, accounts)
	}

}

### docker postgres
```shell
docker run --name bank-postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=oraclE44 -d postgres:12-alpine
```

### criando o database no shell do linux
```shell
createdb --username=root --owner=root simple_bank
```

# ORM
[gorm](https://gorm.io/docs/query.html)

[sqlc](https://sqlc.dev/) *only postgres <br/>
[sqlc go](https://github.com/sqlc-dev/sqlc-gen-go)
[sqlc - insert](https://docs.sqlc.dev/en/latest/howto/insert.html)
[sqlc - select](https://docs.sqlc.dev/en/latest/howto/select.html)

### test postgres
[test postgres lib](https://github.com/lib/pq)
[testfy postgres lib](https://github.com/stretchr/testify)


### Lock Monitoring
[postgres lock monitoring](https://wiki.postgresql.org/wiki/Lock_Monitoring)
```sql
  SELECT blocked_locks.pid     AS blocked_pid,
         blocked_activity.usename  AS blocked_user,
         blocking_locks.pid     AS blocking_pid,
         blocking_activity.usename AS blocking_user,
         blocked_activity.query    AS blocked_statement,
         blocking_activity.query   AS current_statement_in_blocking_process
   FROM  pg_catalog.pg_locks         blocked_locks
    JOIN pg_catalog.pg_stat_activity blocked_activity  ON blocked_activity.pid = blocked_locks.pid
    JOIN pg_catalog.pg_locks         blocking_locks 
        ON blocking_locks.locktype = blocked_locks.locktype
        AND blocking_locks.database IS NOT DISTINCT FROM blocked_locks.database
        AND blocking_locks.relation IS NOT DISTINCT FROM blocked_locks.relation
        AND blocking_locks.page IS NOT DISTINCT FROM blocked_locks.page
        AND blocking_locks.tuple IS NOT DISTINCT FROM blocked_locks.tuple
        AND blocking_locks.virtualxid IS NOT DISTINCT FROM blocked_locks.virtualxid
        AND blocking_locks.transactionid IS NOT DISTINCT FROM blocked_locks.transactionid
        AND blocking_locks.classid IS NOT DISTINCT FROM blocked_locks.classid
        AND blocking_locks.objid IS NOT DISTINCT FROM blocked_locks.objid
        AND blocking_locks.objsubid IS NOT DISTINCT FROM blocked_locks.objsubid
        AND blocking_locks.pid != blocked_locks.pid

    JOIN pg_catalog.pg_stat_activity blocking_activity ON blocking_activity.pid = blocking_locks.pid
   WHERE NOT blocked_locks.granted;
```


### validacoes do tipo: Currency string `json:"currency" binding:"required,oneof=USD,BRL,CAD"`

### comentar sobre o tipo usado para moeda e exposição do ID interno
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

## sqlc create migration
``code
migrate create -ext sql -dir db/migration -seq add_users
``


## GIN Gonic
### docs
[gin gonic - doc](https://github.com/gin-gonic/gin/blob/master/docs/doc.md)
### validacoes do tipo: Currency string `json:"currency" binding:"required,oneof=USD,BRL,CAD"`

### comentar sobre o tipo usado para moeda e exposição do ID interno

## Viper
[viper](https://github.com/spf13/viper)

## GOMock
[gomock](go install github.com/golang/mock/mockgen@v1.6.0)

## mockgen
add ~/go/bin to PATH
``code
export LD_LIBRARY_PATH=/opt/oracle/instantclient_21_4/:$LD_LIBRARY_PATH
export PATH=$PATH:$LD_LIBRARY_PATH

export ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

export PATH=$PATH:~/go/bin

source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
``

mockgen -package mockdb -destination db/mock/store.go bank/db/sqlc Store


## Parameter Validation - write something

## Test with loop for testCases

## JWT
[jwt golang](https://github.com/dgrijalva/jwt-go)

## Paseto
[paseto](https://github.com/o1egl/paseto)

# Docker
## Docker images golang
[docker images for golang](https://hub.docker.com/_/golang)

### info about container
```shell
docker container inspect ${container}
```


### list all network
```shell
docker network ls
```


### info about a network
```shell
docker network inspect bridge
```

### craete a network
```shell
docker network create golang-bank-network
```

### join container in network
```shell
docker network connect golang-bank-network  bank-postgres
```

### dokcer run
```shell
docker run --name golang-bank -p 8080:8080 -e DB_SOURCE="postgresql://root:oraclE44@bank-postgres:5432/simple_bank?sslmode=disable" -e GIN_MODE=release --net=golang-bank-network golang-bank:latest
```

### Validate Dockrfile
```shell
docker run --rm -i hadolint/hadolint < Dockerfile
```


### waitfor script
[wait for script](https://github.com/eficode/wait-for/releases/download/v2.2.4/wait-for)

### AWS pipeline
[AWS pipeline](https://github.com/marketplace/actions/amazon-ecr-login-action-for-github-actions)

### Symetric randm value
````shell
openssl rand -hex 64 | head -c 32
````

## AWS Secret

### AWS Secret all content
```shel
aws --profile dev-api secretsmanager get-secret-value --secret-id dev/bank --query SecretString --output text
```

### AWS Secret filtred
````shell
aws --profile dev-api secretsmanager get-secret-value --secret-id dev/bank --query SecretString --output text | jq -r 'to_entries|map("\(.key)=\(.value)")|.[]'
````

### AWS ECR Login     
```shell
 aws --profile dev-api ecr get-login-password |docker login --username AWS --password-stdin 211125654907.dkr.ecr.us-east-1.amazonaws.com
```

create table account
(
    "id"          bigserial primary key,
    "created_at"   timestamptz NOT NULL DEFAULT (now()),
    "last_update" timestamptz NOT NULL DEFAULT (now()),
    "owner"       varchar not null,
    "balance"     bigint  not null,
    "currency"    varchar not null
);


create table entry
(
    "id"          bigserial primary key,
    "created_at"  timestamptz NOT NULL DEFAULT (now()),
    "last_update" timestamptz NOT NULL DEFAULT (now()),
    "account_id"  bigint not null,
    "amount"      bigint not null
);

create table transfer
(
    "id"              bigserial primary key,
    "created_at"      timestamptz NOT NULL DEFAULT (now()),
    "last_update"     timestamptz NOT NULL DEFAULT (now()),
    "from_account_id" bigint not null,
    "to_account_id"   bigint not null,
    "amount"          bigint not null
);

create index on account ("owner");

create index on entry ("account_id");

create index on transfer ("from_account_id");

create index on transfer ("to_account_id");

create index on transfer ("from_account_id", "to_account_id");

comment on column entry."amount" is 'can ben negative or positive';

comment on column transfer."amount" is 'must be positive';

alter table entry
    add foreign key ("account_id") references account ("id");

alter table transfer
    add foreign key ("from_account_id") references account ("id");

alter table transfer
    add foreign key ("to_account_id") references account ("id");
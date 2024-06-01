alter table if exists account drop constraint if exists "owner_currency_key";
-- alter table if exists account drop constraint if exists "account_owner";
ALTER TABLE account DROP CONSTRAINT account_owner_fkey;
DROP TABLE IF EXISTS "user";

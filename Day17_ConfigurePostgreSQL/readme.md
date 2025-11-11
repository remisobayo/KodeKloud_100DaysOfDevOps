
# Install PostgreSQL Database Server
`

how to check the postgresql service install
what port is it using
sudo ss -tulpn | postgres

postgres does not know where to find the server configuration file.
You must specify the --config-file or -D invocation option or set the PGDATA environment variable.

which psql
/usr/bin/psql

[peter@stdb01 ~]$ which postgres
/usr/bin/postgres

PostgreSQL configuration files are typically found in /var/lib/pgsql/data
    ls -l /var/lib/pgsql/data/postgresql.conf

sudo vi /var/lib/pgsql/data/postgresql.conf
sudo -i -u postgres
psql
a. Create a database user kodekloud_aim and set its password to xxx.
`CREATE USER kodekloud_aim WITH PASSWORD 'xxx';`

b. Create a database kodekloud_db5 and grant full permissions to user kodekloud_aim on this database.
```sql
CREATE DATABASE kodekloud_db5;    
GRANT ALL PRIVILEGES ON DATABASE kodekloud_db5 TO kodekloud_aim;
```

# Connect to the database
```sql
    \c kodekloud_db5 postgres
    GRANT ALL ON SCHEMA public TO kodekloud_aim;
```
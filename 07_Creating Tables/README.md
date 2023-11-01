# SQL

## Creating Tables

### CREATE TABLE
The CREATE TABLE statement is used to create a new table in a database.
```sql
CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    column3 datatype,
   ....
);
```

### ALTER TABLE
The ALTER TABLE statement is used to add, delete, or modify columns in an existing table.

```sql
ALTER TABLE table_name
ADD column_name datatype;
```
```sql
ALTER TABLE table_name
DROP COLUMN column_name;
```
```sql
ALTER TABLE table_name
ALTER COLUMN column_name datatype;
```

### DROP TABLE
The DROP TABLE statement is used to delete a table.
```sql
DROP TABLE table_name;
```

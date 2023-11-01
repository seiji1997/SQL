# SQL

## Case Statements

A CASE statement is used to search for one value and return another value.
```sql
SELECT column_name, CASE
    WHEN condition THEN 'Result1'
    WHEN condition THEN 'Result2'
    ELSE 'Result3'
END
FROM table_name;
```

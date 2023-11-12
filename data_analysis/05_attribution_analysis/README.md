# SQL

## Wildcards

### LIKE
The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.
```sql
SELECT column_name(s)
FROM table_name
WHERE column_name LIKE pattern;
```

### Wildcard Characters
|Character|Description|
|---|---|
|%|	The percent sign represents zero, one, or multiple characters|
|_|	The underscore represents a single character|

# SQL

## Conditional Statements

### IF
The IF statement is used to perform different actions based on different conditions.
```sql
IF condition THEN
    -- code to be executed if condition is true
ELSE
    -- code to be executed if condition is false
END IF;
```

### IFNULL
The IFNULL() function returns a replacement value if the original value is NULL.
```sql
SELECT IFNULL(column_name, 'value')
FROM table_name;
```

### COALESCE
The COALESCE() function returns the first non-NULL value in a list.
```sql
SELECT COALESCE(column_name, 'value')
FROM table_name;
```

# SQL

## overview
### SELECT
The SELECT statement is used to query the database. It is the most common command in SQL.<br>
```sql
SELECT column1, column2, ...
FROM table_name;
```

### WHERE
The WHERE clause is used to filter records.<br>
```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

### AND & OR
The AND and OR operators are used to filter records based on more than one condition.
```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition1 AND condition2 AND ...;
SELECT column1, column2, ...
FROM table_name
WHERE condition1 OR condition2 OR ...;
```

### ORDER BY
The ORDER BY clause sorts the result set in ascending or descending order.<br>
```sql
SELECT column1, column2, ...
FROM table_name
ORDER BY column1, column2, ... ASC|DESC;
```

### NULL CHECKING
The NULL value is a special value that indicates that a value is missing.
```sql
SELECT column1, column2, ...
FROM table_name
WHERE column IS NULL;
```

### DISTINCT
The DISTINCT keyword is used to return only distinct (different) values.
```sql
SELECT DISTINCT column1, column2, ...
FROM table_name;
```

### DATE
The DATE data type is used to store a date (year, month, day).
```sql
SELECT column1, column2, ...
FROM table_name
WHERE column = DATE '2008-08-08';
```

### BETWEEN
The BETWEEN operator is used to filter the result-set within a certain range.
```sql
SELECT column1, column2, ...
FROM table_name
WHERE column BETWEEN value1 AND value2;
```

### LIKE
The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.
```sql
SELECT column1, column2, ...
FROM table_name
WHERE column LIKE pattern;
```

### IN
The IN operator allows you to specify multiple values in a WHERE clause.
```sql
SELECT column1, column2, ...
FROM table_name
WHERE column IN (value1, value2, ...);
```

### ALIAS
An alias is a temporary name given to a table or a column.
```sql
SELECT column1 AS alias1, column2 AS alias2, ...
FROM table_name AS alias3;
```

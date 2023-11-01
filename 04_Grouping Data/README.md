# SQL

## Grouping Data

### GROUP BY
The GROUP BY statement groups rows that have the same values into summary rows, like "find the number of citizens in each country".
```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE column_name operator value
GROUP BY column_name;
```

### HAVING
The HAVING clause was added to SQL because the WHERE keyword could not be used with aggregate functions.
```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE column_name operator value
GROUP BY column_name
HAVING aggregate_function(column_name) operator value;
```

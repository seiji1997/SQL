# SQL

## Subqueries

A subquery is a query within a query. The subquery is executed first, and the main query uses the result of the subquery.
```sql
SELECT column_name(s)
FROM table_name
WHERE column_name operator ANY
(SELECT column_name FROM table_name WHERE condition);
```

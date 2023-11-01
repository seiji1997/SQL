# SQL

## Querying Multiple Tables

![スクリーンショット 2023-11-01 21 25 16](https://github.com/seiji1997/SQL/assets/72504808/23170380-3324-4da9-9499-525b44f9fe91)

The JOIN clause is used to combine rows from two or more tables, based on a related column between them.
```sql
SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name = table2.column_name;
```

### LEFT JOIN
The LEFT JOIN clause returns all records from the left table (table1), and the matched records from the right table (table2). The result is NULL from the right side, if there is no match.
```sql
SELECT column_name(s)
FROM table1 
LEFT JOIN table2
ON table1.column_name = table2.column_name;
```

### RIGHT JOIN
The RIGHT JOIN clause returns all records from the right table (table2), and the matched records from the left table (table1). The result is NULL from the left side, when there is no match.
```sql
SELECT column_name(s)
FROM table1
RIGHT JOIN table2
ON table1.column_name = table2.column_name;
```

### FULL JOIN
The FULL JOIN clause returns all records when there is a match in either left (table1) or right (table2) table records.
```sql
SELECT column_name(s)
FROM table1
FULL JOIN table2
ON table1.column_name = table2.column_name;
```

### FULL OUTER JOIN
The FULL OUTER JOIN keyword returns all records when there is a match in left (table1) or right (table2) table records.
```sql
SELECT column_name(s)
FROM table1
FULL OUTER JOIN table2 ON table1.column_name = table2.column_name;
```

### FULL INNER JOIN
The FULL INNER JOIN keyword returns all records when there is a match in both left (table1) and right (table2) table records.
```sql
SELECT column_name(s)
FROM table1
FULL INNER JOIN table2 ON table1.column_name = table2.column_name;
```

### UNION
The UNION operator is used to combine the results of two or more SELECT statements.
```sql
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;
```

### INNER JOIN
The INNER JOIN keyword selects records that have matching values in both tables.
```sql
SELECT column_name(s)
FROM table1
INNER JOIN table2 ON table1.column_name = table2.column_name;
```

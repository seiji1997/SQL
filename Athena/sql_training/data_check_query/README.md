# SQL
## exp.category

### condition overlap check
```sql
select 
    "category_major_cd"
    , "category_major_name"
    , "category_medium_cd"
    , "category_medium_name"
    , "category_small_cd"
    , "category_small_name"
    , count(1)
from  "DATABASE"."TABLE"
group by 1, 2, 3, 4, 5, 6
having count(1) > 1
order by 7
```

### null check
```sql
select *
from "DATABASE"."TABLE"
where "category_major_cd" is null
or "category_major_name" is null
or "category_medium_cd" is null
or "category_medium_name" is null
or "category_small_cd" is null
or "category_small_name" is null
```

### Column misalignment check
```sql
select *
from  "DATABASE"."TABLE"
where "category_major_cd" like '%"%'
or "category_major_name" like '%"%'
or "category_medium_cd" like '%"%'
or "category_medium_name" like '%"%'
or "category_small_cd" like '%"%'
or "category_small_name" like '%"%'
```

### Code formatting
```sql
select *
from  "DATABASE"."TABLE"
where(
   "category_major_cd" != ''
   and not regexp_like("category_major_cd", '^[0-9]{2}$')
) 
or
(
   "category_medium_cd" != ''
   and not regexp_like("category_medium_cd", '^[0-9]{4}$')
)
or
(
   "category_small_cd" != ''
   and not regexp_like("category_small_cd", '^[0-9]{6}$')
)

```

### all in

```sql
with tbl1 as(
   select *
   from "DATABASE"."TABLE"
   where "category_major_cd" is null
   or "category_major_name" is null
   or "category_medium_cd" is null
   or "category_medium_name" is null
   or "category_small_cd" is null
   or "category_small_name" is null
)

, tbl2 as (
   select *
   from "DATABASE"."TABLE"
   where "category_major_cd" like '%"%'
   or "category_major_name" like '%"%'
   or "category_medium_cd" like '%"%'
   or "category_medium_name" like '%"%'
   or "category_small_cd" like '%"%'
   or "category_small_name" like '%"%'
)

, tbl3 as (
   select *
   from "DATABASE"."TABLE"
   where(
      "category_major_cd" != ''
      and not regexp_like("category_major_cd", '^[0-9]{2}$')
      ) 
      or
      (
      "category_medium_cd" != ''
      and not regexp_like("category_medium_cd", '^[0-9]{4}$')
      )
      or
      (
      "category_small_cd" != ''
      and not regexp_like("category_small_cd", '^[0-9]{6}$')
      )
)
, tbl4 as (
   select 
   "category_major_cd"
   , "category_major_name"
   , "category_medium_cd"
   , "category_medium_name"
   , "category_small_cd"
   , "category_small_name"
   , count(1)
   from "DATABASE"."TABLE"
   group by 1, 2, 3, 4, 5, 6
   having count(1) > 1
   order by 7
)

select tbl1, count(1) as error from tab1
union all
select tbl2, count(1) as error from tab2
union all
select tbl3, count(1) as error from tab3
union all
select tbl4, count(1) as error from tab4
```



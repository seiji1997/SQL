# presto
organize Athena functions.<br>
https://docs.aws.amazon.com/redshift/latest/dg/welcome.html


### add new data check

```sql
with table1 as (
  select * 
  from database.currentdata
)

, table1a as (
  select * 
  from database.previousdata
)

, check1 as (
  select * from(
    select "column1" from "table1"
    except
    select "column1" from "anothertable1"
  ) 
  except
  select "column1" from "table1a"
)

, check2 as (
  select "column1" from "anothertable1"
  except
  select * from(
    select "column1" from "table1a"
    except
    select "column1" from "table1"
  )  
)

select count("column1") from "check2"
union all
select count("column1") from "check2a"

```


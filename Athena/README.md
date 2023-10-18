# SQL
organize Athena functions.<br>
https://docs.aws.amazon.com/redshift/latest/dg/welcome.html


### Time control
[CURRENT_DATE_function](https://docs.aws.amazon.com/redshift/latest/dg/Date_functions_header.html)<br>
[presto timestamp](https://prestodb.io/docs/current/functions/datetime.html)<br>

```sql
select current_date;

-- output
/*date
------------
2008-10-01
*/
```


### control with python(Lambda)
```sql
with now_date as (
--  select date_parse('20231018', '%Y%m%d') as today
  select date_parse('{YYYYMMDD}', '%Y%m%d') as today
)

, r_date as (
  select day((select now from now_date) at time zone 'Asia/Tokyo') as r_day
       , date_format((select now from now_date) at time zone 'Asia/Tokyo', '%Y') as r_year
       , date_format((select now from now_date) at time zone 'Asia/Tokyo', '%Y%m') as r_month
       , date_format((select now from now_date) at time zone 'Asia/Tokyo', '%Y%m%d') as r_today
       , date_format((select now from now_date) at time zone 'Asia/Tokyo', '%Y%m06') as r_day_of_6
       , date_format((select now from now_date) at time zone 'Asia/Tokyo' + interval '-1' month, '%Y%m06') as r_last_month_day_of_6
       , date_format((select now from now_date) at time zone 'Asia/Tokyo' + interval '-1' day, '%Y%m%d') as r_1_day_ago
       , date_format((select now from now_date) at time zone 'Asia/Tokyo' + interval '-100' day, '%Y%m%d') as r_100_days_ago
       , date_format((select now from now_date) at time zone 'Asia/Tokyo' + interval '-1' month, '%Y%m%d') as r_month_ago
       , date_format((select now from now_date) at time zone 'Asia/Tokyo' + interval '-1' year, '%Y%m%d') as r_year_ago
select * from r_date

```

### control by Athena
[https://docs.aws.amazon.com/redshift/latest/dg/r_CURRENT_DATE_function.html](https://docs.aws.amazon.com/redshift/latest/dg/Date_functions_header.html)
```sql
select substr(cast(current_timestamp at time zone 'Asia/Tokyo' as varchar), 1, 4)
    || substr(cast(current_timestamp at time zone 'Asia/Tokyo' as varchar), 6, 2)
    || substr(cast(current_timestamp at time zone 'Asia/Tokyo' as varchar), 9, 2) as yyyymmdd
```

```sql
select day(current_timestamp at time zone 'Asia/Tokyo') as r_day
     , date_format(current_timestamp at time zone 'Asia/Tokyo', '%Y') as r_year
     , date_format(current_timestamp at time zone 'Asia/Tokyo', '%Y%m') as r_month
     , date_format(current_timestamp at time zone 'Asia/Tokyo', '%Y%m%d') as r_today
     , date_format(current_timestamp at time zone 'Asia/Tokyo', '%Y%m06') as r_day_of_6
     , date_format(current_timestamp at time zone 'Asia/Tokyo' + interval '-1' month, '%Y%m06') as r_last_month_day_of_6
     , date_format(current_timestamp at time zone 'Asia/Tokyo' + interval '-1' day, '%Y%m%d') as r_1_day_ago
     , date_format(current_timestamp at time zone 'Asia/Tokyo' + interval '-100' day, '%Y%m%d') as r_100_days_ago
     , date_format(current_timestamp at time zone 'Asia/Tokyo' + interval '-1' month, '%Y%m%d') as r_month_ago
     , date_format(current_timestamp at time zone 'Asia/Tokyo' + interval '-1' year, '%Y%m%d') as r_year_ago
```







with tbl1 as (
    select *
    from `project.dataset.employees`
    where id is null
    or name is null
    or email is null
    or start_date is null
),
tbl2 as (
    select *
    from `project.dataset.employees`
    where name like '%"%'
    or email like '%"%'
),
tbl3 as (
    select *
    from `project.dataset.employees`
    where not regexp_contains(cast(id as string), r'^[0-9]+$')
    or not regexp_contains(email, r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
    or not regexp_contains(cast(start_date as string), r'^\d{4}-\d{2}-\d{2}$')
    or (end_date is not null and not regexp_contains(cast(end_date as string), r'^\d{4}-\d{2}-\d{2}$'))
),
tbl4 as (
    select 
    id, 
    name, 
    email, 
    start_date, 
    end_date, 
    count(1)
    from `project.dataset.employees`
    group by 1, 2, 3, 4, 5
    having count(1) > 1
)

select 'tbl1' as check_list, count(1) as error from tbl1
union all
select 'tbl2' as check_list, count(1) as error from tbl2
union all
select 'tbl3' as check_list, count(1) as error from tbl3
union all
select 'tbl4' as check_list, count(1) as error from tbl4
order by 1 asc;

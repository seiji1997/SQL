with tbl1 as (
    select *
    from `project.dataset.generations`
    where code is null
    or label is null
),
tbl2 as (
    select *
    from `project.dataset.generations`
    where label like '%"%'
),
tbl3 as (
    select *
    from `project.dataset.generations`
    where not regexp_contains(code, r'^[0-9]{1}$')
),
tbl4 as (
    select 
    code, 
    label, 
    count(1)
    from `project.dataset.generations`
    group by 1, 2
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

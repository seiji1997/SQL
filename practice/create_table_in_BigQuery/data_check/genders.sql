with tbl1 as (
    select *
    from `project.dataset.genders`
    where code is null
    or name is null
),
tbl2 as (
    select *
    from `project.dataset.genders`
    where name like '%"%'
),
tbl3 as (
    select *
    from `project.dataset.genders`
    where not regexp_contains(code, r'^[fm]$')
),
tbl4 as (
    select 
    code, 
    name, 
    count(1)
    from `project.dataset.genders`
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

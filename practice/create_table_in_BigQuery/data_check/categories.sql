with tbl1 as (
    select *
    from `project.dataset.categories`
    where id is null
    or name is null
),
tbl2 as (
    select *
    from `project.dataset.categories`
    where name like '%"%'
),
tbl3 as (
    select *
    from `project.dataset.categories`
    where not regexp_contains(cast(id as string), r'^[0-9]+$')
),
tbl4 as (
    select 
    id, 
    name, 
    count(1)
    from `project.dataset.categories`
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

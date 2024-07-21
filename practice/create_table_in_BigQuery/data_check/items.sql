with tbl1 as (
    select *
    from `project.dataset.items`
    where id is null
    or category_id is null
    or name is null
    or price is null
),
tbl2 as (
    select *
    from `project.dataset.items`
    where name like '%"%'
),
tbl3 as (
    select *
    from `project.dataset.items`
    where not regexp_contains(cast(id as string), r'^[0-9]+$')
    or not regexp_contains(cast(category_id as string), r'^[0-9]+$')
    or not regexp_contains(cast(price as string), r'^[0-9]+$')
),
tbl4 as (
    select 
    id, 
    category_id, 
    name, 
    price, 
    count(1)
    from `project.dataset.items`
    group by 1, 2, 3, 4
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

with tbl1 as (
    select *
    from `project.dataset.prefectures`
    where code is null
    or region_code is null
    or name is null
    or acreage is null
),
tbl2 as (
    select *
    from `project.dataset.prefectures`
    where name like '%"%'
),
tbl3 as (
    select *
    from `project.dataset.prefectures`
    where not regexp_contains(code, r'^[0-9]{2}$')
    or not regexp_contains(region_code, r'^[0-9]{2}$')
    or not regexp_contains(cast(acreage as string), r'^[0-9]+(\.[0-9]+)?$')
),
tbl4 as (
    select 
    code, 
    region_code, 
    name, 
    acreage, 
    count(1)
    from `project.dataset.prefectures`
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

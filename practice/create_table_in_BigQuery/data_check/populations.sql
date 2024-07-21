with tbl1 as (
    select *
    from `project.dataset.populations`
    where prefecture_code is null
    or generation_code is null
    or gender_code is null
    or population is null
),
tbl2 as (
    select *
    from `project.dataset.populations`
    where prefecture_code like '%"%'
    or generation_code like '%"%'
    or gender_code like '%"%'
),
tbl3 as (
    select *
    from `project.dataset.populations`
    where not regexp_contains(prefecture_code, r'^[0-9]{2}$')
    or not regexp_contains(generation_code, r'^[0-9]{1}$')
    or not regexp_contains(gender_code, r'^[fm]$')
    or not regexp_contains(cast(population as string), r'^[0-9]+$')
),
tbl4 as (
    select 
    prefecture_code, 
    generation_code, 
    gender_code, 
    population, 
    count(1)
    from `project.dataset.populations`
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

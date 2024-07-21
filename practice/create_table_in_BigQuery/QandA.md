
# BigQuery 問題・回答・解説

## 問題1

### 問題文
`items` テーブルに以下のデータを挿入してください：
- `id` が 13、`category_id` が 1、`name` が '鰯'、`price` が 150 のレコード
- `id` が 14、`category_id` が 2、`name` が '羊'、`price` が 650 のレコード

### 回答

```sql
insert into items (id, category_id, name, price)
values
  (13, 1, '鰯', 150),
  (14, 2, '羊', 650);
```

### 解説
このSQLクエリは、`items` テーブルに複数のレコードを一度に挿入します。複数行の `values` 節を使用することで、個別に `insert` 文を実行するよりも効率的です。

## 問題2

### 問題文
`items` テーブルの全ての `price` 列の値を10%減少させてください。

### 回答

```sql
update items
set price = trunc(price * 0.9);
```

### 解説
このクエリは、`items` テーブルの全ての行の `price` 列を10%減少させます。`trunc` 関数を使用して小数点以下を切り捨てています。

## 問題3

### 問題文
`employees` テーブルから `end_date` が '2013-03-31' より前のレコードを削除してください。

### 回答

```sql
delete from employees
where end_date <= '2013-03-31';
```

### 解説
このクエリは、`employees` テーブルから `end_date` が '2013-03-31' より前の全てのレコードを削除します。

## 問題4

### 問題文
`items` テーブルの中で、欠番となっている最小の `id` を見つけてください。

### 回答

```sql
select
  min(gen.id) as absence
from
  generate_series (
    1,
    (
      select
        max(id)
      from
        items
    ) as id
  ) gen
  left outer join items i on gen.id = i.id
where
  i.id is null;
```

### 解説
このクエリは、まず `generate_series` 関数を使用して 1 から `items` テーブルの最大 `id` までの数値列を生成し、それを `items` テーブルと左外部結合します。その後、結合に失敗した（すなわち `items` テーブルに存在しない）最小の `id` を見つけます。

## 問題5

### 問題文
各都道府県とそれに対応する地域名を表示してください。

### 回答

```sql
select
  a.name as region,
  p.name as prefecture
from
  prefectures p
  inner join regions a on p.region_code = a.code;
```

### 解説
このクエリは、`prefectures` テーブルと `regions` テーブルを結合し、各都道府県とそれに対応する地域名を取得します。

## 問題6

### 問題文
`populations` テーブルの全人口の合計を計算してください。

### 回答

```sql
select
  sum(population) as population
from
  populations;
```

### 解説
このクエリは、`populations` テーブルの `population` 列の値を全て合計し、全人口を計算します。

## 問題7

### 問題文
九州地域の各都道府県ごとに性別ごとの人口を計算し、性別が男性のものを降順で表示してください。

### 回答

```sql
select
  pr.name as prefecture,
  s.name as gender,
  sum(p.population) as population
from
  populations p
  inner join prefectures pr on p.prefecture_code = pr.code
  inner join genders s on p.gender_code = s.code
  inner join regions a on pr.region_code = a.code
group by
  pr.code,
  s.code,
  a.code
having
  a.name = '九州'
order by
  pr.code,
  s.name desc;
```

### 解説
このクエリは、九州地域に属する各都道府県の性別ごとの人口を計算し、性別が男性のものを降順で表示します。`having` 節で九州地域を絞り込み、`group by` 節で都道府県と性別ごとにグループ化しています。

## 問題8

### 問題文
地域ごとに性別と年齢層ごとの人口を集計し、以下のフォーマットで表示してください：
- 地域
- 15歳未満（男）
- 15歳〜64歳（男）
- 65歳以上（男）
- 15歳未満（女）
- 15歳〜64歳（女）
- 65歳以上（女）

### 回答

```sql
select
  a.name as "地域",
  sum(
    case
      when p.gender_code = 'm'
      and p.generation_code = '1' then p.population
      else 0
    end
  ) as "15歳未満(男)",
  sum(
    case
      when p.gender_code = 'm'
      and p.generation_code = '2' then p.population
      else 0
    end
  ) as "15歳〜64歳(男)",
  sum(
    case
      when p.gender_code = 'm'
      and p.generation_code = '3' then p.population
      else 0
    end
  ) as "65歳以上(男)",
  sum(
    case
      when p.gender_code = 'f'
      and p.generation_code = '1' then p.population
      else 0
    end
  ) as "15歳未満(女)",
  sum(
    case
      when p.gender_code = 'f'
      and p.generation_code = '2' then p.population
      else 0
    end
  ) as "15歳〜64歳(女)",
  sum(
    case
      when p.gender_code = 'f'
      and p.generation_code = '3' then p.population
      else 0
    end
  ) as "65歳以上(女)"
from
  populations p
  inner join prefectures pr on p.prefecture_code = pr.code
  inner join regions a on pr.region_code = a.code
group by
  a.code
order by
  a.code;
```

### 解説
このクエリは、`populations` テーブルを `prefectures` テーブルおよび `regions` テーブルと結合し、地域ごとに性別と年齢層ごとの人口を集計します。`case` 文を使用して条件に応じた人口の合計を計算し、`group by` 節で地域ごとにグループ化しています。


# SQL テスト問題

## 問題5

以下のSQL文を使用して `prefectures` テーブルと `regions` テーブルを結合し、各都道府県の所属する地域を取得してください。

```sql
SELECT
  a.name AS region,
  p.name AS prefecture
FROM
  prefectures p
  INNER JOIN regions a ON p.region_code = a.code;
```

## 解説

### SQL文の読み解き方と考え方

この問題では、`prefectures` テーブルと `regions` テーブルを結合し、各都道府県がどの地域に属しているかを取得する必要があります。 `INNER JOIN` を使用してこの情報を取得します。

### 各処理についての丁寧な解説

#### テーブルの結合処理

以下のSQL文を分解して説明します。

```sql
SELECT
  a.name AS region,
  p.name AS prefecture
FROM
  prefectures p
  INNER JOIN regions a ON p.region_code = a.code;
```

1. `SELECT a.name AS region, p.name AS prefecture`:
   - `regions` テーブルの `name` カラムを `region` として選択し、`prefectures` テーブルの `name` カラムを `prefecture` として選択します。

2. `FROM prefectures p`:
   - `prefectures` テーブルを `p` というエイリアスで指定します。

3. `INNER JOIN regions a ON p.region_code = a.code`:
   - `regions` テーブルを `a` というエイリアスで指定し、`prefectures` テーブルの `region_code` カラムと `regions` テーブルの `code` カラムを結合条件として `INNER JOIN` を行います。
   - `INNER JOIN` は、結合条件に一致するレコードのみを結果に含めます。

この操作により、各都道府県がどの地域に属しているかの情報を取得することができます。

### 効率的な短いコードでの回答作成

この `SELECT` 文は簡潔で効率的です。1つの SQL 文で必要な情報を取得できます。

### 入出力の例

例えば、以下のような `prefectures` テーブルと `regions` テーブルがあるとします。

`prefectures` テーブル:

| code | region_code | name     | acreage  |
|------|-------------|----------|----------|
| 01   | 10          | 北海道   | 83456.87 |
| 02   | 20          | 青森県   | 9644.54  |

`regions` テーブル:

| code | name   |
|------|--------|
| 10   | 北海道 |
| 20   | 東北   |

ここに以下のSQL文を実行します。

```sql
SELECT
  a.name AS region,
  p.name AS prefecture
FROM
  prefectures p
  INNER JOIN regions a ON p.region_code = a.code;
```

実行後、結果は次のようになります。

| region  | prefecture |
|---------|------------|
| 北海道  | 北海道     |
| 東北    | 青森県     |

これで、都道府県とその所属する地域が正しく結合されていることが確認できます。

---

このように、SQL文の実行結果やテーブルの変化を具体的に示すことで、理解が深まります。効率的な方法を採用することで、実際のデータベース操作のパフォーマンスも向上します。

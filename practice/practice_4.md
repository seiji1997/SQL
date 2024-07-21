
# SQL テスト問題

## 問題4

以下のSQL文を使用して `items` テーブルの `id` カラムに欠番がある場合、その最小の欠番を取得してください。

```sql
SELECT
  min(gen.id) AS absence
FROM
  generate_series (
    1,
    (
      SELECT
        max(id)
      FROM
        items
    ) AS id
  ) gen
  LEFT OUTER JOIN items i ON gen.id = i.id
WHERE
  i.id IS NULL;
```

## 解説

### SQL文の読み解き方と考え方

この問題では、`items` テーブルの `id` カラムに欠番がある場合、その最小の欠番を見つける必要があります。 `generate_series` 関数と `LEFT OUTER JOIN` を使用して実現します。

### 各処理についての丁寧な解説

#### 欠番の検索処理

以下のSQL文を分解して説明します。

```sql
SELECT
  min(gen.id) AS absence
FROM
  generate_series (
    1,
    (
      SELECT
        max(id)
      FROM
        items
    ) AS id
  ) gen
  LEFT OUTER JOIN items i ON gen.id = i.id
WHERE
  i.id IS NULL;
```

1. `generate_series(1, (SELECT max(id) FROM items) AS id) gen`:
   - `generate_series` は、指定された範囲内の数値のシーケンスを生成します。ここでは、`items` テーブルの `id` の最大値までの数値を生成します。
   - 内部サブクエリ `(SELECT max(id) FROM items)` により、`items` テーブルの `id` の最大値を取得します。

2. `LEFT OUTER JOIN items i ON gen.id = i.id`:
   - `generate_series` により生成されたシーケンスと `items` テーブルを `id` カラムで左外部結合します。
   - これにより、`items` テーブルに存在しない `id` を含む全てのシーケンス番号を取得できます。

3. `WHERE i.id IS NULL`:
   - `LEFT OUTER JOIN` により、`items` テーブルに存在しない `id` が `NULL` として現れます。この `NULL` 値を持つ行のみをフィルタリングします。

4. `SELECT min(gen.id) AS absence`:
   - フィルタリングされた結果から、最小の `id`（すなわち最小の欠番）を選択します。

### 効率的な短いコードでの回答作成

この `SELECT` 文は簡潔で効率的です。1つの SQL 文で欠番を見つけることができます。

### 入出力の例

例えば、以下のような `items` テーブルがあるとします。

| id | category_id | name | price |
|----|-------------|------|-------|
| 1  | 1           | 鮪   | 1000  |
| 2  | 1           | 鯛   | 800   |
| 4  | 1           | 鰹   | 700   |
| 5  | 2           | 牛   | 1200  |

ここに以下のSQL文を実行します。

```sql
SELECT
  min(gen.id) AS absence
FROM
  generate_series (
    1,
    (
      SELECT
        max(id)
      FROM
        items
    ) AS id
  ) gen
  LEFT OUTER JOIN items i ON gen.id = i.id
WHERE
  i.id IS NULL;
```

実行後、`absence` は `3` となります。これは、 `items` テーブルに存在しない最小の `id` です。

| absence |
|---------|
| 3       |

これで、テーブルの `id` に欠番があり、その最小の欠番が正しく取得されていることが確認できます。

---

このように、SQL文の実行結果やテーブルの変化を具体的に示すことで、理解が深まります。効率的な方法を採用することで、実際のデータベース操作のパフォーマンスも向上します。

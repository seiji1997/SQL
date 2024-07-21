
## 問題4: itemsテーブルの欠番IDの取得

### 問題文
以下のSQL文を使用して、`items`テーブルの欠番となっている最小のIDを取得してください。

### 回答例
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

### 解説

#### 回答例の説明
このSQL文では、`items`テーブルのID列に欠番が存在する場合、その最小の欠番IDを取得しています。

- `SELECT min(gen.id) AS absence`の部分で、欠番の最小のIDを取得しています。
- `generate_series(1, (SELECT max(id) FROM items) AS id)`の部分で、1から`items`テーブルの最大IDまでの連続した数列を生成しています。
- `LEFT OUTER JOIN items i ON gen.id = i.id`の部分で、生成した数列と`items`テーブルを左外部結合しています。
- `WHERE i.id IS NULL`の部分で、`items`テーブルに存在しないIDを条件としてフィルタリングしています。

#### 各処理の詳細

1. **`generate_series(1, (SELECT max(id) FROM items) AS id)`**:
   - 1から`items`テーブルの最大IDまでの連続した数列を生成します。
   - 例えば、`items`テーブルの最大IDが10の場合、1から10までの数列を生成します。

2. **`LEFT OUTER JOIN items i ON gen.id = i.id`**:
   - 生成した数列と`items`テーブルを左外部結合します。
   - これにより、`items`テーブルに存在しないIDも結果に含まれます。

3. **`WHERE i.id IS NULL`**:
   - `items`テーブルに存在しないIDを条件としてフィルタリングします。
   - これにより、欠番となっているIDのみが抽出されます。

4. **`SELECT min(gen.id) AS absence`**:
   - 欠番となっているIDの中で最小のものを選択します。

### 入出力例

#### 入力
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

#### 出力
`items`テーブルに欠番が存在する場合、その最小の欠番IDが取得されます。
| id (itemsテーブル) |
|----|
| 1  |
| 2  |
| 4  | 欠番 |
| 5  |
| 6  |

結果: 4 (欠番の最小ID)

### 処理のポイント
- `generate_series`関数を使用して、連続した数列を生成します。
- `LEFT OUTER JOIN`を使用して、欠番を含む結果セットを取得します。
- `WHERE`句を使用して、欠番のみを抽出します。

これにより、SQLの高度なクエリ操作を効率的に行う方法を理解することができます。

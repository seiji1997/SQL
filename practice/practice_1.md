
## 問題1: itemsテーブルへのデータ挿入

### 問題文
以下のSQL文を用いて、`items`テーブルにデータを挿入してください。

1. `id`が13、`category_id`が1、`name`が'鰯'、`price`が150のレコード
2. `id`が14、`category_id`が2、`name`が'羊'、`price`が650のレコード

### 回答例
```sql
INSERT INTO
  items (id, category_id, name, price)
VALUES
  (13, 1, '鰯', 150);

INSERT INTO
  items (id, category_id, name, price)
VALUES
  (14, 2, '羊', 650);
```

### 別解
```sql
INSERT INTO
  items (id, category_id, name, price)
VALUES
  (13, 1, '鰯', 150),
  (14, 2, '羊', 650);
```

### 解説

#### 回答例の説明
このSQL文では、`INSERT INTO`ステートメントを使用して、`items`テーブルに新しいレコードを追加しています。

- `INSERT INTO items (id, category_id, name, price)`の部分で、`items`テーブルの`id`、`category_id`、`name`、`price`の4つの列にデータを挿入することを指定しています。
- `VALUES (13, 1, '鰯', 150)`の部分で、`id`が13、`category_id`が1、`name`が'鰯'、`price`が150のレコードを挿入しています。

上記のステートメントを2回使用して、2つの異なるレコードを`items`テーブルに追加しています。

#### 別解の説明
別解では、1つの`INSERT INTO`ステートメントを使用して、複数のレコードを一度に挿入しています。

- `VALUES (13, 1, '鰯', 150), (14, 2, '羊', 650)`の部分で、2つのレコードを一度に挿入しています。

この方法は、複数のレコードを一度に挿入するために効率的です。

### 入出力例

#### 入力
```sql
INSERT INTO
  items (id, category_id, name, price)
VALUES
  (13, 1, '鰯', 150),
  (14, 2, '羊', 650);
```

#### 出力
`items`テーブルに次のようなレコードが追加されます。
| id | category_id | name | price |
|----|-------------|------|-------|
| 13 | 1           | 鰯   | 150   |
| 14 | 2           | 羊   | 650   |

### 処理のポイント
- `INSERT INTO`ステートメントは、新しいレコードをテーブルに追加するために使用されます。
- 複数のレコードを一度に挿入する場合、`VALUES`句にカンマで区切って複数のレコードを指定できます。

これにより、SQLの基本的な挿入操作を効率的に行う方法を理解することができます。

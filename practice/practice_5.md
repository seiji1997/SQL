
## 問題5: 都道府県と地域の名前の取得

### 問題文
以下のSQL文を使用して、`prefectures`テーブルと`regions`テーブルを結合し、都道府県名とそれに対応する地域名を取得してください。

### 回答例
```sql
SELECT
  a.name AS region,
  p.name AS prefecture
FROM
  prefectures p
  INNER JOIN regions a ON p.region_code = a.code;
```

### 解説

#### 回答例の説明
このSQL文では、`prefectures`テーブルと`regions`テーブルを結合し、各都道府県の地域名を取得しています。

- `SELECT a.name AS region, p.name AS prefecture`の部分で、`regions`テーブルの名前を`region`として、`prefectures`テーブルの名前を`prefecture`として選択しています。
- `FROM prefectures p INNER JOIN regions a ON p.region_code = a.code`の部分で、`prefectures`テーブルと`regions`テーブルを`region_code`と`code`で内部結合しています。

#### 各処理の詳細

1. **`INNER JOIN regions a ON p.region_code = a.code`**:
   - `prefectures`テーブルの`region_code`列と`regions`テーブルの`code`列を基準に内部結合します。
   - 内部結合により、両方のテーブルに一致するレコードのみが結果に含まれます。

2. **`SELECT a.name AS region, p.name AS prefecture`**:
   - 結合された結果セットから、`regions`テーブルの`name`を`region`として、`prefectures`テーブルの`name`を`prefecture`として選択します。

### 入出力例

#### 入力
```sql
SELECT
  a.name AS region,
  p.name AS prefecture
FROM
  prefectures p
  INNER JOIN regions a ON p.region_code = a.code;
```

#### 出力
| region  | prefecture |
|---------|------------|
| 関東    | 東京       |
| 関東    | 神奈川     |
| 関西    | 大阪       |
| 関西    | 京都       |

### 処理のポイント
- `INNER JOIN`ステートメントは、両方のテーブルに一致するレコードを取得するために使用されます。
- 適切な列を指定することで、テーブルを結合し必要な情報を取得できます。

これにより、SQLの結合操作を効率的に行う方法を理解することができます。


## 問題7: 九州地域の都道府県別および性別の総人口の取得

### 問題文
以下のSQL文を使用して、九州地域に属する各都道府県の性別ごとの総人口を取得してください。

### 回答例
```sql
SELECT
  pr.name AS prefecture,
  s.name AS gender,
  SUM(p.population) AS population
FROM
  populations p
  INNER JOIN prefectures pr ON p.prefecture_code = pr.code
  INNER JOIN genders s ON p.gender_code = s.code
  INNER JOIN regions a ON pr.region_code = a.code
GROUP BY
  pr.code,
  s.code,
  a.code
HAVING
  a.name = '九州'
ORDER BY
  pr.code,
  s.name DESC;
```

### 解説

#### 回答例の説明
このSQL文では、九州地域に属する各都道府県の性別ごとの総人口を取得しています。

- `SELECT pr.name AS prefecture, s.name AS gender, SUM(p.population) AS population`の部分で、都道府県名、性別名、総人口を選択しています。
- `FROM populations p`の部分で、データの取得元テーブルを`populations`テーブルに指定しています。
- `INNER JOIN prefectures pr ON p.prefecture_code = pr.code`の部分で、`populations`テーブルと`prefectures`テーブルを`prefecture_code`と`code`で内部結合しています。
- `INNER JOIN genders s ON p.gender_code = s.code`の部分で、`populations`テーブルと`genders`テーブルを`gender_code`と`code`で内部結合しています。
- `INNER JOIN regions a ON pr.region_code = a.code`の部分で、`prefectures`テーブルと`regions`テーブルを`region_code`と`code`で内部結合しています。
- `GROUP BY pr.code, s.code, a.code`の部分で、都道府県コード、性別コード、地域コードでグループ化しています。
- `HAVING a.name = '九州'`の部分で、地域名が「九州」であるレコードをフィルタリングしています。
- `ORDER BY pr.code, s.name DESC`の部分で、都道府県コード、性別名の降順で結果を並べ替えています。

#### 各処理の詳細

1. **`INNER JOIN prefectures pr ON p.prefecture_code = pr.code`**:
   - `populations`テーブルの`prefecture_code`列と`prefectures`テーブルの`code`列を基準に内部結合します。

2. **`INNER JOIN genders s ON p.gender_code = s.code`**:
   - `populations`テーブルの`gender_code`列と`genders`テーブルの`code`列を基準に内部結合します。

3. **`INNER JOIN regions a ON pr.region_code = a.code`**:
   - `prefectures`テーブルの`region_code`列と`regions`テーブルの`code`列を基準に内部結合します。

4. **`GROUP BY pr.code, s.code, a.code`**:
   - 都道府県コード、性別コード、地域コードでレコードをグループ化します。

5. **`HAVING a.name = '九州'`**:
   - 地域名が「九州」であるレコードをフィルタリングします。

6. **`ORDER BY pr.code, s.name DESC`**:
   - 都道府県コード、性別名の降順で結果を並べ替えます。

### 入出力例

#### 入力
```sql
SELECT
  pr.name AS prefecture,
  s.name AS gender,
  SUM(p.population) AS population
FROM
  populations p
  INNER JOIN prefectures pr ON p.prefecture_code = pr.code
  INNER JOIN genders s ON p.gender_code = s.code
  INNER JOIN regions a ON pr.region_code = a.code
GROUP BY
  pr.code,
  s.code,
  a.code
HAVING
  a.name = '九州'
ORDER BY
  pr.code,
  s.name DESC;
```

#### 出力
| prefecture | gender | population |
|------------|--------|------------|
| 福岡       | 男性   | 500000     |
| 福岡       | 女性   | 450000     |
| 熊本       | 男性   | 300000     |
| 熊本       | 女性   | 280000     |

### 処理のポイント
- `INNER JOIN`ステートメントは、両方のテーブルに一致するレコードを取得するために使用されます。
- `GROUP BY`ステートメントは、特定の列でレコードをグループ化します。
- `HAVING`ステートメントは、グループ化された結果にフィルタを適用します。
- `ORDER BY`ステートメントは、結果を指定された順序で並べ替えます。

これにより、SQLの高度なクエリ操作を効率的に行う方法を理解することができます。

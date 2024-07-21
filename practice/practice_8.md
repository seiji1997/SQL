
## 問題8: 地域別の性別および年代別人口の取得

### 問題文
以下のSQL文を使用して、地域別の性別および年代別の人口を取得してください。

### 回答例
```sql
SELECT
  a.name AS "地域",
  SUM(
    CASE
      WHEN p.gender_code = 'm'
      AND p.generation_code = '1' THEN p.population
      ELSE 0
    END
  ) AS "15 歳未満(男)",
  SUM(
    CASE
      WHEN p.gender_code = 'm'
      AND p.generation_code = '2' THEN p.population
      ELSE 0
    END
  ) AS "15 歳～ 64 歳(男)",
  SUM(
    CASE
      WHEN p.gender_code = 'm'
      AND p.generation_code = '3' THEN p.population
      ELSE 0
    END
  ) AS "65 歳以上(男)",
  SUM(
    CASE
      WHEN p.gender_code = 'f'
      AND p.generation_code = '1' THEN p.population
      ELSE 0
    END
  ) AS "15 歳未満(女)",
  SUM(
    CASE
      WHEN p.gender_code = 'f'
      AND p.generation_code = '2' THEN p.population
      ELSE 0
    END
  ) AS "15 歳～ 64 歳(女)",
  SUM(
    CASE
      WHEN p.gender_code = 'f'
      AND p.generation_code = '3' THEN p.population
      ELSE 0
    END
  ) AS "65 歳以上(女)"
FROM
  populations p
  INNER JOIN prefectures pr ON p.prefecture_code = pr.code
  INNER JOIN regions a ON pr.region_code = a.code
GROUP BY
  a.code
ORDER BY
  a.code;
```

### 解説

#### 回答例の説明
このSQL文では、地域別に性別および年代別の人口を取得しています。

- `SELECT a.name AS "地域"`の部分で、`regions`テーブルの名前を`地域`として選択しています。
- 各`SUM(CASE...)`部分で、条件に一致する場合に人口を合計し、一致しない場合は0を合計しています。
- `FROM populations p`の部分で、データの取得元テーブルを`populations`テーブルに指定しています。
- `INNER JOIN prefectures pr ON p.prefecture_code = pr.code`の部分で、`populations`テーブルと`prefectures`テーブルを`prefecture_code`と`code`で内部結合しています。
- `INNER JOIN regions a ON pr.region_code = a.code`の部分で、`prefectures`テーブルと`regions`テーブルを`region_code`と`code`で内部結合しています。
- `GROUP BY a.code`の部分で、地域コードでレコードをグループ化しています。
- `ORDER BY a.code`の部分で、地域コードで結果を並べ替えています。

#### 各処理の詳細

1. **`SUM(CASE...END) AS "15 歳未満(男)"`**:
   - `CASE`文を使用して、`gender_code`が'm'で`generation_code`が'1'の場合に`population`を合計し、それ以外の場合は0を合計します。

2. **`SUM(CASE...END) AS "15 歳～ 64 歳(男)"`**:
   - `gender_code`が'm'で`generation_code`が'2'の場合に`population`を合計し、それ以外の場合は0を合計します。

3. **`SUM(CASE...END) AS "65 歳以上(男)"`**:
   - `gender_code`が'm'で`generation_code`が'3'の場合に`population`を合計し、それ以外の場合は0を合計します。

4. **`SUM(CASE...END) AS "15 歳未満(女)"`**:
   - `gender_code`が'f'で`generation_code`が'1'の場合に`population`を合計し、それ以外の場合は0を合計します。

5. **`SUM(CASE...END) AS "15 歳～ 64 歳(女)"`**:
   - `gender_code`が'f'で`generation_code`が'2'の場合に`population`を合計し、それ以外の場合は0を合計します。

6. **`SUM(CASE...END) AS "65 歳以上(女)"`**:
   - `gender_code`が'f'で`generation_code`が'3'の場合に`population`を合計し、それ以外の場合は0を合計します。

7. **`INNER JOIN prefectures pr ON p.prefecture_code = pr.code`**:
   - `populations`テーブルの`prefecture_code`列と`prefectures`テーブルの`code`列を基準に内部結合します。

8. **`INNER JOIN regions a ON pr.region_code = a.code`**:
   - `prefectures`テーブルの`region_code`列と`regions`テーブルの`code`列を基準に内部結合します。

9. **`GROUP BY a.code`**:
   - 地域コードでレコードをグループ化します。

10. **`ORDER BY a.code`**:
   - 地域コードで結果を並べ替えます。

### 入出力例

#### 入力
```sql
SELECT
  a.name AS "地域",
  SUM(
    CASE
      WHEN p.gender_code = 'm'
      AND p.generation_code = '1' THEN p.population
      ELSE 0
    END
  ) AS "15 歳未満(男)",
  SUM(
    CASE
      WHEN p.gender_code = 'm'
      AND p.generation_code = '2' THEN p.population
      ELSE 0
    END
  ) AS "15 歳～ 64 歳(男)",
  SUM(
    CASE
      WHEN p.gender_code = 'm'
      AND p.generation_code = '3' THEN p.population
      ELSE 0
    END
  ) AS "65 歳以上(男)",
  SUM(
    CASE
      WHEN p.gender_code = 'f'
      AND p.generation_code = '1' THEN p.population
      ELSE 0
    END
  ) AS "15 歳未満(女)",
  SUM(
    CASE
      WHEN p.gender_code = 'f'
      AND p.generation_code = '2' THEN p.population
      ELSE 0
    END
  ) AS "15 歳～ 64 歳(女)",
  SUM(
    CASE
      WHEN p.gender_code = 'f'
      AND p.generation_code = '3' THEN p.population
      ELSE 0
    END
  ) AS "65 歳以上(女)"
FROM
  populations p
  INNER JOIN prefectures pr ON p.prefecture_code = pr.code
  INNER JOIN regions a ON pr.region_code = a.code
GROUP BY
  a.code
ORDER BY
  a.code;
```

#### 出力
| 地域 | 15 歳未満(男) | 15 歳～ 64 歳(男) | 65 歳以上(男) | 15 歳未満(女) | 15 歳～ 64 歳(女) | 65 歳以上(女) |
|------|---------------|-------------------|---------------|---------------|-------------------|---------------|
| 北海道 | 50000         | 300000            | 150000        | 48000         | 290000            | 160000        |
| 東北   | 30000         | 200000            | 100000        | 28000         | 190000            | 110000        |

### 処理のポイント
- `CASE`文を使用して、条件に応じた値を合計することができます。
- `INNER JOIN`ステートメントは、両方のテーブルに一致するレコードを取得するために使用されます。
- `GROUP BY`ステートメントは、特定の列でレコードをグループ化します。
- `ORDER BY`ステートメントは、結果を指定された順序で並べ替えます。

これにより、SQLの条件付き集計操作を効率的に行う方法を理解することができます。

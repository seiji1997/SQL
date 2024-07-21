
# SQL 問題と解説

## 問題

`populations`テーブルには都道府県、世代、性別ごとの人口データが含まれています。また、`prefectures`および`regions`テーブルも存在します。このデータを使用して、地域ごとの人口を以下のカテゴリーに分けて計算するSQLクエリを書いてください：
- 15歳未満の男性人口
- 15歳から64歳までの男性人口
- 65歳以上の男性人口
- 15歳未満の女性人口
- 15歳から64歳までの女性人口
- 65歳以上の女性人口

結果には地域名と各カテゴリーの総人口を表示してください。

## 解答

以下は、この要件を満たすSQLクエリです：

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

## 解説

1. **地域名の選択**:
   - クエリは `a.name AS "地域"` を使用して地域名を選択します。

2. **各カテゴリーの人口を計算**:
   - クエリは `SUM` 関数と `CASE` 文を組み合わせて各カテゴリーの総人口を計算します。
   - 各 `CASE` 文は特定の性別と世代コードをチェックし、条件が満たされた場合は人口を返し、それ以外の場合は0を返します。
   - これらの合計は以下の各カテゴリーについて別々に計算されます：
     - 15歳未満の男性人口： `WHEN p.gender_code = 'm' AND p.generation_code = '1'`
     - 15歳から64歳までの男性人口： `WHEN p.gender_code = 'm' AND p.generation_code = '2'`
     - 65歳以上の男性人口： `WHEN p.gender_code = 'm' AND p.generation_code = '3'`
     - 15歳未満の女性人口： `WHEN p.gender_code = 'f' AND p.generation_code = '1'`
     - 15歳から64歳までの女性人口： `WHEN p.gender_code = 'f' AND p.generation_code = '2'`
     - 65歳以上の女性人口： `WHEN p.gender_code = 'f' AND p.generation_code = '3'`

3. **テーブルの結合**:
   - `populations` テーブルは `prefecture_code` で `prefectures` テーブルと結合され、 `region_code` を取得します。
   - 次に `prefectures` テーブルは `region_code` で `regions` テーブルと結合され、地域名を取得します。

4. **グループ化と順序付け**:
   - 結果は地域コード (`a.code`) でグループ化され、各地域の人口が正しく合計されるようにします。
   - 結果は地域コード (`a.code`) で順序付けされ、一貫した順序で地域が表示されます。

## 例

### 入力テーブル

**populations**:
| prefecture_code | generation_code | gender_code | population |
|-----------------|-----------------|-------------|------------|
| 01              | 1               | m           | 335353     |
| 02              | 1               | m           | 87585      |
| ...             | ...             | ...         | ...        |

**prefectures**:
| code | region_code | name  | acreage |
|------|-------------|-------|---------|
| 01   | 10          | 北海道 | 83456.87|
| 02   | 20          | 青森県 | 9644.54 |
| ...  | ...         | ...   | ...     |

**regions**:
| code | name      |
|------|-----------|
| 10   | 北海道    |
| 20   | 東北      |
| ...  | ...       |

### 出力

| 地域 | 15 歳未満(男) | 15 歳～ 64 歳(男) | 65 歳以上(男) | 15 歳未満(女) | 15 歳～ 64 歳(女) | 65 歳以上(女) |
|------|---------------|-------------------|---------------|---------------|-------------------|---------------|
| 北海道 | 335353        | 1695591            | 567141        | 321959        | 1786578            | 790927        |
| 東北   | 87585         | 414888             | 140636        | 84257         | 428699             | 212132        |
| ...  | ...           | ...               | ...           | ...           | ...               | ...           |

この例では、人口が集計され、地域ごとに表示されます。

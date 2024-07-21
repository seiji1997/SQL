
## 問題6: 総人口の取得

### 問題文
以下のSQL文を使用して、`populations`テーブルの総人口を取得してください。

### 回答例
```sql
SELECT
  SUM(population) AS population
FROM
  populations;
```

### 解説

#### 回答例の説明
このSQL文では、`populations`テーブルの`population`列の値を合計し、総人口を取得しています。

- `SELECT SUM(population) AS population`の部分で、`population`列の合計を計算し、その結果を`population`として選択しています。
- `FROM populations`の部分で、データの取得元テーブルを`populations`テーブルに指定しています。

#### 各処理の詳細

1. **`SUM(population) AS population`**:
   - `SUM`関数を使用して、`population`列の値を合計します。
   - 例えば、`population`列に100、200、300の値が含まれている場合、`SUM(population)`は600になります。
   - 計算結果を`population`というエイリアス名で選択しています。

2. **`FROM populations`**:
   - データの取得元テーブルを`populations`テーブルに指定しています。

### 入出力例

#### 入力
```sql
SELECT
  SUM(population) AS population
FROM
  populations;
```

#### 出力
| population |
|------------|
| 1000000    |

### 処理のポイント
- `SUM`関数は、指定した列の全ての値の合計を計算します。
- テーブル全体の合計を計算する場合に便利です。

これにより、SQLの集計関数を効率的に使用する方法を理解することができます。

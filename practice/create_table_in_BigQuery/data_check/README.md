# BigQuery データチェック用SQLスクリプト

このディレクトリには、BigQueryでテーブルに挿入されたデータの整合性をチェックするためのSQLスクリプトが含まれています。これらのスクリプトを使用することで、データの欠損や不整合を検出し、データ品質を保証することができます。

## ディレクトリ構造

- `data_check/`
  - `categories_data_check.sql`
  - `items_data_check.sql`
  - `employees_data_check.sql`
  - `regions_data_check.sql`
  - `prefectures_data_check.sql`
  - `genders_data_check.sql`
  - `generations_data_check.sql`
  - `populations_data_check.sql`

### `data_check/`

このディレクトリには、各テーブルに対してデータの整合性をチェックするためのSQLスクリプトが含まれています。

#### `categories_data_check.sql`

このファイルには、`categories` テーブルのデータ整合性をチェックするためのSQLクエリが含まれています。以下のチェックを行います：
- `id` または `name` が `NULL` でないか
- `name` に不正な文字（`"` など）が含まれていないか
- `id` が正しい形式であるか
- 重複するレコードがないか

#### `items_data_check.sql`

このファイルには、`items` テーブルのデータ整合性をチェックするためのSQLクエリが含まれています。以下のチェックを行います：
- `id`、`category_id`、`name`、`price` が `NULL` でないか
- `name` に不正な文字（`"` など）が含まれていないか
- `id`、`category_id`、`price` が正しい形式であるか
- 重複するレコードがないか

#### `employees_data_check.sql`

このファイルには、`employees` テーブルのデータ整合性をチェックするためのSQLクエリが含まれています。以下のチェックを行います：
- `id`、`name`、`email`、`start_date` が `NULL` でないか
- `name`、`email` に不正な文字（`"` など）が含まれていないか
- `id` が正しい形式であるか
- `email` の形式が正しいか
- `start_date`、`end_date` が正しい日付形式であるか
- 重複するレコードがないか

#### `regions_data_check.sql`

このファイルには、`regions` テーブルのデータ整合性をチェックするためのSQLクエリが含まれています。以下のチェックを行います：
- `code` または `name` が `NULL` でないか
- `name` に不正な文字（`"` など）が含まれていないか
- `code` が正しい形式であるか
- 重複するレコードがないか

#### `prefectures_data_check.sql`

このファイルには、`prefectures` テーブルのデータ整合性をチェックするためのSQLクエリが含まれています。以下のチェックを行います：
- `code`、`region_code`、`name`、`acreage` が `NULL` でないか
- `name` に不正な文字（`"` など）が含まれていないか
- `code`、`region_code`、`acreage` が正しい形式であるか
- 重複するレコードがないか

#### `genders_data_check.sql`

このファイルには、`genders` テーブルのデータ整合性をチェックするためのSQLクエリが含まれています。以下のチェックを行います：
- `code` または `name` が `NULL` でないか
- `name` に不正な文字（`"` など）が含まれていないか
- `code` が正しい形式であるか
- 重複するレコードがないか

#### `generations_data_check.sql`

このファイルには、`generations` テーブルのデータ整合性をチェックするためのSQLクエリが含まれています。以下のチェックを行います：
- `code` または `label` が `NULL` でないか
- `label` に不正な文字（`"` など）が含まれていないか
- `code` が正しい形式であるか
- 重複するレコードがないか

#### `populations_data_check.sql`

このファイルには、`populations` テーブルのデータ整合性をチェックするためのSQLクエリが含まれています。以下のチェックを行います：
- `prefecture_code`、`generation_code`、`gender_code`、`population` が `NULL` でないか
- `prefecture_code`、`generation_code`、`gender_code` に不正な文字（`"` など）が含まれていないか
- `prefecture_code`、`generation_code`、`gender_code`、`population` が正しい形式であるか
- 重複するレコードがないか

## 使用方法

1. **BigQuery コンソールへのアクセス**
   - GCPコンソールにログインし、BigQueryを選択します。

2. **データチェックの実行**
   - 各ファイルの内容をコピーし、BigQueryのクエリエディタに貼り付けて実行します。これにより、指定されたテーブルに対してデータ整合性チェックが行われます。
   - 例：`categories_data_check.sql` ファイルの内容をコピーし、クエリエディタに貼り付けて実行します。

3. **結果の確認**
   - クエリの実行結果を確認し、エラーが検出された場合は該当するレコードを修正してください。

## 用途

これらのデータチェック用SQLスクリプトは、BigQueryに挿入されたデータの品質を保証するために使用されます。データの欠損や不整合を早期に検出し、適切な修正を行うことで、信頼性の高いデータベースを維持することができます。

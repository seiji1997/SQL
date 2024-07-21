# SQL Practice

このリポジトリは、SQLの練習用として作成されたもので、さまざまなSQLクエリやデータベース操作の例が含まれています。特にBigQueryを使用したテーブルの作成やデータ操作についての演習が含まれています。

## ディレクトリ構造

- `practice/`
  - `create_table_in_BigQuery/`
    - `create_tables.sql`
    - `insert_data.sql`
    - `data_checks.sql`
    - `README.md`
  - `practice_1.md`
  - `practice_2.md`
  - `practice_3.md`
  - `practice_4.md`
  - `practice_5.md`
  - `practice_6.md`
  - `practice_7.md`
  - `practice_8.md`
  - `create_practice_files.zsh`

### `practice/`

このディレクトリは、SQLのさまざまな練習問題や実践的なクエリが含まれているメインディレクトリです。

### `create_table_in_BigQuery/`

このサブディレクトリには、BigQueryを使用してテーブルを作成し、データを挿入し、データをチェックするためのSQLスクリプトが含まれています。各スクリプトの内容と使用方法については、以下の通りです。

#### `create_tables.sql`

このファイルには、BigQueryでテーブルを作成するためのSQLスクリプトが含まれています。以下のテーブルが含まれます：

- `categories`
- `items`
- `employees`
- `regions`
- `prefectures`
- `genders`
- `generations`
- `populations`

各テーブルのスキーマ定義が記載されており、実行することでこれらのテーブルをBigQuery内に作成できます。

#### `insert_data.sql`

このファイルには、各テーブルにデータを挿入するためのSQLスクリプトが含まれています。各テーブルに対して適切なデータを一括で挿入するためのクエリが記載されています。

#### `data_checks.sql`

このファイルには、挿入されたデータの整合性をチェックするためのSQLクエリが含まれています。データの欠損や不整合を検出するためのクエリが記載されており、データ品質を保証するために使用されます。

#### `README.md`

このファイルには、`create_table_in_BigQuery` ディレクトリ内の各ファイルの説明と使用方法が記載されています。

### `practice_1.md` ~ `practice_8.md`

これらのファイルには、SQLの練習問題とその回答が含まれています。各ファイルの内容は以下の通りです：

- `practice_1.md`：基本的なSELECT文の演習問題と解説
- `practice_2.md`：テーブル結合（JOIN）の演習問題と解説
- `practice_3.md`：集計関数とグループ化（GROUP BY）の演習問題と解説
- `practice_4.md`：サブクエリの演習問題と解説
- `practice_5.md`：データの挿入、更新、削除の演習問題と解説
- `practice_6.md`：ウィンドウ関数の演習問題と解説
- `practice_7.md`：データベース設計と正規化の演習問題と解説
- `practice_8.md`：トリガー、ストアドプロシージャの演習問題と解説

各ファイルには、実践的な問題とそれに対する詳細な解説が含まれており、SQLの理解を深めるのに役立ちます。

### `create_practice_files.zsh`

このファイルは、`practice` ディレクトリ内のファイルを自動的に作成するためのZshスクリプトです。具体的には、各練習問題ファイル（`practice_1.md` から `practice_8.md`）を作成し、それぞれにテンプレートとなる内容を記載します。

#### 使用方法

1. ターミナルを開き、`practice` ディレクトリに移動します。
2. 以下のコマンドを実行して、スクリプトに実行権限を付与します：

   ```sh
   chmod +x create_practice_files.zsh
   ./create_practice_files.zsh
   ```

スクリプトの実行後、practice_1.md から practice_8.md までのファイルが作成され、それぞれにテンプレートが記載されます。


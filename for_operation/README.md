# SQL

### study plan 2023/10/1 - 2024/12/31
- 1 [Complete SQL and Databases Bootcamp: Zero to Mastery [2023]](https://www.udemy.com/course/complete-sql-databases-bootcamp-zero-to-mastery/learn/lecture/21449296?start=1#overview)

- 2 [The Complete SQL Bootcamp: Go from Zero to Hero](https://www.udemy.com/course/the-complete-sql-bootcamp/)


```sql
-- ============================================================
-- MDM PRE-VALIDATION - 32 CASE TEST
--
-- 目的:
--   Stored Procedureの主要な業務バリデーションを32ケースで確認する。
--
-- 期待結果:
--   最終結果が32行出力され、すべて「判定 = OK」となること。
-- ============================================================

-- ============================================================
-- 0. 実行環境・項目設定
-- ============================================================

SET APP_DATABASE = '__PHY_APP_DATABASE__';
SET APP_SCHEMA = '__PHY_APP_SCHEMA__';
SET PROCEDURE_FQN = '__PHY_PROCEDURE_FQN__';

USE DATABASE IDENTIFIER($APP_DATABASE);
USE SCHEMA IDENTIFIER($APP_SCHEMA);

SET MASTER_TYPE_A = '__PHY_MASTER_TYPE_A__';
SET MASTER_TYPE_B = '__PHY_MASTER_TYPE_B__';

SET COL_A_ID = '__PHY_MA_ID_COLUMN__';
SET COL_B_ID = '__PHY_MB_ID_COLUMN__';
SET COL_B_TO_A = '__PHY_MB_TO_MA_INPUT_COLUMN__';
SET COL_REF_A = '__PHY_RA_INPUT_COLUMN__';
SET COL_REF_B = '__PHY_RB_INPUT_COLUMN__';
SET COL_REF_C = '__PHY_RC_INPUT_COLUMN__';
SET COL_REF_D = '__PHY_RD_INPUT_COLUMN__';
SET COL_REF_E = '__PHY_RE_INPUT_COLUMN__';

-- 最終結果に表示する業務名称
SET LABEL_MASTER_A = '__SEM_MASTER_A_LABEL__';
SET LABEL_MASTER_B = '__SEM_MASTER_B_LABEL__';
SET LABEL_REF_A = '__SEM_REF_A_LABEL__';
SET LABEL_REF_B = '__SEM_REF_B_LABEL__';
SET LABEL_REF_C = '__SEM_REF_C_LABEL__';
SET LABEL_REF_D = '__SEM_REF_D_LABEL__';
SET LABEL_REF_E = '__SEM_REF_E_LABEL__';

-- ============================================================
-- 1. テストデータ設定
--
-- EXISTING / VALID:
--   対象Masterに実在し、参照関係が成立する値を指定する。
--
-- NEW / MISSING / INVALID:
--   対象Masterに存在しない値を指定する。
--
-- VALID_REF_C / D / E:
--   3項目の組合せとして成立する値を指定する。
-- ============================================================

SET EXISTING_A_ID = '__TEST_EXISTING_A_ID__';
SET ANOTHER_EXISTING_A_ID = '__TEST_ANOTHER_EXISTING_A_ID__';
SET EXISTING_B_ID = '__TEST_EXISTING_B_ID__';

SET NEW_A_ID = '__TEST_NEW_A_ID__';
SET MISSING_A_ID = '__TEST_MISSING_A_ID__';
SET NEW_B_ID = '__TEST_NEW_B_ID__';
SET MISSING_B_ID = '__TEST_MISSING_B_ID__';

SET VALID_REF_A = '__TEST_VALID_REF_A__';
SET VALID_REF_B = '__TEST_VALID_REF_B__';
SET VALID_REF_C = '__TEST_VALID_REF_C__';
SET VALID_REF_D = '__TEST_VALID_REF_D__';
SET VALID_REF_E = '__TEST_VALID_REF_E__';

-- EXISTING_A_IDのDB上の現行Ref Cと組み合わせて成立するRef D
SET VALID_REF_D_FOR_CURRENT_C = '__TEST_VALID_REF_D_FOR_CURRENT_C__';

-- EXISTING_A_IDのDB上の現行Ref C / Ref Dと組み合わせて成立するRef E
SET VALID_REF_E_FOR_CURRENT_C_D = '__TEST_VALID_REF_E_FOR_CURRENT_C_D__';

SET INVALID_REF_A = '__TEST_INVALID_REF_A__';
SET INVALID_REF_B = '__TEST_INVALID_REF_B__';
SET INVALID_REF_C = '__TEST_INVALID_REF_C__';
SET INVALID_REF_D = '__TEST_INVALID_REF_D__';
SET INVALID_REF_E = '__TEST_INVALID_REF_E__';

-- ============================================================
-- 2. 一時テーブル作成
-- ============================================================

CREATE OR REPLACE TEMP TABLE MDM_SMOKE_CASES (
    TEST_NO NUMBER,
    VALIDATION VARCHAR,
    OPERATION VARCHAR,
    FILE_NAME VARCHAR,
    EXPECTED_CHECK_ID VARCHAR,
    EXPECTED_STATUS VARCHAR,
    PAYLOAD VARCHAR
);

CREATE OR REPLACE TEMP TABLE MDM_SMOKE_RAW (
    TEST_NO NUMBER,
    VALIDATION VARCHAR,
    EXPECTED_CHECK_ID VARCHAR,
    EXPECTED_STATUS VARCHAR,
    RAW_RESULT VARIANT,
    ERROR_MESSAGE VARCHAR
);

-- ============================================================
-- 3. 32ケースのテストデータ作成
-- ============================================================

INSERT INTO MDM_SMOKE_CASES
SELECT
    1,
    CONCAT($LABEL_MASTER_A, ' 登録：既存IDを指定した場合、重複チェックがNGになること'),
    'I',
    't01.csv',
    'ID001',
    'NG',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    $VALID_REF_A,
                    $COL_REF_B,
                    $VALID_REF_B,
                    $COL_REF_C,
                    $VALID_REF_C,
                    $COL_REF_D,
                    $VALID_REF_D,
                    $COL_REF_E,
                    $VALID_REF_E,
                    'UPD_FLAG',
                    'I'
                )
            )
        )
    ))

UNION ALL

SELECT
    2,
    CONCAT($LABEL_MASTER_A, ' 登録：新規IDを指定した場合、重複チェックがOKになること'),
    'I',
    't02.csv',
    'ID001',
    'OK',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $NEW_A_ID,
                    $COL_REF_A,
                    $VALID_REF_A,
                    $COL_REF_B,
                    $VALID_REF_B,
                    $COL_REF_C,
                    $VALID_REF_C,
                    $COL_REF_D,
                    $VALID_REF_D,
                    $COL_REF_E,
                    $VALID_REF_E,
                    'UPD_FLAG',
                    'I'
                )
            )
        )
    ))

UNION ALL

SELECT
    3,
    CONCAT($LABEL_MASTER_A, ' 更新：既存IDを指定した場合、存在チェックがOKになること'),
    'U',
    't03.csv',
    'ID002',
    'OK',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    '-',
                    $COL_REF_D,
                    '-',
                    $COL_REF_E,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    4,
    CONCAT($LABEL_MASTER_A, ' 更新：未存在IDを指定した場合、存在チェックがNGになること'),
    'U',
    't04.csv',
    'ID002',
    'NG',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $MISSING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    '-',
                    $COL_REF_D,
                    '-',
                    $COL_REF_E,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    5,
    CONCAT($LABEL_MASTER_B, ' 登録：既存IDを指定した場合、重複チェックがNGになること'),
    'I',
    't05.csv',
    'ID001',
    'NG',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_B,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_B_ID,
                    $EXISTING_B_ID,
                    $COL_B_TO_A,
                    $EXISTING_A_ID,
                    'UPD_FLAG',
                    'I'
                )
            )
        )
    ))

UNION ALL

SELECT
    6,
    CONCAT($LABEL_MASTER_B, ' 登録：参照先', $LABEL_MASTER_A, 'が存在する場合、参照整合性チェックがOKになること'),
    'I',
    't06.csv',
    'REF101',
    'OK',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_B,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_B_ID,
                    $NEW_B_ID,
                    $COL_B_TO_A,
                    $EXISTING_A_ID,
                    'UPD_FLAG',
                    'I'
                )
            )
        )
    ))

UNION ALL

SELECT
    7,
    CONCAT($LABEL_MASTER_B, ' 登録：参照先', $LABEL_MASTER_A, 'が存在しない場合、参照整合性チェックがNGになること'),
    'I',
    't07.csv',
    'REF101',
    'NG',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_B,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_B_ID,
                    $NEW_B_ID,
                    $COL_B_TO_A,
                    $MISSING_A_ID,
                    'UPD_FLAG',
                    'I'
                )
            )
        )
    ))

UNION ALL

SELECT
    8,
    CONCAT($LABEL_MASTER_B, ' 更新：', $LABEL_MASTER_A, '参照が「-」の場合、変更なしとしてSKIPになること'),
    'U',
    't08.csv',
    'REF101',
    'SKIP',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_B,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_B_ID,
                    $EXISTING_B_ID,
                    $COL_B_TO_A,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    9,
    CONCAT($LABEL_MASTER_B, ' 更新：', $LABEL_MASTER_A, '参照が空文字の場合、明示クリアとしてSKIPになること'),
    'U',
    't09.csv',
    'REF101',
    'SKIP',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_B,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_B_ID,
                    $EXISTING_B_ID,
                    $COL_B_TO_A,
                    '',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    10,
    CONCAT($LABEL_MASTER_B, ' 更新：', $LABEL_MASTER_A, '参照を別の既存IDへ変更した場合、参照整合性チェックがOKになること'),
    'U',
    't10.csv',
    'REF101',
    'OK',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_B,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_B_ID,
                    $EXISTING_B_ID,
                    $COL_B_TO_A,
                    $ANOTHER_EXISTING_A_ID,
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    11,
    CONCAT($LABEL_REF_A, '：存在する値を指定した場合、参照整合性チェックがOKになること'),
    'U',
    't11.csv',
    'REF201',
    'OK',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    $VALID_REF_A,
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    '-',
                    $COL_REF_D,
                    '-',
                    $COL_REF_E,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    12,
    CONCAT($LABEL_REF_A, '：存在しない値を指定した場合、参照整合性チェックがNGになること'),
    'U',
    't12.csv',
    'REF201',
    'NG',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    $INVALID_REF_A,
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    '-',
                    $COL_REF_D,
                    '-',
                    $COL_REF_E,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    13,
    CONCAT($LABEL_REF_A, '：更新値が「-」の場合、変更なしとしてSKIPになること'),
    'U',
    't13.csv',
    'REF201',
    'SKIP',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    '-',
                    $COL_REF_D,
                    '-',
                    $COL_REF_E,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    14,
    CONCAT($LABEL_REF_B, '：存在する値を指定した場合、参照整合性チェックがOKになること'),
    'U',
    't14.csv',
    'REF202',
    'OK',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    $VALID_REF_B,
                    $COL_REF_C,
                    '-',
                    $COL_REF_D,
                    '-',
                    $COL_REF_E,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    15,
    CONCAT($LABEL_REF_B, '：存在しない値を指定した場合、参照整合性チェックがNGになること'),
    'U',
    't15.csv',
    'REF202',
    'NG',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    $INVALID_REF_B,
                    $COL_REF_C,
                    '-',
                    $COL_REF_D,
                    '-',
                    $COL_REF_E,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    16,
    CONCAT($LABEL_REF_C, '：存在する値を指定した場合、参照整合性チェックがOKになること'),
    'U',
    't16.csv',
    'REF203',
    'OK',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    $VALID_REF_C,
                    $COL_REF_D,
                    '-',
                    $COL_REF_E,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    17,
    CONCAT($LABEL_REF_C, '：存在しない値を指定した場合、参照整合性チェックがNGになること'),
    'U',
    't17.csv',
    'REF203',
    'NG',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    $INVALID_REF_C,
                    $COL_REF_D,
                    '-',
                    $COL_REF_E,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    18,
    CONCAT($LABEL_REF_C, ' + ', $LABEL_REF_D, '：有効な2項目の組合せの場合、参照整合性チェックがOKになること'),
    'U',
    't18.csv',
    'REF204',
    'OK',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    $VALID_REF_C,
                    $COL_REF_D,
                    $VALID_REF_D,
                    $COL_REF_E,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    19,
    CONCAT($LABEL_REF_C, ' + ', $LABEL_REF_D, '：', $LABEL_REF_C, 'が「-」で', $LABEL_REF_D, 'のみ変更した場合、DB上の現行', $LABEL_REF_C, 'を補完してOKになること'),
    'U',
    't19.csv',
    'REF204',
    'OK',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    '-',
                    $COL_REF_D,
                    $VALID_REF_D_FOR_CURRENT_C,
                    $COL_REF_E,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    20,
    CONCAT($LABEL_REF_C, ' + ', $LABEL_REF_D, '：無効な2項目の組合せの場合、参照整合性チェックがNGになること'),
    'U',
    't20.csv',
    'REF204',
    'NG',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    $VALID_REF_C,
                    $COL_REF_D,
                    $INVALID_REF_D,
                    $COL_REF_E,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    21,
    CONCAT($LABEL_REF_C, ' + ', $LABEL_REF_D, '：両方が「-」の場合、変更なしとしてSKIPになること'),
    'U',
    't21.csv',
    'REF204',
    'SKIP',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    '-',
                    $COL_REF_D,
                    '-',
                    $COL_REF_E,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    22,
    CONCAT($LABEL_REF_C, ' + ', $LABEL_REF_D, ' + ', $LABEL_REF_E, '：有効な3項目の組合せの場合、参照整合性チェックがOKになること'),
    'U',
    't22.csv',
    'REF205',
    'OK',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    $VALID_REF_C,
                    $COL_REF_D,
                    $VALID_REF_D,
                    $COL_REF_E,
                    $VALID_REF_E,
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    23,
    CONCAT($LABEL_REF_C, ' + ', $LABEL_REF_D, ' + ', $LABEL_REF_E, '：', $LABEL_REF_C, ' / ', $LABEL_REF_D, 'が「-」で', $LABEL_REF_E, 'のみ変更した場合、DB上の現行値を補完してOKになること'),
    'U',
    't23.csv',
    'REF205',
    'OK',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    '-',
                    $COL_REF_D,
                    '-',
                    $COL_REF_E,
                    $VALID_REF_E_FOR_CURRENT_C_D,
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    24,
    CONCAT($LABEL_REF_C, ' + ', $LABEL_REF_D, ' + ', $LABEL_REF_E, '：無効な3項目の組合せの場合、参照整合性チェックがNGになること'),
    'U',
    't24.csv',
    'REF205',
    'NG',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    $VALID_REF_C,
                    $COL_REF_D,
                    $VALID_REF_D,
                    $COL_REF_E,
                    $INVALID_REF_E,
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    25,
    CONCAT($LABEL_REF_C, ' + ', $LABEL_REF_D, ' + ', $LABEL_REF_E, '：すべて「-」の場合、変更なしとしてSKIPになること'),
    'U',
    't25.csv',
    'REF205',
    'SKIP',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    '-',
                    $COL_REF_D,
                    '-',
                    $COL_REF_E,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    26,
    CONCAT($LABEL_REF_C, '：単一参照を空文字で明示クリアする場合、SKIPになること'),
    'U',
    't26.csv',
    'REF203',
    'SKIP',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    '',
                    $COL_REF_D,
                    '-',
                    $COL_REF_E,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    27,
    CONCAT($LABEL_REF_C, ' + ', $LABEL_REF_D, '：2項目の一部を空文字で明示クリアする場合、SKIPになること'),
    'U',
    't27.csv',
    'REF204',
    'SKIP',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    '',
                    $COL_REF_D,
                    $VALID_REF_D,
                    $COL_REF_E,
                    '-',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    28,
    CONCAT($LABEL_REF_C, ' + ', $LABEL_REF_D, ' + ', $LABEL_REF_E, '：3項目の一部を空文字で明示クリアする場合、SKIPになること'),
    'U',
    't28.csv',
    'REF205',
    'SKIP',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '-',
                    $COL_REF_B,
                    '-',
                    $COL_REF_C,
                    $VALID_REF_C,
                    $COL_REF_D,
                    $VALID_REF_D,
                    $COL_REF_E,
                    '',
                    'UPD_FLAG',
                    'U'
                )
            )
        )
    ))

UNION ALL

SELECT
    29,
    CONCAT($LABEL_MASTER_A, ' 削除：既存IDを指定した場合、存在・一意性チェックがOKになること'),
    'D',
    't29.csv',
    'ID002',
    'OK',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $EXISTING_A_ID,
                    $COL_REF_A,
                    '',
                    $COL_REF_B,
                    '',
                    $COL_REF_C,
                    '',
                    $COL_REF_D,
                    '',
                    $COL_REF_E,
                    '',
                    'UPD_FLAG',
                    'D'
                )
            )
        )
    ))

UNION ALL

SELECT
    30,
    CONCAT($LABEL_MASTER_A, ' 削除：未存在IDを指定した場合、存在チェックがNGになること'),
    'D',
    't30.csv',
    'ID002',
    'NG',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_A,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_A_ID,
                    $MISSING_A_ID,
                    $COL_REF_A,
                    '',
                    $COL_REF_B,
                    '',
                    $COL_REF_C,
                    '',
                    $COL_REF_D,
                    '',
                    $COL_REF_E,
                    '',
                    'UPD_FLAG',
                    'D'
                )
            )
        )
    ))

UNION ALL

SELECT
    31,
    CONCAT($LABEL_MASTER_B, ' 削除：既存IDを指定した場合、存在・一意性チェックがOKになること'),
    'D',
    't31.csv',
    'ID002',
    'OK',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_B,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_B_ID,
                    $EXISTING_B_ID,
                    $COL_B_TO_A,
                    '',
                    'UPD_FLAG',
                    'D'
                )
            )
        )
    ))

UNION ALL

SELECT
    32,
    CONCAT($LABEL_MASTER_B, ' 削除：未存在IDを指定した場合、存在チェックがNGになること'),
    'D',
    't32.csv',
    'ID002',
    'NG',
    TO_JSON(OBJECT_CONSTRUCT(
        'master_type', $MASTER_TYPE_B,
        'records', ARRAY_CONSTRUCT(
            OBJECT_CONSTRUCT(
                'row_no', 1,
                'record', OBJECT_CONSTRUCT(
                    $COL_B_ID,
                    $MISSING_B_ID,
                    $COL_B_TO_A,
                    '',
                    'UPD_FLAG',
                    'D'
                )
            )
        )
    ))
;

-- ============================================================
-- 4. 32ケース実行
--
-- 各ケースを個別に実行し、1ケースで例外が発生しても
-- 残りのケースを継続して実行する。
-- ============================================================

EXECUTE IMMEDIATE $$
DECLARE
    V_TEST_NO NUMBER;
    V_VALIDATION VARCHAR;
    V_OPERATION VARCHAR;
    V_FILE_NAME VARCHAR;
    V_CHECK_ID VARCHAR;
    V_EXPECTED VARCHAR;
    V_PAYLOAD VARCHAR;
    V_RETURN VARCHAR;

    C_CASES CURSOR FOR
        SELECT
            TEST_NO,
            VALIDATION,
            OPERATION,
            FILE_NAME,
            EXPECTED_CHECK_ID,
            EXPECTED_STATUS,
            PAYLOAD
        FROM MDM_SMOKE_CASES
        ORDER BY TEST_NO;
BEGIN
    FOR REC IN C_CASES DO
        V_TEST_NO := REC.TEST_NO;
        V_VALIDATION := REC.VALIDATION;
        V_OPERATION := REC.OPERATION;
        V_FILE_NAME := REC.FILE_NAME;
        V_CHECK_ID := REC.EXPECTED_CHECK_ID;
        V_EXPECTED := REC.EXPECTED_STATUS;
        V_PAYLOAD := REC.PAYLOAD;
        V_RETURN := NULL;

        BEGIN
            CALL IDENTIFIER($PROCEDURE_FQN)(
                :V_OPERATION,
                :V_FILE_NAME,
                :V_PAYLOAD
            ) INTO :V_RETURN;

            INSERT INTO MDM_SMOKE_RAW (
                TEST_NO,
                VALIDATION,
                EXPECTED_CHECK_ID,
                EXPECTED_STATUS,
                RAW_RESULT,
                ERROR_MESSAGE
            )
            SELECT
                :V_TEST_NO,
                :V_VALIDATION,
                :V_CHECK_ID,
                :V_EXPECTED,
                PARSE_JSON(:V_RETURN),
                NULL;

        EXCEPTION
            WHEN OTHER THEN
                INSERT INTO MDM_SMOKE_RAW (
                    TEST_NO,
                    VALIDATION,
                    EXPECTED_CHECK_ID,
                    EXPECTED_STATUS,
                    RAW_RESULT,
                    ERROR_MESSAGE
                )
                SELECT
                    :V_TEST_NO,
                    :V_VALIDATION,
                    :V_CHECK_ID,
                    :V_EXPECTED,
                    NULL,
                    :SQLERRM;
        END;
    END FOR;

    RETURN 'SMOKE TEST COMPLETED';
END;
$$;

-- ============================================================
-- 5. 最終結果一覧
-- ============================================================

WITH STATUS_MATRIX AS (
    SELECT
        R.TEST_NO,
        R.VALIDATION,
        R.EXPECTED_CHECK_ID,
        R.EXPECTED_STATUS,
        R.ERROR_MESSAGE,
        COALESCE(
            MAX(
                IFF(
                    F.VALUE:check_id::STRING =
                        R.EXPECTED_CHECK_ID,
                    F.VALUE:status::STRING,
                    NULL
                )
            ),
            IFF(
                R.ERROR_MESSAGE IS NOT NULL,
                'ERROR',
                'NOT_RUN'
            )
        ) AS ACTUAL_STATUS
    FROM MDM_SMOKE_RAW R,
         LATERAL FLATTEN(
             INPUT => R.RAW_RESULT:results,
             OUTER => TRUE
         ) F
    GROUP BY
        R.TEST_NO,
        R.VALIDATION,
        R.EXPECTED_CHECK_ID,
        R.EXPECTED_STATUS,
        R.ERROR_MESSAGE
)
SELECT
    TEST_NO AS "#",
    VALIDATION AS "検証内容",
    EXPECTED_CHECK_ID AS "チェックID",
    EXPECTED_STATUS AS "期待結果",
    ACTUAL_STATUS AS "実結果",
    IFF(
        ACTUAL_STATUS = EXPECTED_STATUS,
        'OK',
        'NG'
    ) AS "判定",
    ERROR_MESSAGE AS "エラー"
FROM STATUS_MATRIX
ORDER BY TEST_NO;

```

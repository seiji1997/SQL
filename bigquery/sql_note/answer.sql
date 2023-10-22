-- 31
SELECT
  *
FROM
  sample.customers
WHERE
  name LIKE "山%子"

-- 32
SELECT
  *
FROM
  sample.customers
ORDER BY
  RAND()
LIMIT 3


-- 33
SELECT
  CORR(quantity, revenue) AS corr
FROM
  sample.sales


-- 34
SELECT
  STDDEV_POP(cost) AS std_dev_cost
FROM
  sample.products


-- 35
SELECT
  date_time AS oldest_datetime
FROM
  sample.sales
ORDER BY
  date_time
LIMIT 1


-- 36
SELECT
  order_id
  , user_id
  , revenue
FROM
  sample.sales
ORDER BY
  revenue DESC
LIMIT 1


-- 37
SELECT
  *
FROM
  sample.sales
WHERE
  product_id = 5
AND revenue > 8000
ORDER BY
  order_id


-- 38
SELECT
  date_time
FROM
  sample.web_log
WHERE
  media = "cpc"
ORDER BY
  date_time
LIMIT 1


-- 39
SELECT
  date_time
FROM
  sample.sales
WHERE
  is_proper IS FALSE
ORDER BY
  date_time
LIMIT 1


-- 40
SELECT
  birthday
FROM
  sample.customers
WHERE
  birthday IS NOT NULL
ORDER BY
  birthday
LIMIT 1


-- 41
SELECT
  VAR_POP(cost) AS var_cost
FROM
  sample.products
WHERE
  product_category NOT IN("ゼリー")



-- 42
SELECT
  user_id
FROM
  sample.sales
WHERE
  MOD(order_id, 3) = 0
AND MOD(order_id, 7) = 0
ORDER BY
  1
LIMIT 1


-- 43
SELECT
  FORMAT_DATETIME("%F", date_time) AS newest_date
FROM
  sample.sales
ORDER BY
  date_time DESC
LIMIT 1


-- 44
SELECT
  *
FROM
  sample.customers
WHERE
  name LIKE("%子")
AND birthday IS NOT NULL
ORDER BY
  birthday
LIMIT 1


-- 45
SELECT
  *
FROM
  sample.customers
WHERE
  FORMAT_DATE("%m-%d", birthday) = FORMAT_DATE("%m-%d", register_date)



-- 46
SELECT
  *
FROM
  sample.customers
WHERE
  prefecture IN("福岡", "長崎", "佐賀")
AND is_premium IS TRUE
ORDER BY
  user_id


-- 47
SELECT
  *
FROM
  sample.sales
WHERE
  date_time BETWEEN "2017-02-01" AND "2017-02-10"
ORDER BY
  revenue DESC
LIMIT 1


-- 48
SELECT
  user_id
  , name
FROM
  sample.customers
WHERE
  SUBSTR(name, 1, STRPOS(name, " ") - 1) LIKE "%山"
AND gender = 1


-- 49
SELECT
  name
  , birthday
  , register_date
FROM
  sample.customers
WHERE
  birthday IS NULL
AND register_date IS NOT NULL


-- 50
SELECT
  *
FROM
  sample.products
WHERE
  product_category = "クッキー"
AND REGEXP_CONTAINS(product_name, r"クッキー$") = false



-- 51
SELECT
  DATE_DIFF(current_date(), birthday, YEAR) AS current_age
FROM
  sample.customers
ORDER BY
  birthday DESC
LIMIT 1


-- 52
SELECT
  DATE_DIFF("2019-12-31", birthday, YEAR) AS youngest_age
FROM
  sample.customers
ORDER BY
  birthday DESC
LIMIT 1


-- 53
SELECT
  CONCAT(product_category, "-", product_name) AS cat_prod
  , cost
FROM
  sample.products
ORDER BY
  cost DESC
LIMIT 3



-- 54
SELECT
  *
FROM
  sample.sales
WHERE
  product_id IN(7, 9, 11)
AND quantity >= 2
AND is_proper IS NOT TRUE
ORDER BY
  order_id


-- 55
SELECT
  user_id
  , name
  , birthday
FROM
  sample.customers
WHERE
  EXTRACT(DAYOFWEEK FROM birthday) = 2
ORDER BY
  birthday
LIMIT 1


-- 56
SELECT
  name
  , birthday
FROM
  sample.customers
WHERE
  birthday IS NOT NULL
AND SUBSTR(name, 1, 1) = "川"
ORDER BY
  birthday
LIMIT 3


-- 57
SELECT
  *
FROM
  sample.sales
WHERE
  FORMAT_DATETIME("%m", date_time) = "01"
AND FORMAT_DATETIME("%d", date_time) = "01"
ORDER BY
  order_id


-- 58
SELECT
  IF(
    gender = 1
    , CONCAT(name, "様")
    , CONCAT(name, "さま")
  ) AS name_sama
FROM
  sample.customers
ORDER BY
  register_date DESC
LIMIT 5



-- 59
SELECT
  product_name
  , REGEXP_REPLACE(product_name, r"ゼリー$", "ジュレ") 
  AS modified_name
FROM
  sample.products
WHERE
  STRPOS(product_name, "ゼリー") > 0



-- 60
SELECT
  user_id
  , name
FROM
  sample.customers
WHERE
  LENGTH(SUBSTR(name, 1, STRPOS(name, " ") - 1)) = 3
AND LENGTH(SUBSTR(name, STRPOS(name, " ") + 1)) = 3



-- 61
SELECT
  page
  , REPLACE(page, "?sys=abc123", "")  AS page_without_parameter
FROM
  sample.web_log
WHERE
  STRPOS(page, "?sys=abc123") > 0
ORDER BY
  date_time
LIMIT 3



-- 62
SELECT
  page
  , REGEXP_EXTRACT(page, r"^/prod/prod_id_(\d\d?)/")  AS product_id
FROM
  sample.web_log
WHERE
  STRPOS(page, "/prod/") > 0
ORDER BY
  date_time
LIMIT 5




-- 63
SELECT
  CONCAT(product_category, "-", product_name) AS cat_prod
  , LENGTH(CONCAT(product_category, "-", product_name)) AS length
FROM
  sample.products
ORDER BY
  length DESC
LIMIT 3



-- 64
SELECT
  name
  , prefecture
  , register_date
  , DATE_ADD(register_date, INTERVAL 10 YEAR) 
  AS aniversary_10
FROM
  sample.customers
WHERE
  gender = 1
AND prefecture = "千葉"
AND register_date IS NOT NULL
ORDER BY
  3



-- 65
SELECT
  user_id
  , name
  , birthday
  , register_date
  , DATE_DIFF(register_date, birthday, YEAR)  AS register_age
FROM
  sample.customers
WHERE
  birthday IS NOT NULL
AND register_date IS NOT NULL
ORDER BY
  register_age
LIMIT 1



-- 66
SELECT
  COUNT(*) AS pageviews
FROM
  sample.web_log


-- 67
SELECT
  AVG(cost) AS avg_cost
FROM
  sample.products



-- 68
SELECT
  MAX(cost) AS max_cost
FROM
  sample.products



-- 69
SELECT
  MAX(revenue) AS max_revenue
FROM
  sample.sales



-- 70
SELECT
  SUM(revenue) AS sum_revenue
FROM
  sample.sales



-- 71
SELECT
  SUM(quantity) AS sum_quantity
FROM
  sample.sales



-- 72
SELECT
  COUNT(DISTINCT cid) AS users
FROM
  sample.web_log


-- 73
SELECT
  COUNT(DISTINCT order_id) AS orders
FROM
  sample.sales



-- 74
SELECT
  COUNT(DISTINCT user_id) AS users
FROM
  sample.sales



-- 75
SELECT
  MAX(date_time) AS max_date_time
FROM
  sample.web_log



-- 76
SELECT
  COUNT(DISTINCT product_id) AS items
FROM
  sample.sales



-- 77
SELECT
  SUM(revenue / 1.1) AS revenue_without_tax
FROM
  sample.sales



-- 78
SELECT
  COUNT(DISTINCT media) AS number_of_media
FROM
  sample.web_log



-- 79
SELECT
  SUM(revenue) AS sum_revenue_1
FROM
  sample.sales
WHERE
  product_id = 1



-- 80
SELECT
  COUNT(*) AS pv_new_visit
FROM
  sample.web_log
WHERE
  session_count = 1




-- 81
SELECT
  COUNT(DISTINCT product_category) AS categories
FROM
  sample.products



-- 82
SELECT
  COUNT(DISTINCT product_id) AS items
FROM
  sample.products
WHERE
  cost <= 300



-- 83
SELECT
  SUM(revenue) / COUNT(DISTINCT user_id) AS avg_rev_by_user
FROM
  sample.sales



-- 84
SELECT
  DATETIME_DIFF(MAX(date_time), MIN(date_time), day) AS days
FROM
  sample.web_log



-- 85
SELECT
  device
  , COUNT(*) AS pageviews
FROM
  sample.web_log
GROUP BY
  device
ORDER BY
  2 DESC



-- 86
SELECT
  COUNT(DISTINCT user_id) AS users
FROM
  sample.customers
WHERE
  prefecture <> "東京"



-- 87
SELECT
  COUNT(DISTINCT user_id) AS users
FROM
  sample.customers
WHERE
  register_date IS NULL



-- 88
SELECT
  COUNT(DISTINCT FORMAT_DATETIME("%F", date_time)) AS unique_days
FROM
  sample.web_log



-- 89
SELECT
  page
  , COUNT(*) AS pageviews
FROM
  sample.web_log
GROUP BY
  page
ORDER BY
  2 DESC
LIMIT 5



-- 90
SELECT
  COUNT(*) AS pageviews_8
FROM
  sample.web_log
WHERE
  SUBSTR(page, 1, 16) = "/prod/prod_id_8/"




-- 91
SELECT
  SUM(quantity) AS sum_qty_14_15
FROM
  sample.sales
WHERE
  product_id = 14
OR  product_id = 15



-- 92
SELECT
  FLOOR(SUM(revenue) / COUNT(DISTINCT order_id) / 100) * 100 AS avg_rev_by_order
FROM
  sample.sales



-- 93
SELECT
  order_id
  , SUM(revenue) AS sum_rev
FROM
  sample.sales
GROUP BY
  order_id
ORDER BY
  2 DESC
LIMIT 1



-- 94
SELECT
  SUM(IF(
      date_time < "2019-10-01"
      , revenue * 1.08
      , revenue * 1.1
    )) AS revenue_with_tax
FROM
  sample.sales



-- 95
SELECT
  SUM(revenue) AS sum_revenue_2019
FROM
  sample.sales
WHERE
  FORMAT_DATETIME("%Y", date_time) = "2019"




-- 96
SELECT
  cost
  , COUNT(*) AS number_of_products
FROM
  sample.products
GROUP BY
  cost
HAVING cost < 500
ORDER BY
  1



-- 97
SELECT
  COUNT(DISTINCT user_id) AS users
FROM
  sample.customers
WHERE
  birthday IS NULL
AND register_date IS NULL




-- 98
SELECT
  COUNT(*) AS pageviews_prod
FROM
  sample.web_log
WHERE
  REGEXP_CONTAINS(page, r"^/prod/prod_id_\d\d?/$") = true




-- 99
SELECT
  COUNT(DISTINCT order_id) AS orders
FROM
  sample.sales
WHERE
  FORMAT_DATETIME("%m", date_time) IN("01", "12")



-- 100
SELECT
  COUNT(DISTINCT user_id) AS users
FROM
  sample.customers
WHERE
  birthday BETWEEN "1980-01-01" AND "1989-12-31"



-- 101
SELECT
  prefecture
  , COUNT(DISTINCT user_id) AS users
FROM
  sample.customers
GROUP BY
  prefecture
ORDER BY
  2 DESC
LIMIT 3



-- 102
SELECT
  COUNT(DISTINCT user_id) AS users
FROM
  sample.customers
WHERE
  FORMAT_DATETIME("%Y-%Q", register_date) = "2019-1"


-- 103
SELECT
  CEIL(SUM(revenue) / COUNT(DISTINCT FORMAT_DATETIME("%F", date_time)) / 100) * 100 AS avg_rev_by_day
FROM
  sample.sales



-- 104
SELECT
  FORMAT_DATETIME("%Y-%p", date_time) AS sales_time
  , SUM(revenue) AS sum_rev
FROM
  sample.sales
GROUP BY
  1
ORDER BY
  1



-- 105
SELECT
  AVG(DATE_DIFF("2019-12-31", birthday, YEAR)) AS avg_age
FROM
  sample.customers
WHERE
  prefecture = "千葉"
AND gender = 2



-- 106
SELECT
  SUM(IF(
      product_id = 1
    AND is_proper IS FALSE
    AND quantity = 1
      , 2000
      , revenue
    )) AS modified_sum_rev
FROM
  sample.sales



-- 107
SELECT
  product_category
  , CAST(AVG(cost) AS int64) AS avg_cost
FROM
  sample.products
GROUP BY
  product_category
ORDER BY
  2 DESC




-- 108
SELECT
  SUM(revenue) AS sum_revenue_5_2019
FROM
  sample.sales
WHERE
  product_id = 5
AND FORMAT_DATETIME("%Y", date_time) = "2019"



-- 109
SELECT
  FORMAT_DATETIME("%Y", date_time) AS year
  , ROUND(AVG(quantity), 2) AS avg_qty
FROM
  sample.sales
GROUP BY
  year
ORDER BY
  year


-- 110
SELECT
  FORMAT_DATETIME("%Y", date_time) AS year
  , COUNT(DISTINCT user_id) AS users
FROM
  sample.sales
GROUP BY
  year
ORDER BY
  year



-- 111
SELECT
  FORMAT_DATETIME("%F", date_time) AS date
  , COUNT(*) AS pageviews
FROM
  sample.web_log
GROUP BY
  date
ORDER BY
  2 DESC
LIMIT 3



-- 112
SELECT
  FORMAT_DATETIME("%H", date_time) AS hour
  , COUNT(*) AS pageviews
FROM
  sample.web_log
GROUP BY
  hour
ORDER BY
  2 DESC
LIMIT 3



-- 113
SELECT
  media
  , COUNT(*) AS pageviews
FROM
  sample.web_log
WHERE
  REGEXP_CONTAINS(page, r"^/prod/") IS FALSE
GROUP BY
  media
ORDER BY
  2 DESC



-- 114
SELECT
  session_count
  , COUNT(DISTINCT cid) AS users
FROM
  sample.web_log
WHERE
  device = "mobile"
AND session_count = 1
GROUP BY
  session_count



-- 115
SELECT
  prefecture
  , COUNT(DISTINCT user_id) AS users
FROM
  sample.customers
WHERE
  register_date IS NULL
GROUP BY
  prefecture
ORDER BY
  2 DESC
LIMIT 3



-- 116
SELECT
  prefecture
  , COUNT(DISTINCT user_id) AS premium_users
FROM
  sample.customers
WHERE
  is_premium IS TRUE
GROUP BY
  prefecture
ORDER BY
  2 DESC
LIMIT 3



-- 117
SELECT
  REGEXP_EXTRACT(name, r"^[^\s]+") AS last_name
  , COUNT(*) AS users
FROM
  sample.customers
WHERE
  gender = 2
GROUP BY
  last_name
HAVING users >= 3
ORDER BY
  2 DESC




-- 118
SELECT
  FORMAT_DATETIME("%B", date_time) AS month
  , COUNT(DISTINCT CONCAT(cid, session_count)) AS session
FROM
  sample.web_log
GROUP BY
  month
ORDER BY
  2 DESC
LIMIT 3



-- 119
SELECT
  COUNT(DISTINCT user_id) AS users
  , COUNT(DISTINCT order_id) AS orders
  , ROUND(COUNT(DISTINCT order_id) / COUNT(DISTINCT user_id), 2) AS avg_orders
FROM
  sample.sales



-- 120
SELECT
  prefecture
  , COUNT(DISTINCT user_id) AS premium_or_male_users
FROM
  sample.customers
WHERE
  is_premium IS TRUE
OR  gender = 1
GROUP BY
  prefecture
ORDER BY
  2 DESC
LIMIT 3



-- 121
SELECT
  FORMAT_DATETIME("%A", date_time) AS day_of_week
  , FORMAT_DATETIME("%H", date_time) AS hour
  , COUNT(*) AS pageviews
FROM
  sample.web_log
GROUP BY
  day_of_week
  , hour
HAVING pageviews >= 60
ORDER BY
  3 DESC



-- 122
SELECT
  CASE
    WHEN cost <= 300 THEN "a.300以下"
    WHEN cost <= 600 THEN "b.301-600"
    WHEN cost <= 900 THEN "c.601-900"
    ELSE "d.901以上"
  END AS cost_category
  , COUNT(*) AS number_of_products
FROM
  sample.products
GROUP BY
  cost_category
ORDER BY
  1



-- 123
SELECT
  CASE
    WHEN prefecture IN("東京", "千葉", "埼玉", "神奈川") THEN "一都三県"
    ELSE "一都三県以外"
  END AS pref_category
  , AVG(DATE_DIFF("2019-12-31", birthday, YEAR)) AS avg_age
  , STDDEV_POP(DATE_DIFF("2019-12-31", birthday, YEAR)) AS stddev_age
FROM
  sample.customers
GROUP BY
  pref_category



-- 124
SELECT
  name
  , SUM(revenue) AS sum_rev
FROM
  sample.sales
  JOIN sample.customers
  USING
    (user_id)
GROUP BY
  name
ORDER BY
  2 DESC
LIMIT 3



-- 125
WITH master AS (
  SELECT
    cid
    , session_count
  FROM
    sample.web_log
  GROUP BY
    cid
    , session_count
)
SELECT
  COUNT(*) AS session
FROM
  master



-- 126
WITH master AS (
  SELECT
    *
  FROM
    sample.sales
    LEFT JOIN sample.customers
    USING
      (user_id)
)
SELECT
  SUM(quantity) AS sum_qty
FROM
  master
WHERE
  gender = 2



-- 127
SELECT
  prefecture
  , SUM(quantity) AS sum_qty
FROM
  sample.sales
  LEFT JOIN sample.customers
  USING
    (user_id)
GROUP BY
  prefecture
ORDER BY
  sum_qty
LIMIT 3



-- 128
WITH master AS (
  SELECT
    *
  FROM
    sample.sales
    LEFT JOIN sample.products
    USING
      (product_id)
)
SELECT
  product_category
  , SUM(quantity) AS sum_qty
  , SUM(revenue) AS sum_rev
FROM
  master
GROUP BY
  1
ORDER BY
  3 DESC



-- 129
WITH master AS (
  SELECT
    user_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    user_id
)
SELECT
  prefecture
  , sum_rev
FROM
  master
  LEFT JOIN sample.customers
  USING
    (user_id)
ORDER BY
  sum_rev DESC
LIMIT 1



-- 130
WITH master AS (
  SELECT
    user_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    user_id
)
SELECT
  MAX(sum_rev) AS max_sum_rev
  , MIN(sum_rev) AS min_sum_rev
  , AVG(sum_rev) AS avg_sum_rev
FROM
  master



-- 131
WITH master AS (
  SELECT
    user_id
    , DATE_DIFF("2019-12-31", birthday, YEAR) AS age
  FROM
    sample.customers
  WHERE
    birthday IS NOT NULL
  AND gender = 1
)
SELECT
  age
  , COUNT(DISTINCT user_id) AS users
FROM
  master
GROUP BY
  age
ORDER BY
  2 DESC
LIMIT 3



-- 132
WITH master AS (
  SELECT
    cid
    , MAX(user_id) AS user_id2
  FROM
    sample.web_log
  GROUP BY
    cid
)
SELECT
  user_id2
  , COUNT(*) AS pageview
FROM
  sample.web_log
  JOIN master
  USING
    (cid)
GROUP BY
  user_id2
HAVING user_id2 IS NOT NULL
ORDER BY
  pageview DESC
LIMIT 3




-- 133
SELECT
  p.product_name
  , SUM(s.revenue) AS sum_rev
FROM
  sample.sales AS s
  LEFT JOIN sample.customers AS c
  USING
    (user_id)
  LEFT JOIN sample.products AS p
  USING
    (product_id)
WHERE
  c.prefecture = "東京"
GROUP BY
  p.product_name
ORDER BY
  sum_rev DESC
LIMIT 3



-- 134
WITH master AS (
  SELECT
    user_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    user_id
)
SELECT
  DATE_DIFF("2019-12-31", birthday, YEAR) AS age
  , sum_rev
FROM
  master
  LEFT JOIN sample.customers
  USING
    (user_id)
WHERE
  gender = 1
ORDER BY
  sum_rev DESC
LIMIT 1



-- 135
WITH master AS (
  SELECT
    CONCAT(cid, session_count) AS session_id
    , MAX(IF( page = "/cart/", 1, 0)) AS cart_reach
    , MAX(IF( page = "/thank_you/", 1, 0)) AS cv
  FROM
    sample.web_log
  GROUP BY
    session_id
)
SELECT
  SUM(cv) / SUM(cart_reach) AS cart_completion_rate
FROM
  master



-- 136
WITH master AS (
  SELECT
    order_id AS orders
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    order_id
)
SELECT
  COUNT(DISTINCT orders) AS count_orders
  , SUM(sum_rev) AS sum_rev
  , SUM(sum_rev) / COUNT(DISTINCT orders) AS average_order_value
FROM
  master



-- 137
WITH all_user AS (
  SELECT
    user_id
  FROM
    sample.sales
  GROUP BY
    user_id
)
, user19 AS (
  SELECT
    user_id
    ,
  FROM
    sample.sales
  WHERE
    EXTRACT(YEAR FROM date_time) = 2019
  GROUP BY
    user_id
)
SELECT
  user_id
FROM
  all_user EXCEPT DISTINCT
  SELECT
    user_id
  FROM
    user19
  ORDER BY
    user_id
  LIMIT 10



-- 138
WITH master AS (
  SELECT
    *
    , FORMAT_DATETIME("%u", date_time) AS day_number
    , FORMAT_DATETIME("%A", date_time) AS day_of_week
  FROM
    sample.web_log
)
SELECT
  day_of_week
  , COUNT(*) AS sum_pv
FROM
  master
GROUP BY
  day_of_week
ORDER BY
  MOD(MAX(cast(day_number AS int64)), 7)



-- 139
WITH master AS (
  SELECT
    user_id
    , SUM(revenue) AS sum_rev
    , SUM(quantity) AS sum_qty
  FROM
    sample.sales
  GROUP BY
    user_id
)
SELECT
  prefecture
  , SUM(sum_rev) / SUM(sum_qty) AS avg_unit_price
FROM
  master
  JOIN sample.customers
  USING
    (user_id)
GROUP BY
  prefecture
ORDER BY
  avg_unit_price DESC
LIMIT 3



-- 140
SELECT
  CASE
    WHEN prefecture IN("東京", "千葉", "埼玉", "神奈川") THEN "東京圏"
    WHEN prefecture IN("大阪", "奈良", "兵庫", "京都") THEN "大阪圏"
    ELSE NULL
  END AS area
  , SUM(revenue) AS sum_rev
FROM
  sample.sales
  LEFT JOIN sample.customers
  USING
    (user_id)
GROUP BY
  area
HAVING area IS NOT NULL
ORDER BY
  sum_rev DESC



-- 141
WITH master AS (
  SELECT
    user_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    user_id
)
SELECT
  DATE_DIFF("2019-12-31", birthday, YEAR) AS age
  , SUM(sum_rev) AS sum_rev
FROM
  master
  LEFT JOIN sample.customers
  USING
    (user_id)
GROUP BY
  age
HAVING age IS NOT NULL
ORDER BY
  sum_rev DESC
LIMIT 3



-- 142
WITH master AS (
  SELECT
    user_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    user_id
)
SELECT
  gender
  , is_premium
  , SUM(sum_rev) AS sum_rev
FROM
  master
  LEFT JOIN sample.customers
  USING
    (user_id)
WHERE
  prefecture = "東京"
GROUP BY
  gender
  , is_premium
ORDER BY
  gender
  , is_premium DESC



-- 143
WITH master AS (
  SELECT
    user_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    user_id
)
SELECT
  IF(is_premium IS TRUE, "premium_users", "standard_users") AS user_category
  , MAX(sum_rev) AS max_revenue_by_customer
FROM
  master
  JOIN sample.customers
  USING
    (user_id)
GROUP BY
  user_category



-- 144
WITH master AS (
  SELECT
    user_id
    , product_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    user_id
    , product_id
)
SELECT
  product_id
  , SUM(sum_rev) AS sum_rev
FROM
  master
  JOIN sample.customers
  USING
    (user_id)
WHERE
  DATE_DIFF("2019-12-31", birthday, YEAR) >= 50
GROUP BY
  product_id
ORDER BY
  sum_rev DESC
LIMIT 3




-- 145
WITH master AS (
  SELECT
    user_id
    , COUNT(DISTINCT order_id) AS orders
  FROM
    sample.sales
  GROUP BY
    user_id
)
SELECT
  CASE gender
    WHEN 1 THEN "男性"
    WHEN 2 THEN "女性"
    ELSE NULL
  END AS gender_cat
  , SUM(orders) AS sum_orders
FROM
  master
  LEFT JOIN sample.customers
  USING
    (user_id)
GROUP BY
  gender_cat
ORDER BY
  sum_orders DESC



-- 146
/*問題に誤字があり、誠に申し訳ありません。以下のとおり訂正させていただきます。

[正] ※末尾に追加
結果テーブルは、yyyy-Qの形式で表記した四半期（register_quarter）と、販売金額合計（sum_rev）の2カラムとしてください。
*/
WITH master AS (
  SELECT
    user_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    user_id
)
SELECT
  FORMAT_DATE("%Y-%Q", IFNULL(register_date, DATE "2016-12-31")) AS register_quarter
  , SUM(sum_rev) AS sum_rev
FROM
  master
  LEFT JOIN sample.customers
  USING
    (user_id)
GROUP BY
  register_quarter
ORDER BY
  sum_rev DESC
LIMIT 3


-- 147
WITH master AS (
  SELECT
    user_id
    , order_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    user_id
    , order_id
)
SELECT
  CASE gender
    WHEN 1 THEN "男性"
    WHEN 2 THEN "女性"
  END AS gender_cat
  , SUM(sum_rev) / COUNT(DISTINCT order_id) AS avg_order_value
FROM
  master
  LEFT JOIN sample.customers
  USING
    (user_id)
GROUP BY
  gender_cat



-- 148
WITH master AS (
  SELECT
    user_id
    , COUNT(DISTINCT order_id) AS orders
  FROM
    sample.sales
  GROUP BY
    user_id
)
SELECT
  IF(gender = 1, "男性", "女性") AS gender
  , AVG(orders) AS avg_order
FROM
  master
  JOIN sample.customers
  USING
    (user_id)
GROUP BY
  gender



-- 149
WITH master AS (
  SELECT
    product_id
    , SUM(revenue) / SUM(quantity) AS avg_unit_price_1
  FROM
    sample.sales
  WHERE
    product_id = 1
  GROUP BY
    product_id
)
, master2 AS (
  SELECT
    SUM(revenue) / SUM(quantity) AS avg_unit_price_all
  FROM
    sample.sales
)
SELECT
  avg_unit_price_1
  , avg_unit_price_all
  , avg_unit_price_1 / avg_unit_price_all AS diff_percent
FROM
  master
  CROSS JOIN master2



-- 150
WITH master AS (
  SELECT
    CASE
      WHEN prefecture IN("東京") THEN "東京"
      WHEN prefecture IN("千葉", "埼玉", "神奈川") THEN "南関東"
      WHEN prefecture IN("栃木", "群馬", "茨城") THEN "北関東"
      ELSE NULL
    END AS region
    , DATE_DIFF("2019-12-31", birthday, YEAR) AS age
  FROM
    sample.customers
  WHERE
    birthday IS NOT NULL
)
SELECT
  region
  , ROUND(AVG(age), 1) AS avg_age
FROM
  master
WHERE
  region IS NOT NULL
GROUP BY
  region
ORDER BY
  2



-- 151
WITH sales AS (
  SELECT
    product_id
    , SUM(quantity) AS sum_qty
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    product_id
)
, web AS (
  SELECT
    CAST(REGEXP_EXTRACT(page, r"^/prod/prod_id_(\d\d?)") AS INT64) AS product_id
    , COUNT(*) AS pageview
  FROM
    sample.web_log
  GROUP BY
    product_id
  HAVING product_id IS NOT NULL
)
SELECT
  product_id
  , sum_qty
  , sum_rev
  , pageview
FROM
  sales
  JOIN web
  USING
    (product_id)
ORDER BY
  pageview DESC
LIMIT 3



-- 152
WITH sales18 AS (
  SELECT
    FORMAT_DATETIME("%Q", date_time) AS quarter
    , SUM(revenue) AS sum_rev18
  FROM
    sample.sales
  WHERE
    FORMAT_DATETIME("%Y", date_time) = "2018"
  GROUP BY
    quarter
)
, sales19 AS (
  SELECT
    FORMAT_DATETIME("%Q", date_time) AS quarter
    , SUM(revenue) AS sum_rev19
  FROM
    sample.sales
  WHERE
    FORMAT_DATETIME("%Y", date_time) = "2019"
  GROUP BY
    quarter
)
SELECT
  quarter
  , sum_rev19 / sum_rev18 AS growth_rate
FROM
  sales18
  JOIN sales19
  USING
    (quarter)
ORDER BY
  1



-- 153
WITH master17 AS (
  SELECT
    user_id
  FROM
    sample.sales
  WHERE
    FORMAT_DATETIME("%Y", date_time) = "2017"
)
, master18 AS (
  SELECT
    user_id
  FROM
    sample.sales
  WHERE
    FORMAT_DATETIME("%Y", date_time) = "2018"
)
, master19 AS (
  SELECT
    user_id
  FROM
    sample.sales
  WHERE
    FORMAT_DATETIME("%Y", date_time) = "2019"
)
, master AS (
  SELECT
    user_id
  FROM
    master17
  INTERSECT DISTINCT
  SELECT
    user_id
  FROM
    master18
  INTERSECT DISTINCT
  SELECT
    user_id
  FROM
    master19
)
SELECT
  name
FROM
  master
  LEFT JOIN sample.customers
  USING
    (user_id)
ORDER BY
  birthday DESC
LIMIT 3



-- 154
WITH product17 AS (
  SELECT
    product_id
  FROM
    sample.sales
  WHERE
    EXTRACT(YEAR FROM date_time) = 2017
  GROUP BY
    product_id
  HAVING SUM(revenue) >= 100000
)
, product18 AS (
  SELECT
    product_id
  FROM
    sample.sales
  WHERE
    EXTRACT(YEAR FROM date_time) = 2018
  GROUP BY
    product_id
  HAVING SUM(revenue) >= 200000
)
, product19 AS (
  SELECT
    product_id
  FROM
    sample.sales
  WHERE
    EXTRACT(YEAR FROM date_time) = 2019
  GROUP BY
    product_id
  HAVING SUM(revenue) <= 200000
)
SELECT
  *
FROM
  product17
INTERSECT DISTINCT
SELECT
  *
FROM
  product18
INTERSECT DISTINCT
SELECT
  *
FROM
  product19



-- 155
WITH pref17 AS (
  SELECT
    prefecture
  FROM
    sample.sales
    JOIN sample.customers
    USING
      (user_id)
  WHERE
    EXTRACT(YEAR FROM date_time) = 2017
  GROUP BY
    prefecture
  HAVING SUM(revenue) / COUNT(DISTINCT order_id) <= 2000
)
, pref18 AS (
  SELECT
    prefecture
  FROM
    sample.sales
    JOIN sample.customers
    USING
      (user_id)
  WHERE
    EXTRACT(YEAR FROM date_time) = 2018
  GROUP BY
    prefecture
  HAVING SUM(revenue) / COUNT(DISTINCT order_id) >= 6000
)
, pref19 AS (
  SELECT
    prefecture
  FROM
    sample.sales
    JOIN sample.customers
    USING
      (user_id)
  WHERE
    EXTRACT(YEAR FROM date_time) = 2019
  GROUP BY
    prefecture
  HAVING SUM(revenue) / COUNT(DISTINCT order_id) >= 6000
)
SELECT
  *
FROM
  pref17
INTERSECT DISTINCT
SELECT
  *
FROM
  pref18
INTERSECT DISTINCT
SELECT
  *
FROM
  pref19



-- 156
WITH master AS (
  SELECT
    FORMAT_DATETIME("%Y", date_time) AS year
    , user_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    year
    , user_id
)
SELECT
  *
  , (sum_rev_17 + sum_rev_18 + sum_rev_19) AS ttl_sum_rev
FROM
  (
    SELECT
      user_id
      , MAX(sum_rev_17) AS sum_rev_17
      , MAX(sum_rev_18) AS sum_rev_18
      , MAX(sum_rev_19) AS sum_rev_19
    FROM
      sample.sales
      LEFT JOIN (
          SELECT
            user_id
            , IF(year = "2017", sum_rev, 0) AS sum_rev_17
          FROM
            master
        )
      USING
        (user_id)
      LEFT JOIN (
          SELECT
            user_id
            , IF(year = "2018", sum_rev, 0) AS sum_rev_18
          FROM
            master
        )
      USING
        (user_id)
      LEFT JOIN (
          SELECT
            user_id
            , IF(year = "2019", sum_rev, 0) AS sum_rev_19
          FROM
            master
        )
      USING
        (user_id)
    GROUP BY
      user_id
  )
WHERE
  sum_rev_18 > sum_rev_17
AND sum_rev_19 > sum_rev_18
ORDER BY
  ttl_sum_rev DESC
LIMIT 3



-- 157
SELECT
  COUNT(DISTINCT user_id) AS users
FROM
  (
    SELECT
      *
    FROM
      sample.sales
    WHERE
      product_id = 7
  )



-- 158
SELECT
  COUNT(*) AS orders
FROM
  (
    SELECT
      order_id
      , COUNT(DISTINCT is_proper) AS mix_flag
    FROM
      sample.sales
    GROUP BY
      order_id
    HAVING mix_flag > 1
  )



-- 159
SELECT
  ROUND(AVG(age), 1) AS avg_age
FROM
  (
    SELECT
      DATE_DIFF("2019-12-31", birthday, YEAR) AS age
    FROM
      sample.customers
    WHERE
      birthday IS NOT NULL
  )



-- 160
SELECT
  name
  , birthday
FROM
  sample.customers
WHERE
  birthday IN(
    SELECT
      birthday
    FROM
      sample.customers
    GROUP BY
      birthday
    HAVING COUNT(*) > 1
  )
ORDER BY
  2



-- 161
SELECT
  order_id
  , product_id
  , revenue
  , revenue / (
    SELECT
      SUM(revenue)
    FROM
      sample.sales
  ) AS revenue_percentage
FROM
  sample.sales
ORDER BY
  revenue DESC
LIMIT 3



-- 162
SELECT
  STDDEV_POP(revenue) AS stddev_2017
  , (
    SELECT
      STDDEV_POP(revenue)
    FROM
      sample.sales
  ) AS revenue_stddev
FROM
  sample.sales
WHERE
  EXTRACT(YEAR FROM date_time) = 2017



-- 163
SELECT
  COUNT(*) AS orders_over_avg_rev
FROM
  sample.sales
WHERE
  revenue > (
    SELECT
      AVG(revenue) AS avg_rev
    FROM
      sample.sales
    WHERE
      is_proper IS TRUE
  )
AND is_proper IS TRUE



-- 164
SELECT
  SUM(sum_rev) AS sum_rev
FROM
  (
    SELECT
      order_id
      , SUM(revenue) AS sum_rev
      , MIN(is_proper) AS proper_flag
    FROM
      sample.sales
    GROUP BY
      order_id
    HAVING proper_flag IS TRUE
  )




-- 165
SELECT
  SUM(quantity) AS sum_qty_over_avg_rev
FROM
  sample.sales
WHERE
  revenue > (
    SELECT
      AVG(revenue) AS avg_rev
    FROM
      sample.sales　where is_proper IS TRUE
  )
AND is_proper IS TRUE



-- 166
SELECT
  COUNT(DISTINCT user_id) users
FROM
  (
    SELECT
      user_id
      , SUM(IF(is_proper IS TRUE, 1, 0)) AS proper_price_flag
    FROM
      sample.sales
    GROUP BY
      user_id
    HAVING proper_price_flag = 0
  )



-- 167
SELECT
  COUNT(*) AS users
FROM
  (
    SELECT
      user_id
    FROM
      (
        SELECT
          user_id
          , product_id
        FROM
          sample.sales
        GROUP BY
          user_id
          , product_id
      )
    GROUP BY
      user_id
    HAVING COUNT(DISTINCT product_id) > 1
  )



-- 168
SELECT
  COUNT(DISTINCT user_id) AS users
FROM
  (
    SELECT
      user_id
      , order_id
      , COUNT(DISTINCT product_id) AS items_in_a_order
    FROM
      sample.sales
    GROUP BY
      user_id
      , order_id
    HAVING items_in_a_order > 1
  )



-- 169
SELECT
  prefecture
  , ROUND(AVG(age), 1) AS avg_age
FROM
  (
    SELECT
      prefecture
      , DATE_DIFF("2019-12-31", birthday, YEAR) AS age
    FROM
      sample.customers
    WHERE
      birthday IS NOT NULL
  )
GROUP BY
  prefecture
ORDER BY
  2 DESC
LIMIT 3



-- 170
WITH master AS (
  SELECT
    cid
    , session_count
    , MAX(cv_page) AS cv
  FROM
    (
      SELECT
        *
        , IF(page = "/thank_you/", 1, 0) AS cv_page
      FROM
        sample.web_log
    )
  GROUP BY
    cid
    , session_count
)
SELECT
  COUNT(*) AS cv
FROM
  master
WHERE
  cv > 0



-- 171
SELECT
  AVG(DATE_DIFF("2019-12-31", birthday, YEAR)) AS avg_age
FROM
  sample.customers
WHERE
  DATE_DIFF("2019-12-31", birthday, YEAR) > (
    SELECT
      AVG(DATE_DIFF("2019-12-31", birthday, YEAR)) AS avg_age
    FROM
      sample.customers
  )



-- 172
SELECT
  female_name
  , COUNT(*) AS popularity
FROM
  (
    SELECT
      SUBSTR(name, STRPOS(name, " ") + 1) AS female_name
    FROM
      sample.customers
    WHERE
      gender = 2
  )
GROUP BY
  female_name
HAVING popularity > 2



-- 173
SELECT
  prefecture
  , SUM(revenue) AS sum_rev
  , SUM(revenue) / (
    SELECT
      SUM(revenue)
    FROM
      sample.sales
  ) AS percent_sum_rev
FROM
  sample.sales
  LEFT JOIN sample.customers
  USING
    (user_id)
GROUP BY
  prefecture
ORDER BY
  sum_rev DESC
LIMIT 3



-- 174
SELECT
  COUNT(DISTINCT user_id) users
FROM
  (
    SELECT
      user_id
      , MAX(IF(product_id = 1, 1, 0)) AS product1_flag
      , MAX(IF(product_id = 2, 1, 0)) AS product2_flag
    FROM
      sample.sales
    GROUP BY
      user_id
    HAVING product1_flag > 0
  AND product2_flag > 0
  )



-- 175
WITH master AS (
  SELECT
    order_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    order_id
)
SELECT
  order_id
  , sum_rev
  , sum_rev / (
    SELECT
      MAX(sum_rev)
    FROM
      master
  ) AS percentage_against_max_revenue
FROM
  master
ORDER BY
  sum_rev DESC
LIMIT 5



-- 176
SELECT
  COUNT(DISTINCT user_id) AS users
FROM
  (
    SELECT
      user_id
      , order_id
      , MAX(IF(product_id = 1, 1, 0)) AS product1_flag
      , MAX(IF(product_id = 2, 1, 0)) AS product2_flag
    FROM
      sample.sales
    GROUP BY
      user_id
      , order_id
    HAVING product1_flag > 0
  AND product2_flag > 0
  )



-- 177
SELECT
  user_id
  , SUM(cv) cv_by_user
FROM
  (
    SELECT
      user_id
      , CONCAT(cid, session_count) AS session
      , MAX(IF(page = "/thank_you/", 1, 0)) AS cv
    FROM
      sample.web_log
    GROUP BY
      user_id
      , session
  )
GROUP BY
  user_id
HAVING user_id IS NOT NULL
AND cv_by_user > 1
ORDER BY
  1



-- 178
WITH master AS (
  SELECT
    user_id
    , order_id
    , product_id
    , COUNT(*) AS COUNT
  FROM
    sample.sales
  GROUP BY
    user_id
    , order_id
    , product_id
  HAVING COUNT > 1
)
SELECT
  user_id
  , name
FROM
  sample.customers
WHERE
  user_id IN(
    SELECT
      user_id
    FROM
      master
  )
ORDER BY
  user_id



-- 179
WITH master AS (
  SELECT
    cid
    , session_count
    , MAX(cv_page) AS cv
  FROM
    (
      SELECT
        *
        , IF(page = "/thank_you/", 1, 0) AS cv_page
      FROM
        sample.web_log
    )
  GROUP BY
    cid
    , session_count
)
SELECT
  SUM(cv) AS cv
  , COUNT(*) AS session
  , ROUND(SUM(cv) / COUNT(*), 4) AS cvr
FROM
  master



-- 180
SELECT
  register_age
  , COUNT(DISTINCT user_id) AS users
FROM
  (
    SELECT
      user_id
      , DATE_DIFF(register_date, birthday, YEAR) AS register_age
    FROM
      sample.customers
    WHERE
      birthday IS NOT NULL
    AND register_date IS NOT NULL
  )
GROUP BY
  register_age
ORDER BY
  2 DESC
LIMIT 3



-- 181
WITH master AS (
  SELECT
    cid
    , session_count
    , COUNT(*) AS pv
  FROM
    sample.web_log
  GROUP BY
    cid
    , session_count
)
SELECT
  ROUND(bounce / sessions, 2) AS bounce_rate
FROM
  (
    SELECT
      (
        SELECT
          COUNT(*)
        FROM
          master
        WHERE
          pv = 1
      ) AS bounce
      , (
        SELECT
          COUNT(*)
        FROM
          master
      ) AS sessions
  )



-- 182
SELECT
  prefecture
  , SUM(p) AS premium_users
  , COUNT(DISTINCT user_id) AS users
  , SUM(p) / COUNT(DISTINCT user_id) AS premium_rate
FROM
  (
    SELECT
      prefecture
      , user_id
      , IF(is_premium IS TRUE, 1, 0) AS p
    FROM
      sample.customers
  )
GROUP BY
  prefecture
ORDER BY
  2 DESC
LIMIT 3



-- 183
WITH master AS (
  SELECT
    cid
    , session_count
    , COUNT(*) AS pv
  FROM
    sample.web_log
  GROUP BY
    cid
    , session_count
)
SELECT
  ROUND(pageviews / sessions, 1) AS pv_per_session
FROM
  (
    SELECT
      (
        SELECT
          SUM(pv) AS pageviews
        FROM
          master
      ) AS pageviews
      , (
        SELECT
          COUNT(*)
        FROM
          master
      ) AS sessions
  )



-- 184
SELECT
  user_id
  , DATE_DIFF("2019-12-31", birthday, YEAR) AS age
FROM
  sample.customers
WHERE
  DATE_DIFF("2019-12-31", birthday, YEAR) > (
    SELECT
      AVG(DATE_DIFF("2019-12-31", birthday, YEAR)) AS avg_age
    FROM
      sample.customers
  )
AND register_date IS NOT NULL
ORDER BY
  register_date
LIMIT 3



-- 185
WITH master AS (
  SELECT
    cid
    , session_count
    , device
    , MAX(cv_page) AS cv
  FROM
    (
      SELECT
        *
        , IF(page = "/thank_you/", 1, 0) AS cv_page
      FROM
        sample.web_log
    )
  GROUP BY
    cid
    , session_count
    , device
)
SELECT
  device
  , SUM(cv) AS cv
  , COUNT(*) AS session
  , round(SUM(cv) / COUNT(*), 4) AS cvr
FROM
  master
GROUP BY
  device



-- 186
WITH master AS (
  SELECT
    quantity
    , revenue
    , revenue / quantity AS unit_revenue
    , cost
  FROM
    sample.sales
    JOIN sample.products
    USING
      (product_id)
)
SELECT
  SUM(profit) AS sum_profit
  , SUM(profit) / SUM(revenue) AS profit_rate
FROM
  (
    SELECT
      quantity
      , (unit_revenue - cost) * quantity AS profit
      , revenue
    FROM
      master
  )



-- 187
SELECT
  COUNT(DISTINCT user_id) users
FROM
  (
    SELECT
      user_id
      , MAX(IF(product_id = 1, 1, 0)) AS product1_flag
      , MAX(IF(product_id = 2, 1, 0)) AS product2_flag
      , MAX(IF(product_id = 15, 1, 0)) AS product15_flag
    FROM
      sample.sales
    GROUP BY
      user_id
    HAVING product1_flag > 0
  AND product2_flag > 0
  AND product15_flag = 0
  )



-- 188
WITH master AS (
  SELECT
    cid
    , session_count
    , MAX(cv_page) AS cv
  FROM
    (
      SELECT
        *
        , IF(page = "/thank_you/", 1, 0) AS cv_page
      FROM
        sample.web_log
    )
  GROUP BY
    cid
    , session_count
)
SELECT
  cv_count
  , COUNT(DISTINCT cid) AS users
FROM
  (
    SELECT
      cid
      , SUM(cv) AS cv_count
    FROM
      master
    GROUP BY
      cid
  )
GROUP BY
  cv_count
ORDER BY
  cv_count DESC




-- 189
WITH master AS (
  SELECT
    user_id
    , SUM(revenue) AS sr
  FROM
    sample.sales
  GROUP BY
    user_id
)
SELECT
  gender_name
  , ROUND(STDDEV_POP(sr), 0) AS std_dev
FROM
  (
    SELECT
      CASE gender
        WHEN 1 THEN "男性"
        WHEN 2 THEN "女性"
        ELSE NULL
      END AS gender_name
      , sr
    FROM
      master
      LEFT JOIN sample.customers
      USING
        (user_id)
  )
GROUP BY
  gender_name



-- 190
WITH master AS (
  SELECT
    order_id
    , quantity
    , revenue / quantity AS unit_revenue
    , cost
  FROM
    sample.sales
    JOIN sample.products
    USING
      (product_id)
)
SELECT
  order_id
  , SUM(profit) AS profit_by_order
FROM
  (
    SELECT
      order_id
      , quantity
      , (unit_revenue - cost) * quantity AS profit
    FROM
      master
  )
GROUP BY
  order_id
ORDER BY
  2 DESC
LIMIT 1



-- 191
WITH master AS (
  SELECT
    user_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    user_id
)
SELECT
  gender_name
  , MAX(sum_rev) AS max_sum_rev
FROM
  (
    SELECT
      CASE gender
        WHEN 1 THEN "男性"
        WHEN 2 THEN "女性"
        ELSE "不明"
      END AS gender_name
      , sum_rev
    FROM
      master
      LEFT JOIN sample.customers
      USING
        (user_id)
  )
GROUP BY
  gender_name



-- 192
WITH master AS (
  SELECT
    cid
    , session_count
    , COUNT(*) AS pv
    , MIN(date_time) AS s_start
    , MAX(date_time) AS s_end
  FROM
    sample.web_log
  GROUP BY
    cid
    , session_count
)
SELECT
  ROUND(SUM(session_duration) / COUNT(*), 1) AS avg_session_duration
FROM
  (
    SELECT
      cid
      , session_count
      , DATETIME_DIFF(s_end, s_start, second) AS session_duration
    FROM
      master
  )



-- 193
WITH s_users AS (
  SELECT
    user_id
  FROM
    sample.sales
  GROUP BY
    user_id
)
, w_users AS (
  SELECT
    user_id
  FROM
    sample.web_log
  GROUP BY
    user_id
)
SELECT
  COUNT(DISTINCT w_user) / COUNT(DISTINCT s_user) AS web_usage_rate
FROM
  (
    SELECT
      s_users.user_id AS s_user
      , w_users.user_id AS w_user
    FROM
      s_users
      LEFT JOIN w_users
      ON s_users.user_id = w_users.user_id
  )




-- 194
WITH master AS (
  SELECT
    product_category
    , revenue
    , cost * quantity AS cost_x_qty
  FROM
    sample.sales
    JOIN sample.products
    USING
      (product_id)
)
SELECT
  product_category
  , SUM(profit) AS profit
  , SUM(profit) / SUM(revenue) AS profit_rate
FROM
  (
    SELECT
      product_category
      , revenue
      , revenue - cost_x_qty AS profit
    FROM
      master
  )
GROUP BY
  product_category
ORDER BY
  3 DESC



-- 195
WITH master AS (
  SELECT
    user_id
    , quantity
    , revenue
    , cost * quantity AS cost_x_qty
  FROM
    sample.sales
    JOIN sample.products
    USING
      (product_id)
)
SELECT
  user_id
  , SUM(profit) AS profit
  , SUM(profit) / SUM(revenue) AS profit_rate
FROM
  (
    SELECT
      user_id
      , revenue
      , revenue - cost_x_qty AS profit
    FROM
      master
  )
GROUP BY
  user_id
ORDER BY
  3
LIMIT 1



-- 196
WITH master AS (
  SELECT user_id
    , date_time
    , IF(product_id = 2, date_time, NULL) AS prod_2_time
    , IF(product_id = 15, date_time, NULL) AS prod_15_time
  FROM sample.sales
  WHERE product_id IN (2,15)
)
  
SELECT DISTINCT user_id
FROM (
  SELECT * FROM
    (
      SELECT user_id
        , MIN(prod_2_time) OVER (PARTITION BY user_id) AS min_prod_2_time
        , MIN(prod_15_time) OVER (PARTITION BY user_id) AS min_prod_15_time
        , MAX(prod_2_time) OVER (PARTITION BY user_id) AS max_prod_2_time
        , MAX(prod_15_time) OVER (PARTITION BY user_id) AS max_prod_15_time
      FROM master
    )
  WHERE
    min_prod_2_time < min_prod_15_time AND date_trunc(min_prod_2_time, year) = date_trunc(min_prod_15_time, year)
  OR
    max_prod_2_time < max_prod_15_time AND date_trunc(max_prod_2_time, year) = date_trunc(max_prod_15_time, year)
)
ORDER BY 1



-- 197
WITH master AS (
  SELECT
    CONCAT(cid, session_count) AS session_id
    , MAX(IF(page = "/special/diet/", 1, 0)) AS view_diet_page
    , MAX(IF(page = "/thank_you/", 1, 0)) AS cv
  FROM
    sample.web_log
  GROUP BY
    session_id
)
SELECT
  view_diet_page_session
  , sum_cv / session AS cvr
FROM
  (
    SELECT
      IF(view_diet_page = 1, true, false) AS view_diet_page_session
      , COUNT(DISTINCT session_id) AS session
      , SUM(cv) AS sum_cv
    FROM
      master
    GROUP BY
      view_diet_page_session
  )



-- 198
WITH master AS (
  SELECT
    user_id
    , gender
    , product_name
    , revenue
  FROM
    sample.sales
    LEFT JOIN sample.products
    USING
      (product_id)
    LEFT JOIN sample.customers
    USING
      (user_id)
)
SELECT
  product_name
  , SUM(rev_female) AS sum_rev_female
  , SUM(rev_female) / MAX(ttl_rev) AS percent_rev_female
FROM
  (
    SELECT
      product_name
      , IF(gender = 2, revenue, 0) AS rev_female
      , (
        SELECT
          SUM(revenue)
        FROM
          sample.sales
      ) AS ttl_rev
    FROM
      master
  )
GROUP BY
  1
ORDER BY
  2 DESC
LIMIT 3



-- 199
WITH master AS (
  SELECT
    product_id
    , SUM(revenue) / SUM(quantity) AS proper_unit_price
  FROM
    sample.sales
  WHERE
    is_proper IS TRUE
  GROUP BY
    product_id
)
SELECT
  SUM(discount) AS sum_discount
FROM
  (
    SELECT
      quantity * (proper_unit_price - non_proper_unit_price) AS discount
    FROM
      (
        SELECT
          quantity
          , revenue / quantity AS non_proper_unit_price
          , proper_unit_price
        FROM
          sample.sales
          LEFT JOIN master
          USING
            (product_id)
        WHERE
          is_proper IS NOT TRUE
      )
  )



-- 200
WITH master AS (
  SELECT
    product_id
    , SUM(quantity) AS sum_qty
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    product_id
)
SELECT
  *
  , unit_cost * sum_qty AS sum_cost
  , (avg_rev - unit_cost) * sum_qty AS sum_profit
  , ((avg_rev - unit_cost) * sum_qty) / sum_rev AS avg_profit_rate
FROM
  (
    SELECT
      product_name
      , sum_rev / sum_qty AS avg_rev
      , cost AS unit_cost
      , sum_qty
      , sum_rev
    FROM
      master
      JOIN sample.products
      USING
        (product_id)
  )
ORDER BY
  8 DESC
LIMIT 3



-- 201
WITH master AS (
  SELECT
    user_id
    , product_id
  FROM
    sample.sales
  GROUP BY
    user_id
    , product_id
)
SELECT
  prod_combi
  , COUNT(DISTINCT user_id) AS users
FROM
  (
    SELECT
      m1.user_id
      , m1.product_id AS prod1
      , m2.product_id AS prod2
      , concat(m1.product_id, "-", m2.product_id) AS prod_combi
    FROM
      master AS m1
      INNER JOIN master AS m2
      ON m1.user_id = m2.user_id
      AND m1.product_id < m2.product_id
  )
GROUP BY
  prod_combi
ORDER BY
  2 DESC
LIMIT 3



-- 202
WITH plan AS (
  SELECT
    2017 AS year
    , 800000 AS target
  UNION ALL
  SELECT
    2018
    , 1000000
  UNION ALL
  SELECT
    2019
    , 1200000
)
, result AS (
  SELECT
    EXTRACT(YEAR FROM date_time) AS year
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    year
)
SELECT
  *
  , (result_rev - target) / target AS achivement_rate
FROM
  (
    SELECT
      result.year AS year
      , plan.target AS target
      , result.sum_rev AS result_rev
    FROM
      result
      JOIN plan
      USING
        (year)
    ORDER BY
      year
  )



-- 203
WITH master AS (
  SELECT
    FORMAT_DATETIME("%Y-%Q", date_time) AS quarter
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  WHERE
    FORMAT_DATETIME("%Y", date_time) = "2017"
  GROUP BY
    quarter
)
SELECT
  quarter
  , MAX(sum_rev1) AS sum_rev
  , SUM(sum_rev2) AS accum_sum_rev
FROM
  (
    SELECT
      m1.quarter AS quarter
      , m1.sum_rev AS sum_rev1
      , m2.sum_rev AS sum_rev2
    FROM
      master AS m1
      INNER JOIN master AS m2
      ON m1.quarter >= m2.quarter
    ORDER BY
      m1.quarter
  )
GROUP BY
  quarter
ORDER BY
  1



-- 204
WITH master AS (
  SELECT
    cid
    , session_count
    , MIN(date_time) AS min_date_time
  FROM
    sample.web_log
  GROUP BY
    1
    , 2
)
SELECT
  page AS landing_page
  , COUNT(*) AS sessions
FROM
  (
    SELECT
      wl.cid
      , wl.session_count
      , wl.date_time
      , wl.page
      , wl.date_time
      , master.min_date_time
    FROM
      sample.web_log AS wl
      JOIN master
      ON  wl.cid = master.cid
      AND wl.session_count = master.session_count
      AND wl.date_time = master.min_date_time
    WHERE
      wl.date_time = master.min_date_time
  )
GROUP BY
  page
ORDER BY
  2 DESC
LIMIT 3



-- 205
WITH master AS (
  SELECT
    user_id
    , COUNT(DISTINCT order_id) AS orders
    , COUNT(DISTINCT product_id) AS items
    , SUM(revenue) AS total_revenue
  FROM
    sample.sales
  GROUP BY
    user_id
)
, master2 AS (
  SELECT
    user_id
    , MAX(sum_rev) AS biggest_order
  FROM
    (
      SELECT
        user_id
        , order_id
        , SUM(revenue) AS sum_rev
      FROM
        sample.sales
      GROUP BY
        user_id
        , order_id
    )
  GROUP BY
    user_id
)
SELECT
  user_id
  , orders
  , total_revenue
  , biggest_order
  , items
FROM
  (
    SELECT
      *
    FROM
      master
      JOIN master2
      USING
        (user_id)
  )
WHERE
  orders >= 7
ORDER BY
  user_id



-- 206
WITH sales AS (
  SELECT
    user_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    user_id
)
, web AS (
  SELECT
    user_id
  FROM
    sample.web_log
  GROUP BY
    user_id
  HAVING user_id IS NOT NULL
)
SELECT
  web_usage
  , SUM(sum_rev) AS sum_rev
  , SUM(sum_rev) / COUNT(DISTINCT user_id) AS avg_rev_by_user
FROM
  (
    SELECT
      s.user_id
      , sum_rev
      , IF(w.user_id IS NOT NULL, "Web利用あり顧客", "Web利用なし顧客") AS web_usage
    FROM
      sales AS s
      LEFT JOIN web AS w
      ON s.user_id = w.user_id
  )
GROUP BY
  web_usage
ORDER BY
  2 DESC



-- 207
WITH first AS (
  SELECT
    cid
    , MIN(date_time) AS min_date_time
    , MIN(session_count) AS min_session_count
  FROM
    sample.web_log
  GROUP BY
    cid
  HAVING min_session_count = 1
)
, cvs AS (
  SELECT
    cid
    , MIN(date_time) AS min_cv_date_time
  FROM
    (
      SELECT
        cid
        , date_time
      FROM
        sample.web_log
      WHERE
        page = "/thank_you/"
    )
  GROUP BY
    cid
)
SELECT
  ROUND(AVG(cv_leadtime_day), 0) AS avg_cv_leadtime_day
FROM
  (
    SELECT
      cid
      , min_date_time
      , min_cv_date_time
      , DATETIME_DIFF(min_cv_date_time, min_date_time, DAY) AS cv_leadtime_day
    FROM
      first
      JOIN cvs
      USING
        (cid)
  )



-- 208
WITH ses AS (
  SELECT
    FORMAT_DATETIME("%Y-%m", date_time) AS year_month
    , COUNT(DISTINCT CONCAT(cid, session_count)) AS session
  FROM
    sample.web_log
  GROUP BY
    year_month
)
, cvs AS (
  SELECT
    year_month
    , SUM(cv) AS sum_cv
  FROM
    (
      SELECT
        FORMAT_DATETIME("%Y-%m", date_time) AS year_month
        , CONCAT(cid, session_count) AS session
        , MAX(IF(page = "/thank_you/", 1, 0)) AS cv
      FROM
        sample.web_log
      GROUP BY
        year_month
        , session
    )
  GROUP BY
    year_month
)
SELECT
  CORR(session, sum_cv) AS correlation
FROM
  (
    SELECT
      *
    FROM
      ses
      LEFT JOIN cvs
      USING
        (year_month)
  )



-- 209
WITH master AS (
  SELECT
    FORMAT_DATETIME("%Y", date_time) AS year
    , FORMAT_DATETIME("%B", date_time) AS month
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  WHERE
    FORMAT_DATETIME("%Y", date_time) IN("2017", "2018")
  GROUP BY
    year
    , month
)
SELECT
  month
  , MAX(sum_rev_2017) AS sum_rev_2017
  , MAX(sum_rev_2018) AS sum_rev_2018
  , ROUND(MAX(sum_rev_2018) / MAX(sum_rev_2017), 2) AS change
FROM
  (
    SELECT
      month
      , IF(year = "2017", sum_rev, 0) AS sum_rev_2017
      , IF(year = "2018", sum_rev, 0) AS sum_rev_2018
    FROM
      master
  )
GROUP BY
  month
ORDER BY
  4 DESC
LIMIT 3



-- 210
WITH first AS (
  SELECT
    cid
    , MIN(date_time) AS min_date_time
    , MIN(session_count) AS min_session_count
  FROM
    sample.web_log
  GROUP BY
    cid
  HAVING min_session_count = 1
)
, cvs AS (
  SELECT
    cid
    , MIN(date_time) AS min_cv_date_time
  FROM
    (
      SELECT
        cid
        , date_time
      FROM
        sample.web_log
      WHERE
        page = "/thank_you/"
    )
  GROUP BY
    cid
)
SELECT
  cid
  , FORMAT_DATETIME("%F", min_date_time) AS first_visit_day
  , FORMAT_DATETIME("%F", min_cv_date_time) AS first_cv_day
  , DATETIME_DIFF(min_cv_date_time, min_date_time, DAY) AS cv_leadtime_days
FROM
  first
  JOIN cvs
  USING
    (cid)
ORDER BY
  min_cv_date_time DESC
LIMIT 1



-- 211
SELECT
  prefecture
  , MAX(most_elder) AS most_elder_customer
FROM
  (
    SELECT
      prefecture
      , FIRST_VALUE(name) 
    OVER (PARTITION BY prefecture ORDER BY birthday)
    AS most_elder
    FROM
      sample.customers
    WHERE
      prefecture IN ("東京", "大阪", "京都")
    AND birthday IS NOT NULL
  )
GROUP BY
  prefecture



-- 212
SELECT
  year
  , hour
  , sum_rev
FROM
  (
    SELECT
      *
      , RANK() OVER (PARTITION BY year ORDER BY sum_rev DESC) 
    AS rank
    FROM
      (
        SELECT
          FORMAT_DATETIME("%Y", date_time) AS year
          , FORMAT_DATETIME("%H", date_time) AS hour
          , SUM(revenue) AS sum_rev
        FROM
          sample.sales
        GROUP BY
          year
          , hour
      )
  )
WHERE
  rank = 1



-- 213
WITH master AS (
  SELECT
    EXTRACT(YEAR FROM date_time
    ) AS year
    , product_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    year
    , product_id
)
SELECT
  *
FROM
  (
    SELECT
      year
      , product_id
      , RANK() OVER (PARTITION BY year ORDER BY sum_rev DESC) 
      AS rev_rank
    FROM
      master
    WHERE
      year IN (2018, 2019)
  )
WHERE
  rev_rank <= 3
ORDER BY
  year
  , rev_rank



-- 214
SELECT
  gender
  , ROUND(AVG(age), 1) AS avg_age
  , MAX(med_age) AS median_age
FROM
  (
    SELECT
      *
      , PERCENTILE_CONT(age, 0.5) OVER (PARTITION BY gender) 
      AS med_age
    FROM
      (
        SELECT
          CASE gender
            WHEN 1 THEN "男性"
            WHEN 2 THEN "女性"
            ELSE NULL
          END AS gender
          , DATE_DIFF("2019-12-31", birthday, YEAR) AS age
        FROM
          sample.customers
        WHERE
          birthday IS NOT NULL
      )
  )
GROUP BY
  gender



-- 215
WITH master AS (
  SELECT
    cid
    , COUNT(*) AS pv
  FROM
    sample.web_log
  WHERE
    DATE(DATETIME_TRUNC(date_time, QUARTER)) = "2018-04-01"
  GROUP BY
    cid
)
SELECT
  cid
FROM
  (
    SELECT
      *
      , PERCENTILE_CONT(pv, 0.25) OVER () AS first_q
      , PERCENTILE_CONT(pv, 0.75) OVER () AS third_q
    FROM
      master
  )
WHERE
  pv < first_q - (third_q - first_q) * 1.5
OR pv > third_q + (third_q - first_q) * 1.5



-- 216
SELECT
  gender
  , MAX(name) AS name
  , MAX(birthday) AS birthday
FROM
  (
    SELECT
      CASE gender
        WHEN 1 THEN "男性"
        WHEN 2 THEN "女性"
        ELSE NULL
      END AS gender
      , NTH_VALUE(name, 2) OVER (PARTITION BY gender ORDER BY birthday DESC)
      AS name
      , NTH_VALUE(birthday, 2) OVER (PARTITION BY gender ORDER BY birthday DESC)
      AS birthday
    FROM
      sample.customers
    WHERE
      birthday IS NOT NULL
  )
GROUP BY
  gender



-- 217
SELECT
  year_quarter
  , SUM(revenue) AS sum_rev
FROM
  (
    SELECT
      FORMAT_DATETIME("%Y-Q%Q", date_time) AS year_quarter
      , FORMAT_DATETIME("%Y-Q%Q", FIRST_VALUE(date_time) 
      OVER (PARTITION BY user_id ORDER BY date_time))
      AS first_purchase_quarter
      , revenue
    FROM
      sample.sales
  )
WHERE
  first_purchase_quarter = "2017-Q1"
AND SUBSTR(year_quarter, -2) = "Q1"
GROUP BY
  year_quarter
ORDER BY
  1



-- 218
WITH master AS (
  SELECT
    FORMAT_DATETIME("%Y-%m", date_time) AS year_month
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  WHERE
    FORMAT_DATETIME("%Y", date_time) = "2017"
  GROUP BY
    year_month
)
SELECT
  year_month
  , ROUND(sum_rev / FIRST_VALUE(sum_rev) OVER (ORDER BY year_month), 2) 
  AS change_from_jan
FROM
  master
ORDER BY
  2 DESC
LIMIT 3



-- 219
WITH master AS (
  SELECT
    user_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    user_id
)
SELECT
  ROUND(COUNT(*) / (
      SELECT
        COUNT(DISTINCT user_id)
      FROM
        master
    ), 3) AS user_accum_percentage
  , ROUND(MAX(accum_sum_rev) / (
      SELECT
        SUM(sum_rev)
      FROM
        master
    ), 3) AS rev_accum_percentage
FROM
  (
    SELECT
      user_id
      , SUM(sum_rev) OVER (ORDER BY sum_rev DESC)
      AS accum_sum_rev
    FROM
      master
    ORDER BY
      sum_rev DESC
    LIMIT 100
  )



-- 220
WITH master AS (
  SELECT
    user_id
    , product_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    user_id
    , product_id
  HAVING sum_rev >= 2000
)
SELECT
  *
FROM
  (
    SELECT
      user_id
      , product_id
      , sum_rev
      , LEAD(product_id) 
      OVER (PARTITION BY user_id ORDER BY sum_rev DESC)
      AS product_id2
      , LEAD(sum_rev)
      OVER (PARTITION BY user_id ORDER BY sum_rev DESC)
      AS sum_rev2
    FROM
      master
  )
WHERE
  sum_rev = sum_rev2
ORDER BY
  1



-- 221
SELECT
  *
FROM
  (
    SELECT
      CASE
        WHEN c.gender = 1 THEN "男性"
        WHEN c.gender = 2 THEN "女性"
        ELSE "その他"
      END AS gender
      , p.product_name
      , SUM(s.revenue) AS sum_rev
      , RANK() OVER (PARTITION BY gender ORDER BY SUM(s.revenue) DESC)
      AS rank_in_gender
    FROM
      sample.sales AS s
      LEFT JOIN sample.customers AS c
      USING
        (user_id)
      LEFT JOIN sample.products AS p
      USING
        (product_id)
    GROUP BY
      c.gender
      , p.product_name
    ORDER BY
      sum_rev DESC
  )
WHERE
  rank_in_gender <= 3
ORDER BY
  1
  , 3 DESC



-- 222
/*問題に誤字があり、誠に申し訳ありません。以下のとおり訂正させていただきます。

[誤]
結果テーブルは、年月（yyyy-MM）、

[正]
結果テーブルは、yyyy-MM形式で表記した年月（year_month）、
*/

WITH master AS (
  SELECT
    FORMAT_DATETIME("%Y-%m", date_time) AS year_month
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  WHERE
    FORMAT_DATETIME("%Y", date_time) = "2017"
  GROUP BY
    year_month
)
SELECT
  *
  , ROUND((sum_rev - previous_month_sum_rev) / previous_month_sum_rev, 3)
  AS change_from_previous_month
FROM
  (
    SELECT
      year_month
      , LAG(sum_rev) OVER (ORDER BY year_month)
      AS previous_month_sum_rev
      , sum_rev
    FROM
      master
  )
WHERE
  previous_month_sum_rev IS NOT NULL
ORDER BY
  1
LIMIT 3



-- 223
WITH master AS (
  SELECT
    user_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    user_id
)
SELECT
  *
  , ROUND(accum_sum_rev_by_bucket / (
      SELECT
        SUM(sum_rev)
      FROM
        master
    ), 2) AS accum_rev_percentage
FROM
  (
    SELECT
      rev_bucket
      , sum_rev_by_bucket
      , SUM(sum_rev_by_bucket) OVER (ORDER BY rev_bucket)
      AS accum_sum_rev_by_bucket
    FROM
      (
        SELECT
          rev_bucket
          , SUM(sum_rev) AS sum_rev_by_bucket
        FROM
          (
            SELECT
              *
              , NTILE(5) OVER (ORDER BY sum_rev DESC)
              AS rev_bucket
            FROM
              master
          )
        GROUP BY
          rev_bucket
      )
  )



-- 224
WITH master AS (
  SELECT
    user_id
    , COUNT(DISTINCT order_id) AS orders
    , SUM(revenue) AS total_revenue
    , MAX(date_time) AS recent_order_date_time
  FROM
    sample.sales
  GROUP BY
    user_id
)
SELECT
  COUNT(DISTINCT user_id) AS users
FROM
  (
    SELECT
      user_id
      , recency + frequency + monetary AS total_score
    FROM
      (
        SELECT
          user_id
          , NTILE(5) OVER (ORDER BY recent_order_date_time DESC)
          AS recency
          , NTILE(5) OVER (ORDER BY orders DESC)
          AS frequency
          , NTILE(5) OVER (ORDER BY total_revenue DESC)
          AS monetary
        FROM
          master
      )
  )
GROUP BY
  total_score
HAVING total_score = 3



-- 225
SELECT
  user_id
  , MIN(diff_2_and_3) AS interval_between_2_and_3
FROM
  (
    SELECT
      *
      , DATETIME_DIFF(order_date3, order_date2, DAY) AS diff_2_and_3
    FROM
      (
        SELECT
          user_id
          , order_id
          , NTH_VALUE(order_date, 2)
          OVER (PARTITION BY user_id ORDER BY order_date)
          AS order_date2
          , NTH_VALUE(order_date, 3)
          OVER (PARTITION BY user_id ORDER BY order_date)
          AS order_date3
        FROM
          (
            SELECT
              user_id
              , order_id
              , MIN(date_time) AS order_date
            FROM
              sample.sales
            GROUP BY
              user_id
              , order_id
          )
      )
    WHERE
      order_date2 IS NOT NULL
    AND order_date3 IS NOT NULL
  )
GROUP BY
  user_id
ORDER BY
  interval_between_2_and_3
LIMIT 3



-- 226
WITH master17 AS (
  SELECT
    user_id
    , sum_rev17
    , NTILE(10) OVER (ORDER BY sum_rev17 DESC)
    AS rev_bucket17
  FROM
    (
      SELECT
        user_id
        , SUM(revenue) AS sum_rev17
      FROM
        sample.sales
      WHERE
        FORMAT_DATETIME("%Y", date_time) = "2017"
      GROUP BY
        user_id
    )
)
, master18 AS (
  SELECT
    user_id
    , sum_rev18
    , NTILE(10) OVER (ORDER BY sum_rev18 DESC)
    AS rev_bucket18
  FROM
    (
      SELECT
        user_id
        , SUM(revenue) AS sum_rev18
      FROM
        sample.sales
      WHERE
        FORMAT_DATETIME("%Y", date_time) = "2018"
      GROUP BY
        user_id
    )
)
SELECT
  user_id
FROM
  master17
  INNER JOIN master18
  USING
    (user_id)
WHERE
  rev_bucket17 = 1
AND rev_bucket18 = 1



-- 227
WITH master AS (
  SELECT
    *
    , REGEXP_EXTRACT(page, r"[^\?]+") AS page_wo_parameter
  FROM
    sample.web_log
)
SELECT
  *
  , round(bounce / session, 4) AS bounce_rate
FROM
  (
    SELECT
      landing_page
      , COUNT(DISTINCT session_id) AS session
      , SUM(bounce) AS bounce
    FROM
      (
        SELECT
          CONCAT(cid, session_count) AS session_id
          , FIRST_VALUE(page_wo_parameter)
          OVER (PARTITION BY cid, session_count ORDER BY date_time)
          AS landing_page
          , COUNT(*) OVER (PARTITION BY cid, session_count)
          AS pv_per_session
          , IF(COUNT(*) OVER (PARTITION BY cid, session_count) = 1, 1, 0)
          AS bounce
        FROM
          master
      )
    GROUP BY
      landing_page
  )
ORDER BY
  4 DESC
LIMIT 3



-- 228
WITH master AS (
  SELECT
    user_id
    , order_id
    , SUM(revenue) AS sum_rev
  FROM
    sample.sales
  GROUP BY
    user_id
    , order_id
)
SELECT
  user_id
  , MAX(min_rev) AS min_rev
  , MAX(max_rev) AS max_rev
  , MAX(max_rev) - MAX(min_rev) AS rev_range
FROM
  (
    SELECT
      user_id
      , order_id
      , MIN(sum_rev) OVER (
        PARTITION BY
          user_id
          ORDER BY
            sum_rev ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) AS min_rev
      , MAX(sum_rev) OVER (
        PARTITION BY
          user_id
          ORDER BY
            sum_rev ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) AS max_rev
    FROM
      master
  )
GROUP BY
  user_id
HAVING COUNT(DISTINCT order_id) > 1
ORDER BY
  rev_range DESC
LIMIT 3



-- 229
/*問題に誤字があり、誠に申し訳ありません。以下のとおり訂正させていただきます。

[誤]
結果テーブルは、ランディングページ（landing_page）、セッション中の2ページ目（second_page）、セッション（session）の3カラムとし、［session］の多い順にトップ5を表示してください。

[正]
結果テーブルは、ランディングページ（landing_page）、セッション中の2ページ目（second_page）、セッション中の3ページ目（third_page）、セッション（session）の4カラムとし、［session］の多い順にトップ5を表示してください。
*/

WITH master AS (
  SELECT
    cid
    , session_count
    , MAX(lp) AS landing_page
    , MAX(sp) AS second_page
    , MAX(tp) AS third_page
  FROM
    (
      SELECT
        cid
        , session_count
        , date_time
        , page_wo_parameter
        , FIRST_VALUE(page_wo_parameter) 
        OVER (PARTITION BY cid, session_count ORDER BY date_time)
        AS lp
        , nth_value(page_wo_parameter, 2) 
        OVER (PARTITION BY cid, session_count ORDER BY date_time)
        AS sp
        , nth_value(page_wo_parameter, 3) 
        OVER (PARTITION BY cid, session_count ORDER BY date_time)
        AS tp
      FROM
        (
          SELECT
            *
            , REGEXP_EXTRACT(page, r"[^\?]+") AS page_wo_parameter
          FROM
            sample.web_log
        )
    )
  GROUP BY
    cid
    , session_count
)
SELECT
  landing_page
  , second_page
  , third_page
  , COUNT(*) AS sessions
FROM
  master
GROUP BY
  landing_page
  , second_page
  , third_page
HAVING landing_page = "/"
ORDER BY
  4 DESC
LIMIT 5


-- 230
WITH yup AS (
  SELECT
    user_id
    , EXTRACT(YEAR FROM date_time) AS year
    , product_id
    , SUM(revenue) AS sum_rev_yup
  FROM
    sample.sales
  GROUP BY
    year
    , user_id
    , product_id
)
, yu AS (
  SELECT
    EXTRACT(YEAR FROM date_time) AS year
    , user_id
    , SUM(revenue) AS sum_rev_yu
  FROM
    sample.sales
  GROUP BY
    year
    , user_id
)
SELECT
  bsp.year
  , bsu.user_id
  , c.name
  , bsp.best_product_by_user
  , p.product_name AS best_product_name_by_user
  , sum_rev_by_user_product
FROM
  (
    SELECT
      year
      , user_id
      , MAX(best_sold_product) AS best_product_by_user
      , MAX(sum_rev_yup) AS sum_rev_by_user_product
    FROM
      (
        SELECT
          user_id
          , year
          , FIRST_VALUE(product_id)
          OVER (PARTITION BY year, user_id ORDER BY sum_rev_yup DESC)
          AS best_sold_product
          , sum_rev_yup
        FROM
          yup
      )
    GROUP BY
      year
      , user_id
  ) AS bsp
  JOIN (
      SELECT
        *
      FROM
        (
          SELECT
            year
            , user_id
            , RANK() OVER (PARTITION BY year ORDER BY sum_rev_yu DESC)
            AS rev_rank
          FROM
            yu
        )
      WHERE
        rev_rank = 1
    ) AS bsu
  USING
    (user_id, year)
  JOIN sample.products AS p
  ON bsp.best_product_by_user = p.product_id
  JOIN sample.customers AS c
  ON bsu.user_id = c.user_id




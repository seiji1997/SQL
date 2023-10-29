# SQL

 **notes**
Crawler：　Data types of some columns need to be modified to the specifications. So create table by Athena query<be>

change your own `DATABASE`.`TABLE` AND `YOUR S3 BUCKET`/`YOUR FOLDER`.
```
-- table
`DATABASE`.`TABLE`

-- bucket
`YOUR S3 BUCKET`/`YOUR FOLDER`
```

### Numeric Types
> Integer (true) INTEGER, INT, SMALLINT, TINYINT, MEDIUMINT, BIGINT<br>
> Fixed-point (true) DECIMAL, NUMERIC<br>
> Floating-point types (approximate numbers) FLOAT, DOUBLE<br>
> Bit value type BIT<br>


### List of date and time types
> DATE, DATETIME, and TIMESTAMP types<br>
> TIME type<br>
> YEAR type<br>

### List of string types
> CHAR and VARCHAR types<br>
> BINARY and VARBINARY types<br>
> BLOB and TEXT types<br>
> ENUM type<br>
> SET types<br>



### category

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS `DATABASE`.`TABLE` (
  `category_major_cd` string,
  `category_major_name` string,
  `category_medium_cd` string,
  `category_medium_name` string,
  `category_small_cd` string,
  `category_small_name` string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES ('field.delim' = ',')
STORED AS INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat' OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 's3://YOUR S3 BUCKET/YOUR FOLDER/'
TBLPROPERTIES ('classification' = 'csv', "skip.header.line.count"="1");

```

### customer

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS `DATABASE`.`TABLE` (
  `customer_id` string,
  `customer_name` string,
  `gender_cd` string,
  `gender` string,
  `birth_day` timestamp,
  `age` int,
  `postal_cd` string,
  `address` string,
  `application_store_cd` string,
  `application_date` string,
  `status_cd` string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES ('field.delim' = ',')
STORED AS INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat' OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 's3://YOUR S3 BUCKET/YOUR FOLDER/'
TBLPROPERTIES ('classification' = 'csv', "skip.header.line.count"="1");

```


### geocode

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS `DATABASE`.`TABLE` (
  `postal_cd` string,
  `prefecture` string,
  `city` string,
  `town` string,
  `street` string,
  `address` string,
  `full_address` string,
  `longitude` int,
  `latitude` int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES ('field.delim' = ',')
STORED AS INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat' OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 's3://YOUR S3 BUCKET/YOUR FOLDER/'
TBLPROPERTIES ('classification' = 'csv', "skip.header.line.count"="1");

```

### product

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS `DATABASE`.`TABLE` (
  `product_cd` string,
  `category_major_cd` string,
  `category_medium_cd` string,
  `category_small_cd` string,
  `unit_price` int,
  `unit_cost` int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES ('field.delim' = ',')
STORED AS INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat' OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 's3://YOUR S3 BUCKET/YOUR FOLDER/'
TBLPROPERTIES ('classification' = 'csv', "skip.header.line.count"="1");

```


### receipt

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS `DATABASE`.`TABLE` (
  `sales_ymd` int,
  `sales_epoch` int,
  `store_cd` string,
  `receipt_no` int,
  `receipt_sub_no` int,
  `customer_id` string,
  `product_cd` string,
  `quantity` int,
  `amount` int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES ('field.delim' = ',')
STORED AS INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat' OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 's3://YOUR S3 BUCKET/YOUR FOLDER/'
TBLPROPERTIES ('classification' = 'csv', "skip.header.line.count"="1");

```


### store

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS `DATABASE`.`TABLE` (
  `store_cd` string,
  `store_name` string,
  `prefecture_cd` string,
  `prefecture` string,
  `address` string,
  `address_kana` string,
  `tel_no` string,
  `longitude` int,
  `latitude` int,
  `floor_area` int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES ('field.delim' = ',')
STORED AS INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat' OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 's3://YOUR S3 BUCKET/YOUR FOLDER/'
TBLPROPERTIES ('classification' = 'csv', "skip.header.line.count"="1");

```


## DROP TABLE 

```sql
DROP TABLE IF EXISTS `category`;
DROP TABLE IF EXISTS `customer`;
DROP TABLE IF EXISTS `geocode`;
DROP TABLE IF EXISTS `product`;
DROP TABLE IF EXISTS `receipt`;
DROP TABLE IF EXISTS `store`;

```

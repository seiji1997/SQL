# SQL

 **notes**
Crawler：　Data types of some columns need to be modified to the specifications. So create table by Athena query<be>


```sql
CREATE EXTERNAL TABLE IF NOT EXISTS `YOUR S3 BUCKET`.`YOUR FOLDER` (
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

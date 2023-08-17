# SQL
Learning SQL.



SELECT 
    CAST(DATE_PART('year', CAST(current_timestamp AT TIME ZONE 'Asia/Tokyo' AS TIMESTAMP)) AS VARCHAR) || 
    RIGHT('0' || CAST(DATE_PART('month', CAST(current_timestamp AT TIME ZONE 'Asia/Tokyo' AS TIMESTAMP)) AS VARCHAR), 2) || 
    RIGHT('0' || CAST(DATE_PART('day', CAST(current_timestamp AT TIME ZONE 'Asia/Tokyo' AS TIMESTAMP)) AS VARCHAR), 2) AS yyyymmdd;

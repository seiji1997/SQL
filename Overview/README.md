# SQL
Learning SQL.



SELECT 
    SUBSTR(CAST(current_timestamp AT TIME ZONE 'Asia/Tokyo' AS VARCHAR), 1, 4) || 
    SUBSTR(CAST(current_timestamp AT TIME ZONE 'Asia/Tokyo' AS VARCHAR), 6, 2) || 
    SUBSTR(CAST(current_timestamp AT TIME ZONE 'Asia/Tokyo' AS VARCHAR), 9, 2) AS yyyymmdd;

SELECT time_bucket('5 seconds', time) AS time,
       avg(blks_hit/(0.0+blks_hit+blks_read)) AS blks_hit_ratio,
       avg(xact_rollback/(0.0+xact_commit+xact_rollback)) AS xact_rollback_ratio
FROM db_stats
WHERE dbname = '$dbname'
  AND $__timeFilter(time)
GROUP BY time
SELECT time_bucket('5 seconds', time) AS time,, avg(tup_deleted),
                                                avg(tup_inserted),
                                                avg(tup_updated)
FROM db_stats
WHERE dbname = '$dbname'
  AND $__timeFilter(time)
GROUP BY time
SELECT time_bucket('5 seconds', time) AS time,
       last(tup_deleted) - first(tup_deleted) AS tup_deleted,
       last(tup_inserted) - first(tup_inserted) AS tup_inserted,
       last(tup_updated) - first(tup_updated) AS tup_updated
FROM db_stats
WHERE dbname = '$dbname'
  AND $__timeFilter(time)
GROUP BY time
SELECT time_bucket('60 seconds', time) AS time,
       last(tup_deleted,time) AS tup_deleted
FROM db_stats
WHERE dbname = 'core-master'
  AND extract(epoch
              FROM time) BETWEEN 1528260248 AND 1528281848
GROUP BY time
ORDER BY time DESC;


SELECT time_bucket('2 minutes', time) + '1 minutes' AS time,
       avg(idle),
       avg(idleintransaction),
       avg(waiting),
       avg(active)
FROM backends
WHERE dbname = '$dbname'
  AND $__timeFilter(time)
GROUP BY time;


SELECT time,
       tup_updated - lag(tup_updated,20) over (
                                               ORDER BY time) AS tup_updated,
       tup_inserted - lag(tup_inserted,20) over (
                                                 ORDER BY time) AS tup_inserted,
       tup_deleted - lag(tup_deleted,20) over (
                                               ORDER BY time) AS tup_deleted
FROM db_stats
WHERE dbname = 'core-master'
  AND extract(epoch
              FROM time) BETWEEN 1528332142 AND 1528335742;


SELECT time_bucket('4 minutes', time) + '1 minutes' AS time,
       last(tup_updated,time) - first(tup_updated,time) AS tu
FROM db_stats
WHERE dbname = 'core-master'
  AND extract(epoch
              FROM time) BETWEEN 1528332142 AND 1528335742
GROUP BY time
ORDER BY time;


SELECT time_bucket('1 minutes', time),
       first(tup_inserted,time)-last(tup_inserted,time) AS i,
       first(tup_deleted,time)-last(tup_deleted,time) AS d,
       first(tup_updated,time)-last(tup_updated,time) AS u
FROM db_stats
WHERE time > ' 2018-06-06 08:42'
GROUP BY time_bucket LIMIT 10;


SELECT time_bucket('1 minutes', time),
       last(tup_inserted,time),
       last(tup_deleted,time),
       last(tup_updated,time)
FROM db_stats
WHERE time > ' 2018-06-06 08:42'
GROUP BY time_bucket LIMIT 10;


SELECT interval AS time ,
       tup_inserted_2min,
       tup_deleted_2min,
       tup_updated_2min
FROM
  (SELECT time_bucket('2 minutes', time) AS interval,
          last(tup_inserted,time)-first(tup_inserted,time) AS tup_inserted_2min,
          last(tup_deleted,time)-first(tup_deleted,time) AS tup_deleted_2min,
          last(tup_updated,time)-first(tup_updated,time) AS tup_updated_2min
   FROM db_stats
   WHERE dbname = '$dbname'
     AND $__timeFilter(time)
   GROUP BY interval) AS t LIMIT 10;


SELECT time_bucket('30 seconds', time) AS interval,
       count(sp_calls) AS sp_calls
FROM sproc_stats
WHERE dbname = 'core-master'
  AND function_full_name = 'yay.update_user_status'
  AND extract(epoch
              FROM time) BETWEEN 1528332142 AND 1528335742
GROUP BY interval LIMIT 10;


SELECT time_bucket('60 seconds', time) AS interval,
       CASE
           WHEN (last(sp_calls,time) - first(sp_calls,time)) = 0 THEN -1
           ELSE ( (last(total_time,time) - first(total_time,time))/(last(sp_calls,time) - first(sp_calls,time)))
       END AS runtime_avg
FROM sproc_stats
WHERE dbname = 'core-master'
  AND function_full_name = 'yay.upsert_profile_tag'
  AND time > '2018-06-07 13:22'
GROUP BY interval;




 WITH m_calls AS
  (SELECT time_bucket('1 minutes', time) AS interval,
          avg(sp_calls) AS call_avg
   FROM sproc_stats
   WHERE dbname = 'core-master'
     AND function_full_name = 'yay.upsert_profile_tag'
   GROUP BY interval
   ORDER BY interval
)

SELECT call_avg - lag(call_avg) over ( ORDER BY interval)
FROM m_calls LIMIT 10;



WITH m_calls AS
  (SELECT time_bucket('1 minutes', time) AS interval,
          avg(sp_calls) AS call_avg
   FROM sproc_stats
   WHERE dbname = '$dbname'
     AND function_full_name = '$function'
   GROUP BY interval
   ORDER BY interval
)

SELECT interval as time , call_avg - lag(call_avg) over ( ORDER BY interval) as call_change
FROM m_calls 
WHERE $__timeFilter(interval);






 WITH m_calls AS
  (SELECT time_bucket('1 minutes', time) AS interval,
          last(total_time,time) AS total_run_time,
          last(sp_calls,time) as total_sp_calls
   FROM sproc_stats
   WHERE dbname = 'core-master'
     AND function_full_name = 'yay.upsert_profile_tag'
   GROUP BY interval
   ORDER BY interval
)

SELECT 
  case when 
    (total_sp_calls - lag(total_sp_calls) over ( ORDER BY interval)) = 0 then 0
  ELSE  
    (total_run_time - lag(total_run_time) over ( ORDER BY interval)) / (total_sp_calls - lag(total_sp_calls) over ( ORDER BY interval)) 
  end as avg_run_time
FROM m_calls LIMIT 10;



 WITH m_calls AS
  (SELECT time_bucket('1 minutes', time) AS interval,
          last(total_time,time) AS total_run_time,
          last(sp_calls,time) as total_sp_calls
   FROM sproc_stats
   WHERE dbname = 'core-master'
     AND function_full_name = 'yay.update_user'
   GROUP BY interval
   ORDER BY interval desc
)

SELECT 
  interval as time,
  case when 
    (total_sp_calls - lag(total_sp_calls) over ( ORDER BY interval)) = 0 then 0
  ELSE  
    (total_run_time - lag(total_run_time) over ()) / (total_sp_calls - lag(total_sp_calls) over ()) 
  end as avg_run_time
FROM m_calls 
WHERE extract(epoch from interval) BETWEEN 1528360849 AND 1528364449;











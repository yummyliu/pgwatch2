SELECT non_negative_derivative(last("xact_commit"), 1s) + non_negative_derivative(last("xact_rollback"), 1s)
FROM "db_stats"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(5m) fill(NONE)

SELECT non_negative_derivative(last("calls"), 1s)
FROM "stat_statements_calls"
WHERE __timeFilter
  AND "dbname" =~ /^__dbname__/
GROUP BY time(5m) fill(NONE)

SELECT mean(q)
FROM
  (SELECT non_negative_derivative(mean("total_time")) / non_negative_derivative(mean("calls")) AS q
   FROM "stat_statements"
   WHERE "dbname" =~ /^__dbname__/
     AND "query" !~ /(?i)::int8[\s+]as[\s]+epoch_ns/
     AND __timeFilter
   GROUP BY queryid,
            time(5m) fill(NONE))
GROUP BY time(5m) fill(NONE)

SELECT last("size_b") - first("size_b")
FROM "db_stats"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(1h) fill(NONE)

SELECT "load_5"
FROM "db_stats"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(1h) fill(NONE)

SELECT "load_5"
FROM "db_stats"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(1h) fill(NONE)

SELECT non_negative_derivative(mean("tup_deleted"), 1h)
FROM "db_stats"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(2m) fill(NONE)

SELECT non_negative_derivative(mean("tup_updated"), 1h)
FROM "db_stats"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(2m) fill(NONE)

SELECT non_negative_derivative(mean("tup_inserted"), 1h)
FROM "db_stats"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(2m) fill(NONE)

SELECT non_negative_derivative(mean("blk_read_time"), 1h)
FROM "db_stats"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(2m) fill(NONE)

SELECT non_negative_derivative(mean("blk_write_time"), 1h)
FROM "db_stats"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(2m) fill(NONE)

SELECT (non_negative_derivative(mean("blks_hit")) / (non_negative_derivative(mean("blks_hit")) + non_negative_derivative(mean("blks_read")))) * 100
FROM "db_stats"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(2m) fill(NONE)

SELECT (non_negative_derivative(mean("xact_rollback")) / (non_negative_derivative(mean("xact_commit")) + non_negative_derivative(mean("xact_rollback"))) * 100)
FROM "db_stats"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(2m) fill(NONE)

SELECT non_negative_derivative(mean("deadlocks"))
FROM "db_stats"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(2m) fill(NONE)

SELECT mean("numbackends")
FROM "db_stats"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(2m) fill(NONE)

SELECT non_negative_derivative(mean("temp_bytes"))
FROM "db_stats"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(2m) fill(NONE)

SELECT derivative(mean("xlog_location_b"), 1s)
FROM "wal"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(2m) fill(NONE)

SELECT mean("idle")
FROM "backends"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(2m) fill(NONE)

SELECT mean("load_5min")
FROM "cpu_load"
WHERE "dbname" =~ /^__dbname__/
  AND __timeFilter
GROUP BY time(2m) fill(NONE)

SELECT mean(runtime)
FROM
  (SELECT non_negative_derivative(last("total_time"), 1h) / non_negative_derivative(last("calls"), 1h) AS runtime
   FROM "stat_statements"
   WHERE "dbname" =~ /^__dbname__/
     AND "query" !~ /(?i)::int8[\s]+as[\s]+epoch_ns/
     AND __timeFilter
   GROUP BY queryid,
            time(2m) fill(NONE))
GROUP BY time(2m) fill(NONE) SHOW TAG
VALUES WITH KEY = "dbname"

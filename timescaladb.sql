create table backends (
    time                    timestamp,
    dbname                  text,
    active                  integer,
    background_workers      integer,
    idle                    integer,
    idleintransaction       integer,
    longest_query_seconds   integer,
    longest_session_seconds integer,
    longest_tx_seconds      integer,
    total                   integer,
    waiting                 integer
);

create table bgwriter (
    time                    timestamp,
    dbname                  text,
    buffers_alloc         integer,
    buffers_backend       integer,
    buffers_backend_fsync integer,
    buffers_checkpoint    integer,
    buffers_clean         integer,
    checkpoint_sync_time  float,
    checkpoint_write_time float,
    checkpoints_req       integer,
    checkpoints_timed     integer,
    maxwritten_clean      integer
);

create table cpu_load (
    time                    timestamp,
    dbname                  text,
    load_15min float,
    load_1min  float,
    load_5min  float
);


create table db_stats (
    time                    timestamp,
    dbname                  text,
    blk_read_time  float,
    blk_write_time float,
    blks_hit       integer,
    blks_read      integer,
    conflicts      integer,
    deadlocks      integer,
    numbackends    integer,
    size_b         integer,
    temp_bytes     integer,
    temp_files     integer,
    tup_deleted    integer,
    tup_fetched    integer,
    tup_inserted   integer,
    tup_returned   integer,
    tup_updated    integer,
    xact_commit    integer,
    xact_rollback  integer
);

create table index_stats (
    time                    timestamp,
    dbname                  text,
    idx_scan      integer,
    idx_tup_fetch integer,
    idx_tup_read  integer,
    index_size_b  integer
);

create table locks (
    time                    timestamp,
    dbname                  text,
    count    integer
);

create table locks_mode (
    time                    timestamp,
    dbname                  text,
    count    integer
);

create table pgbouncer_stats (
    time                    timestamp,
    dbname                  text,
    avg_query_count   integer,
    avg_query_time    integer,
    avg_recv          integer,
    avg_sent          integer,
    avg_wait_time     integer,
    avg_xact_count    integer,
    avg_xact_time     integer,
    total_query_count integer,
    total_query_time  integer,
    total_received    integer,
    total_sent        integer,
    total_wait_time   integer,
    total_xact_count  integer,
    total_xact_time   integer
);

create table replication (
    time                    timestamp,
    dbname                  text,
    lag_b    integer
);

create table sproc_stats (
    time                    timestamp,
    dbname                  text,
    self_time  float,
    sp_calls   integer,
    total_time float
);

create table stat_statements (
    time                    timestamp,
    dbname                  text,
    blk_read_time       float,
    blk_write_time      float,
    calls               integer,
    shared_blks_hit     integer,
    shared_blks_read    integer,
    shared_blks_written integer,
    temp_blks_read      integer,
    temp_blks_written   integer,
    total_time          float
);

create table stat_statements_calls (
    time                    timestamp,
    dbname                  text,
    calls    float
);

create table table_bloat_approx_summary (
    time                    timestamp,
    dbname                  text,
    approx_free_percent float,
    approx_free_space_b float
);

create table table_io_stats (
    time                    timestamp,
    dbname                  text,
    heap_blks_hit   integer,
    heap_blks_read  integer,
    idx_blks_hit    integer,
    idx_blks_read   integer,
    tidx_blks_hit   integer,
    tidx_blks_read  integer,
    toast_blks_hit  integer,
    toast_blks_read integer
);

create table table_stats (
    time                    timestamp,
    dbname                  text,
    analyze_count              integer,
    autoanalyze_count          integer,
    autovacuum_count           integer,
    idx_scan                   integer,
    idx_tup_fetch              integer,
    n_tup_del                  integer,
    n_tup_hot_upd              integer,
    n_tup_ins                  integer,
    n_tup_upd                  integer,
    seconds_since_last_analyze float,
    seconds_since_last_vacuum  float,
    seq_scan                   integer,
    seq_tup_read               integer,
    table_size_b               integer,
    toast_size_b               integer,
    total_relation_size_b      integer,
    vacuum_count               integer
);

create table wal (
    time                    timestamp,
    dbname                  text,
    xlog_location_b integer
);

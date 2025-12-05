{{ config(
    materialized = 'table'
) }}

with raw as (
    select * 
    from {{ source('uniswap_raw', 'uniswap_logs28') }}
),

ts as ( select * from {{ref('timestamp')}}
)

select 
    ts.block_time_utc,
    r.block_number::bigint as block_number,
    r.tx_hash::text as tx_hash,
    r.log_index::bigint as log_index,
    r.topic_0::text as topic_0,
    {{event_name('topic_0')}} as event_name,
    r.topic_1::text as topic_1,
    r.topic_2::text as topic_2,
    r.topic_3::text as topic_3,
    r.data::text as data,
    now() as ingested_at
from raw r
join ts 
on r.block_number = ts.block_number
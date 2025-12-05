{{config (materialized = 'table')}}

with raw as (
    select * from {{ref ('stg_uniswap_logs')}}
),

ts as (
    select * from {{ref ('timestamp')}}
)

select 
    ts.block_time_utc,
    r.block_number,
    r.tx_hash,
    r.log_index,
    r.topic_0,
    {{event_name('r.topic_0')}} as event_name,
    
    r.topic_1 as pool_id,
    '0x' || substring(r.topic_2, 27, 40) as currency0,
    '0x' || substring(r.topic_3, 27, 40) as currency1,
    
   {{ decode_initialize_data('r.data') }}
    
  -- r.data as raw_data
    
from raw r
join ts
    on r.block_number = ts.block_number
where {{event_name('r.topic_0')}} = 'Initialize'
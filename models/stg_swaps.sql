{{config (materialized = 'table')}}

with raw as (
    select * from {{ref ('stg_uniswap_logs')}}
),

ts as (
    select * from {{ref ('timestamp')}}
),

tm as ( 
    select * from {{ref('stg_tokens')}}  
),

decoded_swaps as (
    select 
        r.block_number,
        ts.block_time_utc,
        r.tx_hash,
        r.log_index,
        r.topic_0,
        {{event_name('r.topic_0')}} as event_name,
        r.topic_1 as pool_id,
        '0x' || substring(r.topic_2, 27, 40) as sender,
        {{ decode_swap_columns('r.data') }},
        tm.decimals_0,
        tm.decimals_1,
        tm.pair,
        tm.symbol_0,
        tm.symbol_1
    from raw r
    join ts on r.block_number = ts.block_number
    join tm on r.topic_1 = tm.pool_id
    where {{event_name('r.topic_0')}} = 'Swap'
)

select 
    block_number,
    block_time_utc,
    tx_hash,
    log_index,
    event_name,
    pool_id,

    -- normalized token amounts
    --amount0 / power(10, decimals_0) as amount_0,
    --amount1 / power(10, decimals_1) as amount_1,

    -- token sold (positive amount)
    case 
        when amount0 > 0 then symbol_0
        else symbol_1
    end as token_sold,

    case 
        when amount0 > 0 then amount0 / power(10, decimals_0)
        else amount1 / power(10, decimals_1)
    end as token_sold_amount,

    -- token bought (negative amount)
    case 
        when amount0 < 0 then symbol_0
        else symbol_1
    end as token_bought,

    case 
        when amount0 < 0 then abs(amount0 / power(10, decimals_0))
        else abs(amount1 / power(10, decimals_1))
    end as token_bought_amount,

    pair,
   -- sqrt_price_x96,
   -- liquidity,
  --  tick,
    fee

from decoded_swaps

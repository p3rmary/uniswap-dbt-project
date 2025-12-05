with raw as (
    select * from {{ ref('stg_initialize') }}
),

meta as (
    select * from {{ ref('stg_meta') }}
)

select
    r.pool_id,
    r.currency0,
    r.currency1,


    m0.name      as name_0,
    m0.symbol    as symbol_0,
    m0.decimals  as decimals_0,

  
    m1.name      as name_1,
    m1.symbol    as symbol_1,
    m1.decimals  as decimals_1,

 
    concat(m0.symbol, '/', m1.symbol) as pair

from raw r


left join meta m0 
    on r.currency0 = m0.token


left join meta m1 
    on r.currency1 = m1.token

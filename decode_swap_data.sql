{% macro decode_swap_columns(data_column) %}

    -- amount 0  (int128)
    {{ hex_to_int("substring(" ~ data_column ~ ", case when left(" ~ data_column ~ ", 2) = '0x' then 3 else 1 end, 64)", 128, true) }} AS amount0,

-- amount1 (int128)
    {{ hex_to_int("substring(" ~ data_column ~ ", case when left(" ~ data_column ~ ", 2) = '0x' then 67 else 65 end, 64)", 128, true) }} AS amount1,

    -- sqrt_price_x96 (uint160)
    {{ hex_to_int("substring(" ~ data_column ~ ", case when left(" ~ data_column ~ ", 2) = '0x' then 131 else 129 end, 64)", 160, false) }} AS sqrt_price_x96,

    -- liquidity (uint128)
    {{ hex_to_int("substring(" ~ data_column ~ ", case when left(" ~ data_column ~ ", 2) = '0x' then 195 else 193 end, 64)", 128, false) }} AS liquidity,

    -- tick (int24)
    {{ hex_to_int("substring(" ~ data_column ~ ", case when left(" ~ data_column ~ ", 2) = '0x' then 259 else 257 end, 64)", 24, true) }} AS tick,

    -- fee (uint24)
    {{ hex_to_int("substring(" ~ data_column ~ ", case when left(" ~ data_column ~ ", 2) = '0x' then 323 else 321 end, 64)", 24, false) }} AS fee

{% endmacro %}
{% macro decode_initialize_data(data_column) %}

    (
        '0x' || substring({{ data_column }} from 3 for 64))::numeric AS fee,

    (
        '0x' || substring({{ data_column }} from 67 for 64))::numeric AS tick_spacing,

    LOWER(
        '0x' || substring({{ data_column }} from 155 for 40)) AS hooks,

    (
        '0x' || substring({{ data_column }} from 195 for 64)
    )::numeric AS sqrt_price_x96,
    

    CASE 
        WHEN ('0x' || substring({{ data_column }} from 259 for 64))::numeric > (2::numeric ^ 255)
        THEN ('0x' || substring({{ data_column }} from 259 for 64))::numeric - (2::numeric ^ 256)
        ELSE ('0x' || substring({{ data_column }} from 259 for 64))::numeric
    END AS tick

{% endmacro %}
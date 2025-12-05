select 
block_number,
block_timestamp,
block_time_utc
from {{ref ('timestamp')}}
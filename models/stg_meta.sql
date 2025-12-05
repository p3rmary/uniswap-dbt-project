select 
token, name, symbol, decimals
from {{ref ('v4tokens_metadata')}}
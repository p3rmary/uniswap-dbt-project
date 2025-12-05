# Uniswap-dbt-project

This project pulls raw Uniswap v4 swap logs from Blocks *21688329* to *21708329* and turns them into a clear table that’s easy to work with.

The goal is simple: take messy blockchain event data and shape it into something anyone can read.

I decoded the swap events, mapped the tokens, handled decimals, and built a table that shows what was bought, what was sold, and how much actually moved.

Everything is done with dbt models, macros, and seeds.

What the project does:
- Loads raw Ethereum logs from Uniswap v4.
- Extracts the swap events from the PoolManager contract.
- Decodes the event data into real numbers:
   - token amounts
   - sqrt price
   - liquidity
  -  tick
  - fee
- Joins each swap with token metadata:
   - symbol
   - name
   - decimals
   - token pair

- Calculates token in and token out based on the sign of the swap amounts.
- Builds a clean final swaps table that is easy to read.


## **Project Structure**

**uniswap_dbt/**
- **dbt_project.yml**
- **models/**
  - **staging/**
    - stg_uniswap_logs.sql
    - stg_initialize.sql
    - stg_tokens.sql
    - stg_swaps.sql
    - stg_meta.sql
    - -stg_timestamp.sql
- **macros/**
  - event_name.sql
  - decode_swap_data.sql
  - hex_utils.sql
  - initialize_data.sql
- **seeds/**
  - timestamp.csv
  - tokens.csv
  - v4tokens_metadata
  - uniswap_logs28
- **README.md**

*The staging folder holds all main transformation steps.*

*Macros handle decoding logic.*

*Seeds store timestamps and token metadata.*

## How swaps are interpreted

- Uniswap v4 emits raw amounts as signed integers.
- Positive means the pool received that token.
- Negative means the pool sent it out.

I decoded these into something easier to read:

- token_bought

- token_sold

- token_bought_amount

- token_sold_amount

This avoids confusion around negative numbers.

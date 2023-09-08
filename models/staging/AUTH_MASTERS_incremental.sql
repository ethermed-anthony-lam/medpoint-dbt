{{ config(materialized='table') }}

with incremental_data as (
  select
    *
  from
    your_source_data
  where
    LASTCHANGEDATE >= '{{ target('staging', 'last_auth_masters_timestamp') }}'
)

select *
from incremental_data


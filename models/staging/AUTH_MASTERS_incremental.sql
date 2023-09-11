{{ config(materialized='table') }}

with incremental_data as (
  select
    *
  from
    {{source('medpoint', 'rvs_auth_masters')}}
  -- where
  --   LASTCHANGEDATE >= '{{ target('staging', 'last_auth_masters_timestamp') }}'
)

select *
from incremental_data


{{ config(materialized='table') }}

with incremental_data as (
  select
    *
  from
    {{source('medpoint', 'rvs_auth_masters')}}
)

select *
from incremental_data


{{ config(materialized='table') }}

with source_data as (
  select
    *
  from
    {{source('medpoint_dev', 'meta_table')}}
)

select *
from source_data
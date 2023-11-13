{{ config(materialized='table') }}

with raw_auth_masters_df as (
    select
      *
    from
      {{source('medpoint_raw', 'rvs_auth_masters')}}
  ),
  raw_vend_masters_df as (
    select
      *
    from
      {{source('medpoint_raw', 'rvs_vend_masters')}}
  ),
  raw_prov_company_df as (
    select
      *
    from
      {{source('medpoint_raw', 'rvs_prov_company')}}
  ),
  raw_memb_company_df as (
    select
      *
    from
      {{source('medpoint_raw', 'rvs_memb_company')}}
  ),
  raw_prov_hospinfo_df as (
    select
      *
    from
      {{source('medpoint_raw', 'rv_prov_hospinfo')}}
  ),
  raw_auth_attachments_df as (
    select
      *
    from
      {{source('medpoint_raw', 'rvs_auth_attachments')}}
  ),
  raw_auth_notes_df as (
    select
      *
    from
      {{source('medpoint_raw', 'rvs_auth_notes')}}
  ),
  raw_auth_details_df as (
    select
      *
    from
      {{source('medpoint_raw', 'rv_auth_details')}}
  ),
  raw_auth_diags_df as (
    select
      *
    from
      {{source('medpoint_raw', 'rv_auth_diags')}}
  ),
  aux_vendor as (
    select DISTINCT COMPANY_ID, VENDORID as VENDOR, LASTCHANGEDATE as aux_vendor_LASTCHANGEDATE from raw_vend_masters_df
  ),
  vendor_timestamps as (
    select COMPANY_ID, WEBKEY, aux_vendor_LASTCHANGEDATE as UPDATE_TIMESTAMP, 'VEND_MASTERS' AS UPDATE_REASON
    from raw_auth_masters_df r
    join aux_vendor a on r.COMPANY_ID = a.COMPANY_ID AND r.VENDOR = a.VENDOR
  )



select *
from vendor_timestamps


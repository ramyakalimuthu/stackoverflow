{{
  config(
    materialized = 'incremental',
    unique_key = 'id',
    incremental_strategy = 'microbatch',
    event_time = 'creation_date',
    begin = '2020-04-28',
    batch_size = 'month',
    partition_by = {
      "field": "creation_date",
      "data_type": "timestamp",
      "granularity": "month"
    }
  )
}}

select *
from {{ source('stackoverflow', 'posts_questions') }}
where creation_date <= '2020-05-30'
{% if is_incremental() %}
  and creation_date >= (select max(creation_date) from {{ this }})
{% endif %}

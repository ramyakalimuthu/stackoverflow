{{
  config(
    materialized = 'incremental',
    unique_key = 'id',
    incremental_strategy = 'microbatch',
    event_time='last_activity_date',
    begin='2020-04-28',
    batch_size='day'
  )
}}
select * from {{ source('posts_questions', 'posts_questions') }}
{% if is_incremental() %}
where
last_activity_date >= (select max(last_activity_date) from {{this}})
{% endif %}


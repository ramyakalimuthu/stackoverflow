{{
  config(
    materialized = 'incremental',
    unique_key = 'id',
    partition_by = {
      "field": "question_creation_dt",
      "data_type": "DATE"
    }
  )
}}

SELECT
  *,
  DATE(creation_date) question_creation_dt,
  -- Derived fields
  DATE_DIFF(CURRENT_DATE(), DATE(creation_date), DAY) AS question_age_days,
  upvotes - downvotes AS net_votes,

  CASE 
    WHEN answer_count = 0 THEN 'Unanswered'
    WHEN answer_count = 1 THEN 'Single Answer'
    ELSE 'Multiple Answers'
  END AS answer_status,

  CASE 
    WHEN upvotes >= 5 AND answer_count >= 2 THEN 'High Quality'
    WHEN upvotes >= 1 THEN 'Medium Quality'
    ELSE 'Low Quality'
  END AS post_quality,

  CASE
    WHEN REGEXP_CONTAINS(tags, r'python') THEN 'Python'
    WHEN REGEXP_CONTAINS(tags, r'javascript') THEN 'JavaScript'
    WHEN REGEXP_CONTAINS(tags, r'sql') THEN 'SQL'
    ELSE 'Other'
  END AS major_tag
FROM {{ ref('stg_question_votes_enriched') }}

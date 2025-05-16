SELECT
  DATE(creation_date) AS creation_date,
  COUNT(*) AS row_count
FROM {{ ref('base_questions') }}
GROUP BY 1

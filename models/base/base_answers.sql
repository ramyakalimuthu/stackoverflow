SELECT
  id,
  parent_id AS question_id
FROM {{ source('stackoverflow', 'posts_answers') }}
-- `bigquery-public-data.stackoverflow.posts_answers`

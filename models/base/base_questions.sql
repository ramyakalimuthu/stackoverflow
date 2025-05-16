SELECT
  id,
  title,
  tags,
  creation_date,
  owner_user_id
FROM {{ source('stackoverflow', 'posts_questions') }}
-- `bigquery-public-data.stackoverflow.posts_questions`

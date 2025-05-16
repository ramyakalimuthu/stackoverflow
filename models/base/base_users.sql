SELECT
  id AS user_id,
  display_name
FROM {{ source('stackoverflow', 'users') }}
-- `bigquery-public-data.stackoverflow.users`

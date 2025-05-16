SELECT
  post_id,
  vote_type_id
FROM {{ source('stackoverflow', 'votes') }}
-- `bigquery-public-data.stackoverflow.votes`

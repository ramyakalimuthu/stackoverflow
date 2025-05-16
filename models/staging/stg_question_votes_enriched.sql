SELECT
  q.*,
  SUM(IF(v.vote_type_id = 2, 1, 0)) AS upvotes,
  SUM(IF(v.vote_type_id = 3, 1, 0)) AS downvotes
FROM {{ ref('stg_question_with_answers') }} q
LEFT JOIN {{ ref('base_votes') }} v ON q.id = v.post_id
GROUP BY q.id, q.title, q.tags, q.creation_date, q.owner_user_id, q.display_name, q.answer_count

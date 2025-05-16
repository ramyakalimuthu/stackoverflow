SELECT 
  q.*,
  u.display_name,
  COUNT(a.id) AS answer_count
FROM {{ ref('base_questions') }} q
LEFT JOIN {{ ref('base_users') }} u ON q.owner_user_id = u.user_id
LEFT JOIN {{ ref('base_answers') }} a ON a.question_id = q.id
WHERE q.creation_date >= '2022-01-01'
GROUP BY q.id, q.title, q.tags, q.creation_date, q.owner_user_id, u.display_name

SELECT
q.id AS question_id,
 q.creation_date,
 q.tags,
 q.title,
 u.display_name AS author,
 COUNT(a.id) AS answer_count,
 SUM(IF(v.vote_type_id = 2, 1, 0)) AS upvotes
FROM 
--    {{ ref('stg__questions') }}
    {{ source('stackoverflow', 'posts_questions') }} q
LEFT JOIN
    {{ source('stackoverflow', 'users') }} u
ON
 q.owner_user_id = u.id
LEFT JOIN
    {{ source('stackoverflow', 'posts_answers') }} a
ON
 a.parent_id = q.id
LEFT JOIN
    {{ source('stackoverflow', 'votes') }} v
ON
 v.post_id = q.id
WHERE
 q.creation_date= '2022-01-01'
GROUP BY
q.id, q.creation_date, q.tags, q.title, u.display_name
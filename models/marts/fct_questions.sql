SELECT
q.id AS question_id,
 q.creation_date,
 q.tags,
 q.title,
 u.display_name AS author,
 COUNT(a.id) AS answer_count,
 SUM(IF(v.vote_type_id = 2, 1, 0)) AS upvotes
FROM 
{{ ref('stg__questions') }} q
--    {{ source('stackoverflow', 'posts_questions') }} q
LEFT JOIN
    {{ ref('base_users') }} u
--    {{ source('stackoverflow', 'users') }} u
ON
 q.owner_user_id = u.user_id
LEFT JOIN
    {{ ref('base_answers') }} a
--    {{ source('stackoverflow', 'posts_answers') }} a
ON
 a.question_id = q.id
LEFT JOIN
    {{ ref('base_votes') }} v
--     {{ source('stackoverflow', 'votes') }} v
ON
 v.post_id = q.id
WHERE
 q.creation_date= '2020-04-28'
GROUP BY
q.id, q.creation_date, q.tags, q.title, u.display_name
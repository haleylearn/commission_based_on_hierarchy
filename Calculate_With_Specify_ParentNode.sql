
WITH ParentAndChildwCondition AS (
     -- base query
    SELECT user_id AS parent, user_id AS child, 0 As hireachy_level FROM user_mapping WHERE user_id = 'user_000002'
    -- Get specify user_id = 'user_000002'

    UNION ALL

    -- recursive query
    SELECT c1.parent, c2.user_id, hireachy_level + 1
    FROM ParentAndChildwCondition c1, user_mapping c2
    WHERE c1.child = c2.parent_user_id
) -- To get all child of each node

, ParentAndChildFinnal AS (
    SELECT * FROM ParentAndChildwCondition WHERE parent <> child
) -- To get all child of each node but dont have any parent = child

, ParentAndChildOneMore AS (
     -- base query
    SELECT child AS parent, child AS child, 0 As hireachy_level FROM ParentAndChildFinnal

    UNION ALL

    -- recursive query
    SELECT c1.parent, c2.user_id, hireachy_level + 1
    FROM ParentAndChildOneMore c1, user_mapping c2
    WHERE c1.child = c2.parent_user_id
) -- Write one more recursive for all node is child of user_id = 'user_000002' 

, CalculateRI AS (
    SELECT parent, SUM(bonus_percent) AS RI
    FROM 
    (
        SELECT parent, child, hireachy_level, CONVERT(DECIMAL(10,2),b.level_percentage) * 100 AS bonus_percent
        FROM ParentAndChildOneMore p
        JOIN level_bonus b ON p.hireachy_level = b.id
    ) x
    GROUP BY parent
)
, CalculateRB AS (
    SELECT parent, SUM(CONVERT(DECIMAL(10,2),total)) AS RB
    FROM 
    (
        SELECT p.parent, child
            , parent_user_id AS leader
            , user_level AS level_leader
            , CONVERT(DECIMAL(10,2),b.ld_level_percentage) AS bonus_percent
            , r.RI
            , (r.RI * b.ld_level_percentage) AS total
        FROM ParentAndChildOneMore p 
        JOIN user_mapping u ON p.child = u.user_id
        JOIN leadership_bonus b ON hireachy_level = b.id
        LEFT JOIN CalculateRI r ON r.parent = child
    ) x
    GROUP BY parent
)

SELECT * FROM CalculateRB;
WITH ConsecutiveChairs AS (
    SELECT 
        c1.queue,
        c1.id AS left_chair,
        c2.id AS right_chair
    FROM chairs c1
    JOIN chairs c2 ON c1.queue = c2.queue 
                    AND c1.id = c2.id - 1  -- Garantir que c1 é a cadeira à esquerda de c2 (id consecutivo)
                    AND c1.available = TRUE
                    AND c2.available = TRUE
)
SELECT queue, left_chair, right_chair
FROM ConsecutiveChairs
ORDER BY queue, left_chair;

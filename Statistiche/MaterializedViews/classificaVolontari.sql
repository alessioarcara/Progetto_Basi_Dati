DROP MATERIALIZED VIEW IF EXISTS classificaVolontari;

CREATE MATERIALIZED VIEW classificaVolontari AS
SELECT
    emailvolontario, count(*) AS NumConsegne
FROM consegna
GROUP BY
    emailvolontario
ORDER BY
    NumConsegne DESC;
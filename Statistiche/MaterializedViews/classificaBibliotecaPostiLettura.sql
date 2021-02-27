DROP MATERIALIZED VIEW IF EXISTS classificaBibliotecaPostiLettura;

CREATE MATERIALIZED VIEW classificaBibliotecaPostiLettura AS
WITH BibliotecaPostiLetturaDisponibili AS (
    SELECT count(*) AS NumPostiLetturaDispobili, nomebiblioteca
    FROM postolettura
    GROUP BY nomebiblioteca
), BibliotecaPostiLetturaOccupati AS (
    SELECT count(numeropostolettura) AS NumPostiLetturaOccupati, nome
    FROM registrazione RIGHT JOIN biblioteca ON nome = nomebiblioteca
--         WHERE data = current_date
    GROUP BY nome
)
SELECT ( (NumPostiLetturaOccupati * 1.) / (NumPostiLetturaDispobili * 1.) ) * 100 AS PERCENTUALE_OCCUPAZIONE, BibliotecaPostiLetturaOccupati.nome
FROM BibliotecaPostiLetturaDisponibili JOIN BibliotecaPostiLetturaOccupati ON BibliotecaPostiLetturaOccupati.nome = BibliotecaPostiLetturaDisponibili.nomebiblioteca
ORDER BY percentuale_occupazione;
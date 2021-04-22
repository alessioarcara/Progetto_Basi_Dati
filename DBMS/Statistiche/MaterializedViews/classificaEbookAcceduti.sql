DROP TRIGGER IF EXISTS incrementaAccessi ON VISITA;
DROP FUNCTION IF EXISTS incrementaEbook;

-- Creazione function per utilizzo successivo del trigger
CREATE OR REPLACE FUNCTION incrementaEbook ()
    RETURNS TRIGGER
    AS $$
    BEGIN
        UPDATE EBOOK SET NumAccessiScheda = NumAccessiScheda + 1
        WHERE (CodiceEbook = NEW.CodiceEbook);
        RETURN NEW;
    END; $$
LANGUAGE 'plpgsql';

-- Creazione trigger
CREATE TRIGGER incrementaAccessi AFTER INSERT ON VISITA
FOR EACH ROW EXECUTE PROCEDURE incrementaEbook();

-- Creazione view materializzata per classica degli ebook più acceduti
DROP MATERIALIZED VIEW IF EXISTS classificaEbookAcceduti;

CREATE MATERIALIZED VIEW classificaEbookAcceduti (CodiceE, Accessi) AS
SELECT CodiceEbook, NumAccessiScheda
FROM EBOOK
ORDER BY NumAccessiScheda DESC;
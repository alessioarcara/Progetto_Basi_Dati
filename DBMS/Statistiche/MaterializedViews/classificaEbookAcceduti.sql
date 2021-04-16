DROP TRIGGER IF EXISTS incrementaAccessi ON VISITA;
DROP FUNCTION IF EXISTS incrementaEbook;

CREATE OR REPLACE FUNCTION incrementaEbook ()
    RETURNS TRIGGER
    AS $$
    BEGIN
        UPDATE EBOOK SET NumAccessiScheda = NumAccessiScheda + 1
        WHERE (CodiceEbook = NEW.CodiceEbook);
        RETURN NEW;
    END; $$
LANGUAGE 'plpgsql';

CREATE TRIGGER incrementaAccessi AFTER INSERT ON VISITA
FOR EACH ROW EXECUTE PROCEDURE incrementaEbook();


DROP MATERIALIZED VIEW IF EXISTS classificaEbookAcceduti;

CREATE MATERIALIZED VIEW classificaEbookAcceduti (CodiceE, Accessi) AS
SELECT CodiceEbook, NumAccessiScheda
FROM EBOOK
ORDER BY NumAccessiScheda DESC;

REFRESH MATERIALIZED VIEW classificaEbookAcceduti;
SELECT * FROM classificaEbookAcceduti;

INSERT INTO VISITA VALUES ('AAA', 'utente1@g.com', 'A000000001');
INSERT INTO VISITA VALUES ('BBB', 'utente1@g.com', 'A000000002');
-- DELETE FROM VISITA
-- UPDATE EBOOK SET NumAccessiScheda = 0
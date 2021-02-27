CREATE OR REPLACE FUNCTION CambioStatoPrenotatoConsegnato_funzione()
    RETURNS trigger
AS $$

DECLARE tempCodiceLibro CHAR(10);

BEGIN

    IF (new.tipo = 'Affidamento') THEN
        SELECT codicelibrocartaceo INTO tempCodiceLibro
        FROM prenotazione JOIN consegna ON prenotazione.codiceprenotazione = consegna.codiceprenotazione
        WHERE consegna.codiceprenotazione = new.codiceprenotazione;

        UPDATE librocartaceo SET statoprestito = 'CONSEGNATO' WHERE codicelibrocartaceo = tempCodiceLibro;
        RETURN NEW;
    ELSE
        RETURN NULL;
    END IF;
END
$$
    LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS CambioStatoPrenotatoConsegnato ON consegna;
CREATE TRIGGER CambioStatoPrenotatoConsegnato
    AFTER INSERT ON consegna
    FOR EACH ROW
EXECUTE PROCEDURE CambioStatoPrenotatoConsegnato_funzione();
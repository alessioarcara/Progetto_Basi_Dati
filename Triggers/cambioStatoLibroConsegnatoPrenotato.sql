CREATE OR REPLACE FUNCTION CambioStatoConsegnatoPrenotato_funzione()
    RETURNS trigger
AS $$

DECLARE tempCodiceLibro CHAR(10);

BEGIN

    IF (new.tipo = 'Restituzione') THEN
        SELECT codicelibrocartaceo INTO tempCodiceLibro
        FROM prenotazione JOIN consegna ON prenotazione.codiceprenotazione = consegna.codiceprenotazione
        WHERE consegna.codiceprenotazione = new.codiceprenotazione;

        UPDATE librocartaceo SET statoprestito = 'PRENOTATO' WHERE codicelibrocartaceo = tempCodiceLibro;
        RETURN NEW;
    ELSE
        RETURN NULL;
    END IF;
END
$$
    LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS CambioStatoConsegnatoPrenotato ON consegna;
CREATE TRIGGER CambioStatoConsegnatoPrenotato
    AFTER INSERT ON consegna
    FOR EACH ROW
EXECUTE PROCEDURE CambioStatoConsegnatoPrenotato_funzione()
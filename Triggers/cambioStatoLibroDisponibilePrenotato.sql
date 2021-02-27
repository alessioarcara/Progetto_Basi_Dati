CREATE OR REPLACE FUNCTION CambioStatoDisponibilePrenotato_funzione()
RETURNS trigger
    AS $$
    BEGIN
        UPDATE librocartaceo SET statoprestito = 'PRENOTATO' WHERE codicelibrocartaceo = NEW.codicelibrocartaceo;
        RETURN NEW;
    END
    $$
LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS CambioStatoDisponibileConsegnato ON prenotazione;
CREATE TRIGGER CambioStatoDisponibileConsegnato
    AFTER INSERT ON prenotazione
    FOR EACH ROW
    EXECUTE PROCEDURE CambioStatoDisponibilePrenotato_funzione();
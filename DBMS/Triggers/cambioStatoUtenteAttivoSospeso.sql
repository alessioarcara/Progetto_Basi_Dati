-- Creazione function da richiamare nella creazione del trigger
CREATE OR REPLACE FUNCTION CambiaStatoAttivoSospeso_Funzione()
    RETURNS trigger
AS $$

DECLARE Contatore SMALLINT;

BEGIN

    SELECT COUNT(*) AS NumSegnalazioni INTO Contatore
    FROM segnalazione
    WHERE (emailutilizzatore = new.emailutilizzatore);

    IF (Contatore >= 3) THEN

        UPDATE utilizzatore SET statoaccount = 'SOSPESO' WHERE emailutilizzatore = new.emailutilizzatore;
        RETURN NEW;
    ELSE
        RETURN NULL;
    END IF;
END
$$
    LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS CambiaStatoAttivoSospeso ON segnalazione;
CREATE TRIGGER CambiaStatoAttivoSospeso
    AFTER INSERT ON segnalazione
    FOR EACH ROW
EXECUTE PROCEDURE CambiaStatoAttivoSospeso_Funzione();
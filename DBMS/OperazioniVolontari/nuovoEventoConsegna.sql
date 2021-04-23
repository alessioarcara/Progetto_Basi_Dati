-- Creazione stored procedure per modificare data di evento consegna
DROP PROCEDURE IF EXISTS modificaDataPrenotazione;
CREATE PROCEDURE modificaDataPrenotazione (CodiceP TEXT, DataC DATE)
    AS $$
    BEGIN
        UPDATE PRENOTAZIONE SET DataAvvio = DataC WHERE (CodicePrenotazione = CodiceP);
        UPDATE PRENOTAZIONE SET DataFine = (DataC + INTERVAL '15 DAYS') WHERE (CodicePrenotazione = CodiceP);
    END; $$
LANGUAGE 'plpgsql';

-- Creazione function per inserire un evento di consegna
DROP FUNCTION IF EXISTS inserimentoConsegna;

CREATE FUNCTION inserimentoConsegna (Codice TEXT, Note TEXT, DataC DATE, TipoC TIPOLOGIA, CodiceP TEXT, EmailVol TEXT)
RETURNS BOOLEAN
    AS $$
    -- DECLARE controllo INT;

    BEGIN
        -- Controllo che vengano rispettate le proprietà
        IF TipoC = 'Affidamento' AND NOT EXISTS (
            SELECT CodicePrenotazione
            FROM PRENOTAZIONE
            WHERE (CodicePrenotazione = CodiceP AND DataAvvio IS NULL AND DataFine IS NULL)
        ) THEN
            RETURN FALSE;
        END IF;

        INSERT INTO CONSEGNA VALUES (Codice, Note, DataC, TipoC, CodiceP, EmailVol);
        CALL modificaDataPrenotazione (CodiceP, DataC);
        RETURN TRUE;
    END; $$
LANGUAGE 'plpgsql';
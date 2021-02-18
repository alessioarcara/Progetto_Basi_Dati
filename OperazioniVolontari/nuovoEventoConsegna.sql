DROP PROCEDURE IF EXISTS modificaDataPrenotazione;
CREATE PROCEDURE modificaDataPrenotazione (CodiceP TEXT, DataC DATE)
    AS $$
    BEGIN
        UPDATE PRENOTAZIONE SET DataAvvio = DataC WHERE (CodicePrenotazione = CodiceP);
        UPDATE PRENOTAZIONE SET DataFine = (DataC + INTERVAL '15 DAYS') WHERE (CodicePrenotazione = CodiceP);
    END; $$
LANGUAGE 'plpgsql';

DROP FUNCTION IF EXISTS inserimentoConsegna;

CREATE FUNCTION inserimentoConsegna (Codice TEXT, Note TEXT, DataC DATE, TipoC TIPOLOGIA, CodiceP TEXT, EmailVol TEXT)
RETURNS BOOLEAN
    AS $$
    DECLARE controllo INT;

    BEGIN
        SELECT COUNT(*) INTO controllo 
        FROM PRENOTAZIONE 
        WHERE (CodicePrenotazione = CodiceP AND DataAvvio IS NULL AND DataFine IS NULL);

        IF (controllo = 0) THEN 
            RETURN FALSE;
        END IF;

        IF (controllo = 1) THEN
            INSERT INTO CONSEGNA VALUES (Codice, Note, DataC, TipoC, CodiceP, EmailVol);
            CALL modificaDataPrenotazione (CodiceP, DataC);

            RETURN TRUE;
        END IF;
    END; $$
LANGUAGE 'plpgsql';
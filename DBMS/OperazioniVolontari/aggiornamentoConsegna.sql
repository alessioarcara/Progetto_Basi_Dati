DROP FUNCTION IF EXISTS aggiornamentoConsegna;

CREATE FUNCTION aggiornamentoConsegna (Codice TEXT, NoteC TEXT, DataC DATE, TipoC TIPOLOGIA, CodiceP TEXT)
RETURNS BOOLEAN
    AS $$
    DECLARE controllo INT;
    DECLARE controlloConsegna INT;

    BEGIN
        --Verifico che la consegna sia presente
        SELECT COUNT(*) INTO controlloConsegna
        FROM CONSEGNA
        WHERE (CodiceConsegna = Codice);

        --Controllo per aggiornare solo consegne inserite che hanno modificato il campo
        --DataAvvio e DataFine in prenotazione
        SELECT COUNT(*) INTO controllo 
        FROM PRENOTAZIONE 
        WHERE (CodicePrenotazione = CodiceP AND DataAvvio IS NOT NULL AND DataFine IS NOT NULL);

        IF (controllo = 0 OR controlloConsegna = 0) THEN 
            RETURN FALSE;
        END IF;

        IF (controllo = 1) THEN
            UPDATE CONSEGNA SET Note = NoteC WHERE (CodiceConsegna = Codice);
            UPDATE CONSEGNA SET Data = DataC WHERE (CodiceConsegna = Codice);
            UPDATE CONSEGNA SET Tipo = TipoC WHERE (CodiceConsegna = Codice);
            CALL modificaDataPrenotazione (CodiceP, DataC);

            RETURN TRUE;
        END IF;
    END; $$
LANGUAGE 'plpgsql';
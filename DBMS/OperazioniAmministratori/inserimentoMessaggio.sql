-- Creazione function per inserire messaggio
DROP FUNCTION IF EXISTS inserimentoMessaggio;

CREATE FUNCTION inserimentoMessaggio (IdM TEXT, TitoloM TEXT, TestoM TEXT, DataM DATE, EmailA TEXT, EmailU TEXT)
    RETURNS BOOLEAN
    AS $$
    DECLARE flagAmministratore INT;
    DECLARE flagUtilizzatore INT;

    BEGIN
        SELECT COUNT(*) INTO flagAmministratore
        FROM AMMINISTRATORE
        WHERE (EmailAmministratore = EmailA);

        SELECT COUNT(*) INTO flagUtilizzatore
        FROM UTILIZZATORE
        WHERE (EmailUtilizzatore = EmailU);

        IF (flagAmministratore = 1 AND flagUtilizzatore = 1) THEN
            INSERT INTO MESSAGGIO VALUES (IdM, TitoloM, TestoM, DataM, EmailA, EmailU);
            RETURN TRUE;
        END IF;

        RETURN FALSE;
    END; $$
LANGUAGE 'plpgsql';

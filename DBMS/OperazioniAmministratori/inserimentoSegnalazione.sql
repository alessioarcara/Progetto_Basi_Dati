DROP FUNCTION IF EXISTS inserimentoSegnalazione;

CREATE FUNCTION inserimentoSegnalazione (IdS TEXT, TestoS TEXT, DataS DATE, EmailA TEXT, EmailU TEXT)
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
            INSERT INTO SEGNALAZIONE VALUES (IdS, TestoS, DataS, EmailA, EmailU);
            RETURN TRUE;
        END IF;

        RETURN FALSE;
    END; $$
LANGUAGE 'plpgsql';
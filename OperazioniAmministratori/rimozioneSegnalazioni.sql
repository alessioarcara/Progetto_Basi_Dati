DROP FUNCTION IF EXISTS rimozioneSegnalazioni;

CREATE FUNCTION rimozioneSegnalazioni (EmailA TEXT, EmailU TEXT)
    RETURNS BOOLEAN
    AS $$
    DECLARE controlloAmministratore INT;
    DECLARE controlloUtilizzatore INT;

    BEGIN
        --Controllo la presenza dell'amministratore
        SELECT COUNT(*) INTO controlloAmministratore
        FROM AMMINISTRATORE
        WHERE (EmailAmministratore = EmailA);

        --Controllo la presenza dell'utilizzatore
        SELECT COUNT(*) INTO controlloUtilizzatore
        FROM UTILIZZATORE
        WHERE (EmailUtilizzatore = EmailU);

        IF (controlloAmministratore = 1 AND controlloUtilizzatore = 1) THEN
            DELETE FROM SEGNALAZIONE WHERE (EmailUtilizzatore = EmailU);
            UPDATE UTILIZZATORE SET StatoAccount = 'ATTIVO' WHERE (EmailUtilizzatore = EmailU);
            RETURN TRUE;
        END IF;

        RETURN FALSE;
    END; $$
LANGUAGE 'plpgsql';

SELECT rimozioneSegnalazioni ('mario.verdi@unibo.it', 'mario.rossi@unibo.it');
SELECT * FROM SEGNALAZIONE;

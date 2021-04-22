DROP FUNCTION IF EXISTS cancellazioneLibroAmministratore;

CREATE FUNCTION cancellazioneLibroAmministratore(EmailA TEXT, CodiceL TEXT, NomeBiblio TEXT)
RETURNS BOOLEAN
    AS $$
    DECLARE flagBiblioteca INT;

    BEGIN
        IF EXISTS (
            SELECT *
            FROM AMMINISTRATORE
            WHERE (EmailAmministratore = EmailA 
                   AND NomeBiblioteca = NomeBiblio 
                   AND NomeBiblioteca IN (SELECT NomeBiblioteca
                                          FROM LIBRO
                                          WHERE (CodiceLibro = CodiceL)))
        ) THEN
            DELETE FROM LIBRO WHERE (codiceLibro = CodiceL);
            RETURN TRUE;
        END IF;

        RETURN FALSE;
    END; $$
LANGUAGE 'plpgsql';
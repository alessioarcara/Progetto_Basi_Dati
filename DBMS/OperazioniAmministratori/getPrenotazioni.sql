DROP FUNCTION IF EXISTS getPrenotazioni;

CREATE FUNCTION getPrenotazioni (EmailA TEXT, NomeBiblio TEXT)
    RETURNS TABLE (
        Codice CHAR(10),
        DataI DATE,
        DataF DATE,
        EmailU VARCHAR(50),
        CodiceLibroC CHAR(10)
    )
    AS $$
    BEGIN
        IF EXISTS (
            SELECT *
            FROM AMMINISTRATORE
            WHERE (EmailAmministratore = EmailA AND NomeBiblioteca = NomeBiblio)
        ) THEN
            RETURN QUERY
            SELECT *
            FROM PRENOTAZIONE
            WHERE (CodiceLibroCartaceo IN (SELECT CodiceLibro
                                           FROM LIBRO
                                           WHERE (NomeBiblioteca = NomeBiblio)));
        END IF;
    END; $$
LANGUAGE 'plpgsql';
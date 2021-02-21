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

SELECT cancellazioneLibroAmministratore ('mario.verdi@unibo.it', '0000', 'Biblioteca di Medicina');

SELECT * FROM BIBLIOTECA;
SELECT * FROM AMMINISTRATORE;
SELECT * FROM UTENTE;
SELECT * FROM LIBRO;
--INSERT INTO LIBRO VALUES ('0000', 'Libro1', 'NuovaEdizione', '1999', 'Giallo', 'Biblioteca di Medicina');

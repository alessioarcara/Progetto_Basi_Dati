DROP FUNCTION IF EXISTS aggiornamentoLibroAmministratore;

CREATE FUNCTION aggiornamentoLibroAmministratore (EmailA TEXT, CodiceL TEXT, TitoloL TEXT, Edizione TEXT, Pubblicazione SMALLINT, GenereL TEXT, NomeBiblio TEXT)
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
            UPDATE LIBRO SET Titolo = TitoloL WHERE (codiceLibro = CodiceL);
            UPDATE LIBRO SET NomeEdizione = Edizione WHERE (codiceLibro = CodiceL);
            UPDATE LIBRO SET AnnoPubblicazione = Pubblicazione WHERE (codiceLibro = CodiceL);
            UPDATE LIBRO SET Genere = GenereL WHERE (codiceLibro = CodiceL);
            RETURN TRUE;
        END IF;

        RETURN FALSE;
    END; $$
LANGUAGE 'plpgsql';

SELECT aggiornamentoLibroAmministratore ('mario.gialli@unibo.it', '123AA123BB', 'Prova1', 'Ediz', '1700', 'Horror', 'Biblioteca Universitaria di Bologna');

SELECT * FROM BIBLIOTECA;
SELECT * FROM AMMINISTRATORE;
SELECT * FROM UTENTE;
SELECT * FROM LIBRO;
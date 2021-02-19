DROP FUNCTION IF EXISTS inserimentoLibroAmministratore;

CREATE FUNCTION inserimentoLibroAmministratore (EmailA TEXT, CodiceL TEXT, TitoloL TEXT, Edizione TEXT, Pubblicazione SMALLINT, GenereL TEXT, NomeBiblio TEXT)
RETURNS BOOLEAN
    AS $$
    DECLARE flagBiblioteca INT;

    BEGIN
        IF EXISTS (
            SELECT *
            FROM AMMINISTRATORE
            WHERE (EmailAmministratore = EmailA AND NomeBiblioteca = NomeBiblio)
        ) THEN
            INSERT INTO LIBRO VALUES (CodiceL, TitoloL, Edizione, Pubblicazione, GenereL, NomeBiblio);
            RETURN TRUE;
        END IF;

        RETURN FALSE;
    END; $$
LANGUAGE 'plpgsql';

SELECT inserimentoLibroAmministratore ('mario.gialli@unibo.it', '123AA123BB', 'Titolo-1', 'Giunti', '1997', 'Azione', 'Biblioteca Universitaria di Bologna');

SELECT * FROM BIBLIOTECA;
SELECT * FROM AMMINISTRATORE;
SELECT * FROM UTENTE;
SELECT * FROM LIBRO;
--DROP FUNCTION IF EXISTS inserimentoLibroAmministratore;

--CREATE FUNCTION inserimentoLibroAmministratore (EmailA TEXT, CodiceL TEXT, TitoloL TEXT, Edizione TEXT, Pubblicazione SMALLINT, GenereL TEXT, NomeBiblio TEXT)
--RETURNS BOOLEAN
--    AS $$
--    DECLARE flagBiblioteca INT;
--
--    BEGIN
--        IF EXISTS (
--            SELECT *
--            FROM AMMINISTRATORE
--            WHERE (EmailAmministratore = EmailA AND NomeBiblioteca = NomeBiblio)
--        ) THEN
--            INSERT INTO LIBRO VALUES (CodiceL, TitoloL, Edizione, Pubblicazione, GenereL, NomeBiblio);
--            RETURN TRUE;
--        END IF;
--
--        RETURN FALSE;
--    END; $$
--LANGUAGE 'plpgsql';



DROP FUNCTION IF EXISTS inserimentoLibroCartaceo;
CREATE FUNCTION inserimentoLibroCartaceo (EmailA TEXT, CodLibro TEXT, TitoloL TEXT, NomeEd TEXT, Pubblicazione SMALLINT, GenereL TEXT, StatoPrest PRESTITO, StatoCons CONSERVAZIONE, NPagine SMALLINT, NScaffale SMALLINT, NomeBiblio TEXT)
    RETURNS BOOLEAN
	AS $$
	DECLARE flagAmministratore INT;
	DECLARE flagEbook INT;
	DECLARE flagLibro INT;
	
	BEGIN
		--Controllo che il libro cartaceo non sia stato inserito
		SELECT COUNT(*) INTO flagLibro
		FROM LIBROCARTACEO
		WHERE (codicelibrocartaceo = CodLibro);
		
		--Controllo che l'amministratore sia presente
		SELECT COUNT(*) INTO flagAmministratore
		FROM AMMINISTRATORE
		WHERE (emailamministratore = EmailA);
		
		--Controllo che l'ebook non sia presente sfruttando un flag
		SELECT COUNT(*) INTO flagEbook
		FROM EBOOK
		WHERE (codiceebook = CodLibro);
		
		IF (flagLibro = 0 AND flagAmministratore = 1 AND flagEbook = 0) THEN
			INSERT INTO LIBRO VALUES (CodLibro, TitoloL, NomeEd, Pubblicazione, GenereL, NomeBiblio);
			INSERT INTO LIBROCARTACEO VALUES (CodLibro, StatoPrest, StatoCons, NPagine, NScaffale);
			RETURN TRUE;
		END IF;
		
		RETURN FALSE;
	END; $$
LANGUAGE 'plpgsql';			

SELECT inserimentoLibroCartaceo ('elena.bianchi@unibo.it', '90J0GHJKL3', 'Il fu Mattia Pascal', 'Giunti', '2010', 'Romanzo', 'DISPONIBILE', 'OTTIMO', '124', '12', 'Biblioteca Universitaria di Bologna');


SELECT * FROM LIBRO;
SELECT * FROM LIBROCARTACEO;
SELECT * FROM EBOOK;
		
		
		
		
		
		
	
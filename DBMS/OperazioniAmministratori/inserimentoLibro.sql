DROP FUNCTION IF EXISTS inserisciAutori;
CREATE FUNCTION inserisciAutori (
	CodiceL TEXT,
	NomeAutore TEXT,
	CognomeAutore TEXT
)
	RETURNS BOOLEAN
	AS $$
	DECLARE flagAutore INT;
	DECLARE codice TEXT;

	BEGIN
		-- Controllo che l'autore sia stato già inserito
		SELECT COUNT(*) INTO flagAutore
		FROM AUTORE
		WHERE (Nome = NomeAutore AND Cognome = CognomeAutore);

		-- Se non inserito lo inserisco
		IF (flagAutore = 0) THEN
			INSERT INTO AUTORE VALUES (substr(md5(random()::text), 0, 11), NomeAutore, CognomeAutore);
		END IF;

		SELECT codiceautore INTO codice
		FROM AUTORE
		WHERE (nome = NomeAutore AND cognome = CognomeAutore);
		INSERT INTO LISTA VALUES (codice, CodiceL);
		RETURN TRUE;

	END; $$
LANGUAGE 'plpgsql';


DROP FUNCTION IF EXISTS inserimentoLibroCartaceo;
CREATE FUNCTION inserimentoLibroCartaceo (
	EmailA TEXT, 
	TitoloL TEXT, 
	NomeEd TEXT, 
	Pubblicazione SMALLINT,
	GenereL TEXT,
	StatoPrest PRESTITO,
	StatoCons CONSERVAZIONE,
	NPagine SMALLINT,
	NScaffale SMALLINT,
	NomeAutori TEXT[],
	CognomeAutori TEXT[]
)
    RETURNS BOOLEAN
	AS $$
	DECLARE count INT;
	DECLARE flagAmministratore INT;
	DECLARE biblioteca TEXT;
	DECLARE codice TEXT;
	
	BEGIN
		--Controllo che l'amministratore sia presente
		SELECT COUNT(*) INTO flagAmministratore
		FROM AMMINISTRATORE
		WHERE (emailamministratore = EmailA);

		IF (flagAmministratore = 1) THEN
            SELECT nomebiblioteca INTO biblioteca
            FROM AMMINISTRATORE
            WHERE (emailamministratore = EmailA);
        END IF;

		-- Creo codice casuale con funzione random
		SELECT substr(md5(random()::text), 0, 11) INTO codice;
		
		IF (flagAmministratore = 1) THEN
			INSERT INTO LIBRO VALUES (codice, TitoloL, NomeEd, Pubblicazione, GenereL, biblioteca);
			INSERT INTO LIBROCARTACEO VALUES (codice, StatoPrest, StatoCons, NPagine, NScaffale);

			SELECT cardinality(NomeAutori) INTO count;
			FOR index in 1..count
			LOOP
				PERFORM inserisciAutori (codice, NomeAutori[index], CognomeAutori[index]);
			END LOOP;
			RETURN TRUE;
		END IF;
		
		RETURN FALSE;
	END; $$
LANGUAGE 'plpgsql';


SELECT inserimentoLibroCartaceo (
	'elena.bianchi@unibo.it',
	'Il nome della rosa',
	'Feltrinelli',
	'2010',
	'Romanzo',
	'DISPONIBILE',
	'OTTIMO',
	'120',
	'11',
	array['Umberto', 'Francesco'],
	array['Eco', 'Feltrinelli']
);

SELECT * FROM LIBRO;
SELECT * FROM LIBROCARTACEO;

-- SELECT Nome, Cognome
-- FROM AUTORE
-- WHERE (codiceautore IN (SELECT codiceautore
-- 					   FROM LISTA
-- 					   WHERE (codicelibro = '3cdf50d6ac')));

SELECT * FROM LIBRO;
SELECT * FROM LIBROCARTACEO;
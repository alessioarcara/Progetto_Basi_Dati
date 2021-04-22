DROP FUNCTION IF EXISTS inserimentoEbook;
CREATE FUNCTION inserimentoEbook (
    EmailA TEXT,
    TitoloL TEXT, 
	NomeEd TEXT, 
	Pubblicazione SMALLINT, 
	GenereL TEXT, 
    Dim FLOAT,
    Pdf TEXT,
    NomeAutori TEXT[],
	CognomeAutori TEXT[]
)
    RETURNS BOOLEAN
    AS $$
    DECLARE flagAmministratore INT;
    DECLARE biblioteca TEXT;
    DECLARE codice TEXT;
    DECLARE count INT;

    BEGIN
        -- Controllo se email inserita è un amministratore
        SELECT COUNT(*) INTO flagAmministratore
        FROM AMMINISTRATORE
        WHERE (emailamministratore = EmailA);

        -- Se l'amministratore è presente registro il nome della biblioteca
        IF (flagAmministratore = 1) THEN
            SELECT nomebiblioteca INTO biblioteca
            FROM AMMINISTRATORE
            WHERE (emailamministratore = EmailA);
        END IF;

        -- Creo codice casuale con funzione random
		SELECT substr(md5(random()::text), 0, 11) INTO codice;

        IF (flagAmministratore = 1) THEN
            INSERT INTO LIBRO VALUES (codice, TitoloL, NomeEd, Pubblicazione, GenereL, biblioteca);
            INSERT INTO EBOOK (codiceebook, dimensione, pdf) VALUES (codice, Dim, Pdf);
            
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
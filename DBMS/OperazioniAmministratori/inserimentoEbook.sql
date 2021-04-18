DROP FUNCTION IF EXISTS inserimentoEbook;
CREATE FUNCTION inserimentoEbook (
    EmailA TEXT,
    TitoloL TEXT, 
	NomeEd TEXT, 
	Pubblicazione SMALLINT, 
	GenereL TEXT, 
    CodEbook TEXT,
    Dim FLOAT,
    Pdf TEXT
)
    RETURNS BOOLEAN
    AS $$
    DECLARE flagAmministratore INT;
    DECLARE flagLibro INT;
    DECLARE flagEbook INT;
    DECLARE biblioteca TEXT;

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

        -- Controllo che il cartaceo non sia stato inserito
        SELECT COUNT(*) INTO flagLibro
        FROM LIBROCARTACEO
        WHERE (codicelibrocartaceo = CodEbook);

        -- Controllo che ebook non sia presente
        SELECT COUNT(*) INTO flagEbook
        FROM EBOOK
        WHERE (codiceebook = CodEbook);

        IF (flagAmministratore = 1 AND flagLibro = 0 AND flagEbook = 0) THEN
            INSERT INTO LIBRO VALUES (CodEbook, TitoloL, NomeEd, Pubblicazione, GenereL, biblioteca);
            INSERT INTO EBOOK (codiceebook, dimensione, pdf) VALUES (CodEbook, Dim, Pdf);
            RETURN TRUE;
        END IF;

        RETURN FALSE;
    END; $$
LANGUAGE 'plpgsql';

-- SELECT inserimentoEbook (
--     'elena.bianchi@unibo.it',
--     'La coscienza di Zeno',
--     'Giunti',
--     '2020',
--     'Romanzo',
--     '0089uIuIiQ',
--     '5.6',
--     'prova.pdf'
-- );

-- SELECT inserimentoEbook (
--     'elena.bianchi@unibo.it',
--     'La coscienza di Zeno',
--     'Giunti',
--     '2020',
--     'Romanzo',
--     '0000AA2323',
--     '5.6',
--     'prova.pdf'
-- );

-- SELECT * FROM LIBRO;
-- SELECT * FROM librocartaceo;
-- SELECT * FROM EBOOK;
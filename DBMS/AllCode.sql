/* Creazione tabelle */

CREATE TABLE BIBLIOTECA (
	Nome VARCHAR(100) PRIMARY KEY,
	Via VARCHAR(50) NOT NULL,
	Civico VARCHAR(10) NOT NULL,
	CAP INT NOT NULL,
	Citta VARCHAR(30) NOT NULL,
	Email VARCHAR(50) NOT NULL,
	SitoWeb VARCHAR(300) NOT NULL,
	Lat DECIMAL(10, 8) NOT NULL,
	Long DECIMAL(10, 8) NOT NULL,
	NoteStoriche VARCHAR(250) NOT NULL
);

CREATE TABLE RECAPITOTELEFONICO (
	Numero VARCHAR(20) PRIMARY KEY,
	NomeBiblioteca VARCHAR(100) NOT NULL,
	
	FOREIGN KEY (NomeBiblioteca) REFERENCES BIBLIOTECA (Nome) ON DELETE CASCADE 
														      ON UPDATE CASCADE
);

CREATE TABLE IMMAGINE (
	IdImmagine CHAR(10) PRIMARY KEY,
	Path VARCHAR(500) NOT NULL,
	NomeBiblioteca VARCHAR(100) NOT NULL,
	
	FOREIGN KEY (NomeBiblioteca) REFERENCES BIBLIOTECA (Nome) ON DELETE CASCADE
													          ON UPDATE CASCADE
);

CREATE TABLE POSTOLETTURA (
	Numero SMALLINT,
	NomeBiblioteca VARCHAR(100),
	PresaCorrente BOOLEAN NOT NULL,
	PresaEthernet BOOLEAN NOT NULL,
	
	PRIMARY KEY (Numero, NomeBiblioteca),
	FOREIGN KEY (NomeBiblioteca) REFERENCES BIBLIOTECA (Nome) ON DELETE CASCADE
															  ON UPDATE CASCADE
);

-- Creazione di una sequenza per effettuare l'inserimenti come AUTO_INCREMENT in MySQL
CREATE SEQUENCE seriale AS integer START 1 OWNED BY POSTOLETTURA.Numero;
ALTER TABLE POSTOLETTURA ALTER COLUMN Numero SET DEFAULT nextval('seriale');

CREATE TABLE LIBRO (
	CodiceLibro CHAR(10) PRIMARY KEY,
	Titolo VARCHAR(30) NOT NULL,
	NomeEdizione VARCHAR(30) NOT NULL,
	AnnoPubblicazione SMALLINT NOT NULL,
	Genere VARCHAR(30) NOT NULL,
	NomeBiblioteca VARCHAR(100) NOT NULL,
	
	FOREIGN KEY (NomeBiblioteca) REFERENCES BIBLIOTECA (Nome) ON DELETE CASCADE
															  ON UPDATE CASCADE
);

CREATE TABLE AUTORE (
	CodiceAutore CHAR(10) PRIMARY KEY,
	Nome VARCHAR(20) NOT NULL,
	Cognome VARCHAR(20) NOT NULL
);

--CREATE TYPE PRESTITO AS ENUM ('DISPONIBILE', 'PRENOTATO', 'CONSEGNATO');
--CREATE TYPE CONSERVAZIONE AS ENUM ('OTTIMO', 'BUONO', 'NON BUONO', 'SCADENTE');

CREATE TABLE LIBROCARTACEO (
	CodiceLibroCartaceo CHAR(10) PRIMARY KEY,
	StatoPrestito PRESTITO NOT NULL,
	StatoConservazione CONSERVAZIONE NOT NULL,
	NumPagine SMALLINT NOT NULL,
	NumScaffale SMALLINT NOT NULL,
	
	FOREIGN KEY (CodiceLibroCartaceo) REFERENCES LIBRO (CodiceLibro) ON DELETE CASCADE
																	 ON UPDATE CASCADE
);

CREATE TABLE EBOOK (
	CodiceEbook CHAR(10) PRIMARY KEY,
	Dimensione FLOAT NOT NULL,
	PDF VARCHAR(100) NOT NULL,
	NumAccessiScheda INT DEFAULT 0,
	
	FOREIGN KEY (CodiceEbook) REFERENCES LIBRO (CodiceLibro) ON DELETE CASCADE
														     ON UPDATE CASCADE
);

CREATE TABLE UTENTE (
    EmailUtente VARCHAR(50) PRIMARY KEY,
    Password VARCHAR(100) NOT NULL,
    Nome VARCHAR(20) NOT NULL,
    Cognome VARCHAR(20) NOT NULL,
    DataDiNascita DATE NOT NULL,
    LuogoDiNascita VARCHAR(20) NOT NULL,
    RecapitoTelefonico VARCHAR(20) NOT NULL
);

CREATE TABLE AMMINISTRATORE (
    EmailAmministratore VARCHAR(50) PRIMARY KEY,
    Qualifica VARCHAR(10) NOT NULL,
    NomeBiblioteca VARCHAR(100) NOT NULL,
    FOREIGN KEY (EmailAmministratore) REFERENCES UTENTE(EmailUtente) ON DELETE CASCADE
    							   									 ON UPDATE CASCADE,
    FOREIGN KEY (NomeBiblioteca) REFERENCES BIBLIOTECA(Nome) ON DELETE CASCADE
    														 ON UPDATE CASCADE
);

--CREATE TYPE MEZZO AS ENUM ('Piedi','Bici','Auto');

CREATE TABLE VOLONTARIO (
    EmailVolontario VARCHAR(50) PRIMARY KEY,
    MezzoDiTrasporto MEZZO NOT NULL,
    FOREIGN KEY (EmailVolontario) REFERENCES UTENTE(EmailUtente) ON DELETE CASCADE
    															 ON UPDATE CASCADE
);

--CREATE TYPE STATO AS ENUM ('ATTIVO', 'SOSPESO');

CREATE TABLE UTILIZZATORE (
    EmailUtilizzatore VARCHAR(50) PRIMARY KEY,
    Professione VARCHAR(40) NOT NULL,
    DataCreazioneAccount DATE NOT NULL,
    StatoAccount STATO DEFAULT 'ATTIVO',
    FOREIGN KEY (EmailUtilizzatore) REFERENCES UTENTE(EmailUtente) ON DELETE CASCADE
    															   ON UPDATE CASCADE
);

CREATE TABLE MESSAGGIO (
    IdMessaggio CHAR(10) PRIMARY KEY,
    Titolo VARCHAR(30) NOT NULL,
    Testo VARCHAR(100) NOT NULL,
    Data DATE NOT NULL,
    EmailAmministratore VARCHAR(50) NOT NULL,
    EmailUtilizzatore VARCHAR(50) NOT NULL,
    FOREIGN KEY (EmailAmministratore) REFERENCES 
        AMMINISTRATORE(EmailAmministratore) ON DELETE CASCADE
    																				ON UPDATE CASCADE,
    FOREIGN KEY (EmailUtilizzatore) REFERENCES 
        UTILIZZATORE(EmailUtilizzatore) ON DELETE CASCADE
    																		ON UPDATE CASCADE
);

CREATE TABLE SEGNALAZIONE (
    IdSegnalazione CHAR(10) PRIMARY KEY,
    Testo VARCHAR(80),
    Data DATE NOT NULL,
    EmailAmministratore VARCHAR(50) NOT NULL,
    EmailUtilizzatore VARCHAR(50) NOT NULL,
    FOREIGN KEY (EmailAmministratore) REFERENCES 
        AMMINISTRATORE(EmailAmministratore) ON DELETE CASCADE
    																				ON UPDATE CASCADE,
    FOREIGN KEY (EmailUtilizzatore) REFERENCES 
        UTILIZZATORE(EmailUtilizzatore) ON DELETE CASCADE
  																			ON UPDATE CASCADE
);

CREATE TABLE LISTA (
    CodiceAutore CHAR(10),
    CodiceLibro CHAR(10),
    PRIMARY KEY (CodiceAutore, CodiceLibro),
    FOREIGN KEY (CodiceAutore) REFERENCES AUTORE(CodiceAutore) ON DELETE CASCADE
    														   ON UPDATE CASCADE,	
    FOREIGN KEY (CodiceLibro) REFERENCES LIBRO(CodiceLibro) ON DELETE CASCADE
    														ON UPDATE CASCADE
);

CREATE TABLE VISITA (
	IdVisita CHAR(10) PRIMARY KEY,
	EmailUtilizzatore VARCHAR(50) NOT NULL,
	CodiceEbook CHAR(10) NOT NULL,
	
	FOREIGN KEY (EmailUtilizzatore) REFERENCES 
      UTILIZZATORE (EmailUtilizzatore) ON DELETE CASCADE
																			 ON UPDATE CASCADE,
	FOREIGN KEY (CodiceEbook) REFERENCES 
      EBOOK (CodiceEbook) ON DELETE CASCADE
													ON UPDATE CASCADE
);

CREATE TABLE REGISTRAZIONE (
	IdRegistrazione CHAR(10) PRIMARY KEY,
	Data DATE NOT NULL,
	OraInizio TIME NOT NULL,
	OraFine TIME NOT NULL,
	EmailUtilizzatore VARCHAR(50) NOT NULL,
	NumeroPostoLettura SMALLINT NOT NULL,
	NomeBiblioteca VARCHAR(100) NOT NULL,
	
	FOREIGN KEY (EmailUtilizzatore) REFERENCES 
      UTILIZZATORE (EmailUtilizzatore) ON DELETE CASCADE
																			 ON UPDATE CASCADE,
	FOREIGN KEY (NumeroPostoLettura, NomeBiblioteca) REFERENCES 
      POSTOLETTURA (Numero, NomeBiblioteca) ON DELETE CASCADE
																	          ON UPDATE CASCADE
);

CREATE TABLE PRENOTAZIONE (
    CodicePrenotazione CHAR(10) PRIMARY KEY,
    DataAvvio DATE,
    DataFine DATE,
    EmailUtilizzatore VARCHAR(50) NOT NULL,
    CodiceLibroCartaceo CHAR(10) NOT NULL,
    FOREIGN KEY (EmailUtilizzatore) REFERENCES 
        UTILIZZATORE(EmailUtilizzatore) ON DELETE CASCADE
    																		ON UPDATE CASCADE,
    FOREIGN KEY (CodiceLibroCartaceo) REFERENCES 
        LIBROCARTACEO(CodiceLibroCartaceo) ON DELETE CASCADE
    																			 ON UPDATE CASCADE
);

--CREATE TYPE TIPOLOGIA AS ENUM ('Restituzione','Affidamento');

CREATE TABLE CONSEGNA (
    CodiceConsegna CHAR(10) PRIMARY KEY,
    Note VARCHAR(200) NOT NULL,
    Data DATE NOT NULL,
    Tipo TIPOLOGIA NOT NULL,
    CodicePrenotazione CHAR(10) NOT NULL,
    EmailVolontario VARCHAR(50) NOT NULL,
    FOREIGN KEY (CodicePrenotazione) REFERENCES 
        PRENOTAZIONE(CodicePrenotazione) ON DELETE CASCADE
    																		 ON UPDATE CASCADE,
    FOREIGN KEY (EmailVolontario) REFERENCES 
        VOLONTARIO(EmailVolontario) ON DELETE CASCADE
    																ON UPDATE CASCADE
);

/* Operazioni UTENTI - Stored procedure e Function */
-- Function per l'autenticazione
DROP FUNCTION IF EXISTS Authentication;
CREATE FUNCTION Authentication (Email TEXT, Pwd TEXT)
RETURNS BOOLEAN
AS $$
  BEGIN
    IF EXISTS (
      SELECT *
      FROM UTILIZZATORE
      WHERE (emailutilizzatore = Email AND statoaccount = 'SOSPESO')
    ) THEN 
      RETURN FALSE;
    ELSE RETURN EXISTS (
      SELECT EmailUtente
      FROM UTENTE
      WHERE (EmailUtente=Email) AND (Password=Pwd)
    );
    END IF;
    
  END; $$
LANGUAGE 'plpgsql';

-- Creazione function per visualizzazione delle biblioteche
DROP FUNCTION IF EXISTS GetBiblioteche;
CREATE FUNCTION GetBiblioteche (VARIADIC NomiB TEXT[] DEFAULT NULL)
RETURNS TABLE (
    nome varchar,
    via varchar,
    civico varchar,
    cap integer,
    citta varchar,
    email varchar,
    sitoweb varchar,
    lat numeric(10,8),
    long numeric(10,8),
    notestoriche varchar,
    numero varchar
)
AS $$
BEGIN
    IF nomiB ISNULL THEN
        RETURN QUERY
            SELECT b.nome, b.via, b.civico, b.cap, b.citta, b.email, 
                   b.sitoweb, b.lat, b.long, b.notestoriche, r.numero
            FROM biblioteca b
                     LEFT JOIN recapitotelefonico r on b.nome = r.nomebiblioteca;
    ELSIF EXISTS(SELECT * 
                 FROM biblioteca b 
                 WHERE REPLACE(b.nome, ' ', '') =  ANY(nomiB)) THEN
        RETURN QUERY
            SELECT b.nome, b.via, b.civico, b.cap, b.citta, b.email, 
                   b.sitoweb, b.lat, b.long, b.notestoriche, r.numero
            FROM biblioteca b
                     LEFT JOIN recapitotelefonico r on b.nome = r.nomebiblioteca
            WHERE REPLACE(b.nome, ' ', '') = ANY (NomiB);
    END IF;
END $$
LANGUAGE 'plpgsql';

-- Creazione function per i posti lettura nelle biblioteche
DROP FUNCTION IF EXISTS PostiLetturaBiblioteca;
CREATE FUNCTION PostiLetturaBiblioteca (VARIADIC NomiB TEXT[] DEFAULT NULL)
    RETURNS TABLE(
                     NumPosto SMALLINT,
                     PresaCorr BOOLEAN,
                     PresaEth BOOLEAN,
                     NomeBiblioteca VARCHAR
                 )
AS $$
BEGIN
    IF nomiB ISNULL THEN
        RETURN QUERY
            SELECT numero, presacorrente, presaethernet, p.nomebiblioteca
            FROM postolettura p;
    ELSIF EXISTS(SELECT * 
                 FROM postolettura p 
                 WHERE REPLACE(p.nomebiblioteca, ' ', '') = ANY (NomiB)) THEN
        RETURN QUERY
            SELECT numero, presacorrente, presaethernet, p.nomebiblioteca
            FROM postolettura p
            WHERE REPLACE(p.nomebiblioteca, ' ', '') = ANY (NomiB);
    END IF;
END; $$
LANGUAGE 'plpgsql';

-- Function per libri disponibili
DROP FUNCTION IF EXISTS LibriBiblioteca;
CREATE FUNCTION LibriBiblioteca (VARIADIC words TEXT[] DEFAULT NULL)
    RETURNS TABLE(
                     codicelibrocartaceo char,
                     titolocartaceo varchar,
                     nomeedizionecartaceo varchar,
                     annopubblicazionecartaceo smallint,
                     generecartaceo varchar,
                     nomebibliotecacartaceo varchar,
                     statoprestito text,
                     statoconservazione text,
                     numpagine smallint,
                     numscaffale smallint,
                     codiceebook char,
                     titoloebook varchar,
                     nomeedizioneebook varchar,
                     annopubblicazioneebook smallint,
                     genereebook varchar,
                     nomebibliotecaebook varchar,
                     dimensione float,
                     pdf varchar,
                     nomeautore varchar,
                     cognomeautore varchar
                 )
AS $$
BEGIN
    IF words ISNULL THEN
        RETURN QUERY
            SELECT t1.codicelibro AS codicelibrocartaceo,
                   t1.titolo AS titolocartaceo,
                   t1.nomeedizione AS nomeedizionecartaceo,
                   t1.annopubblicazione AS annopubblicazionecartaceo,
                   t1.genere AS generecartaceo,
                   t1.nomebiblioteca AS nomebibliotecacartaceo,
                   t1.statoprestito::text AS statoprestito,
                   t1.statoconservazione::text AS statoconservazione,
                   t1.numpagine AS numpagine,
                   t1.numscaffale AS numscaffale,
                   t2.codicelibro AS codiceebook,
                   t2.titolo AS titoloebook,
                   t2.nomeedizione AS nomeedizioneebook,
                   t2.annopubblicazione AS annopubblicazioneebook,
                   t2.genere AS genereebook,
                   t2.nomebiblioteca AS nomebibliotecaebook,
                   t2.dimensione AS dimensione,
                   t2.pdf AS pdf,
                   a.nome AS nomeautore,
                   a.cognome AS cognomeautore
            FROM ((SELECT * 
                   FROM libro l JOIN librocartaceo on 
                   l.codicelibro = librocartaceo.codicelibrocartaceo) T1
                   FULL JOIN (SELECT * FROM libro l JOIN ebook e on 
                   l.codicelibro = e.codiceebook) T2
                   ON T1.codicelibro = T2.codicelibro)
                     LEFT JOIN lista on T1.codicelibro = lista.codicelibro or 
                      T2.codicelibro = lista.codicelibro
                     LEFT JOIN autore a on lista.codiceautore = a.codiceautore;
    ELSEIF EXISTS(SELECT * 
                  FROM libro l 
                  WHERE titolo ~~*  ANY (SELECT concat('%',w,'%') 
                                         FROM unnest(array[words]) w)) THEN
        RETURN QUERY
            SELECT t1.codicelibro AS codicelibrocartaceo,
                   t1.titolo AS titolocartaceo,
                   t1.nomeedizione AS nomeedizionecartaceo,
                   t1.annopubblicazione AS annopubblicazionecartaceo,
                   t1.genere AS generecartaceo,
                   t1.nomebiblioteca AS nomebibliotecacartaceo,
                   t1.statoprestito::text AS statoprestito,
                   t1.statoconservazione::text AS statoconservazione,
                   t1.numpagine AS numpagine,
                   t1.numscaffale AS numscaffale,
                   t2.codicelibro AS codiceebook,
                   t2.titolo AS titoloebook,
                   t2.nomeedizione AS nomeedizioneebook,
                   t2.annopubblicazione AS annopubblicazioneebook,
                   t2.genere AS genereebook,
                   t2.nomebiblioteca AS nomebibliotecaebook,
                   t2.dimensione AS dimensione,
                   t2.pdf AS pdf,
                   a.nome AS nomeautore,
                   a.cognome AS cognomeautore
            FROM ((SELECT * 
                   FROM libro l JOIN librocartaceo on 
                    l.codicelibro = librocartaceo.codicelibrocartaceo) T1
                FULL JOIN (SELECT * FROM libro l JOIN ebook e on 
                            l.codicelibro = e.codiceebook) T2
                ON T1.codicelibro = T2.codicelibro)
                     LEFT JOIN lista on T1.codicelibro = lista.codicelibro or 
                                        T2.codicelibro = lista.codicelibro
                     LEFT JOIN autore a on lista.codiceautore = a.codiceautore
            WHERE (t1.titolo ~~*  ANY (SELECT concat('%',w,'%') 
                                       FROM unnest(array[words]) w))
                or (t2.titolo ~~*  ANY (SELECT concat('%',w,'%') 
                                        FROM unnest(array[words]) w));
    END IF;
END; $$
LANGUAGE 'plpgsql';

/* Statistiche realizzate */
DROP MATERIALIZED VIEW IF EXISTS classificaBibliotecaPostiLettura;

-- Creazione della view materializzata utilizzando delle Common Table Expressione
CREATE MATERIALIZED VIEW classificaBibliotecaPostiLettura AS
WITH BibliotecaPostiLetturaDisponibili AS (
    SELECT count(*) AS NumPostiLetturaDispobili, nomebiblioteca
    FROM postolettura
    GROUP BY nomebiblioteca
), BibliotecaPostiLetturaOccupati AS (
    SELECT count(numeropostolettura) AS NumPostiLetturaOccupati, nome
    FROM registrazione RIGHT JOIN biblioteca ON nome = nomebiblioteca
    WHERE data = current_date
    GROUP BY nome
)
SELECT round( ( (NumPostiLetturaOccupati * 1.) / (NumPostiLetturaDispobili * 1.) 
                * 100 ), 2 ) 
       AS PERCENTUALE_OCCUPAZIONE, BibliotecaPostiLetturaOccupati.nome
FROM BibliotecaPostiLetturaDisponibili JOIN BibliotecaPostiLetturaOccupati ON 
  BibliotecaPostiLetturaOccupati.nome = BibliotecaPostiLetturaDisponibili.nomebiblioteca
ORDER BY percentuale_occupazione;

-- Creazione view materializzata per classifica dei volontari
DROP MATERIALIZED VIEW IF EXISTS classificaVolontari;

CREATE MATERIALIZED VIEW classificaVolontari AS
SELECT emailvolontario, count(*) AS NumConsegne
FROM consegna
GROUP BY emailvolontario
ORDER BY NumConsegne DESC;

-- Creazione view materializzata per la classifica dei cartacei più prenotati
DROP MATERIALIZED VIEW IF EXISTS classificaLibriCartacei;

-- In un sistema bibliotecario le prenotazioni vengono gestite sul codice del libro
CREATE MATERIALIZED VIEW classificaLibriCartacei AS
SELECT CodiceLibroCartaceo, COUNT(*) AS NumPrenotazioni
FROM PRENOTAZIONE
GROUP BY CodiceLibroCartaceo
ORDER BY NumPrenotazioni DESC;

-- Altra query possibile permette di verificare il tutto in base al titolo del libro
-- (il titolo non è identificativo univoco)
-- SELECT Titolo, COUNT(*) AS NumPrenotazioni
-- FROM PRENOTAZIONE JOIN LIBRO ON (codicelibro = codicelibrocartaceo)
-- GROUP BY Titolo
-- ORDER BY NumPrenotazioni DESC;

DROP TRIGGER IF EXISTS incrementaAccessi ON VISITA;
DROP FUNCTION IF EXISTS incrementaEbook;

-- Creazione function per utilizzo successivo del trigger
CREATE OR REPLACE FUNCTION incrementaEbook ()
    RETURNS TRIGGER
    AS $$
    BEGIN
        UPDATE EBOOK SET NumAccessiScheda = NumAccessiScheda + 1
        WHERE (CodiceEbook = NEW.CodiceEbook);
        RETURN NEW;
    END; $$
LANGUAGE 'plpgsql';

-- Creazione trigger
CREATE TRIGGER incrementaAccessi AFTER INSERT ON VISITA
FOR EACH ROW EXECUTE PROCEDURE incrementaEbook();

-- Creazione view materializzata per classica degli ebook più acceduti
DROP MATERIALIZED VIEW IF EXISTS classificaEbookAcceduti;

CREATE MATERIALIZED VIEW classificaEbookAcceduti (CodiceE, Accessi) AS
SELECT CodiceEbook, NumAccessiScheda
FROM EBOOK
ORDER BY NumAccessiScheda DESC;

/* Operazioni UTILIZZATORI - Stored procedure e Function */
DROP FUNCTION IF EXISTS RegistrazioneUtente;
CREATE FUNCTION RegistrazioneUtente (
  Email TEXT,
  Password TEXT,
  Nome TEXT,
  Cognome TEXT,
  DataDiNascita DATE,
  LuogoDiNascita TEXT,
  RecapitoTelefonico TEXT,
  Professione TEXT
)
RETURNS BOOLEAN
AS $$
BEGIN
  INSERT INTO UTENTE VALUES (
    Email,
    Password,
    Nome,
    Cognome,
    DataDiNascita,
    LuogoDiNascita,
    RecapitoTelefonico
  );
  INSERT INTO UTILIZZATORE VALUES (
    Email,
    Professione,
    NOW(),
    'ATTIVO'
  );
  RETURN TRUE;
END; $$
LANGUAGE 'plpgsql';

DROP FUNCTION IF EXISTS PrenotaPostoLettura;
CREATE FUNCTION PrenotaPostoLettura (
  EmailUtente TEXT,
  DataPrenotazione DATE,
  NumeroPosto NUMERIC,
  Biblioteca TEXT,
  OraInizioPrenotazione TIME,
  OraFinePrenotazione TIME
)
RETURNS BOOLEAN
AS $$
BEGIN
  -- Controllo se il posto lettura è libero all'orario specificato
  IF EXISTS (
    SELECT IdRegistrazione
    FROM REGISTRAZIONE
    WHERE NumeroPosto = REGISTRAZIONE.NumeroPostoLettura AND 
          Biblioteca = REGISTRAZIONE.NomeBiblioteca
          AND DataPrenotazione = REGISTRAZIONE.Data
          AND (
                (OraInizioPrenotazione >= REGISTRAZIONE.OraInizio AND 
                OraInizioPrenotazione < REGISTRAZIONE.OraFine)
                OR (OraFinePrenotazione > REGISTRAZIONE.OraInizio AND 
                    OraFinePrenotazione <= REGISTRAZIONE.OraFine)
              )
  )
  THEN RETURN FALSE;
  END IF;

  -- Inserisci registrazione posto lettura se l'if è superato
  INSERT INTO REGISTRAZIONE VALUES (
    substr(md5(random()::text), 0, 11),
    DataPrenotazione,
    OraInizioPrenotazione,
    OraFinePrenotazione,
    EmailUtente,
    NumeroPosto,
    Biblioteca
  );
  RETURN TRUE;
END; $$
LANGUAGE 'plpgsql';

DROP FUNCTION IF EXISTS PrenotaLibro;
CREATE FUNCTION PrenotaLibro (
  CodiceLibro TEXT,
  EmailUtente TEXT
)
RETURNS BOOLEAN
AS $$
BEGIN
  -- Controllo se il libro è DISPONIBILE e con uno stato di conservazione non SCADENTE
  IF NOT EXISTS (
    SELECT CodiceLibroCartaceo 
    FROM LIBROCARTACEO 
    WHERE CodiceLibro = CodiceLibroCartaceo
    AND StatoPrestito = 'DISPONIBILE'
    AND StatoConservazione <> 'SCADENTE'
  ) THEN RETURN FALSE;
  END IF;
  -- Inserisco prenotazione con stringa casuale
  INSERT INTO PRENOTAZIONE (CodicePrenotazione, EmailUtilizzatore, CodiceLibroCartaceo) 
  VALUES (
    substr(md5(random()::text), 0, 11),
    EmailUtente,
    CodiceLibro
  );

  RETURN TRUE;

END; $$
LANGUAGE 'plpgsql';

-- Creazione function per ritornare le prenotazioni gestite lato PHP con tabelle dinamiche
-- Restituisce solo la tabella di uno specifico utilizzatore
DROP FUNCTION IF EXISTS GetPrenotazioniUtente;
CREATE FUNCTION GetPrenotazioniUtente (EmailUtente TEXT)
RETURNS TABLE(
  Codice CHAR(10),
  DataAvvioPrenotazione DATE,
  DataFinePrenotazione DATE,
  CodiceLibro CHAR(10)
)
AS $$
BEGIN
  RETURN QUERY
    SELECT CodicePrenotazione, DataAvvio, DataFine, CodiceLibroCartaceo
    FROM PRENOTAZIONE
    WHERE EmailUtilizzatore = EmailUtente;
END; $$
LANGUAGE 'plpgsql';

DROP FUNCTION IF EXISTS VisitaEbook;
CREATE FUNCTION VisitaEbook (
    CodiceVisitaEbook TEXT,
    EmailUtente TEXT
)
    RETURNS BOOLEAN
AS $$
BEGIN
    -- Controllo se EBook esiste
    IF NOT EXISTS (
            SELECT codiceebook
            FROM ebook e
            WHERE e.codiceebook = CodiceVisitaEbook
        ) THEN RETURN FALSE;
    END IF;
    
    -- Inserisco visita con stringa casuale
    INSERT INTO visita (idvisita, emailutilizzatore, codiceebook) VALUES
    (
    substr(md5(random()::text), 0, 11),
    EmailUtente,
    CodiceVisitaEbook
    );
    RETURN TRUE;
END; $$
LANGUAGE 'plpgsql';

DROP FUNCTION IF EXISTS GetConsegneByUtente;
CREATE FUNCTION GetConsegneByUtente (EmailUtente TEXT)
RETURNS TABLE(
  Codice CHAR(10),
  NoteConsegna VARCHAR(100),
  DataConsegna DATE,
  TipoConsegna TIPOLOGIA,
  Codice_Prenotazione CHAR(10)
)
AS $$
BEGIN 
  RETURN QUERY
    SELECT CodiceConsegna, Note, Data, Tipo, CONSEGNA.CodicePrenotazione
    FROM CONSEGNA, PRENOTAZIONE
    WHERE CONSEGNA.CodicePrenotazione = PRENOTAZIONE.CodicePrenotazione
    AND PRENOTAZIONE.EmailUtilizzatore = EmailUtente;
END; $$
LANGUAGE 'plpgsql';

DROP FUNCTION IF EXISTS GetRegistrazioni;
CREATE OR REPLACE FUNCTION GetRegistrazioni()
    RETURNS JSON
AS $$
    DECLARE registrazioni JSON;
    BEGIN
        SELECT json_agg(src) INTO registrazioni
        FROM (SELECT nomebiblioteca, numeropostolettura, data, orainizio, orafine
              FROM registrazione) src;
    RETURN registrazioni;
    END;
$$
LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS GetStatoLibri();
CREATE OR REPLACE FUNCTION GetStatoLibri()
    RETURNS JSON
AS $$
DECLARE statolibri JSON;
BEGIN
    SELECT json_agg(src) INTO statolibri
    FROM (SELECT codicelibrocartaceo, statoprestito FROM librocartaceo) src;
    RETURN statolibri;
END;
$$
    LANGUAGE plpgsql;

/* Operazioni VOLONTARI - Stored procedure e Function */
-- Function per aggiornare la consegna
DROP FUNCTION IF EXISTS aggiornamentoConsegna;

CREATE FUNCTION aggiornamentoConsegna (
  Codice TEXT, NoteC TEXT, DataC DATE, TipoC TIPOLOGIA, CodiceP TEXT
)
RETURNS BOOLEAN
    AS $$
    DECLARE controllo INT;
    DECLARE controlloConsegna INT;

    BEGIN
        --Verifico che la consegna sia presente con un flag
        SELECT COUNT(*) INTO controlloConsegna
        FROM CONSEGNA
        WHERE (CodiceConsegna = Codice);

        --Controllo per aggiornare solo consegne inserite che hanno modificato il campo
        --DataAvvio e DataFine in prenotazione
        SELECT COUNT(*) INTO controllo 
        FROM PRENOTAZIONE 
        WHERE (CodicePrenotazione = CodiceP AND 
               DataAvvio IS NOT NULL AND DataFine IS NOT NULL);

        IF (controllo = 0 OR controlloConsegna = 0) THEN 
            RETURN FALSE;
        END IF;

        IF (controllo = 1) THEN
            UPDATE CONSEGNA SET Note = NoteC WHERE (CodiceConsegna = Codice);
            UPDATE CONSEGNA SET Data = DataC WHERE (CodiceConsegna = Codice);
            UPDATE CONSEGNA SET Tipo = TipoC WHERE (CodiceConsegna = Codice);
            CALL modificaDataPrenotazione (CodiceP, DataC);

            RETURN TRUE;
        END IF;
    END; $$
LANGUAGE 'plpgsql';

-- Creazione stored procedure per modificare data di evento consegna
DROP PROCEDURE IF EXISTS modificaDataPrenotazione;
CREATE PROCEDURE modificaDataPrenotazione (CodiceP TEXT, DataC DATE)
    AS $$
    BEGIN
        UPDATE PRENOTAZIONE SET DataAvvio = DataC 
        WHERE (CodicePrenotazione = CodiceP);
        UPDATE PRENOTAZIONE SET DataFine = (DataC + INTERVAL '15 DAYS') 
        WHERE (CodicePrenotazione = CodiceP);
    END; $$
LANGUAGE 'plpgsql';

-- Creazione function per inserire un evento di consegna
DROP FUNCTION IF EXISTS inserimentoConsegna;

CREATE FUNCTION inserimentoConsegna (
  Codice TEXT, Note TEXT, DataC DATE, TipoC TIPOLOGIA, CodiceP TEXT, EmailVol TEXT
)
RETURNS BOOLEAN
    AS $$
    -- DECLARE controllo INT;

    BEGIN
        -- Controllo che vengano rispettate le proprietà
        IF TipoC = 'Affidamento' AND NOT EXISTS (
            SELECT CodicePrenotazione
            FROM PRENOTAZIONE
            WHERE (CodicePrenotazione = CodiceP AND 
                   DataAvvio IS NULL AND DataFine IS NULL)
        ) THEN
            RETURN FALSE;
        END IF;

        INSERT INTO CONSEGNA VALUES (Codice, Note, DataC, TipoC, CodiceP, EmailVol);
        CALL modificaDataPrenotazione (CodiceP, DataC);
        RETURN TRUE;
    END; $$
LANGUAGE 'plpgsql';

-- Creazione view per la visualizzazione delle prenotazioni
DROP VIEW IF EXISTS getPrenotazione;

CREATE VIEW getPrenotazione AS
SELECT * FROM PRENOTAZIONE;

/* Operazioni AMMINISTRATORI - Stored procedure e Function */
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
			INSERT INTO AUTORE VALUES (
        substr(md5(random()::text), 0, 11), NomeAutore, CognomeAutore
      );
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
			INSERT INTO LIBRO VALUES (
        codice, TitoloL, NomeEd, Pubblicazione, GenereL, biblioteca
      );
			INSERT INTO LIBROCARTACEO VALUES (
        codice, StatoPrest, StatoCons, NPagine, NScaffale
      );

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
            INSERT INTO LIBRO VALUES (
              codice, TitoloL, NomeEd, Pubblicazione, GenereL, biblioteca
            );
            INSERT INTO EBOOK (codiceebook, dimensione, pdf) VALUES (
              codice, Dim, Pdf
            );
            
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

-- Aggiornamento libro generico se e solo se appartiene
-- alla biblioteca dell'amministratore
DROP FUNCTION IF EXISTS aggiornamentoLibroAmministratore;

CREATE FUNCTION aggiornamentoLibroAmministratore (
  EmailA TEXT, 
  CodiceL TEXT, 
  TitoloL TEXT, 
  Edizione TEXT, 
  Pubblicazione SMALLINT, 
  GenereL TEXT, 
  NomeBiblio TEXT
)
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
            UPDATE LIBRO SET Titolo = TitoloL 
            WHERE (codiceLibro = CodiceL);

            UPDATE LIBRO SET NomeEdizione = Edizione 
            WHERE (codiceLibro = CodiceL);

            UPDATE LIBRO SET AnnoPubblicazione = Pubblicazione 
            WHERE (codiceLibro = CodiceL);

            UPDATE LIBRO SET Genere = GenereL 
            WHERE (codiceLibro = CodiceL);
            RETURN TRUE;
        END IF;

        RETURN FALSE;
    END; $$
LANGUAGE 'plpgsql';

-- Cancellazione di un libro per sfruttare le cascade nello schema delle tabelle
DROP FUNCTION IF EXISTS cancellazioneLibroAmministratore;

CREATE FUNCTION cancellazioneLibroAmministratore(
  EmailA TEXT, 
  CodiceL TEXT, 
  NomeBiblio TEXT
)
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

-- Visualizzazione delle sole prenotazioni
-- che fanno riferimento alla biblioteca gestita
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

-- Creazione function per inserire messaggio
DROP FUNCTION IF EXISTS inserimentoMessaggio;

CREATE FUNCTION inserimentoMessaggio (
  IdM TEXT, 
  TitoloM TEXT, 
  TestoM TEXT, 
  DataM DATE, 
  EmailA TEXT, 
  EmailU TEXT
)
    RETURNS BOOLEAN
    AS $$
    DECLARE flagAmministratore INT;
    DECLARE flagUtilizzatore INT;

    BEGIN
        SELECT COUNT(*) INTO flagAmministratore
        FROM AMMINISTRATORE
        WHERE (EmailAmministratore = EmailA);

        SELECT COUNT(*) INTO flagUtilizzatore
        FROM UTILIZZATORE
        WHERE (EmailUtilizzatore = EmailU);

        IF (flagAmministratore = 1 AND flagUtilizzatore = 1) THEN
            INSERT INTO MESSAGGIO VALUES (
              IdM, TitoloM, TestoM, DataM, EmailA, EmailU
            );
            RETURN TRUE;
        END IF;

        RETURN FALSE;
    END; $$
LANGUAGE 'plpgsql';

-- Inserimento segnalazione per un utilizzatore
DROP FUNCTION IF EXISTS inserimentoSegnalazione;

CREATE FUNCTION inserimentoSegnalazione (
  IdS TEXT, 
  TestoS TEXT, 
  DataS DATE, 
  EmailA TEXT, 
  EmailU TEXT
)
RETURNS BOOLEAN
    AS $$
    DECLARE flagAmministratore INT;
    DECLARE flagUtilizzatore INT;

    BEGIN
        SELECT COUNT(*) INTO flagAmministratore
        FROM AMMINISTRATORE
        WHERE (EmailAmministratore = EmailA);

        SELECT COUNT(*) INTO flagUtilizzatore
        FROM UTILIZZATORE
        WHERE (EmailUtilizzatore = EmailU);

        IF (flagAmministratore = 1 AND flagUtilizzatore = 1) THEN
            INSERT INTO SEGNALAZIONE VALUES (
              IdS, TestoS, DataS, EmailA, EmailU
            );
            RETURN TRUE;
        END IF;

        RETURN FALSE;
    END; $$
LANGUAGE 'plpgsql';

-- Function per rimuovere tutte le segnalazioni settando lo stato ad attivo
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
            UPDATE UTILIZZATORE SET StatoAccount = 'ATTIVO' 
            WHERE (EmailUtilizzatore = EmailU);
            RETURN TRUE;
        END IF;

        RETURN FALSE;
    END; $$
LANGUAGE 'plpgsql';

/* Trigger */
-- Creazione function da richiamare nella creazione del trigger
CREATE OR REPLACE FUNCTION CambioStatoConsegnatoPrenotato_funzione()
    RETURNS trigger
AS $$

DECLARE tempCodiceLibro CHAR(10);

BEGIN

    IF (new.tipo = 'Restituzione') THEN
        SELECT codicelibrocartaceo INTO tempCodiceLibro
        FROM prenotazione JOIN consegna ON 
          prenotazione.codiceprenotazione = consegna.codiceprenotazione
        WHERE consegna.codiceprenotazione = new.codiceprenotazione;

        UPDATE librocartaceo SET statoprestito = 'DISPONIBILE' 
        WHERE codicelibrocartaceo = tempCodiceLibro;
        RETURN NEW;
    ELSE
        RETURN NULL;
    END IF;
END
$$
    LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS CambioStatoConsegnatoPrenotato ON consegna;
CREATE TRIGGER CambioStatoConsegnatoPrenotato
    AFTER INSERT ON consegna
    FOR EACH ROW
EXECUTE PROCEDURE CambioStatoConsegnatoPrenotato_funzione();

-- Creazione function da richiamare nella creazione del trigger
CREATE OR REPLACE FUNCTION CambioStatoDisponibilePrenotato_funzione()
RETURNS trigger
    AS $$
    BEGIN
        UPDATE librocartaceo SET statoprestito = 'PRENOTATO' 
        WHERE codicelibrocartaceo = NEW.codicelibrocartaceo;
        RETURN NEW;
    END
    $$
LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS CambioStatoDisponibileConsegnato ON prenotazione;
CREATE TRIGGER CambioStatoDisponibileConsegnato
    AFTER INSERT ON prenotazione
    FOR EACH ROW
    EXECUTE PROCEDURE CambioStatoDisponibilePrenotato_funzione();

-- Creazione function da richiamare nella creazione del trigger
CREATE OR REPLACE FUNCTION CambioStatoPrenotatoConsegnato_funzione()
    RETURNS trigger
AS $$

DECLARE tempCodiceLibro CHAR(10);

BEGIN

    IF (new.tipo = 'Affidamento') THEN
        SELECT codicelibrocartaceo INTO tempCodiceLibro
        FROM prenotazione JOIN consegna ON 
          prenotazione.codiceprenotazione = consegna.codiceprenotazione
        WHERE consegna.codiceprenotazione = new.codiceprenotazione;

        UPDATE librocartaceo SET statoprestito = 'CONSEGNATO' 
        WHERE codicelibrocartaceo = tempCodiceLibro;
        RETURN NEW;
    ELSE
        RETURN NULL;
    END IF;
END
$$
    LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS CambioStatoPrenotatoConsegnato ON consegna;
CREATE TRIGGER CambioStatoPrenotatoConsegnato
    AFTER INSERT ON consegna
    FOR EACH ROW
EXECUTE PROCEDURE CambioStatoPrenotatoConsegnato_funzione();

-- Creazione function da richiamare nella creazione del trigger
CREATE OR REPLACE FUNCTION CambiaStatoAttivoSospeso_Funzione()
    RETURNS trigger
AS $$

DECLARE Contatore SMALLINT;

BEGIN

    SELECT COUNT(*) AS NumSegnalazioni INTO Contatore
    FROM segnalazione
    WHERE (emailutilizzatore = new.emailutilizzatore);

    IF (Contatore >= 3) THEN

        UPDATE utilizzatore SET statoaccount = 'SOSPESO' 
        WHERE emailutilizzatore = new.emailutilizzatore;
        RETURN NEW;
    ELSE
        RETURN NULL;
    END IF;
END
$$
    LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS CambiaStatoAttivoSospeso ON segnalazione;
CREATE TRIGGER CambiaStatoAttivoSospeso
    AFTER INSERT ON segnalazione
    FOR EACH ROW
EXECUTE PROCEDURE CambiaStatoAttivoSospeso_Funzione();

/* Classificatore KNN */
/*
segmentare
età e professione utenti utilizzatori
numero e genere richieste prestiti libri cartacei
*/
DROP FUNCTION k_nnClassifier();

CREATE OR REPLACE FUNCTION k_nnClassifier ()
    RETURNS JSON
AS $$
    import pandas as pd
    import numpy as np
    from sklearn.model_selection import train_test_split
    from sklearn.cluster import KMeans

    dict_utilizzatore = {}

    # data extraction from db

    rv = plpy.execute("""
    WITH richiestelibri AS (
      SELECT emailutilizzatore, count(distinct (genere)) 
             AS generi, count(*) AS prenotazioni
      FROM prenotazione
      JOIN libro ON codicelibrocartaceo = codicelibro
      GROUP BY emailutilizzatore
      )
    SELECT utilizzatore.emailutilizzatore, professione, 
           datadinascita, generi, prenotazioni
    FROM utilizzatore
              JOIN utente ON emailutente = utilizzatore.emailutilizzatore
              JOIN richiestelibri ON 
                utilizzatore.emailutilizzatore = richiestelibri.emailutilizzatore
    """)

    # cursor to dictionary to dataFrame

    for r in rv:
        dict_utilizzatore.update({ r['emailutilizzatore'] : ( r['professione'],
                                                              r['datadinascita'],
                                                              r['generi'],
                                                              r['prenotazioni'])})

    df = pd.DataFrame.from_dict(dict_utilizzatore, 
                                orient='index', 
                                columns=['professione',
                                          'datadinascita',
                                          'generi',
                                          'prenotazioni'])

    # normalize data
    normalize = lambda v: v / np.linalg.norm(v)

    # preprocessing data
    df['professione_feat'] = 
      normalize(df['professione'].astype('category').cat.codes)
    df['generi_feat'], 
    df['prenotazioni_feat'] = 
      normalize(df['generi']), normalize(df['prenotazioni'])
    df['eta'] = 
      (pd.to_datetime('today').year -  pd.to_datetime(df.datadinascita).dt.year)
    df['eta_feat'] = normalize(df['eta'].copy())
    df = df.drop('datadinascita', 1)

    # clustering
    # 4 as my model suggested
    kmeans = KMeans(n_clusters=4, init='k-means++', max_iter=300, n_init=10,
                    random_state=42)
    kmeans.fit(df[['professione_feat', 'eta_feat', 'generi_feat', 'prenotazioni_feat']])

    # return table
    df["cluster"] = kmeans.labels_
    df = 
      df.drop(['professione_feat', 'eta_feat', 'generi_feat', 'prenotazioni_feat'], 1)
    return df.T.to_json()
$$ LANGUAGE plpython3u;

select k_nnClassifier();

DROP MATERIALIZED VIEW IF EXISTS ClustersUtilizzatori;

CREATE MATERIALIZED VIEW ClustersUtilizzatori AS
select
       key as email,
       (data.value ->> 'cluster')::numeric AS cluster,
       (data.value ->> 'professione')::text AS professione,
       (data.value ->> 'eta')::numeric AS eta,
       (data.value ->> 'generi')::numeric AS generi,
       (data.value ->> 'prenotazioni')::numeric AS prenotazioni
FROM json_each(k_nnClassifier()) AS data ;

/* Stored procedure per effettuare refresh delle view materializzate */
-- Creazione stored procedure per il refresh delle view materializzate
DROP PROCEDURE IF EXISTS refreshStatistiche;

CREATE PROCEDURE refreshStatistiche ()
LANGUAGE plpgsql
AS $$
    BEGIN
        REFRESH MATERIALIZED VIEW classificaBibliotecaPostilettura;
        REFRESH MATERIALIZED VIEW classificaLibriCartacei;
        REFRESH MATERIALIZED VIEW classificaEbookAcceduti;
        REFRESH MATERIALIZED VIEW classificaVolontari;
    END;
$$
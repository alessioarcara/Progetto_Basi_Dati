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
  -- Controlla se il posto lettura è libero all'orario specificato
  IF EXISTS (
    SELECT IdRegistrazione
    FROM REGISTRAZIONE
    WHERE NumeroPosto = REGISTRAZIONE.NumeroPostoLettura AND Biblioteca = REGISTRAZIONE.NomeBiblioteca
    AND DataPrenotazione = REGISTRAZIONE.Data
    AND (
            (OraInizioPrenotazione >= REGISTRAZIONE.OraInizio AND OraInizioPrenotazione < REGISTRAZIONE.OraFine)
            OR (OraFinePrenotazione > REGISTRAZIONE.OraInizio AND OraFinePrenotazione <= REGISTRAZIONE.OraFine)
        )
  )
  THEN RETURN FALSE;
  END IF;
  -- Inserisci registrazione posto lettura
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

  -- EXCEPTION
  --   WHEN OTHERS THEN
  --     RETURN FALSE;

END; $$
LANGUAGE 'plpgsql';
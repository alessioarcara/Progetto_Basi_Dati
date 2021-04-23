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
  INSERT INTO PRENOTAZIONE (CodicePrenotazione, EmailUtilizzatore, CodiceLibroCartaceo) VALUES (
    substr(md5(random()::text), 0, 11),
    EmailUtente,
    CodiceLibro
  );

  RETURN TRUE;

END; $$
LANGUAGE 'plpgsql';
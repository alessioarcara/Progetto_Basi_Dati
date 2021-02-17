DROP FUNCTION IF EXISTS PrenotaPostoLettura;
CREATE FUNCTION PrenotaPostoLettura (
  EmailUtente TEXT,
  NumeroPosto NUMERIC,
  Biblioteca TEXT,
  OraInizio TIME,
  OraFine TIME
)
RETURNS BOOLEAN 
AS $$
BEGIN 
  INSERT INTO REGISTRAZIONE VALUES (
    substr(md5(random()::text), 0, 10),
    NOW(),
    OraInizio,
    OraFine,
    EmailUtente,
    NumeroPosto,
    Biblioteca
  );
  RETURN TRUE;
END; $$
LANGUAGE 'plpgsql';
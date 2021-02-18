DROP FUNCTION IF EXISTS PrenotaLibro;
CREATE FUNCTION PrenotaLibro (
  CodiceLibro TEXT,
  EmailUtente TEXT
)
RETURNS BOOLEAN
AS $$
BEGIN
  -- Controllo se il libro è 
END; $$
LANGUAGE 'plpgsql';
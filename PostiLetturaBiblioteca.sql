DROP FUNCTION IF EXISTS PostiLetturaBiblioteca;
CREATE FUNCTION PostiLetturaBiblioteca (Biblioteca TEXT) 
RETURNS TABLE(
  NumPosto SMALLINT,
  PresaCorr BOOLEAN,
  PresaEth BOOLEAN
)
AS $$
BEGIN
  RETURN QUERY 
    SELECT Numero, PresaCorrente, PresaEthernet
    FROM POSTOLETTURA
    WHERE NomeBiblioteca=Biblioteca;
END; $$
LANGUAGE 'plpgsql';
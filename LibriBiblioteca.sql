DROP FUNCTION IF EXISTS LibriBiblioteca;
CREATE FUNCTION LibriBiblioteca (Biblioteca TEXT)
RETURNS TABLE(
  Codice CHAR(10),
	TitoloLibro VARCHAR(30),
	Anno SMALLINT,
	GenereLibro VARCHAR(30)
)
AS $$
BEGIN 
  RETURN QUERY
    SELECT CodiceLibro, Titolo, AnnoPubblicazione, Genere
    FROM LIBRO
    WHERE NomeBiblioteca=Biblioteca;
END; $$
LANGUAGE 'plpgsql';
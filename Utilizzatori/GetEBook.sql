DROP FUNCTION IF EXISTS GetEBook;
CREATE FUNCTION GetEBook (
  CodiceEBookInput TEXT
)
RETURNS TABLE (
  Codice CHAR(10),
  Size FLOAT,
  PathPDF VARCHAR(100),
  NumeroAccessi INT,
  TitoloEBook VARCHAR(30),
  Edizione VARCHAR(30),
	AnnoPubb SMALLINT,
	GenereEBook VARCHAR(30),
	Biblioteca VARCHAR(100)
)
AS $$
BEGIN 
  RETURN QUERY
    SELECT CodiceEbook, Dimensione, PDF, NumAccessiScheda, Titolo, 
           NomeEdizione, AnnoPubblicazione, Genere, NomeBiblioteca
    FROM LIBRO, EBOOK
    WHERE CodiceLibro = CodiceEbook AND CodiceLibro = CodiceEBookInput;
END; $$
LANGUAGE 'plpgsql';
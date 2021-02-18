-- DROP FUNCTION IF EXISTS GetBiblioteche;
-- CREATE FUNCTION GetBiblioteche ()
-- RETURNS TABLE(
--   Nome VARCHAR(30),
-- 	Indirizzo VARCHAR(50),
-- 	Email VARCHAR(50),
-- 	SitoWeb VARCHAR(50),
-- 	Lat DECIMAL(10, 8),
-- 	Long DECIMAL(10, 8)
-- )
-- AS $$
-- BEGIN
--   RETURN QUERY
--     SELECT * 
--     FROM BIBLIOTECA;
-- END; $$
-- LANGUAGE 'plpgsql';

CREATE VIEW BIBLIOTECHE
AS SELECT * FROM BIBLIOTECA;
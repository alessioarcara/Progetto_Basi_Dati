-- DROP FUNCTION IF EXISTS funcClassificaBibliotecaPostiLettura;
-- CREATE FUNCTION funcClassificaBibliotecaPostiLettura ()
-- RETURNS SETOF classificaBibliotecaPostiLettura
--     AS $$
--         SELECT * FROM classificaBibliotecaPostiLettura;
--     $$
-- LANGUAGE SQL;

-- SELECT * FROM funcClassificaBibliotecaPostiLettura();

-- DROP PROCEDURE IF EXISTS callClassificaEbookAcceduti;
-- CREATE PROCEDURE callClassificaEbookAcceduti ()
-- LANGUAGE plpgsql
-- AS $$
--     BEGIN
--         SELECT * FROM classificaEbookAcceduti;
--     END;
-- $$

-- DROP PROCEDURE IF EXISTS callClassificaLibriCartacei;
-- CREATE PROCEDURE callClassificaLibriCartacei ()
-- LANGUAGE plpgsql
-- AS $$
--     BEGIN
--         SELECT * FROM classificaLibriCartacei;
--     END;
-- $$

-- DROP PROCEDURE IF EXISTS callClassificaVolontari;
-- CREATE PROCEDURE callClassificaVolontari ()
-- LANGUAGE plpgsql
-- AS $$
--     BEGIN
--         SELECT * FROM classificaVolontari;
--     END;
-- $$


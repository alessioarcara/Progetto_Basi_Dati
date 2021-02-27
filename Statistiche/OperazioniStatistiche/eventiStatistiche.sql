DROP PROCEDURE IF EXISTS refreshStatistiche;

CREATE PROCEDURE refreshStatistiche ()
LANGUAGE plpgsql
AS $$
    BEGIN
        REFRESH MATERIALIZED VIEW classificabibliotecapostilettura;
        REFRESH MATERIALIZED VIEW classificaLibriCartacei;
        REFRESH MATERIALIZED VIEW classificaEbookAcceduti;
        REFRESH MATERIALIZED VIEW classificaVolontari;
    END;
$$
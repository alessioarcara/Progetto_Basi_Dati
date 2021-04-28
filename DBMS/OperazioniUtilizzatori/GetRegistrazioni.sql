DROP FUNCTION IF EXISTS GetRegistrazioni;
CREATE OR REPLACE FUNCTION GetRegistrazioni()
    RETURNS JSON
AS $$
    DECLARE registrazioni JSON;
    BEGIN
        SELECT json_agg(src) INTO registrazioni
        FROM (SELECT nomebiblioteca, numeropostolettura, data, orainizio, orafine
              FROM registrazione) src;
    RETURN registrazioni;
    END;
$$
LANGUAGE plpgsql;
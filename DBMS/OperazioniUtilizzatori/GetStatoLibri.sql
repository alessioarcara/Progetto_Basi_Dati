DROP FUNCTION IF EXISTS GetStatoLibri();
CREATE OR REPLACE FUNCTION GetStatoLibri()
    RETURNS JSON
AS $$
DECLARE statolibri JSON;
BEGIN
    SELECT json_agg(src) INTO statolibri
    FROM (SELECT codicelibrocartaceo, statoprestito FROM librocartaceo) src;
    RETURN statolibri;
END;
$$
    LANGUAGE plpgsql;
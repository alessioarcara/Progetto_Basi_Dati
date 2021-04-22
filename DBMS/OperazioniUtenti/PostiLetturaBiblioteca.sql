DROP FUNCTION IF EXISTS PostiLetturaBiblioteca;
CREATE FUNCTION PostiLetturaBiblioteca (VARIADIC NomiB TEXT[] DEFAULT NULL)
    RETURNS TABLE(
                     NumPosto SMALLINT,
                     PresaCorr BOOLEAN,
                     PresaEth BOOLEAN,
                     NomeBiblioteca VARCHAR
                 )
AS $$
BEGIN
    IF nomiB ISNULL THEN
        RETURN QUERY
            SELECT numero, presacorrente, presaethernet, p.nomebiblioteca
            FROM postolettura p;
    ELSIF EXISTS(SELECT * FROM postolettura p WHERE REPLACE(p.nomebiblioteca, ' ', '') = ANY (NomiB)) THEN
        RETURN QUERY
            SELECT numero, presacorrente, presaethernet, p.nomebiblioteca
            FROM postolettura p
            WHERE REPLACE(p.nomebiblioteca, ' ', '') = ANY (NomiB);
    END IF;
END; $$
LANGUAGE 'plpgsql';
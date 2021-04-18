DROP FUNCTION IF EXISTS GetBiblioteche;
CREATE FUNCTION GetBiblioteche (VARIADIC NomiB TEXT[] DEFAULT NULL)
RETURNS TABLE (
    nome varchar,
    via varchar,
    civico varchar,
    cap integer,
    citta varchar,
    email varchar,
    sitoweb varchar,
    lat numeric(10,8),
    long numeric(10,8),
    notestoriche varchar,
    numero varchar
)
AS $$
BEGIN
    IF nomiB ISNULL THEN
        RETURN QUERY
            SELECT b.nome, b.via, b.civico, b.cap, b.citta, b.email, b.sitoweb, b.lat, b.long, b.notestoriche, r.numero
            FROM biblioteca b
                     LEFT JOIN recapitotelefonico r on b.nome = r.nomebiblioteca;
    ELSIF EXISTS(SELECT * FROM biblioteca b WHERE REPLACE(b.nome, ' ', '') =  ANY(nomiB)) THEN
        RETURN QUERY
            SELECT b.nome, b.via, b.civico, b.cap, b.citta, b.email, b.sitoweb, b.lat, b.long, b.notestoriche, r.numero
            FROM biblioteca b
                     LEFT JOIN recapitotelefonico r on b.nome = r.nomebiblioteca
            WHERE REPLACE(b.nome, ' ', '') = ANY (NomiB);
    END IF;
END $$
LANGUAGE 'plpgsql';

SELECT * FROM getbiblioteche();
SELECT * FROM getbiblioteche('BibliotecaUniversitariadiBologna', 'asdasd', 'asdas')

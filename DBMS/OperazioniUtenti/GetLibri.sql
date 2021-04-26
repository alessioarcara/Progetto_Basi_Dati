-- Function per libri disponibili
DROP FUNCTION IF EXISTS LibriBiblioteca;
CREATE FUNCTION LibriBiblioteca (VARIADIC words TEXT[] DEFAULT NULL)
    RETURNS TABLE(
                     codicelibrocartaceo char,
                     titolocartaceo varchar,
                     nomeedizionecartaceo varchar,
                     annopubblicazionecartaceo smallint,
                     generecartaceo varchar,
                     nomebibliotecacartaceo varchar,
                     statoprestito text,
                     statoconservazione text,
                     numpagine smallint,
                     numscaffale smallint,
                     codiceebook char,
                     titoloebook varchar,
                     nomeedizioneebook varchar,
                     annopubblicazioneebook smallint,
                     genereebook varchar,
                     nomebibliotecaebook varchar,
                     dimensione float,
                     pdf varchar,
                     nomeautore varchar,
                     cognomeautore varchar
                 )
AS $$
BEGIN
    IF words ISNULL THEN
        RETURN QUERY
            SELECT t1.codicelibro AS codicelibrocartaceo,
                   t1.titolo AS titolocartaceo,
                   t1.nomeedizione AS nomeedizionecartaceo,
                   t1.annopubblicazione AS annopubblicazionecartaceo,
                   t1.genere AS generecartaceo,
                   t1.nomebiblioteca AS nomebibliotecacartaceo,
                   t1.statoprestito::text AS statoprestito,
                   t1.statoconservazione::text AS statoconservazione,
                   t1.numpagine AS numpagine,
                   t1.numscaffale AS numscaffale,
                   t2.codicelibro AS codiceebook,
                   t2.titolo AS titoloebook,
                   t2.nomeedizione AS nomeedizioneebook,
                   t2.annopubblicazione AS annopubblicazioneebook,
                   t2.genere AS genereebook,
                   t2.nomebiblioteca AS nomebibliotecaebook,
                   t2.dimensione AS dimensione,
                   t2.pdf AS pdf,
                   a.nome AS nomeautore,
                   a.cognome AS cognomeautore
            FROM ((SELECT * FROM libro l JOIN librocartaceo on l.codicelibro = librocartaceo.codicelibrocartaceo) T1
                FULL JOIN (SELECT * FROM libro l JOIN ebook e on l.codicelibro = e.codiceebook) T2
                ON T1.codicelibro = T2.codicelibro)
                     LEFT JOIN lista on T1.codicelibro = lista.codicelibro or T2.codicelibro = lista.codicelibro
                     LEFT JOIN autore a on lista.codiceautore = a.codiceautore;
    ELSEIF EXISTS(SELECT * FROM libro l WHERE titolo ~~*  ANY (SELECT concat('%',w,'%') FROM unnest(array[words]) w)) THEN
        RETURN QUERY
            SELECT t1.codicelibro AS codicelibrocartaceo,
                   t1.titolo AS titolocartaceo,
                   t1.nomeedizione AS nomeedizionecartaceo,
                   t1.annopubblicazione AS annopubblicazionecartaceo,
                   t1.genere AS generecartaceo,
                   t1.nomebiblioteca AS nomebibliotecacartaceo,
                   t1.statoprestito::text AS statoprestito,
                   t1.statoconservazione::text AS statoconservazione,
                   t1.numpagine AS numpagine,
                   t1.numscaffale AS numscaffale,
                   t2.codicelibro AS codiceebook,
                   t2.titolo AS titoloebook,
                   t2.nomeedizione AS nomeedizioneebook,
                   t2.annopubblicazione AS annopubblicazioneebook,
                   t2.genere AS genereebook,
                   t2.nomebiblioteca AS nomebibliotecaebook,
                   t2.dimensione AS dimensione,
                   t2.pdf AS pdf,
                   a.nome AS nomeautore,
                   a.cognome AS cognomeautore
            FROM ((SELECT * FROM libro l JOIN librocartaceo on l.codicelibro = librocartaceo.codicelibrocartaceo) T1
                FULL JOIN (SELECT * FROM libro l JOIN ebook e on l.codicelibro = e.codiceebook) T2
                ON T1.codicelibro = T2.codicelibro)
                     LEFT JOIN lista on T1.codicelibro = lista.codicelibro or T2.codicelibro = lista.codicelibro
                     LEFT JOIN autore a on lista.codiceautore = a.codiceautore
            WHERE (t1.titolo ~~*  ANY (SELECT concat('%',w,'%') FROM unnest(array[words]) w))
                or (t2.titolo ~~*  ANY (SELECT concat('%',w,'%') FROM unnest(array[words]) w));
    END IF;
END; $$
LANGUAGE 'plpgsql';
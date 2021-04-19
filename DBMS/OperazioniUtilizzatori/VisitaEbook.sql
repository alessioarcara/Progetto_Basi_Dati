DROP FUNCTION IF EXISTS VisitaEbook;
CREATE FUNCTION VisitaEbook (
    CodiceVisitaEbook TEXT,
    EmailUtente TEXT
)
    RETURNS BOOLEAN
AS $$
BEGIN
    -- Controllo se eBook esiste
    IF NOT EXISTS (
            SELECT codiceebook
            FROM ebook e
            WHERE e.codiceebook = CodiceVisitaEbook
        ) THEN RETURN FALSE;
    END IF;
    -- Inserisco visita
    INSERT INTO visita (idvisita, emailutilizzatore, codiceebook) VALUES
    (
    substr(md5(random()::text), 0, 11),
    EmailUtente,
    CodiceVisitaEbook
    );
    RETURN TRUE;
END; $$
LANGUAGE 'plpgsql';
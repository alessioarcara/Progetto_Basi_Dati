-- Function per l'autenticazione
DROP FUNCTION IF EXISTS Authentication;
CREATE FUNCTION Authentication (Email TEXT, Pwd TEXT)
RETURNS BOOLEAN
AS $$
  BEGIN
    IF EXISTS (
      SELECT *
      FROM UTILIZZATORE
      WHERE (emailutilizzatore = Email AND statoaccount = 'SOSPESO')
    ) THEN 
      RETURN FALSE;
    ELSE RETURN EXISTS (
      SELECT EmailUtente
      FROM UTENTE
      WHERE (EmailUtente=Email) AND (Password=Pwd)
    );
    END IF;
    
  END; $$
LANGUAGE 'plpgsql';
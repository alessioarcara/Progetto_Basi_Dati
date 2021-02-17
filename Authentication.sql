DROP FUNCTION IF EXISTS Authentication;
CREATE FUNCTION Authentication (Email TEXT, Pwd TEXT)
RETURNS BOOLEAN
AS $$
BEGIN 
  RETURN EXISTS(
    SELECT EmailUtente
    FROM UTENTE
    WHERE (EmailUtente=Email) AND (Password=Pwd)
  );
END; $$
LANGUAGE 'plpgsql';
    
DROP FUNCTION IF EXISTS RegistrazioneUtente;
CREATE FUNCTION RegistrazioneUtente (
  Email TEXT,
  Password TEXT,
  Nome TEXT,
  Cognome TEXT,
  DataDiNascita DATE,
  LuogoDiNascita TEXT,
  RecapitoTelefonico TEXT,
  Professione TEXT
)
RETURNS BOOLEAN
AS $$
BEGIN
  INSERT INTO UTENTE VALUES (
    Email,
    Password,
    Nome,
    Cognome,
    DataDiNascita,
    LuogoDiNascita,
    RecapitoTelefonico
  );
  INSERT INTO UTILIZZATORE VALUES (
    Email,
    Professione,
    NOW(),
    'ATTIVO'
  );
  RETURN TRUE;
END; $$
LANGUAGE 'plpgsql';

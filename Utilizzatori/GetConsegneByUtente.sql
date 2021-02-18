DROP FUNCTION IF EXISTS GetConsegneByUtente;
CREATE FUNCTION GetConsegneByUtente (EmailUtente TEXT)
RETURNS TABLE(
  Codice CHAR(10),
  NoteConsegna VARCHAR(100),
  DataConsegna DATE,
  TipoConsegna TIPOLOGIA,
  Codice_Prenotazione CHAR(10)
)
AS $$
BEGIN 
  RETURN QUERY
    SELECT CodiceConsegna, Note, Data, Tipo, CONSEGNA.CodicePrenotazione
    FROM CONSEGNA, PRENOTAZIONE
    WHERE CONSEGNA.CodicePrenotazione = PRENOTAZIONE.CodicePrenotazione
    AND PRENOTAZIONE.EmailUtilizzatore = EmailUtente;
END; $$
LANGUAGE 'plpgsql';
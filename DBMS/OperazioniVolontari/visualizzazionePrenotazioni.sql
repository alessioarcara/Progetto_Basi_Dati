-- Creazione view per la visualizzazione delle prenotazioni
DROP VIEW IF EXISTS getPrenotazione;

CREATE VIEW getPrenotazione AS
SELECT * FROM PRENOTAZIONE;

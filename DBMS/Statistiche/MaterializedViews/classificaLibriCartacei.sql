-- Creazione view materializzata per la classifica dei cartacei più prenotati
DROP MATERIALIZED VIEW IF EXISTS classificaLibriCartacei;

-- In un sistema bibliotecario le prenotazioni vengono gestite sul codice del libro
CREATE MATERIALIZED VIEW classificaLibriCartacei AS
SELECT CodiceLibroCartaceo, COUNT(*) AS NumPrenotazioni
FROM PRENOTAZIONE
GROUP BY CodiceLibroCartaceo
ORDER BY NumPrenotazioni DESC;

-- Altra query possibile permette di verificare il tutto in base al titolo del libro
-- (il titolo non è identificativo univoco)
-- SELECT Titolo, COUNT(*) AS NumPrenotazioni
-- FROM PRENOTAZIONE JOIN LIBRO ON (codicelibro = codicelibrocartaceo)
-- GROUP BY Titolo
-- ORDER BY NumPrenotazioni DESC;
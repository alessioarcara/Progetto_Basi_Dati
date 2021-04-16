-- SELECT Nome
-- FROM GetBiblioteche();

-- SELECT * 
-- FROM PostiLetturaBiblioteca('Biblioteca Universitaria di Bologna');

-- SELECT *
-- FROM LibriBiblioteca('Biblioteca Universitaria di Bologna');

-- SELECT Authentication('utente1@g.com', 'argo');

-- SELECT RegistrazioneUtente (
--   'utente10@g.com',
--   'argo',
--   'Alessio',
--   'Carchesio',
--   '10/09/1990',
--   'Milano',
--   '3334433789',
--   'Studente'
-- );

-- SELECT PrenotaPostoLettura (
--   'mario.verdi@unibo.it',
--   '2021-02-18',
--   1,
--   'Biblioteca Universitaria di Bologna',
--   '8:00:00',
--   '9:00:00'
-- );

-- SELECT PrenotaLibro(
--   'AA00000000',
--   'mario.rossi@unibo.it'
-- );

-- SELECT * FROM GetPrenotazioniUtente(
--   'mario.rossi@unibo.it'
-- )

-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
-- SELECT uuid_generate_v1();

-- ALTER TABLE EBOOK ALTER NumAccessiScheda SET DEFAULT 0;

-- SELECT * FROM GetEBook('A000000001');

SELECT * FROM GetConsegneByUtente('mario.rossi@unibo.it');

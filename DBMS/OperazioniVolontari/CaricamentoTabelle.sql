INSERT INTO LIBRO VALUES (
    'AA00000000',
    'Il nome della rosa',
    'Treccani',
    '2010',
    'Romantico',
    'Biblioteca Universitaria di Bologna'
);

INSERT INTO LIBRO VALUES (
    'AA11111111',
    'Il corpo umano',
    'Garzanti',
    '2000',
    'Scientifico',
    'Biblioteca Universitaria di Bologna'
);

INSERT INTO LIBROCARTACEO VALUES (
    'AA00000000',
    'DISPONIBILE',
    'BUONO',
    120,
    9
);

INSERT INTO LIBROCARTACEO VALUES (
    'AA11111111',
    'PRENOTATO',
    'OTTIMO',
    1102,
    12
);

INSERT INTO UTENTE VALUES (
    'mario.rossi@unibo.it', 
    'Passwd1', 
    'Mario', 
    'Rossi', 
    '1989/02/23', 
    'Bologna',
    '+39 1111111111'
);

INSERT INTO UTENTE VALUES (
    'mario.verdi@unibo.it', 
    'Passwd2', 
    'Mario', 
    'Verdi', 
    '1989/11/01', 
    'Parma',
    '+39 2222222222'
);

INSERT INTO UTILIZZATORE VALUES (
    'mario.rossi@unibo.it',
    'Docente',
    '2010/09/09',
    'ATTIVO'
);

INSERT INTO UTILIZZATORE VALUES (
    'mario.verdi@unibo.it',
    'Professore ordinario',
    '2000/10/22',
    'ATTIVO'
);

INSERT INTO VOLONTARIO VALUES (
    'mario.rossi@unibo.it',
    'Piedi'
);

INSERT INTO VOLONTARIO VALUES (
    'mario.verdi@unibo.it',
    'Auto'
);

INSERT INTO PRENOTAZIONE VALUES (
    'AAAAABBBBB',
    NOW(),
    NOW(),
    'mario.rossi@unibo.it',
    'AA00000000'
);

INSERT INTO PRENOTAZIONE VALUES (
    'BBBBBCCCCC',
    NOW(),
    NOW(),
    'mario.verdi@unibo.it',
    'AA11111111'
);

INSERT INTO PRENOTAZIONE VALUES (
    '123AAABBBB',
    NOW(),
    NOW(),
    'mario.rossi@unibo.it',
    'AA11111111'
);

INSERT INTO PRENOTAZIONE VALUES (
    '1234567891',
    NULL,
    NULL,
    'mario.rossi@unibo.it',
    'AA11111111'
);
/* INSERT INTO BIBLIOTECA */

INSERT INTO BIBLIOTECA VALUES (
	'Biblioteca Universitaria di Bologna',
	'Via Zamboni, 33-35 Bologna 40126 BO',
	'bub.info@unibo.it',
	'http://www.bub.unibo.it',
	10,
	20
);
INSERT INTO BIBLIOTECA VALUES (
	'Biblioteca Giuridica "Antonio Cicu"',
	'Via Zamboni, 27/29 Bologna 40126 BO',
	'abis.bibliotecacicu@unibo.it',
	'http://giuridica.sba.unibo.it/',
	10,
	20
);
INSERT INTO BIBLIOTECA VALUES (
	'Biblioteca del Dipartimento di Scienze economiche',
	'Via delle Belle Arti 33',
	'info.bigiavi@unibo.it',
	'http://bigiavi.sba.unibo.it/',
	10,
	20
);
INSERT INTO BIBLIOTECA VALUES (
	'Biblioteca di discipline umanistiche',
	'Via Zamboni, 36 Bologna 40126 BO',
	'bdu.lettere@unibo.it',
	'http://bdu.sba.unibo.it/',
	10,
	20
);
INSERT INTO BIBLIOTECA VALUES (
	'Biblioteca di Medicina',
	'Via Filippo Re, 8 Bologna 40126 BO',
	'bibbiomed.info@unibo.it',
	'http://biomedica.sba.unibo.it/',
	10,
	20
);

INSERT INTO UTENTE VALUES (
  'utente1@g.com',
  'argo',
  'Alessio',
  'Carchesio',
  '01/01/2001',
  'Bologna',
  '33344455667'
);
INSERT INTO UTENTE VALUES (
  'utente2@g.com',
  'argo',
  'Andrea',
  'Carchesio',
  '01/01/2001',
  'Bologna',
  '33344455664'
);
INSERT INTO UTENTE VALUES (
  'utente3@g.com',
  'argo',
  'Alessio',
  'Borghesi',
  '01/01/2001',
  'Bologna',
  '33344455663'
);
INSERT INTO UTENTE VALUES (
  'utente4@g.com',
  'argo',
  'Michael',
  'Borghesi',
  '01/01/2001',
  'Bologna',
  '33344455662'
);
INSERT INTO UTENTE VALUES (
  'utente5@g.com',
  'argo',
  'Michael',
  'Arcara',
  '01/01/2001',
  'Brescia',
  '33344455661'
);
INSERT INTO LIBRO VALUES (
  'A000000001',
  'Un Libro',
  'EdizioneBella',
  2010,
  'Giallo',
  'Biblioteca Universitaria di Bologna'
);
INSERT INTO LIBRO VALUES (
  'A000000002',
  'Un Libro 2',
  'EdizioneBella',
  2010,
  'Giallo',
  'Biblioteca Universitaria di Bologna'
);
INSERT INTO LIBRO VALUES (
  'A000000003',
  'Un Libro 3 - Il ritorno',
  'EdizioneBellaFes',
  2010,
  'Giallo',
  'Biblioteca Universitaria di Bologna'
);
INSERT INTO POSTOLETTURA VALUES (
  1,
  'Biblioteca del Dipartimento di Scienze economiche',
  TRUE,
  FALSE
);
INSERT INTO POSTOLETTURA VALUES (
  2,
  'Biblioteca del Dipartimento di Scienze economiche',
  TRUE,
  TRUE
);
INSERT INTO POSTOLETTURA VALUES (
  3,
  'Biblioteca del Dipartimento di Scienze economiche',
  TRUE,
  FALSE
);
INSERT INTO POSTOLETTURA VALUES (
  1,
  'Biblioteca Universitaria di Bologna',
  TRUE,
  TRUE
);
INSERT INTO POSTOLETTURA VALUES (
  2,
  'Biblioteca Universitaria di Bologna',
  TRUE,
  FALSE
);
INSERT INTO LISTA VALUES (
  'AUTORE0001',
  'A000000001'
);
INSERT INTO LISTA VALUES (
  'AUTORE0001',
  'A000000002'
);
INSERT INTO LISTA VALUES (
  'AUTORE0002',
  'A000000003'
);
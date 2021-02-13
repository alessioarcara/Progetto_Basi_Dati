CREATE TABLE BIBLIOTECA (
	Nome VARCHAR(30) PRIMARY KEY,
	Indirizzo VARCHAR(50) NOT NULL,
	Email VARCHAR(50) NOT NULL,
	SitoWeb VARCHAR(50) NOT NULL,
	Lat DECIMAL(10, 8) NOT NULL,
	Long DECIMAL(10, 8) NOT NULL
);

CREATE TABLE POSTOLETTURA (
	Numero SMALLINT,
	NomeBiblioteca VARCHAR(30),
	PresaCorrente BOOLEAN NOT NULL,
	PresaEthernet BOOLEAN NOT NULL,
	
	PRIMARY KEY (Numero, NomeBiblioteca),
	FOREIGN KEY (NomeBiblioteca) REFERENCES BIBLIOTECA (Nome)
);

CREATE TABLE LIBRO (
	CodiceLibro CHAR(10) PRIMARY KEY,
	Titolo VARCHAR(30) NOT NULL,
	AnnoPubblicazione SMALLINT NOT NULL,
	Genere VARCHAR(30) NOT NULL,
	NomeBiblioteca VARCHAR(30) NOT NULL,
	
	FOREIGN KEY (NomeBiblioteca) REFERENCES BIBLIOTECA (Nome)
);
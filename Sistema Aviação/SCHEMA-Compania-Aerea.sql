DROP DATABASE IF EXISTS  SISTEMA_AVIACAO;
CREATE DATABASE SISTEMA_AVIACAO;
USE SISTEMA_AVIACAO;

CREATE TABLE COMPANIA_AEREA (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(256) NOT NULL
);

CREATE TABLE AERONAVE (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    TIPO ENUM('HELICÓPTERO', 'AVIÃO', 'JATO') NOT NULL,
    MODELO VARCHAR(256) NOT NULL,
    ID_COMPANIA_AEREA INT NOT NULL,

    CONSTRAINT FK_ID_COMPANIA_AEREA_AERONAVE FOREIGN KEY (ID_COMPANIA_AEREA) REFERENCES COMPANIA_AEREA(ID)
);

CREATE TABLE POLTRONA (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CLASSE ENUM ('ECONÔMICA', 'PRIMEIRA CLASSE', 'LUXO') NOT NULL,
    ESTA_VAGA BOOL NOT NULL,
    LOCALIZACAO ENUM ('JANELA', 'CORREDOR', 'DIREITA', 'ESQUERDA', 'CENTRO') NOT NULL,
    ID_AERONAVE INT NOT NULL,
    
    CONSTRAINT FK_ID_AERONAVE_POLTRONA FOREIGN KEY (ID_AERONAVE) REFERENCES AERONAVE(ID)
);

CREATE TABLE AEROPORTO (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(256) NOT NULL,
    CIDADE VARCHAR(256) NOT NULL,
    ESTADO VARCHAR(4) NOT NULL,
    PAIS VARCHAR(256) NOT NULL
);

CREATE TABLE VOO (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_AERONAVE INT NOT NULL,
	ID_AEROPORTO_PARTIDA INT NOT NULL,
    ID_AEROPORTO_CHEGADA INT NOT NULL,
    HORARIO_PARTIDA DATETIME NOT NULL,
    HORARIO_CHEGADA DATETIME NOT NULL,
    
    CONSTRAINT FK_ID_AERONAVE_VOO FOREIGN KEY (ID_AERONAVE) REFERENCES AERONAVE(ID),
    CONSTRAINT FK_ID_AEROPORTO_PARTIDA_VOO FOREIGN KEY (ID_AEROPORTO_PARTIDA) REFERENCES AEROPORTO(ID),
    CONSTRAINT FK_ID_AEROPORTO_CHEGADA_VOO FOREIGN KEY (ID_AEROPORTO_CHEGADA) REFERENCES AEROPORTO(ID)
);

CREATE TABLE ESCALA (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	ID_AEROPORTO_SAIDA INT NOT NULL,
    HORARIO_SAIDA_ESCALA DATETIME NOT NULL,
    ID_VOO INT NOT NULL,
    
    CONSTRAINT FK_ID_AEROPORTO_SAIDA_ESCALA FOREIGN KEY (ID_AEROPORTO_SAIDA) REFERENCES AEROPORTO(ID),
	CONSTRAINT FK_ID_VOO_ESCALA FOREIGN KEY (ID_VOO) REFERENCES VOO(ID)
);

CREATE TABLE CLIENTE (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    TIPO_CLIENTE ENUM('NORMAL', 'CORPORATIVO') NOT NULL,
    NOME VARCHAR(256) NOT NULL,
    TELEFONE VARCHAR(256) NOT NULL,
    PREFERENCIAL BOOL NOT NULL
);

CREATE TABLE MALA (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_CLIENTE_DONO INT NOT NULL,
    PESO_MALA FLOAT NOT NULL,
    ID_VOO INT NOT NULL,
    
    CONSTRAINT FK_ID_CLIENTE_DONO_MALA FOREIGN KEY (ID_CLIENTE_DONO) REFERENCES CLIENTE(ID),
    CONSTRAINT FK_ID_VOO_MALA FOREIGN KEY (ID_VOO) REFERENCES VOO(ID)
);

CREATE TABLE PASSAGEM (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_POLTRONA INT NOT NULL,
    ID_CLIENTE INT NOT NULL,
    ID_VOO INT NOT NULL,
    
    CONSTRAINT FK_ID_POLTRONA_PASSAGEM FOREIGN KEY (ID_POLTRONA) REFERENCES POLTRONA(ID),
    CONSTRAINT FK_ID_CLIENTE_PASSAGEM FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID),
    CONSTRAINT FK_ID_VOO_PASSAGEM FOREIGN KEY (ID_VOO) REFERENCES VOO(ID)
);
-- Patinhas do bem schema.sql
SET NAMES utf8mb4;
DROP DATABASE IF EXISTS patinhas_do_bem;
CREATE DATABASE patinhas_do_bem CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE patinhas_do_bem;

CREATE TABLE coordenador (
    id_coordenador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL

);

CREATE TABLE adotante (
    id_adotante INT AUTO_INCREMENT PRIMARY KEY,
    id_coordenador INT NOT NULL,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20) NOT NULL,
    data_cadastro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_coordenador) REFERENCES coordenador (id_coordenador)
);

CREATE TABLE animal (
    id_animal INT AUTO_INCREMENT PRIMARY KEY,
    id_coordenador INT NOT NULL,
    id_adotante INT,
    nome VARCHAR(100) NOT NULL,
    raca VARCHAR(50) NOT NULL,
    porte VARCHAR(30) NOT NULL CHECK (porte IN ('pequeno', 'médio','grande')),
    idade_estimada VARCHAR(30) NOT NULL,
    foto VARCHAR(255) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'em tratamento',
    CHECK (status IN ('em tratamento', 'disponível','adotado')),
    historico_medico TEXT,
    data_cadastro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_coordenador) REFERENCES coordenador (id_coordenador),
    FOREIGN KEY (id_adotante) REFERENCES adotante (id_adotante)
);

CREATE TABLE triagem_medica (
    id_triagem INT AUTO_INCREMENT PRIMARY KEY,
    id_coordenador INT NOT NULL,
    id_animal INT NOT NULL,
    data_triagem DATE NOT NULL,
    hora_triagem TIME NOT NULL,
    UNIQUE (data_triagem, hora_triagem),
    FOREIGN KEY (id_coordenador) REFERENCES coordenador (id_coordenador),
    FOREIGN KEY (id_animal) REFERENCES animal (id_animal)
);

CREATE TABLE item_estoque (
    id_item_estoque INT AUTO_INCREMENT PRIMARY KEY,
    id_coordenador INT NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL CHECK (tipo IN ('ração', 'vacina', 'medicamento')),
    quantidade_restante INT NOT NULL DEFAULT 0 CHECK (quantidade_restante >= 0),
    FOREIGN KEY (id_coordenador) REFERENCES coordenador (id_coordenador)
);

CREATE TABLE triagem_item (
    id_triagem INT NOT NULL,
    id_item_estoque INT NOT NULL,
    quantidade_usada INT NOT NULL CHECK (quantidade_usada > 0),
    PRIMARY KEY (id_triagem, id_item_estoque),
    FOREIGN KEY (id_triagem) REFERENCES triagem_medica (id_triagem) ON DELETE CASCADE,
    FOREIGN KEY (id_item_estoque) REFERENCES item_estoque (id_item_estoque)
);

CREATE TABLE visita_entrevista (
    id_visita INT AUTO_INCREMENT PRIMARY KEY,
    id_animal INT NOT NULL,
    id_adotante INT NOT NULL,
    id_coordenador INT,
    data_visita DATE NOT NULL,
    hora_visita TIME NOT NULL,
    FOREIGN KEY (id_animal) REFERENCES animal (id_animal),
    FOREIGN KEY (id_adotante) REFERENCES adotante (id_adotante),
    FOREIGN KEY (id_coordenador) REFERENCES coordenador (id_coordenador)
);

CREATE TABLE doacao (
    id_doacao INT AUTO_INCREMENT PRIMARY KEY,
    id_coordenador INT NOT NULL,
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('financeira', 'material')),
    quantidade DECIMAL(10,2) NOT NULL CHECK (quantidade > 0),
    data_doacao DATE NOT NULL,
    nome_doador VARCHAR(150),
    FOREIGN KEY (id_coordenador) REFERENCES coordenador (id_coordenador)
);
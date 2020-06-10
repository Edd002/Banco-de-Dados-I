CREATE TABLE titulacao (
    id_titulacao smallint NOT NULL,
    nom_titulacao varchar(50) NOT NULL,
    CONSTRAINT pk_titulacao PRIMARY KEY (id_titulacao),
    CONSTRAINT un_nom_titulacao UNIQUE (nom_titulacao)
);

CREATE TABLE professor (
    id_prof int NOT NULL,
    nom_prof varchar(100) NOT NULL,
    id_titulacao smallint NOT NULL,
    CONSTRAINT pk_prof PRIMARY KEY (id_prof),
    CONSTRAINT un_nom_prof UNIQUE (nom_prof)
);

CREATE TABLE departamento (
    id_depto smallint NOT NULL,
    nom_depto varchar(100) NOT NULL,
    id_prof int NOT NULL,
    CONSTRAINT pk_depto PRIMARY KEY (id_depto),
    CONSTRAINT un_nom_depto UNIQUE (nom_depto),
    CONSTRAINT fk_depto_prof FOREIGN KEY (id_prof) REFERENCES professor(id_prof)
);
    
CREATE TABLE curso (
    id_curso smallint NOT NULL,
    nom_curso varchar(100) NOT NULL,
    id_depto smallint NOT NULL,
    CONSTRAINT pk_curso PRIMARY KEY (id_curso),
    CONSTRAINT un_nom_curso UNIQUE (nom_curso),
    CONSTRAINT fk_curso_depto FOREIGN KEY (id_depto) REFERENCES departamento(id_depto)
);

CREATE TABLE bolsista (
    id_bolsista int NOT NULL,
    nom_bolsista varchar(100) NOT NULL,
    id_curso smallint NOT NULL,
    dsc_email varchar(50) NOT NULL,
    num_telefone varchar(25) NULL,
    sex_bolsista char(1) NULL,
    CONSTRAINT pk_bolsista PRIMARY KEY (id_bolsista),
    CONSTRAINT un_nom_bolsista UNIQUE (nom_bolsista),
    CONSTRAINT fk_bolsista_curso FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    CONSTRAINT ck_sex_bolsista CHECK (sex_bolsista='M' or sex_bolsista='F')
);

CREATE TABLE projeto (
    id_projeto smallint IDENTITY(1,1) NOT NULL,
    nom_projeto varchar(100) NOT NULL,
    dsc_projeto varchar(MAX) NULL,
    dat_inicio smalldatetime NOT NULL DEFAULT getdate(),
    dat_fim smalldatetime NULL,
    val_orcamento numeric(7,2) NOT NULL,
    id_prof int NOT NULL,
    CONSTRAINT pk_projeto PRIMARY KEY (id_projeto),
    CONSTRAINT un_nome_projeto UNIQUE (nom_projeto),
    CONSTRAINT fk_projeto_prof FOREIGN KEY (id_prof) REFERENCES professor(id_prof),
	CONSTRAINT ck_dat CHECK (dat_inicio<=dat_fim)
);

CREATE TABLE equipe (
	id_projeto smallint NOT NULL,
	id_bolsista int NOT NULL,
	val_bolsa numeric(7,2) NOT NULL,
	CONSTRAINT pk_equipe PRIMARY KEY (id_projeto, id_bolsista),
	CONSTRAINT fk_equipe_projeto FOREIGN KEY (id_projeto) REFERENCES projeto (id_projeto),
	CONSTRAINT fk_equipe_bolsista FOREIGN KEY (id_bolsista) REFERENCES bolsista (id_bolsista),
	CONSTRAINT ck_val_bolsa CHECK (val_bolsa >= 100)
);

ALTER TABLE professor ADD sex_prof char(1) NOT NULL;

ALTER TABLE professor ADD CONSTRAINT ck_sex_prof CHECK (sex_prof='M' or sex_prof='F');

CREATE TABLE area_conhecimento (
	id_area_conhecimento smallint NOT NULL,
	dsc_area_conhecimento varchar(100) NOT NULL,
	CONSTRAINT pk_area_conhecimento PRIMARY KEY (id_area_conhecimento),
	CONSTRAINT un_dsc_area_conhecimento UNIQUE (dsc_area_conhecimento)
);

ALTER TABLE curso ADD id_area_conhecimento smallint NULL;
ALTER TABLE curso ADD CONSTRAINT fk_curso_area_conhecimento FOREIGN KEY (id_area_conhecimento) REFERENCES area_conhecimento(id_area_conhecimento);
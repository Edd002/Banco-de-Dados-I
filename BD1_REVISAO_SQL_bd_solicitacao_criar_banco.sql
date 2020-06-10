USE [master]
GO


CREATE DATABASE [bd_solicitacao] 
GO


USE [bd_solicitacao]
GO


/*
	DROP TABLE atendimento
	DROP TABLE solicitacao
	DROP TABLE funcionario
	DROP TABLE setor
	
*/

CREATE TABLE setor 
(
	cod_setor			int				NOT NULL	PRIMARY KEY		IDENTITY(1,1),
	nom_setor			varchar(100)	NOT NULL 
)
GO

CREATE TABLE funcionario 
(
	cod_funcionario		int				NOT NULL	IDENTITY(1,1),
	nom_funcionario		varchar(100)	NOT NULL,
	cod_setor			int				NULL
		REFERENCES setor (cod_setor)
			ON UPDATE CASCADE
			ON DELETE NO ACTION, 

	CONSTRAINT PK_funcionario PRIMARY KEY  CLUSTERED (cod_funcionario) 
)
GO

CREATE TABLE solicitacao
(
	cod_solicitacao		int				NOT NULL	IDENTITY (1,1),
	dsc_assunto			varchar(100)	NOT NULL,
	dat_abertura		datetime		NOT NULL	DEFAULT getdate(),
	dat_encerramento	datetime		NULL,
	dsc_solicitacao		text			NOT NULL,
	cod_funcionario		int				NOT NULL, 
	CONSTRAINT PK_solicitacao PRIMARY KEY  CLUSTERED (cod_solicitacao), 
	CONSTRAINT FK_solicitacao_funcionario FOREIGN KEY (cod_funcionario) 
		REFERENCES funcionario (cod_funcionario)
			ON UPDATE CASCADE
) 
GO

CREATE TABLE atendimento 
(
	seq_atendimento		int				NOT NULL		IDENTITY(1,1),
	cod_solicitacao 	int				NOT NULL,
	cod_funcionario 	int				NOT NULL,
	dat_atendimento 	datetime		NOT NULL,
	num_horas			int				NOT NULL 
)
GO

ALTER TABLE atendimento WITH NOCHECK ADD 
	CONSTRAINT PK_atendimento PRIMARY KEY  CLUSTERED (seq_atendimento)
GO

ALTER TABLE atendimento WITH NOCHECK ADD 
	CONSTRAINT FK_atendimento_solicitacao FOREIGN KEY (cod_solicitacao) 
		REFERENCES solicitacao (cod_solicitacao)
			ON DELETE CASCADE
GO

ALTER TABLE atendimento WITH NOCHECK ADD 
	CONSTRAINT FK_atendimento_funcionario FOREIGN KEY (cod_funcionario) 
		REFERENCES funcionario (cod_funcionario)
			ON UPDATE CASCADE 
GO


		insert into setor (nom_setor) values ('Vendas')
		insert into setor (nom_setor) values ('Compras')
		insert into setor (nom_setor) values ('Informática')
		insert into setor (nom_setor) values ('RH')
		insert into setor (nom_setor) values ('Financeiro')

		insert into funcionario (nom_funcionario, cod_setor) values ('João da Silva',1)
		insert into funcionario (nom_funcionario, cod_setor) values ('José da Silva',1)
		insert into funcionario (nom_funcionario, cod_setor) values ('Maria da Silva',2)
		insert into funcionario (nom_funcionario, cod_setor) values ('João Oliveira',2)
		insert into funcionario (nom_funcionario, cod_setor) values ('José Oliveira',3)
		insert into funcionario (nom_funcionario, cod_setor) values ('Maria Oliveira Nunes',3)
		insert into funcionario (nom_funcionario, cod_setor) values ('Luiz Osório',3)
		insert into funcionario (nom_funcionario, cod_setor) values ('Maria Filomena',4)
		insert into funcionario (nom_funcionario, cod_setor) values ('Maria Oliveira',null)

		insert into solicitacao (dsc_assunto, dsc_solicitacao, cod_funcionario,dat_abertura)
		values ('Remover vírus','Remover vírus na máquina do Sr.Antonio',1,'20070710 08:00')
		insert into solicitacao (dsc_assunto, dsc_solicitacao, cod_funcionario,dat_abertura)
		values ('Remover vírus','Remover vírus na máquina do Sra.Maria',1,'20070730 08:00')
		insert into solicitacao (dsc_assunto, dsc_solicitacao, cod_funcionario,dat_abertura)
		values ('Instalar impressora','Instalar impressora para contratos',2,'20070710 08:00')
		insert into solicitacao (dsc_assunto, dsc_solicitacao, cod_funcionario,dat_abertura)
		values ('Criar sistema','Criar sistema de contas a receber',2,'20070805 08:00')
		insert into solicitacao (dsc_assunto, dsc_solicitacao, cod_funcionario,dat_abertura)
		values ('Instalar software','Instalar bankline para movimentar conta',3,'20070804 08:00')
		insert into solicitacao (dsc_assunto, dsc_solicitacao, cod_funcionario,dat_abertura)
		values ('Remover vírus','Remover vírus na máquina do Sr.Luiz Carlos',3,'20070710 08:00')
		insert into solicitacao (dsc_assunto, dsc_solicitacao, cod_funcionario,dat_abertura,dat_encerramento)
		values ('Configurar e-mail','Configurar conta do Sr. Luiz Carlos',3,'20070804 08:00','20070810')
		insert into solicitacao (dsc_assunto, dsc_solicitacao, cod_funcionario,dat_abertura, dat_encerramento)
		values ('Impressora não funciona','Urgente: impressora não funciona',4,'20070805 08:00','20070807')

		insert into atendimento (cod_solicitacao, cod_funcionario, dat_atendimento, num_horas)
		values (1,5,'20070710 10:00',2)
		insert into atendimento (cod_solicitacao, cod_funcionario, dat_atendimento, num_horas)
		values (1,5,'20070713 10:00',5)
		insert into atendimento (cod_solicitacao, cod_funcionario, dat_atendimento, num_horas)
		values (2,5,'20070801 11:00',6)
		insert into atendimento (cod_solicitacao, cod_funcionario, dat_atendimento, num_horas)
		values (2,6,'20070805 10:00',4)
		insert into atendimento (cod_solicitacao, cod_funcionario, dat_atendimento, num_horas)
		values (4,6,'20070811 10:00',8)
		insert into atendimento (cod_solicitacao, cod_funcionario, dat_atendimento, num_horas)
		values (4,1,'20070816 10:00',5)

		insert into funcionario (nom_funcionario, cod_setor) values ('Eduardo Costa',5)
	

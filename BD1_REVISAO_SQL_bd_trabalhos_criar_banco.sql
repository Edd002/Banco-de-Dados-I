USE [master]
GO

CREATE DATABASE [bd_trabalhos] 
GO

USE [bd_trabalhos]
GO

create table situacao
(
	cod_situacao		smallint	not null	primary key
,	dsc_situacao		varchar(50)	not null
)

go

create table area_conhecimento
(
	cod_area_conhecimento	smallint	not null	primary key
,	dsc_area_conhecimento	varchar(50)	not null
)

go

create table autor
(
	cod_autor		smallint	not null	primary key
,	nom_autor		varchar(50)	not null
,	dsc_email_autor		varchar(50)	null
)

go

create table trabalho
(
	seq_trabalho		int		not null	primary key
,	dsc_titulo		varchar(100)	not null
,	dsc_trabalho		text		not null
,	dat_inclusao		datetime	not null
,	cod_area_conhecimento	smallint	not null
,	cod_situacao		smallint	not null
,	foreign key (cod_area_conhecimento) references area_conhecimento (cod_area_conhecimento)
,	foreign key (cod_situacao) references situacao (cod_situacao)
)

go

create table trabalho_autor
(
	seq_trabalho		int		not null
,	cod_autor		smallint	not null
,	primary key (seq_trabalho, cod_autor)
,	foreign key (seq_trabalho) references trabalho (seq_trabalho)
,	foreign key (cod_autor) references autor (cod_autor)
)

go

create table historico_situacao
(
	seq_trabalho		int		not null
,	dat_situacao		datetime	not null
,	cod_situacao		smallint	not null
,	primary key (seq_trabalho, dat_situacao)
,	foreign key (seq_trabalho) references trabalho (seq_trabalho)
,	foreign key (cod_situacao) references situacao (cod_situacao)
)

go

insert into autor values (1, 'Prof. Machado de Assis','machado@assis.com.br')
insert into autor values (2, 'Prof. Monteiro Lobato',null)
insert into autor values (3, 'Prof. Francisco de Assis',null)
insert into autor values (4, 'Prof. Carlos Drumond',null)
insert into autor values (5, 'Prof. Umberto Eco','umberto@eco.com.br')
insert into autor values (6, 'Prof. Osvald de Souza','osvald@souza.com.br')
insert into autor values (7, 'Prof. Junvenal Juvencio',null)
insert into autor values (8, 'Prof. Inciso de Lei',null)

insert into situacao values (1, 'Aguardando aprovação')
insert into situacao values (2, 'Em aprovação')
insert into situacao values (3, 'Aprovado')
insert into situacao values (4, 'Reprovado')

insert into area_conhecimento values (1, 'Computação')
insert into area_conhecimento values (2, 'Medicina')
insert into area_conhecimento values (3, 'Odontologia')
insert into area_conhecimento values (4, 'Engenharia')
insert into area_conhecimento values (5, 'Direito')

insert into trabalho values (1,'Elicitando requisitos com JAD','texto do trabalho',getdate(),1,1)
insert into trabalho_autor values (1,1)
insert into trabalho_autor values (1,2)
insert into trabalho values (2,'Learning to rank using association rules','texto do trabalho',getdate(),1,1)
insert into trabalho_autor values (2,4)
insert into trabalho values (3,'Exploring H1N1 Flu','texto do trabalho',getdate(),2,1)
insert into trabalho_autor values (3,3)
insert into trabalho_autor values (3,4)
insert into trabalho_autor values (3,5)
insert into trabalho values (4,'Como evitar a gripe A','texto do trabalho',getdate(),2,1)
insert into trabalho_autor values (4,4)
insert into trabalho_autor values (4,5)
insert into trabalho values (5,'O Direito no direito de viver','texto do trabalho',getdate(),5,1)
insert into trabalho_autor values (5,5)
insert into trabalho values (6,'O Direito de Família','texto do trabalho',getdate(),5,1)
insert into trabalho_autor values (6,5)
insert into trabalho_autor values (6,7)
insert into trabalho values (7,'O Problema do Direito','texto do trabalho',getdate(),5,1)

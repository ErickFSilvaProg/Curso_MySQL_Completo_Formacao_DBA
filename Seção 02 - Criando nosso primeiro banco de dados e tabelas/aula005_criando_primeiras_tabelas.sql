/*
	Criando tabelas
*/

-- Selecione o banco livraria:
use livraria;


-- Criar a tabela autor:
create table if not exists autor (
	id int not null,
    nome varchar(30) not null,
    sobrenome varchar(45) not null
);

alter table autor
add constraint pk_autor
primary key (id);

alter table autor
modify column id int auto_increment;


-- Criar a tabela editora:
create table if not exists editora (
	id int not null,
    nome varchar(45) not null
);

alter table editora
add constraint pk_editora
primary key (id);

alter table editora
modify column id int auto_increment;


-- Criar a tabela livro:
create table if not exists livro (
	id int not null,
    nome varchar(40) not null,
    id_editora int not null,
    id_autor int not null
);

alter table livro
add constraint pk_livro
primary key (id);

alter table livro
modify column id int auto_increment;

alter table livro
add constraint fk_livro_autor
foreign key (id_autor) references autor (id)
on update restrict
on delete no action;

alter table livro
add constraint fk_livro_editora
foreign key (id_editora) references editora (id)
on update restrict
on delete restrict;


/*
	Excluindo tabelas
*/

-- Excluir a tabela autor:
drop table autor;


-- Exluir tabela editora:
drop table editora;


-- Exluir tabela livro:
drop table livro;
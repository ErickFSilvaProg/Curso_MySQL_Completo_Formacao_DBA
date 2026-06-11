/*
	Criar banco de dados
*/

-- Cria o banco clientes:
create database clientes
character set utf8mb4
collate utf8mb4_0900_ai_ci;

-- Selecione o banco clientes:
use clientes;


-- Alterar a collation no banco:
alter database clientes
character set utf16
collate utf16_general_ci;

alter database clientes
character set utf8mb4
collate utf8mb4_0900_ai_ci;


-- Comado para visualizar a instrução que criou o banco de dados:
show databases;
show create database `nome_do_banco`;


-- Cria o banco livraria:
create database livraria
character set utf8mb4
collate utf8mb4_0900_ai_ci;


-- Visualisar as collation existentes no banco:
show character set;
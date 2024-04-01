-- Scripts para povoar o ambiente operacional

/*
   Para números decimais:
   SELECT RAND()*(b-a)+a;
   Onde b é o maior número
   e a é o menor número

   Para números inteiros:
   SELECT FLOOR(RAND()*(b-a+1))+a;
   Onde b é o maior número
   e a é o menor número

    Exemplos: 
	Gerar um valor decimal aleatório entre 10.0 e 100.0
	SELECT RAND()*(100-10)+10;

	Gerar um valor inteiro aleatório entre 1 e 7
	SELECT FLOOR(RAND()*(7-1+1))+1;
	print floor(RAND() * 7)
*/
use hawkmart
DBCC CHECKIDENT (localidade, RESEED, 0);

create or alter procedure sp_povoar_avaliacao
as
begin
    set nocount on
	DECLARE @CONTADOR INT
	SET @CONTADOR = 0
	while (@CONTADOR < 6)
	BEGIN
		insert into AVALIACAO default values
		SET @CONTADOR = @CONTADOR + 1
	END
end
EXEC sp_povoar_avaliacao
select * from AVALIACAO


create or alter procedure sp_povoar_localidade
as
begin
    set nocount on
	INSERT INTO LOCALIDADE (CIDADE, ESTADO, SIGLA_ESTADO) VALUES
    ('ARACAJU', 'SERGIPE', 'SE'),
    ('MACEIÓ', 'ALAGOAS', 'AL'),
    ('SALVADOR', 'BAHIA', 'BA'),
    ('FORTALEZA', 'CEARÁ', 'CE'),
    ('TERESINA', 'PIAUÍ', 'PI'),
    ('NATAL', 'RIO GRANDE DO NORTE', 'RN'),
    ('JOÃO PESSOA', 'PARAÍBA', 'PB'),
    ('RECIFE', 'PERNAMBUCO', 'PE'),
    ('SÃO LUÍS', 'MARANHÃO', 'MA'),
    ('BELÉM', 'PARÁ', 'PA'),
    ('MANAUS', 'AMAZONAS', 'AM'),
    ('RIO DE JANEIRO', 'RIO DE JANEIRO', 'RJ'),
    ('SÃO PAULO', 'SÃO PAULO', 'SP'),
    ('PORTO ALEGRE', 'RIO GRANDE DO SUL', 'RS'),
    ('BRASÍLIA', 'DISTRITO FEDERAL', 'DF');
end
EXEC sp_povoar_localidade
select * from localidade

create or alter procedure sp_povoar_cliente
as
begin
    set nocount on
	INSERT INTO CLIENTE (NOME, CPF, EMAIL, SEXO, COD_LOCALIDADE) VALUES
    ('Amanda Torres', '12345678901', 'amandinha11@gmail.com', 'F', 1),
    ('Maria Oliveira', '23456789012', 'maria.oliveira@example.com', 'F', 2),
    ('Ana Silva', '34567890123', 'ana.silva@example.com', 'F', 3),
    ('Carla Santos', '45678901234', 'carla.santos@example.com', 'F', 4),
    ('Juliana Costa', '56789012345', 'juliana.costa@example.com', 'F', 5),
    ('Beatriz Souza', '67890123456', 'beatriz.souza@example.com', 'F', 6),
    ('Fernanda Pereira', '78901234567', 'fernanda.pereira@example.com', 'F', 7),
    ('Patrícia Lima', '89012345678', 'patricia.lima@example.com', 'F', 8),
    ('Camila Gomes', '90123456789', 'camila.gomes@example.com', 'F', 9),
    ('Pedro Santos', '12304567890', 'pedro.santos@example.com', 'M', 10),
    ('Lucas Oliveira', '23415678901', 'lucas.oliveira@example.com', 'M', 11),
    ('Gustavo Silva', '34526789012', 'gustavo.silva@example.com', 'M', 12),
    ('João Costa', '45637890123', 'joao.costa@example.com', 'M', 13),
    ('Marcos Souza', '56748901234', 'marcos.souza@example.com', 'M', 14),
    ('Rafael Pereira', '67859012345', 'rafael.pereira@example.com', 'M', 15),
    ('Gabriel Lima', '78960123456', 'gabriel.lima@example.com', 'M', 1),
    ('Mateus Gomes', '89671234567', 'mateus.gomes@example.com', 'M', 2),
    ('André Santos', '90782345678', 'andre.santos@example.com', 'M', 3),
    ('Thiago Oliveira', '12393456789', 'thiago.oliveira@example.com', 'M', 4),
	('Armano Silva', '12393456788', 'armaninho.oliveira@example.com', 'M', 7)
end
EXEC sp_povoar_cliente
select * from cliente

create or alter procedure sp_povar_tb_status
as
begin
	INSERT INTO TB_STATUS (STATUS)
	VALUES('AGUARDANDO PAGAMENTO'),('PAGAMENTO EFETUADO'),('PRODUTO EM ANDAMENTO'),
	('PRODUTO ENTREGUE'),('CANCELADO')

end
exec sp_povar_tb_status
select * from TB_STATUS

create or alter procedure sp_povoar_CATEGORIA
as
begin
    set nocount on
	INSERT INTO CATEGORIA (CATEGORIA) VALUES
    ('ROUPA'),
    ('CALÇADO'),
    ('ELETRÔNICO'),
    ('ALIMENTO'),
    ('COSMÉTICO'),
    ('MÓVEL'),
    ('UTENSÍLIO DOMÉSTICO'),
    ('LIVRO'),
    ('BRINQUEDO'),
    ('FERRAMENTA');
end
EXEC sp_povoar_CATEGORIA
select * from CATEGORIA

create or alter procedure sp_povoar_subcategoria
as
begin
    set nocount on
	INSERT INTO SUBCATEGORIA (SUBCATEGORIA, COD_CATEGORIA) VALUES
    ('VESTIDO', 1),('SAIA', 1),('CAMISA', 1),('CALÇA', 1),('TÊNIS', 2),
    ('SAPATO', 2),('SANDÁLIA', 2),('SMARTPHONE', 3),('TABLET', 3),('TV', 3),
    ('FRUTA', 4),('LEGUME', 4),('PROTEÍNA', 4),('SHAMPOO', 5),('CREME HIDRATANTE', 5),
    ('BATOM', 5),('SOFA', 6),('MESA', 6),('CADEIRA', 6),('PANELA', 7),('LIVRO DE FICÇÃO', 8),
    ('LIVRO DE NÃO FICÇÃO', 9),('BRINQUEDO EDUCATIVO', 10);
end
EXEC sp_povoar_SUBCATEGORIA
select * from SUBCATEGORIA

create or alter procedure sp_povoar_produto
as
begin
    set nocount on
	INSERT INTO PRODUTO (PRODUTO, COD_SUBCATEGORIA) VALUES
    ('VESTIDO FLORAL', 1),('VESTIDO DE FESTA', 1),('SAIA MIDI', 2),
    ('SAIA JEANS', 2),('CAMISA SOCIAL', 3),('CAMISA POLO', 3),
    ('CALÇA JEANS', 4),('CALÇA SOCIAL', 4),('TÊNIS ESPORTIVO', 5),
    ('TÊNIS CASUAL', 5),('SAPATO SOCIAL', 6),('SAPATO MOCASSIM', 6),
    ('SANDÁLIA RASTEIRA', 7),('SANDÁLIA DE SALTO', 7),('SMARTPHONE GALAXY', 8),
    ('SMARTPHONE IPHONE', 8),('TABLET SAMSUNG', 9),('TABLET IPAD', 9),
    ('TV LED 50"', 10),('TV SMART 55"', 10),('MAÇÃ', 11),
    ('BANANA', 11),('CENOURA', 12),('ABÓBORA', 12),
    ('FRANGO ASSADO', 13),('PEIXE GRELHADO', 13),('SHAMPOO ANTI-CASPA', 14),
    ('CONDICIONADOR HIDRATANTE', 15),('BATOM VERMELHO', 16),('BATOM NUDE', 16),
    ('SOFA RETRÁTIL', 17),('MESA DE JANTAR', 18),('CADEIRA DE ESCRITÓRIO', 19),
    ('PANELA DE PRESSÃO', 20),('HARRY POTTER E A PEDRA FILOSOFAL', 21),('O MUNDO DE SOFIA', 22),
    ('QUEBRA-CABEÇA 1000 PEÇAS', 23);
end
EXEC sp_povoar_produto
select * from PRODUTO

create or alter procedure sp_povoar_pagamento
as
begin
    set nocount on
	-- DEBITO CREDITO PIX BOLETO
  INSERT INTO PAGAMENTO (PAGAMENTO)VALUES
  ('DEBITO'),('CREDITO'),('PIX'),('BOLETO')
end
EXEC sp_povoar_pagamento
select * from PAGAMENTO


create or alter procedure sp_povoar_LOJA
as
begin
    set nocount on
	INSERT INTO LOJA (LOJA, CNPJ, EMAIL, COD_LOCALIDADE) VALUES
    ('Caruru', '12345678901234', 'carururu15@example.com', 1),
    ('Pão de Açúcar', '23456789012345', 'paoacucar@example.com', 2),
    ('Americanas', '34567890123456', 'americanas@example.com', 3),
    ('Casas Bahia', '45678901234567', 'casasbahia@example.com', 4),
    ('Magazine Luiza', '56789012345678', 'magazineluiza@example.com', 5),
    ('Extra', '67890123456789', 'extra@example.com', 6),
    ('Renner', '78901234567890', 'renner@example.com', 7),
    ('C&A', '89012345678901', 'cea@example.com', 8),
    ('Riachuelo', '90123456789012', 'riachuelo@example.com', 9),
    ('Leroy Merlin', '01234567890123', 'leroymerlin@example.com', 10),
    ('Marisa', '12345678901234', 'marisa@example.com', 11),
    ('Havan', '23456789012345', 'havan@example.com', 12),
    ('Saraiva', '34567890123456', 'saraiva@example.com', 13),
    ('Submarino', '45678901234567', 'submarino@example.com', 14),
    ('Tok&Stok', '56789012345678', 'tokstok@example.com', 15);
end
EXEC sp_povoar_LOJA
select * from LOJA

DBCC CHECKIDENT (ESTOQUE, RESEED, 0);

create or alter procedure sp_povoar_estoque 
as
begin
    set nocount on
  INSERT INTO ESTOQUE (COD_PRODUTO,VALOR, COD_LOJA, QUANTIDADEESTOQUE, DATA) VALUES
    (1,150, 1, FLOOR(RAND() * 21 + 10), '20240102'),(2,350, 2, FLOOR(RAND() * 21 + 10), '20240101'),
    (3,130, 3, FLOOR(RAND() * 21 + 10), '20240103'),(4,100, 4, FLOOR(RAND() * 21 + 10), '20240105'),
    (5,200, 5, FLOOR(RAND() * 21 + 10), '20240104'),(6,100, 6, FLOOR(RAND() * 21 + 10), '20240111'),
    (7,120, 7, FLOOR(RAND() * 21 + 10), '20240105'),(8,160, 8, FLOOR(RAND() * 21 + 10), '20240121'),
    (9,200, 9, FLOOR(RAND() * 21 + 10), '20240106'),(10,130, 10, FLOOR(RAND() * 21 + 10), '20240125'),
    (11,250, 11, FLOOR(RAND() * 21 + 10), '20240107'),(12,150, 12, FLOOR(RAND() * 21 + 10), '20240125'),
    (13,80, 13, FLOOR(RAND() * 21 + 10), '20240108'),(14,80, 14, FLOOR(RAND() * 21 + 10), '20240201'),
    (15,450, 15, FLOOR(RAND() * 21 + 10), '20240109'),(16,1500, 1, FLOOR(RAND() * 21 + 10), '20240221'),
    (17,750, 2, FLOOR(RAND() * 21 + 10), '20240110'),(18,1600, 3, FLOOR(RAND() * 21 + 10), '20240301'),
    (19,3500, 4, FLOOR(RAND() * 21 + 10), '20240111'),(20,4500, 5, FLOOR(RAND() * 21 + 10), '20240304'),
    (21,1, 6, FLOOR(RAND() * 21 + 10), '20240112'),(22,10, 7, FLOOR(RAND() * 21 + 10), '20240405'),
    (23,6, 8, FLOOR(RAND() * 21 + 10), '20240113'),(24,10,9, FLOOR(RAND() * 21 + 10), '20240501'),
    (25,17, 10, FLOOR(RAND() * 21 + 10), '20240801'),(26,25, 11, FLOOR(RAND() * 21 + 10), '20240501'),
    (27,16, 12, FLOOR(RAND() * 21 + 10), '20240901'),(28,35, 13, FLOOR(RAND() * 21 + 10), '20240505'),
    (29,75, 14, FLOOR(RAND() * 21 + 10), '20241001'),(30,90, 15, FLOOR(RAND() * 21 + 10), '20240607'),
    (31,1300, 1, FLOOR(RAND() * 21 + 10), '20240301'),(32,1300, 2, FLOOR(RAND() * 21 + 10), '20240901'),
    (33,500, 3, FLOOR(RAND() * 21 + 10), '20240401'),(34,175, 4, FLOOR(RAND() * 21 + 10), '20241001'),
    (35,45, 5, FLOOR(RAND() * 21 + 10), '20240501'),(36,55, 6, FLOOR(RAND() * 21 + 10), '20241101'),
    (37,100, 7, FLOOR(RAND() * 21 + 10), '20240601'),(37,90, 8, FLOOR(RAND() * 21 + 10), '20241201'),
    (37,120, 9, FLOOR(RAND() * 21 + 10), '20240701'),(1,130, 10, FLOOR(RAND() * 21 + 10), '20241212');
end

exec sp_povoar_estoque
select * from estoque


create or alter procedure sp_povoar_venda
as
begin
    set nocount on
	insert into VENDA (COD_CLIENTE,COD_PAGAMENTO,COD_STATUS,VALOR_TOTAL,DATA)
	values(1,1,4,280,'20240101'),
	(2,4,4,320,'20240505'),
	(3,4,4,470,'20240510'),
	(4,4,5,3500,'20240515')
end
EXEC sp_povoar_venda
select * from VENDA
--VENDIDO DEVOLVIDO
create or alter procedure sp_povoar_produto_venda
as
begin
	insert into PRODUTOVENDA (VALOR,ACAO,COD_VENDA,COD_ESTOQUE,COD_PRODUTO,COD_AVALIACAO)
	VALUES(150,'VENDIDO',1,1,1,5),
		  (130,'VENDIDO',1,3,3,5),

		  (200,'VENDIDO',2,5,5,5),
		  (120,'VENDIDO',2,7,7,5),

		  (200,'VENDIDO',3,5,5,5),
		  (120,'VENDIDO',2,7,7,5),
		  (150,'VENDIDO',2,1,1,5),

		  (3500,'DEVOLVIDO',4,19,19,2)



	UPDATE ESTOQUE
	SET QUANTIDADEVENDIDA = 2
	WHERE COD_ESTOQUE = 1

	UPDATE ESTOQUE
	SET QUANTIDADEVENDIDA = 1
	WHERE COD_ESTOQUE = 3

	UPDATE ESTOQUE
	SET QUANTIDADEVENDIDA = 2
	WHERE COD_ESTOQUE = 5

	UPDATE ESTOQUE
	SET QUANTIDADEVENDIDA = 2
	WHERE COD_ESTOQUE = 7

	UPDATE ESTOQUE
	SET QUANTIDADEVENDIDA = 1,REAJUSTES = 1
	WHERE COD_ESTOQUE = 19

end
EXEC sp_povoar_produto_venda
select * from produtovenda
SELECT * FROM ESTOQUE
select * from venda

DBCC CHECKIDENT (PRODUTOVENDA, RESEED, 0);
DELETE PRODUTOVENDA WHERE COD_ESTOQUE <= 100


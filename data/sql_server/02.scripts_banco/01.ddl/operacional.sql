-- Scripts ddl para o ambiente operacional
use master
drop database if exists hawkmart
create database hawkmart
use hawkmart

CREATE TABLE AVALIACAO(
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
)

CREATE TABLE CATEGORIA(
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	CATEGORIA VARCHAR(100) NOT NULL,
	CODIGO INT NOT NULL,
	INDEX idx_CATEGORIA (CATEGORIA)
)

CREATE TABLE SUBCATEGORIA (
  ID INT NOT NULL IDENTITY(1,1),
  SUBCATEGORIA VARCHAR(80) NOT NULL,
  CODIGO INT NOT NULL,
  ID_CATEGORIA INT NOT NULL,
  PRIMARY KEY (id),
  INDEX IDX_SUBCATEGORIA_SUBCATEGORIA (SUBCATEGORIA),
  CONSTRAINT FK_ID_CATEGORIA_CATEGORIA
  FOREIGN KEY (ID_CATEGORIA)
  REFERENCES CATEGORIA (ID)
);

CREATE TABLE LOCALIDADE(
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	CIDADE VARCHAR(100) NOT NULL,
	ESTADO VARCHAR(100) NOT NULL,
	SIGLA_ESTADO CHAR(2) NOT NULL CHECK (LEN(SIGLA_ESTADO) = 2),
	INDEX idx_cidade (CIDADE),
	INDEX idx_estado (ESTADO),
	INDEX idx_SIGLA_ESTADO (SIGLA_ESTADO)
)

CREATE TABLE CLIENTE(
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	NOME VARCHAR(100) NOT NULL,
	CPF VARCHAR(11) NOT NULL CHECK (LEN(CPF) = 11),
	EMAIL VARCHAR(200) NOT NULL,
	ID_LOCALIDADE INT NOT NULL,
	CONSTRAINT FK_LOCALIDADE FOREIGN KEY (ID_LOCALIDADE)
	REFERENCES LOCALIDADE(ID)
)

CREATE TABLE TB_STATUS (
  ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY (id),
  STATUS VARCHAR(50) NOT NULL CONSTRAINT DF_Status_Status DEFAULT 'AGUARDANDO PAGAMENTO',
)
--('AGUARDANDO PAGAMENTO', 'PAGAMENTO EFETUADO', 'PRODUTO EM ANDAMENTO',
--'PRODUTO ENTREGUE', 'CANCELADO') NOT NULL DEFAULT 'AGUARDANDO PAGAMENTO',


CREATE TABLE PRODUTO (
  ID INT NOT NULL IDENTITY(1,1),
  PRODUTO VARCHAR(80) NOT NULL,
  CODIGO INT NOT NULL,
  ID_SUBCATEGORIA INT NOT NULL,
  PRIMARY KEY (ID),
  INDEX INDEX_PRODUTO (PRODUTO),
  CONSTRAINT FK_ID_SUBCATEGORIA_SUBCATEGORIA
    FOREIGN KEY (ID_SUBCATEGORIA)
    REFERENCES SUBCATEGORIA (ID)
)

CREATE TABLE PAGAMENTO (
  ID INT NOT NULL IDENTITY(1,1),
  PAGAMENTO VARCHAR(50) NOT NULL,
  PRIMARY KEY (ID),
  INDEX INDEX_PAGAMENTO (PAGAMENTO)
)
-- DEBITO CREDITO PIX BOLETO

CREATE TABLE LOJA (
  ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  LOJA VARCHAR(80) NOT NULL,
  CNPJ VARCHAR(14) NOT NULL,
  EMAIL VARCHAR(200) NOT NULL,
  ID_LOCALIDADE INT NOT NULL,
  CONSTRAINT FK_LOJA_LOCALIDADE_LOCALIDADE
    FOREIGN KEY (ID_LOCALIDADE)
    REFERENCES LOCALIDADE (ID),
	INDEX INDEX_LOJA (LOJA)
)

CREATE TABLE ESTOQUE (
  ID INT NOT NULL IDENTITY(1,1),
  ID_PRODUTO INT NOT NULL,
  ID_LOJA INT NOT NULL,
  QUANTIDADEESTOQUE INT NOT NULL,
  QUANTIDADEVENDIDA INT NOT NULL DEFAULT 0,
  REAJUSTES INT NOT NULL DEFAULT 0,
  DATA DATETIME NOT NULL DEFAULT GETDATE(),
  PRIMARY KEY (ID),
  CONSTRAINT FK_ESTOQUE_LOJA
    FOREIGN KEY (ID_LOJA)
    REFERENCES LOJA (ID),
  CONSTRAINT FK_ESTOQUE_PRODUTO
    FOREIGN KEY (ID_PRODUTO)
    REFERENCES PRODUTO (ID)
);

CREATE TABLE VENDA (
  ID INT NOT NULL IDENTITY(1,1),
  ID_CLIENTE INT NOT NULL,
  ID_AVALIACAO INT NOT NULL,
  ID_PAGAMENTO INT NOT NULL,
  ID_STATUS INT NOT NULL,
  DATA DATETIME NOT NULL DEFAULT GETDATE(),
  PRIMARY KEY (ID),
  CONSTRAINT FK_VENDA_AVALIACAO1
    FOREIGN KEY (ID_AVALIACAO)
    REFERENCES AVALIACAO (ID),
  CONSTRAINT FK_VENDA_CLIENTE1
    FOREIGN KEY (ID_CLIENTE)
    REFERENCES CLIENTE (ID),
  CONSTRAINT FK_VENDA_PAGAMENTO1
    FOREIGN KEY (ID_PAGAMENTO)
    REFERENCES PAGAMENTO (ID),
	CONSTRAINT FK_VENDA_STATUS
    FOREIGN KEY (ID_STATUS)
    REFERENCES TB_STATUS (ID),
);


CREATE TABLE PRODUTOVENDA (
  ID INT NOT NULL IDENTITY(1,1),
  CODIGO INT NOT NULL,
  VALOR DECIMAL(10,2) NOT NULL,
  DESCONTO DECIMAL(3,2) NOT NULL DEFAULT 1.00,
  ACAO VARCHAR(50) NOT NULL DEFAULT 'VENDIDO',
  ID_VENDA INT NOT NULL,
  ID_ESTOQUE INT NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT FK_PRODUTOVENDA_VENDA1
    FOREIGN KEY (ID_VENDA)
    REFERENCES VENDA (ID),
  CONSTRAINT FK_PRODUTOVENDA_ESTOQUE1
    FOREIGN KEY (ID_ESTOQUE)
    REFERENCES ESTOQUE (ID)
);
--VENDIDO DEVOLVIDO
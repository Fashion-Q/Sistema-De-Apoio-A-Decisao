-- Scripts ddl para o ambiente dimensional

USE dw_lowlatency

DROP TABLE FATO_VENDA
DROP TABLE DIM_PRODUTO
DROP TABLE DIM_LOJA
DROP TABLE DIM_TEMPO
DROP TABLE DIM_TIPO_PAGAMENTO


CREATE TABLE DIM_PRODUTO (
   ID_PRODUTO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
   COD_PRODUTO INT NOT NULL,
   PRODUTO VARCHAR(100) NOT NULL,
   COD_CATEGORIA INT NOT NULL,
   CATEGORIA VARCHAR(100) NOT NULL,
   VALOR NUMERIC (10,2) NOT NULL
)

CREATE TABLE DIM_LOJA (
	ID_LOJA INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COD_LOJA INT NOT NULL,
	LOJA VARCHAR(100) NOT NULL,
	CIDADE VARCHAR(100) NOT NULL,
	ESTADO VARCHAR(100) NOT NULL,
	SIGLA_ESTADO VARCHAR(2) NOT NULL
)

CREATE TABLE DIM_TIPO_PAGAMENTO (
	ID_TIPO_PAGAMENTO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COD_TIPO_PAGAMENTO INT NOT NULL,
	TIPO_PAGAMENTO VARCHAR(100)
)

CREATE TABLE DIM_TEMPO (
	ID_TEMPO BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	DATA DATETIME NOT NULL,
	DIA INT NOT NULL,
	DIA_SEMANA VARCHAR(50) NOT NULL,
	FIM_SEMANA VARCHAR(3) NOT NULL,
	MES INT NOT NULL,
	NOME_MES VARCHAR(100) NOT NULL,
	TRIMESTRE INT NOT NULL,
	NOME_TRIMESTRE VARCHAR(100) NOT NULL,
	SEMESTRE INT NOT NULL,
	NOME_SEMESTRE VARCHAR(100) NOT NULL,
	ANO INT NOT NULL
)

CREATE INDEX IX_DIM_TEMPO_DATA ON DIM_TEMPO (DATA)

CREATE TABLE FATO_VENDA (
	ID_VENDA BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ID_TEMPO BIGINT NOT NULL,
	ID_LOJA INT NOT NULL,
	ID_PRODUTO INT NOT NULL,
	ID_TIPO_PAGAMENTO INT NOT NULL,
	COD_VENDA BIGINT NOT NULL,
	VOLUME NUMERIC(10,2) NOT NULL,
	VALOR NUMERIC(10,2) NOT NULL,
	QUANTIDADE INT NOT NULL DEFAULT (1)
	CONSTRAINT FK_DIM_LOJA FOREIGN KEY (ID_LOJA) REFERENCES DIM_LOJA (ID_LOJA),
	CONSTRAINT FK_DIM_PRODUTO FOREIGN KEY (ID_PRODUTO) REFERENCES DIM_PRODUTO (ID_PRODUTO),
	CONSTRAINT FK_TEMPO FOREIGN KEY (ID_TEMPO) REFERENCES DIM_TEMPO (ID_TEMPO),
	CONSTRAINT FK_DIM_TIPO_PAGAMENTO FOREIGN KEY (ID_TIPO_PAGAMENTO) REFERENCES DIM_TIPO_PAGAMENTO (ID_TIPO_PAGAMENTO)
)


CREATE INDEX IX_FATO_VENDA_TEMPO ON FATO_VENDA(ID_TEMPO)
CREATE INDEX IX_FATO_VENDA_PRODUTO ON FATO_VENDA(ID_PRODUTO)
CREATE INDEX IX_FATO_VENDA_LOJA ON FATO_VENDA(ID_LOJA)
CREATE INDEX IX_FATO_VENDA_TIPO_PAGAMENTO ON FATO_VENDA(ID_TIPO_PAGAMENTO)
CREATE INDEX IX_FATO_VENDA_COD_VENDA ON FATO_VENDA(COD_VENDA)



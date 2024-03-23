USE hawkmart

CREATE TABLE TB_AUX_VENDA(
	DATA_CARGA DATETIME NOT NULL,
	DATA_VENDA DATETIME NOT NULL,
	COD_AVALIACAO INT NOT NULL,
	COD_PAGAMENTO INT NOT NULL,
	COD_STATUS INT NOT NULL,
	COD_PRODUTO INT NOT NULL,
	COD_LOJA INT NOT NULL,
	COD_VENDA INT NOT NULL,
	VALOR DECIMAL(10,2) NOT NULL,
	DESCONTO DECIMAL(3,2) NOT NULL DEFAULT 1.00,
	ACAO VARCHAR(50) NOT NULL DEFAULT 'VENDIDO',
)
CREATE TABLE TB_AUX_PRODUTO(
	DATA_CARGA DATETIME NOT NULL,
	COD_PRODUTO INT NOT NULL,
	PRODUTO VARCHAR(80) NOT NULL,
	COD_SUBCATEGORIA INT NOT NULL,
	SUBCATEGORIA VARCHAR(80) NOT NULL,
	COD_CATEGORIA INT NOT NULL,
	CATEGORIA VARCHAR(100) NOT NULL
)
CREATE TABLE TB_AUX_LOJA(
	DATA_CARGA DATETIME NOT NULL,
	COD_LOJA INT NOT NULL,
	LOJA VARCHAR(80) NOT NULL,
	COD_LOCALIDADE INT NOT NULL,
	CIDADE VARCHAR(100) NOT NULL,
	ESTADO VARCHAR(100) NOT NULL,
	SIGLA_ESTADO CHAR(2) NOT NULL CHECK (LEN(SIGLA_ESTADO) = 2)
)
CREATE TABLE TB_AUX_PAGAMENTO(
	DATA_CARGA DATETIME NOT NULL,
	COD_PAGAMENTO INT NOT NULL,
	PAGAMENTO VARCHAR(50) NOT NULL,
)
CREATE TABLE TB_AUX_AVALIACAO(
	DATA_CARGA DATETIME NOT NULL,
	COD_AVALIACAO INT NOT NULL
)
CREATE TABLE TB_AUX_STATUS(
	DATA_CARGA DATETIME NOT NULL,
	COD_STATUS INT NOT NULL,
	STATUS VARCHAR(50) NOT NULL DEFAULT 'AGUARDANDO PAGAMENTO',
)

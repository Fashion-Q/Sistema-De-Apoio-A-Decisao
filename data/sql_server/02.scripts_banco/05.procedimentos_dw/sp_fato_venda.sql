use hawkmart

create or alter procedure sp_fato_venda(@data_carga datetime)
as
begin
	declare @id_tempo int,
	@DATA_CARGA_AUX DATETIME, 
	@DATA_VENDA DATETIME,
	@id_avaliacao int,
	@id_pagamento int,
	@id_status int,
	@id_produto int, 
	@id_loja int,
	@cod_venda int, 
	@valor numeric(10,2),
	@desconto decimal(3,2),
	@acao varchar(50),
	@temVioacal BIT,
	@violacaoMensagem varchar(100)

	declare c_venda cursor for
	select DATA_CARGA, DATA_VENDA, COD_AVALIACAO, COD_PAGAMENTO, COD_STATUS, COD_PRODUTO, COD_LOJA, COD_VENDA, 
	VALOR, DESCONTO, ACAO
	from TB_AUX_VENDA 


	open c_venda 
	fetch next from c_venda into @DATA_CARGA_AUX, @DATA_VENDA, @ID_AVALIACAO, @ID_PAGAMENTO, @ID_STATUS, 
		@ID_PRODUTO, @ID_LOJA, @COD_VENDA, @VALOR, @DESCONTO, @ACAO
	WHILE(@@FETCH_STATUS = 0)
	begin
		set @temVioacal = 0
		set @violacaoMensagem = ''
		set @id_tempo = (select id_tempo from dim_tempo where @DATA_VENDA = data)
		IF NOT EXISTS (SELECT 1 FROM DIM_TEMPO WHERE DATA = @DATA_VENDA)
		BEGIN
			SET @temVioacal = 1
			set @violacaoMensagem = @violacaoMensagem + 'DATA DIM_TEMPO fora do intervalo | '
		END
		IF NOT EXISTS(SELECT 1 FROM DIM_LOJA WHERE COD_LOJA = @id_loja)
		BEGIN
			SET @temVioacal = 1
			set @violacaoMensagem = @violacaoMensagem + 'ID de DIM_LOJA fora do intervalo | '
		END
		IF NOT EXISTS(SELECT 1 FROM DIM_PRODUTO WHERE COD_PRODUTO = @id_produto)
		BEGIN
			SET @temVioacal = 1
			set @violacaoMensagem = @violacaoMensagem + 'ID de DIM_PRODUTO fora do intervalo | '
		END
		IF NOT EXISTS(SELECT 1 FROM DIM_PAGAMENTO WHERE COD_PAGAMENTO = @id_pagamento)
		BEGIN
			SET @temVioacal = 1
			set @violacaoMensagem = @violacaoMensagem + 'ID de DIM_PAGAMENTO fora do intervalo | '
		END
		IF @VALOR < 0
		BEGIN
			SET @temVioacal = 1
			set @violacaoMensagem = @violacaoMensagem + 'PREÇO NEGATIVO | '
		END
		IF @temVioacal = 0
		BEGIN
			insert into fato_venda 
			(id_tempo, id_avaliacao,id_pagamento, id_status, id_produto, 
			 id_loja, cod_venda, valor, desconto, acao)
			values (@id_tempo, @id_avaliacao, @id_pagamento, 
				    @id_status, @id_produto, @id_loja, @cod_venda, @valor, @desconto, @acao)
		END
		ELSE
		BEGIN
			insert into tb_vio_venda 
			(data_carga, data_venda, id_tempo, id_avaliacao,id_pagamento, id_status, id_produto, 
			 id_loja, cod_venda, valor, desconto, acao, dt_erro, violacao)
			values (@data_carga, @data_venda, @id_tempo, @id_avaliacao, @id_pagamento, 
				    @id_status, @id_produto, @id_loja, @cod_venda, @valor, 
					@desconto, @acao,CURRENT_TIMESTAMP,@violacaoMensagem)
		END
	fetch next from c_venda into @DATA_CARGA_AUX, @DATA_VENDA, @ID_AVALIACAO, @ID_PAGAMENTO, @ID_STATUS, 
				@ID_PRODUTO, @ID_LOJA, @COD_VENDA, @VALOR, @DESCONTO, @ACAO		
	end
	close c_venda
	deallocate c_venda
end

-- Teste
UPDATE TB_AUX_VENDA 
SET COD_PRODUTO = 100
WHERE VALOR = 150


exec sp_fato_venda '20230101'
SELECT * FROM TB_AUX_VENDA
select * from tb_vio_venda
select * from fato_venda













/*
create or alter procedure sp_fato_venda(@data_carga datetime)
as
begin
	insert into fato_venda 
	(id_tempo, id_avaliacao,id_pagamento, id_status, id_produto, id_loja, cod_venda, valor, desconto, acao)
	select t.ID_TEMPO, AV.COD_AVALIACAO, AV.COD_PAGAMENTO, AV.COD_STATUS, AV.COD_PRODUTO, AV.COD_LOJA,
		   AV.COD_VENDA, AV.VALOR, AV.DESCONTO, AV.ACAO
	from tb_aux_venda av
	inner join DIM_TEMPO t on (t.data = av.data_venda)
	where av.data_carga = @data_carga


end

select * from tb_aux_venda

-- Teste

exec sp_fato_venda '20240324'

DROP TABLE FATO_VENDA
select * from fato_venda

select * from venda

select * from tb_aux_venda
*/

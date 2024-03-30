use hawkmart;
create or alter procedure sp_oltp_venda(@data_carga datetime, @data_inicial datetime, @data_final datetime)
as
begin
	delete tb_aux_venda where @data_carga = data_carga
	insert into tb_aux_venda 
	(data_carga, data_venda, COD_AVALIACAO, COD_PAGAMENTO, COD_STATUS, COD_PRODUTO, COD_LOJA,COD_VENDA, VALOR, DESCONTO, ACAO)
	select @data_carga, V.DATA, AV.COD_AVALIACAO, V.COD_PAGAMENTO, V.COD_STATUS, AV.COD_PRODUTO, E.COD_LOJA, 
		   V.COD_VENDA, AV.VALOR, AV.DESCONTO, AV.ACAO
	from venda v
	INNER JOIN PRODUTOVENDA AV 
	ON AV.COD_VENDA = V.COD_VENDA
	INNER JOIN ESTOQUE E
	ON E.COD_ESTOQUE = AV.COD_ESTOQUE
	where v.DATA >= @data_inicial and v.DATA < @data_final
end



-- Teste

exec sp_oltp_venda '20230101', '20240101', '20241231'

select * from tb_aux_venda
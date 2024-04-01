use hawkmart
create or alter procedure sp_fato_venda_feriadoa(@data_carga datetime)
as
begin
	insert into fato_venda_feriado
	(id_tempo, id_produto, id_loja, cod_venda, valor, desconto, acao)
	select t.ID_TEMPO, AV.COD_PRODUTO, AV.COD_LOJA, AV.COD_VENDA, AV.VALOR, AV.DESCONTO, AV.ACAO
	from tb_aux_venda av
	inner join DIM_TEMPO t on (t.data = av.data_venda)
	where av.data_carga = @data_carga
	AND t.fl_feriado = 'SIM'
end
-- Teste

exec sp_fato_venda_feriadoa '20230101'

select * from fato_venda_feriado
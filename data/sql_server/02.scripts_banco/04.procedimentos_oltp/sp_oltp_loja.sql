use dw_lowlatency
create or alter procedure sp_oltp_loja(@data_carga datetime)
as
begin
	insert into tb_aux_loja
	(data_carga,cod_loja,loja,cidade,estado,sigla_estado)
	select @data_carga,l.cod_loja,l.nm_loja,c.cidade,e.estado,e.sigla
	from tb_loja l
	inner join tb_cidade c on (c.COD_CIDADE = l.COD_CIDADE)
	inner join tb_estado e on (c.COD_ESTADO = e.COD_ESTADO)
end



-- Teste

exec sp_oltp_loja '20230101'
select * from tb_loja
select * from tb_cidade
select * from tb_estado
select * from tb_aux_loja

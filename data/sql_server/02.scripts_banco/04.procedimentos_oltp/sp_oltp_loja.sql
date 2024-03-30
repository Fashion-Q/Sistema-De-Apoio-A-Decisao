use hawkmart
create or alter procedure sp_oltp_loja(@data_carga datetime)
as
begin
	delete tb_aux_loja where @data_carga = DATA_CARGA
	insert into tb_aux_loja
	(data_carga,cod_loja,loja,COD_LOCALIDADE,cidade,estado,sigla_estado)
	select @data_carga,l.cod_loja,l.loja,l.COD_LOCALIDADE,lo.cidade,lo.estado,lo.SIGLA_ESTADO
	from loja l
	inner join LOCALIDADE lo on (lo.COD_LOCALIDADE = l.COD_LOCALIDADE)
	
end

-- Teste
exec sp_oltp_loja '20230101'
select * from tb_aux_loja

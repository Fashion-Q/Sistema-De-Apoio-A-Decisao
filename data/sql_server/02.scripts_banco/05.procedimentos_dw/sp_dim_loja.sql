use dw_lowlatency
create or alter procedure sp_dim_loja(@data_carga datetime)
as
begin
	insert into dim_loja
	(cod_loja,loja,cidade,estado,sigla_estado)
	select cod_loja,loja,cidade,estado,sigla_estado
	from tb_aux_loja where @data_carga = data_carga
end



-- Teste

exec sp_dim_loja '20230101'

select * from dim_loja
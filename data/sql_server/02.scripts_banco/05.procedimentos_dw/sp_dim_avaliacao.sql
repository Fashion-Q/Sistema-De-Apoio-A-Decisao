USE hawkmart
create or alter procedure sp_dim_avaliacao(@data_carga datetime)
as
begin
	insert into DIM_AVALIACAO(COD_AVALIACAO)
	select COD_AVALIACAO
	from TB_AUX_AVALIACAO where @data_carga = data_carga
end



-- Teste

exec sp_dim_avaliacao'20230101'

select * from DIM_AVALIACAO
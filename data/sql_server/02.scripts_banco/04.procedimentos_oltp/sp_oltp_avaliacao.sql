use hawkmart
create or alter procedure sp_oltp_avaliacao(@data_carga datetime)
as
begin
	insert into TB_AUX_AVALIACAO(data_carga,COD_AVALIACAO)
	select @data_carga, COD_AVALIACAO
	from AVALIACAO
end



-- Teste

exec sp_oltp_avaliacao'20230101'

select * from TB_AUX_AVALIACAO
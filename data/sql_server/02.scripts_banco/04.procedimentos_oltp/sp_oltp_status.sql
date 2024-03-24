use hawkmart
create or alter procedure sp_oltp_status(@data_carga datetime)
as
begin
	insert into TB_AUX_STATUS(data_carga,COD_STATUS,STATUS)
	select @data_carga, COD_STATUS, STATUS
	from TB_STATUS
end



-- Teste

exec sp_oltp_status'20230101'

select * from TB_AUX_STATUS
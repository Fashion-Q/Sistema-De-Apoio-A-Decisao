USE hawkmart
create or alter procedure sp_dim_status(@data_carga datetime)
as
begin
	insert into DIM_STATUS(COD_STATUS,STATUS)
	select COD_STATUS, STATUS
	from TB_AUX_STATUS where @data_carga = data_carga
end



-- Teste

exec sp_dim_status'20230101'

select * from DIM_STATUS
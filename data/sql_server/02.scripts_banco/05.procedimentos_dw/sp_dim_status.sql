USE hawkmart
create or alter procedure sp_dim_status(@data_carga datetime)
as
begin
	if exists(select 1 from DIM_STATUS where COD_STATUS IN (select COD_STATUS from TB_AUX_STATUS where @data_carga = DATA_CARGA))
    begin
        --Update em DIM_
        update DIM_STATUS
        set
            STATUS = AUX.STATUS
        from DIM_STATUS A
        inner join TB_AUX_STATUS AUX
        on A.COD_STATUS = AUX.COD_STATUS
        where AUX.DATA_CARGA = @data_carga
    end
    else
    begin
        --Insere em DIM
        insert into DIM_STATUS(COD_STATUS)
        select AUX.COD_STATUS
        from TB_AUX_STATUS AUX
        where @data_carga = AUX.DATA_CARGA
    end
end



-- Teste

exec sp_dim_status'20230101'

select * from DIM_STATUS
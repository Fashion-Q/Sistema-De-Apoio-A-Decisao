USE hawkmart
create or alter procedure sp_dim_pagamento(@data_carga datetime)
as
begin
	if exists(select 1 from DIM_PAGAMENTO where COD_PAGAMENTO IN (select COD_PAGAMENTO from TB_AUX_PAGAMENTO where @data_carga = DATA_CARGA))
    begin
        --Update em DIM_PAGAMENTO
        update DIM_PAGAMENTO
        set
            PAGAMENTO = AUX.PAGAMENTO
        from DIM_PAGAMENTO A
        inner join TB_AUX_PAGAMENTO AUX
        on A.COD_PAGAMENTO = AUX.COD_PAGAMENTO
        where AUX.DATA_CARGA = @data_carga
    end
    else
    begin
        --Insere em DIM_PAGAMENTO
        insert into DIM_PAGAMENTO (COD_PAGAMENTO,PAGAMENTO)
        select AUX.COD_PAGAMENTO,AUX.PAGAMENTO
        from TB_AUX_PAGAMENTO AUX
        where @data_carga = AUX.DATA_CARGA
    end
end

-- Teste

exec sp_dim_pagamento '20230101'

select * from dim_pagamento
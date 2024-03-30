use hawkmart

create or alter procedure sp_oltp_pagamento(@data_carga datetime)
as
begin
	delete tb_aux_pagamento where @data_carga = DATA_CARGA
	insert into tb_aux_pagamento (data_carga,cod_pagamento,pagamento)
	select @data_carga, cod_pagamento, pagamento
	from pagamento

	if exists(select 1 from DIM_PAGAMENTO where COD_PAGAMENTO IN (select COD_PAGAMENTO from TB_AUX_PAGAMENTO where @data_carga = DATA_CARGA))
    begin
        --Update em DIM_LOJA
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
        --Insere em DIM_LOJA
        insert into DIM_LOJA (COD_LOJA, LOJA,COD_LOCALIDADE, CIDADE, ESTADO, SIGLA_ESTADO)
        select al.COD_LOJA, al.LOJA,AL.COD_LOCALIDADE, al.CIDADE, al.ESTADO, al.SIGLA_ESTADO
        from TB_AUX_LOJA al
        where @data_carga = al.DATA_CARGA
    end
end



-- Teste

exec sp_oltp_pagamento '20230101'

select * from tb_aux_pagamento
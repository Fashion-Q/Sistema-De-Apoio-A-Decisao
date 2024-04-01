use hawkmart
create or alter procedure sp_dim_loja(@data_carga datetime)
as
begin
	if exists(select 1 from DIM_LOJA where COD_LOJA IN (select COD_LOJA from TB_AUX_LOJA where @data_carga = DATA_CARGA))
    begin
        --Update em DIM_LOJA
        update DIM_LOJA
        set
            LOJA = al_aux.LOJA,
            COD_LOCALIDADE = AL_AUX.COD_LOCALIDADE,
			CIDADE = AL_AUX.CIDADE,
			ESTADO = AL_AUX.ESTADO,
            SIGLA_ESTADO = al_aux.SIGLA_ESTADO
        from DIM_LOJA dl
        inner join TB_AUX_LOJA al_aux
        on dl.COD_LOJA = al_aux.COD_LOJA
        where al_aux.DATA_CARGA = @data_carga
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
exec sp_dim_loja '20230101'

select * from dim_loja
select * from TB_AUX_LOJA
use hawkmart
create or alter procedure sp_dim_produto(@data_carga datetime)
as
begin
   if exists(select 1 from DIM_PRODUTO where COD_PRODUTO IN (select COD_PRODUTO from TB_AUX_PRODUTO where @data_carga = DATA_CARGA))
    begin
        --Update em DIM_
        update DIM_PRODUTO
        set
            PRODUTO = AUX.PRODUTO,
			COD_SUBCATEGORIA = AUX.COD_SUBCATEGORIA,
			SUBCATEGORIA = AUX.SUBCATEGORIA,
			COD_CATEGORIA = AUX.COD_CATEGORIA,
			CATEGORIA = AUX.CATEGORIA
        from DIM_PRODUTO A
        inner join TB_AUX_PRODUTO AUX
        on A.COD_PRODUTO = AUX.COD_PRODUTO
        where AUX.DATA_CARGA = @data_carga
    end
    else
    begin
        --Insere em DIM
        insert into DIM_PRODUTO (COD_PRODUTO,PRODUTO,COD_SUBCATEGORIA,SUBCATEGORIA,COD_CATEGORIA,CATEGORIA)
        select AUX.COD_PRODUTO,AUX.PRODUTO,AUX.COD_SUBCATEGORIA,AUX.SUBCATEGORIA,AUX.COD_CATEGORIA,AUX.CATEGORIA
        from TB_AUX_PRODUTO AUX
        where @data_carga = AUX.DATA_CARGA
    end
end


-- Teste

exec sp_dim_produto '20230101'

select * from dim_produto
select * from TB_AUX_PRODUTO

delete from DIM_PRODUTO where ID_PRODUTO <> -1
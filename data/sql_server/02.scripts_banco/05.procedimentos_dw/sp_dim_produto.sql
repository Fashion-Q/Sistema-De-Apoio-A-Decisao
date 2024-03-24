use hawkmart
create or alter procedure sp_dim_produto(@data_carga datetime)
as
begin
   insert into dim_produto (cod_produto, produto, COD_SUBCATEGORIA,SUBCATEGORIA, cod_categoria, categoria)
	select cod_produto,produto, COD_SUBCATEGORIA, SUBCATEGORIA,cod_categoria,categoria
	from tb_aux_produto where @data_carga = data_carga
end


-- Teste

exec sp_dim_produto '20230101'

select * from dim_produto
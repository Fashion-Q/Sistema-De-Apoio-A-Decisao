use hawkmart
create or alter procedure sp_oltp_produto(@data_carga datetime)
as
begin
	delete tb_aux_produto where @data_carga = DATA_CARGA
	insert into tb_aux_produto (data_carga, cod_produto, produto,COD_SUBCATEGORIA, SUBCATEGORIA, cod_categoria, categoria)
	select @data_carga,p.cod_produto,p.produto,p.COD_SUBCATEGORIA,s.SUBCATEGORIA,s.cod_categoria,c.categoria
	from produto p
	inner join SUBCATEGORIA s on (s.COD_SUBCATEGORIA = p.COD_SUBCATEGORIA)
	inner join categoria c on (c.COD_CATEGORIA = s.COD_CATEGORIA)
end


-- Teste

exec sp_oltp_produto '20230101'

select * from tb_aux_produto
select * from produto
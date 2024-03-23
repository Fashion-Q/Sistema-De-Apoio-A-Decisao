use dw_lowlatency
create or alter procedure sp_oltp_produto(@data_carga datetime)
as
begin
	insert into tb_aux_produto (data_carga, cod_produto, produto, cod_categoria, categoria,valor)
	select @data_carga,p.cod_produto,p.produto,c.cod_categoria,c.categoria,p.valor
	from tb_produto p
	inner join tb_categoria c on (p.cod_categoria = c.cod_categoria)
end


-- Teste

exec sp_oltp_produto '20230101'

select * from tb_aux_produto
select * from tb_produto
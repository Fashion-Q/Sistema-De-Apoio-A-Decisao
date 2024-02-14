use hawkmart;

# Qual o numero de compras realizadas hoje?
select count(f.count) from fato_venda f
join dim_tempo t
#where t.dia = 1 and t.mes = 2 and t.ano = 2015;
where f.data_produto_entregue is not null and DATE(t.data) = CURDATE();

# Qual o numero de compras canceladas hoje?
select count(f.count) from fato_venda v
join dim_tempo t
where v.data_cancelado is not null and DATE(t.data) = CURDATE();

# Quais estoques não tiveram seus produtos vendidos completamente?
select e.nome from fato_estoque e
where e.data_validade is not null and
 e.quantidadeEstoque <> e.quantidadeVendida;
 
#Quantas devoluções ao todo um produto teve?
select nome, count(reajustes) as devolvido from fato_estoque
group by nome;

# Quais produtos foram passado da validade
select nome,reajustes as quantidade from fato_estoque
where reajustes <> 0 and CURDATE() > date(data_validade);

# Qual a média de vendas por mês do ano atual?
select t.ano, t.mes, avg(f.valor_total) as 'valor total'from fato_venda f
join dim_tempo t on t.id = f.data_produto_entregue
where f.data_cancelado is null and f.data_produto_entregue is not null
and t.ano = year(curdate())
group by t.ano,t.mes; 

# Qual o número de compras por loja?
select l.nome, count(f.count) as quantidade from fato_venda f
join dim_loja l on l.id = f.loja_id
where f.data_cancelado is null and f.data_produto_entregue is not null
group by l.nome;


# Qual o número de vendas por categoria ?
select c.nome, count(f.count) as quantidade from fato_venda f
join dim_categoria c on c.id = f.categoria_id
where f.data_cancelado is null and f.data_produto_entregue is not null
group by c.nome;

# Qual o número de vendas por subcategoria ?
select s.nome, count(f.count) as quantidade from fato_venda f
join dim_subcategoria s on s.id = f.subcategoria_id
where f.data_cancelado is null and f.data_produto_entregue is not null
group by s.nome;
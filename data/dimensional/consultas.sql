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

# Qual o número de compras feitas por cada usuário?
select c.nome, count(f.count) as quantidade from fato_venda f
join dim_cliente c on c.id = f.cliente_id
where f.data_produto_entregue is not null 
group by c.nome;

# Quais os produtos mais comprados por categoria?
select pv.nome, count(f.count) as quantidade from fato_venda f
join dim_produtovenda pv on pv.Venda_id = f.id
where pv.Venda_id = f.id
group by pv.nome;
# Qual a média de compras de clientes do Sexo Masculino?
select c.sexo, count(f.count)as masculino from fato_venda f
join dim_cliente c on c.id = f.cliente_id
where f.data_produto_entregue is not null and c.sexo = 'M'
group by c.sexo;

# Qual a média de compras de clientes do Sexo Feminino?
select c.sexo, count(f.count)as feminino from fato_venda f
join dim_cliente c on c.id = f.cliente_id
where f.data_produto_entregue is not null and c.sexo = 'F'
group by c.sexo;

# Quais estoques que mais lucrou? Top 10
select fe.id, fe.data_inserido as "Data de Inserção do Estoque", (fe.quantidadeVendida * fe.valor) as "Valor Total" from fato_estoque fe  
order by "Valor Total" desc
LIMIT 10;
# Quais estoques que menos lucrou? Top 10
select fe.id, fe.data_inserido as "Data de Inserção do Estoque", (fe.quantidadeVendida * fe.valor) as "Valor Total" from fato_estoque fe  
order by "Valor Total" asc
LIMIT 10;
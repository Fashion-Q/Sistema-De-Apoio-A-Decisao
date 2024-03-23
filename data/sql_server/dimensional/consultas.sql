use hawkmart;

# Qual o numero de compras realizadas hoje?
select sum(fv.count) as 'Compras feitas hoje' from fato_venda fv
join dim_tempo t
on (t.id = fv.data_aguardando_pagamento)
#where t.dia = 1 and t.mes = 2 and t.ano = 2015;
where fv.data_produto_entregue is not null and DATE(t.data) = CURDATE();

# Qual o numero de compras canceladas hoje?
select sum(fv.count) from fato_venda fv
join dim_tempo t
on (t.id = fv.data_aguardando_pagamento)
join dim_status st on (st.id = fv.status_id)
where st.status = 'CANCELADO' and DATE(t.data) = CURDATE();

# Quais estoques não tiveram seus produtos vendidos completamente?
select e.nome from fato_estoque e
where e.quantidadeEstoque <> e.quantidadeVendida;
 
# Quantas devoluções ao todo um produto teve?
select nome, count(reajustes) as devolvido from fato_estoque
group by nome;

# Quais produtos foram passado da validade
select nome,reajustes as quantidade from fato_estoque
where reajustes <> 0 and data_validade is not null and CURDATE() > date(data_validade);

# Qual a média de vendas por mês do ano atual?
select t.ano, t.mes, avg(f.valor_total) as 'media de vendas'from fato_venda f
join dim_status st on (f.status_id = st.id)
join dim_tempo t on (t.id = f.data_produto_entregue)
where st.status = 'ENTREGUE'
and t.ano = year(curdate())
group by t.ano,t.mes; 

# Qual o número de compras por loja?
select l.nome, sum(f.count) as quantidade from fato_venda f
join dim_loja l on l.id = f.loja_id
join dim_status st on(st.id = f.status_id)
where st.status = 'ENTREGUE'
group by l.nome;


# Qual o número de vendas por categoria ?
select p.categoria, sum(fv.count) as quantidade from fato_venda fv
join dim_produto p on (p.id = fv.produto_id)
join dim_status st on (st.id = fv.status_id)
where st.status = 'ENTREGUE' and p.id_categoria = 3
group by p.categoria;

# Qual o número de vendas por subcategoria ?
select p.subcategoria, sum(fv.count) as quantidade from fato_venda fv
join dim_produto p on (p.id = fv.produto_id)
join dim_status st on (st.id = fv.status_id)
where st.status = 'ENTREGUE' and p.id_categoria = 3
group by p.subcategoria;


# Quais os produtos mais comprados por categoria?
select p.produto,p.categoria, avg(fv.valor_total * fv.desconto) as Total
from fato_venda fv
join dim_produto p on (p.id = fv.produto_id)
where (p.id = fv.produto_id) # testa depois sem a condicao where
group by p.produto,p.categoria;

# Quais os produtos mais comprados por subcategoria?
select p.produto,p.subcategoria, avg(fv.valor_total * fv.desconto) as Total
from fato_venda fv
join dim_produto p on (p.id = fv.produto_id)
where (p.id = fv.produto_id) # testa depois sem a condicao where
group by p.produto,p.subcategoria;


# Qual a média de compras de clientes do Sexo Masculino?
select fv.sexo, sum(fv.count)as masculino from fato_venda fv
join dim_status st on (fv.status_id = st.id)
where st.status = 'ENTREGUE' and fv.sexo = 'M'
group by fv.sexo;

# Qual a média de compras de clientes do Sexo Feminino?
select fv.sexo, sum(fv.count)as Feminino from fato_venda fv
join dim_status st on (fv.status_id = st.id)
where st.status = 'ENTREGUE' and fv.sexo = 'F'
group by fv.sexo;

# Quais estoques que mais lucrou? Top 10
select fe.id, fe.data_inserido as "Data de Inserção do Estoque", 
(fe.quantidadeVendida * fe.valor) as "Valor Total" from fato_estoque fe  
order by "Valor Total" desc
LIMIT 10;

# Quais estoques que menos lucrou? Top 10
select fe.id, fe.data_inserido as "Data de Inserção do Estoque", (fe.quantidadeVendida * fe.valor) as "Valor Total" from fato_estoque fe  
order by "Valor Total" asc
LIMIT 10;
use hawkmart;

-- Qual o numero de compras realizadas hoje?
select sum(fv.QUANTIDADE) as 'Compras feitas hoje' from fato_venda fv
join dim_tempo t
on (t.ID_TEMPO = fv.ID_TEMPO)
join dim_status st on (st.COD_STATUS = fv.ID_STATUS)
--where t.dia = 1 and t.mes = 2 and t.ano = 2015;
where st.status = 'PRODUTO ENTREGUE' and t.data = GETDATE();

-- Qual o numero de compras canceladas?
select sum(fv.QUANTIDADE) as 'Compras Canceladas 'from fato_venda fv
join dim_status st on (st.COD_STATUS = fv.ID_STATUS)
where st.status = 'CANCELADO';


-- Quantas devoluções ao todo um produto teve?
select DP.PRODUTO, sum(FV.QUANTIDADE) as devolvido from fato_venda FV
INNER JOIN DIM_PRODUTO DP ON (DP.COD_PRODUTO = FV.ID_PRODUTO)
INNER JOIN DIM_STATUS ST ON (ST.COD_STATUS = FV.ID_STATUS)
WHERE DP.COD_PRODUTO = FV.ID_PRODUTO AND FV.ID_STATUS = ST.COD_STATUS
GROUP BY PRODUTO

-- Qual a média de vendas por mês do ano atual?
select t.ano, t.mes, avg(f.VALOR) as 'media de vendas'from fato_venda f
join dim_status st on (f.ID_STATUS = st.COD_STATUS)
join dim_tempo t on (t.ID_TEMPO = f.ID_TEMPO)
where st.status = 'PRODUTO ENTREGUE'
and t.ano = year(GETDATE())
group by t.ano,t.mes; 

-- Qual total de vendas em por mês e por ano?
select t.ano, t.mes, sum(f.VALOR) as 'TOTAL POR MÊS'from fato_venda f
join dim_status st on (f.ID_STATUS = st.COD_STATUS)
join dim_tempo t on (t.ID_TEMPO = f.ID_TEMPO)
where st.status = 'PRODUTO ENTREGUE'
and t.ano = year(GETDATE())
group by t.ano,t.mes; 

-- Qual o número de compras por loja?
select l.LOJA, sum(f.QUANTIDADE) as quantidade from fato_venda f
join dim_loja l on l.COD_LOJA = f.ID_LOJA
join dim_status st on(st.COD_STATUS = f.ID_STATUS)
where st.status = 'PRODUTO ENTREGUE'
group by l.LOJA;


-- Qual o número de vendas por categoria ?
select p.categoria, sum(fv.QUANTIDADE) as quantidade from fato_venda fv
join dim_produto p on (p.ID_PRODUTO = fv.ID_PRODUTO)
join dim_status st on (st.ID_STATUS = fv.ID_STATUS)
where st.status = 'PRODUTO ENTREGUE'
group by p.categoria;

-- Qual o número de vendas por subcategoria ?
select p.subcategoria, sum(fv.QUANTIDADE) as quantidade from fato_venda fv
join dim_produto p on (p.COD_PRODUTO = fv.ID_PRODUTO)
join dim_status st on (st.COD_STATUS = fv.ID_STATUS)
where st.status = 'PRODUTO ENTREGUE' 
group by p.subcategoria;


-- Quais os produtos mais comprados por categoria?
select p.produto,p.categoria, avg(fv.VALOR * fv.desconto) as Total
from fato_venda fv
join dim_produto p on (p.COD_PRODUTO = fv.ID_PRODUTO)
where (p.ID_PRODUTO = fv.ID_PRODUTO)
group by p.produto,p.categoria;

-- Quais os produtos mais comprados por subcategoria?
select p.produto,p.subcategoria, avg(fv.VALOR * fv.desconto) as Total
from fato_venda fv
join dim_produto p on (p.COD_PRODUTO = fv.ID_PRODUTO)
where (p.ID_PRODUTO = fv.ID_PRODUTO)
group by p.produto,p.subcategoria;

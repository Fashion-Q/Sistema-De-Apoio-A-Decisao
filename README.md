# Sistema-De-Apoio-A-Decisao
Repositorio para guardar informações da matéria de SAD

**Alunos: Nadianne Galvão, Valdir Santana e Verenilson Souza**


## Cenário OLTP 

### Introdução

Em um cenário cada vez mais digital, a gestão eficiente de sistemas de vendas online torna-se essencial para as operações bem-sucedidas das empresas. Neste contexto, exploraremos a aplicação de um Data Warehouse em um sistema de vendas online, analisando como cada elemento, desde a busca por produtos até a entrega final, proporcionando uma visão detalhada e estruturada do funcionamento do e-commerce.

**Granularidade**

Uma empresa gerencia um sistema de vendas online. Uma linha na tabela venda é uma solicitação de um cliente para comprar um ou mais produtos disponíveis em um e-commerce em um determinado dia, através de uma determinada forma de pagamento. 

**Sistema operacional / cenário**

O usuário busca produtos desejados e adiciona-os no carrinho. Ao finalizar a busca de produtos, o cliente vai ao carrinho e seleciona aforma de pagamento (pix, cartão de débito, cartão de crédito, boleto) e adiciona o CEP para verificar o valor do frete, e também descreve o endereço para entrega.

Uma vez confirmada a compra, o status da venda fica como: **“aguardando pagamento”**. Se o tempo do pagamento expirar o status da venda vai para **“cancelado”**. Caso tenha feito o pagamento, o status da venda será: **“pagamento efetuado”**.

Ao efetuar o pagamento, o status do produto será alterado para **“em andamento”**

Ao fazer a entrega o status do produto sera **“entregue”** e o usuário poderá fazer uma avaliação do produto e da entrega.

## Indicadores

- Qual o número de compras realizadas hoje?
- Qual o número de de compras realizadas nos últimos dois meses ?
- Qual o número de de compras canceladas hoje ?
- Qual o número de compras que passaram para o status ‘Pagamento efetuado’ hoje e quantas passaram para o status “entregue”?
- Qual a média de compras por dia ? por mês ? por semestre ?
- Qual o número de compras por loja? por semestre ?
- Qual o número de compras por categoria ? por trimestre?
- Qual o número de compras em determinada categoria para uma subcategoria ? por trimestre ?
- Qual o número de compras com status: cancelado? por dia? por mês? por trimestre ?
- Qual o número de compras com status: pagamento efetuado? por dia? por mês? por trimestre ?
- Qual o número de compras com status: em andamento? por dia? por mês? por trimestre ?
- Qual o número de compras com status: entregue? por dia? por mês? por trimestre ?
- Qual o número de compras feitas por cada usuário?
- Qual o número de avaliações recebidas por produto de (1 à 5)? E quais não tiveram avaliações?
- Qual a média de tempo (em dias) entre o status “em andamento” e “entregue” de um produto?
- Qual o número de compras, cujo tempo entre “em andamento” e “entregue” ultrapassa o tempo estimado de entrega ?
- Qual a média das vendas por categoria? Por subcategoria?
- Quais os produtos mais requisitadas por categoria ?
- Qual o número de compras de clientes por estado e por cidade ?
- Qual a média de compras de clientes por Sexo em uma determinada loja?
- Qual o número de compras de atendimentos por Faixa Etária ?
- Qual a média de compras em uma determinada loja? por dia? por mês? por semestre ?
- Qual a média de compras com status: entregue? por dia? por mês? por trimestre ?
- Quais estoques não tiverem seus produtos vendidos completamente? Por loja? Por estado?
- Qual a média de venda de produto por estoque? Por Loja? Por Época?
- Qual estoque de produto que teve mais devoluções? Por loja?
- Quais produtos alimentício foram passado da validade?
- Qual media de venda de estoque por produto de uma loja por semestre? Por estado? Por Cidade?
- Quais estoques que mais lucrou? Top 10
- Quais estoques que menos lucrou? Top 10
- Qual o maior estoque de produto registrado de uma loja?
- Qual a quantidade média de produtos por estoque de uma determinada categoria? 









![image](https://github.com/Fashion-Q/Sistema-De-Apoio-A-Decisao/assets/54487179/1d887151-8d4d-4cd7-a13a-55b32774b2d8)

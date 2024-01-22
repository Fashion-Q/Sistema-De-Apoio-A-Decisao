# Sistema-De-Apoio-A-Decisao
Repositorio para guardar informações da matéria de SAD

## Cenário OLTP / Indicadores

### Introdução

Em um cenário cada vez mais digital, a gestão eficiente de sistemas de vendas online torna-se essencial para as operações bem-sucedidas das empresas. Neste contexto, exploraremos a aplicação de um Data Warehouse em um sistema de vendas online, analisando como cada elemento, desde a busca por produtos até a entrega final, proporcionando uma visão detalhada e estruturada do funcionamento do e-commerce.

**Granularidade**

Uma empresa gerencia um sistema de vendas online. Uma linha na tabela venda é uma solicitação de um cliente para comprar um ou mais produtos disponíveis em um e-commerce em um determinado dia, através de uma determinada forma de pagamento. 

**Sistema operacional / cenário**

O usuário busca produtos desejados e adiciona-os no carrinho. Ao finalizar a busca de produtos, o cliente vai ao carrinho e seleciona aforma de pagamento (pix, cartão de débito, cartão de crédito, boleto) e adiciona o CEP para verificar o valor do frete, e também descreve o endereço para entrega.

Uma vez confirmada a compra, o status da venda fica como: **“aguardando pagamento”**. Se o tempo do pagamento expirar o status da venda vai para **“cancelado”**. Caso tenha feito o pagamento, o status da venda será: **“pagamento efetuado”**.

Ao efetuar o pagamento, o status do produto será alterado para **“em andamento”**

Ao fazer a entrega o status do produto sera **“entregue”** e o usuário poderá fazer uma avaliação do produto e da entrega.



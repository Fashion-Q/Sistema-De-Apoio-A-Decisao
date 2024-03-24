create or alter procedure sp_fato_venda(@data_carga datetime)
as
begin
insert into fato_venda 
(id_tempo, id_avaliacao,id_pagamento, id_status, id_produto, id_loja, cod_venda, valor, desconto, acao)
select t.ID_TEMPO, AV.COD_AVALIACAO, AV.COD_PAGAMENTO, AV.COD_STATUS, AV.COD_PRODUTO, AV.COD_LOJA,
	   AV.COD_VENDA, AV.VALOR, AV.DESCONTO, AV.ACAO
from tb_aux_venda av
inner join DIM_TEMPO t on (t.data = av.data_venda)
where av.data_carga = @data_carga

end

select * from tb_aux_venda

-- Teste

exec sp_fato_venda '20240324'

DROP TABLE FATO_VENDA
select * from fato_venda

select * from venda

select * from tb_aux_venda
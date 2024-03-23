create or alter procedure sp_fato_venda(@data_carga datetime)
as
begin
insert into fato_venda 
(      t.id_tempo,   id_loja   ,id_produto,    id_tipo_pagamento,   cod_venda,   volume,   valor,quantidade)
select t.ID_TEMPO,dl.id_loja,dp.id_produto,dtp.id_tipo_pagamento,av.cod_venda,av.volume,av.valor,1
from tb_aux_venda av on (av.data_carga = @data_carga)
inner join dim_loja dl on (av.cod_loja = dl.cod_loja)
inner join dim_produto dp on (av.cod_produto = dp.cod_produto)
inner join dim_tipo_pagamento dtp on (av.cod_tipo_pagamento = dtp.cod_tipo_pagamento)
inner join dim_tempo t on (t.data = av.data_venda)
where av.data_carga = @data_carga
end

select * from tb_aux_venda

-- Teste

exec sp_fato_venda '20230101'

select * from fato_venda

select * from tb_venda

select * from tb_aux_venda
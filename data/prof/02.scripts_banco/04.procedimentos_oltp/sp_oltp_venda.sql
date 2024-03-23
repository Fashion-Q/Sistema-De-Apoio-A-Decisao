use dw_lowlatency;
create or alter procedure sp_oltp_venda(@data_carga datetime, @data_inicial datetime, @data_final datetime)
as
begin

insert into tb_aux_venda 
(      data_carga, data_venda,  cod_loja,  cod_produto,  cod_tipo_pagamento,  cod_venda,  volume,  valor)
select @data_carga,v.data_venda,v.cod_loja,v.cod_produto,v.cod_tipo_pagamento,v.cod_venda,v.volume,v.valor
from tb_venda v
where v.data_venda >= @data_inicial and v.data_venda < @data_final

end



-- Teste

exec sp_oltp_venda '20230101', '20230101', '20230104'

select * from tb_aux_venda

select * from tb_venda

truncate table tb_aux_venda
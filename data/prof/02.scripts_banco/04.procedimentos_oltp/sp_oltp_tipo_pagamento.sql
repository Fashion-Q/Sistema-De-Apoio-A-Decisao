use dw_lowlatency
create or alter procedure sp_oltp_tipo_pagamento(@data_carga datetime)
as
begin
	insert into tb_aux_tipo_pagamento (data_carga,cod_tipo_pagamento,tipo_pagamento)
	select @data_carga, cod_tipo_pagamento, tipo_pagamento
	from tb_tipo_pagamento
end



-- Teste

exec sp_oltp_tipo_pagamento '20230101'

select * from tb_aux_tipo_pagamento
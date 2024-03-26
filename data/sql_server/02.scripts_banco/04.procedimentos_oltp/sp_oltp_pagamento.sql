use hawkmart

create or alter procedure sp_oltp_pagamento(@data_carga datetime)
as
begin
	delete tb_aux_pagamento where @data_carga = DATA_CARGA
	insert into tb_aux_pagamento (data_carga,cod_pagamento,pagamento)
	select @data_carga, cod_pagamento, pagamento
	from pagamento
end



-- Teste

exec sp_oltp_pagamento '20230101'

select * from tb_aux_pagamento
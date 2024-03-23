create or alter procedure sp_dim_tipo_pagamento(@data_carga datetime)
as
begin
	insert into dim_tipo_pagamento (cod_tipo_pagamento,tipo_pagamento)
	select cod_tipo_pagamento, tipo_pagamento
	from tb_aux_tipo_pagamento where @data_carga = @data_carga
end



-- Teste

exec sp_dim_tipo_pagamento '20230101'

select * from dim_tipo_pagamento
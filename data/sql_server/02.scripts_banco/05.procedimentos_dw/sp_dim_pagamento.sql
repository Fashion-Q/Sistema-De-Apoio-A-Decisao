USE hawkmart
create or alter procedure sp_dim_pagamento(@data_carga datetime)
as
begin
	insert into dim_pagamento (cod_pagamento,pagamento)
	select cod_pagamento, pagamento
	from tb_aux_pagamento where @data_carga = data_carga
end



-- Teste

exec sp_dim_pagamento '20230101'

select * from dim_pagamento
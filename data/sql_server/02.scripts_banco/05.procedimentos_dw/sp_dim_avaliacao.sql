USE hawkmart
create or alter procedure sp_dim_avaliacao(@data_carga datetime)
as
begin
	DECLARE @CONTADOR INT
	SET @CONTADOR = 0
	while (@CONTADOR < 6)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM DIM_AVALIACAO WHERE COD_AVALIACAO = @CONTADOR)
		BEGIN
			SELECT * FROM DIM_AVALIACAO
			insert into AVALIACAO default values
		END
		SET @CONTADOR = @CONTADOR + 1
	END
end
-- Teste

exec sp_dim_avaliacao'20230101'

select * from DIM_AVALIACAO
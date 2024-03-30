-- Script para povoar a dimensão tempo
use hawkmart
	
CREATE OR ALTER PROCEDURE sp_dim_tempo @DataInicial DATE, @DataFinal DATE AS
BEGIN
	SET NOCOUNT ON 
	PRINT 'Data Inicial: ' + convert(varchar(10),@DataInicial,103)
	PRINT 'Data Final: ' + convert(varchar(10),@DataFinal,103)
	DECLARE @EhFimDeSemana varchar(3),@DiaMesAno varchar(50)
	while (@DataInicial < @DataFinal)
	BEGIN
		IF (DATEPART(WEEKDAY,@dataInicial) IN (1,7))
			SET @EhFimDeSemana = 'SIM'
		else
			SET @EhFimDeSemana = 'NAO'
		IF(DAY(@dataInicial) = 1 and MONTH(@dataInicial) = 1 )
		BEGIN
			SET @DiaMesAno = 'ANO'
		END
		ELSE IF(DAY(@dataInicial) = 1 and MONTH(@dataInicial) > 1 )
		BEGIN
			SET @DiaMesAno = 'MES'
		END
		ELSE
		BEGIN
			SET @DiaMesAno = 'DIA'
		END

		INSERT INTO DIM_TEMPO(
			NIVEL,
			DATA,
			DIA,
			DIA_SEMANA,
			FIM_SEMANA,
			FERIADO,
			FL_FERIADO,
			MES,
			NOME_MES,
			TRIMESTRE,
			NOME_TRIMESTRE,
			SEMESTRE,
			NOME_SEMESTRE,
			ANO
		)
		VALUES(
			@DiaMesAno,
			@DataInicial,
			DAY(@DataInicial),
			DATENAME(WEEKDAY, @DataInicial),
			@EhFimDeSemana,
			NULL,
			'NAO',
			MONTH(@DataInicial),
			DATENAME(MONTH,@DataInicial),
			(MONTH(@DataInicial) -1) / 3 + 1,
			'NOME_TRIMESTRE',
			(MONTH(@DataInicial) -1) / 6 + 1,
			'NOME_SEMESTRE',
			YEAR(@DataInicial)
		)
		SET @DataInicial = DATEADD(DAY,1,@DataInicial)
	END
END
EXEC sp_dim_tempo '2023-01-01','2025-01-01'
select * from dim_tempo

INSERT INTO DIM_FERIADOS(DATA,DESCRICAO,TIPO)VALUES
('2024-01-01','Confraternização Universal','NACIONAL'),
('2024-12-02','Carnaval','NACIONAL'),
('2024-13-02','Carnaval','NACIONAL'),
('2024-23-03','Paixão de Cristo','NACIONAL'),
('2024-21-04','Tiradentes','NACIONAL'),
('2024-01-05','Dia do Trabalho','NACIONAL'),
('2024-30-05','Corpus Christi','NACIONAL'),
('2024-07-09','Independência do Brasil','NACIONAL'),
('2024-12-10','Nossa Sr. Aparecida - Padroeira do Brasil','NACIONAL'),
('2024-02-11','Finados','NACIONAL'),
('2024-15-11','Proclamação da República','NACIONAL'),
('2024-20-11','Dia Nacional de Zumbi e da Consciência Negra','NACIONAL'),
('2024-25-12','Natal','NACIONAL')
select * from DIM_FERIADOS

CREATE OR ALTER PROCEDURE so_atualiza_feriado @ANO INT AS
BEGIN
	update DIM_TEMPO SET FL_FERIADO = 'SIM', FERIADO = f.DESCRICAO
	from DIM_TEMPO t
	inner join DIM_FERIADOS f on (t.DATA = f.DATA)
	where t.ANO = @ANO
END

EXEC so_atualiza_feriado 2024

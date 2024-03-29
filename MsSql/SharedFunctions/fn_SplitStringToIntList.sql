/*
Leleko Nikita 21.03.2014
*/
ALTER FUNCTION [dbo].[fn_SplitStringToIntList]
(
	@String VARCHAR(MAX),
    @Separator CHAR(1) = ','
)
RETURNS @Values TABLE (Value INT NOT NULL) AS
BEGIN
	DECLARE @StringLen		INT = LEN(@String)
	DECLARE @LastIndex		INT = 1;
	DECLARE @CurrentIndex   INT = CHARINDEX(@Separator, @String, @LastIndex);

	WHILE (@CurrentIndex != 0)
	BEGIN
		INSERT INTO @Values(Value) VALUES(CAST(SUBSTRING(@String, @LastIndex, @CurrentIndex - @LastIndex) AS INT));
		SET @LastIndex = @CurrentIndex + 1;
		Set @CurrentIndex = CHARINDEX(@Separator, @String, @LastIndex);
	END;
	IF (@CurrentIndex != @StringLen)
	BEGIN
		INSERT INTO @Values(Value) VALUES(CAST(SUBSTRING(@String, @LastIndex, @StringLen - @LastIndex + 1) AS INT));
	END;
	RETURN;
END;



CREATE PROCEDURE usp_UpdateBalance
(
      @CardNumber NUMERIC(16),
      @NameOnCard VARCHAR(40),
      @CardType CHAR(6),
      @CVVNumber NUMERIC(3),
      @ExpiryDate DATE,
      @Price NUMERIC(8)
) 
AS 
BEGIN
       DECLARE @Balance NUMERIC(8)
BEGIN TRY
       IF( @CardNumber IS NULL)
       BEGIN
          RETURN -1
       END 
       IF NOT EXISTS (SELECT CardNumber FROM CardDetails WHERE CardNumber=@CardNumber)
       BEGIN
          RETURN -2
       END
       IF NOT EXISTS (SELECT NameOnCard FROM CardDetails WHERE NameOnCard=@NameOnCard)
       BEGIN
          RETURN -3
       END
       IF (@NameOnCard IS NULL)
       BEGIN
          RETURN -3
       END
       IF NOT EXISTS (SELECT CardType FROM CardDetails WHERE CardType=@CardType)
       BEGIN
          RETURN -4
       END
       IF (@CardType IS NULL)
       BEGIN
          RETURN -4
       END 
       IF NOT EXISTS (SELECT CVVNumber FROM CardDetails WHERE CVVNumber=@CVVNumber)
       BEGIN
          RETURN -5
       END
       IF (@CVVNumber IS NULL)
       BEGIN
          RETURN -5
       END
       IF NOT EXISTS (SELECT ExpiryDate FROM CardDetails WHERE ExpiryDate=@ExpiryDate)
       BEGIN
          RETURN -6
       END
       IF (@ExpiryDate IS NULL)
       BEGIN
          RETURN -6
       END
       IF (@Price IS NULL)
       BEGIN
          RETURN -7
       END

    
       SELECT @Balance=Balance FROM CardDetails WHERE CardNumber = @CardNumber

       IF @Balance >= @Price
       BEGIN
           UPDATE CardDetails SET Balance = Balance - @Price
              WHERE CardNumber = @CardNumber      
           RETURN 1
       END
       ELSE
       BEGIN
           RETURN -8
       END
       
   END TRY
   BEGIN CATCH
        RETURN -99
   END CATCH 
   
END  
GO




--SELECT * FROM CardDetails



DECLARE @ReturnValue INT
EXEC @ReturnValue = usp_UpdateBalance 1372132080189220, 'Sommer', 'V' ,54, '2031-04-12',556
SELECT @ReturnValue AS Results



--SP_HELPTEXT 'usp_UpdateBalance'
ALTER PROCEDURE usp_AddProduct
(
      @ProductId CHAR(4),
      @ProductName VARCHAR(50),
      @CategoryId TINYINT,
      @Price NUMERIC(8),
      @QuantityAvailable INT
) 
AS 
BEGIN
       DECLARE @Leng INT=4
BEGIN TRY
       IF( @ProductId IS NULL)
       BEGIN
          RETURN -1
       END 
       IF NOT (@ProductId LIKE 'P%')
       BEGIN
          RETURN -2
       END
       IF NOT (@Leng<>LEN('@ProductId'))
       BEGIN
          RETURN -2
       END  
       IF (@ProductName IS NULL)
       BEGIN
          RETURN -3
       END       
        IF (@CategoryId IS NULL)
       BEGIN
          RETURN -4
       END       
       IF NOT EXISTS (SELECT CategoryId FROM Categories WHERE CategoryId=@CategoryId)
       BEGIN
          RETURN -5
       END
       IF (@Price <=0 OR @Price IS NULL)
       BEGIN
          RETURN -6
       END       
       IF (@QuantityAvailable <=0 OR @QuantityAvailable IS NULL)
       BEGIN
          RETURN -6
       END       
       
       BEGIN
           INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable)
               VALUES (@ProductId,@ProductName, @CategoryId,@Price,@QuantityAvailable)
           RETURN 1
       END
       
   END TRY
   BEGIN CATCH
        RETURN -99
   END CATCH 
   
END  
GO




--SELECT * FROM Products



DECLARE @ReturnValue INT
EXEC @ReturnValue = usp_AddProduct 'P595', 'shoes',8, 2500, 2
SELECT @ReturnValue AS Results


--SELECT * FROM Products

--SP_HELPTEXT 'usp_AddProduct'
BEGIN
DECLARE @ProductId CHAR(4)='P392',@ProductName VARCHAR(50)='ppd',@CategoryId TINYINT=8,@Price NUMERIC(8)=550,
        @QuantityAvailable INT=50
BEGIN TRY
    IF @ProductId=NULL
     BEGIN
        PRINT -1
        RETURN
     END
    IF @ProductName=NULL
     BEGIN
        PRINT -2
        RETURN
     END
    IF @CategoryId=NULL
     BEGIN
        PRINT -3
        RETURN
     END
    IF @Price=NULL
     BEGIN
        PRINT -4
        RETURN
     END
    IF @QuantityAvailable=NULL
     BEGIN
        PRINT -5
        RETURN
     END
    IF NOT (@ProductId LIKE 'P%'AND len(@ProductId)=4)
     BEGIN
        PRINT -6
        RETURN
     END 
    IF (@CategoryId<1 AND @CategoryId>7)
     BEGIN
        PRINT -7
        RETURN 
     END
    IF @Price <= 0
     BEGIN
        PRINT -8
        RETURN
     END
    IF @QuantityAvailable <= 0
     BEGIN
        PRINT -9
        RETURN
     END
     
      IF EXISTS (SELECT CategoryId FROM Products WHERE CategoryId=@CategoryId) 
      BEGIN
        INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable)
                VALUES (@ProductId,@ProductName,   
                       @CategoryId,@Price,@QuantityAvailable) 
         PRINT 1 
         RETURN
      END
      ELSE 
      BEGIN
         PRINT 'CategoryId donot exist'
         RETURN
      END  
END TRY 
BEGIN CATCH 
   PRINT -99   
   SELECT ERROR_NUMBER() AS ErrorNumber,         
          ERROR_LINE() AS LineNumber,    
          ERROR_MESSAGE() AS ErrorMessage
END CATCH 
END


--SELECT * FROM Products

-- UPDATE CardDetails
-- SET Balance=500000
-- WHERE CardNumber=2122490035590690
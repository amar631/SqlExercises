CREATE PROCEDURE usp_InsertPurchaseDetails
(
      @EmailId VARCHAR(50),
      @CardNumber NUMERIC(16),
      @ProductId CHAR(4),
      @QtyPurchased INT,
      @PurchaseId BIGINT OUT
)
AS
BEGIN
       DECLARE @Price NUMERIC(8), @Amount NUMERIC(8), @Balance NUMERIC(8),
               @TotalAmount INT

BEGIN TRY
       IF NOT EXISTS (SELECT ProductId FROM Products WHERE ProductId=@ProductId)
       BEGIN
          RETURN -1
       END
       IF NOT EXISTS (SELECT EmailId FROM Users WHERE EmailId=@EmailId)
       BEGIN
          RETURN -2
       END
       IF @QtyPurchased <= 0
       BEGIN
         RETURN -3
       END
       IF NOT EXISTS (SELECT CardNumber FROM CardDetails WHERE CardNumber=@CardNumber)
       BEGIN
          RETURN -4
       END
       -- Getting price of the products
       SELECT @Price = Price FROM Products WHERE ProductId = @ProductId
       -- Getting the available balance
       SELECT @Balance=Balance FROM CardDetails WHERE CardNumber = @CardNumber
       -- Calculating the bill amount
       SET @Amount = @QtyPurchased * @Price
       IF @Balance >= @Amount
       BEGIN
         BEGIN TRAN
           UPDATE CardDetails SET Balance = Balance - @Amount
              WHERE CardNumber = @CardNumber      
           -- Insert PurchaseDetails
           INSERT INTO PurchaseDetails(EmailId,ProductId,QuantityPurchased,DateOfPurchase)
               VALUES (@EmailId,@ProductId, @QtyPurchased,CAST(GETDATE() AS DATE))
           --Update the Quantity Available
           UPDATE Products
           SET QuantityAvailable = QuantityAvailable - @QtyPurchased
           WHERE ProductId = @ProductId
           SET @PurchaseId = IDENT_CURRENT('PurchaseDetails') -- Fetches the maximum
                                                              -- value for the Identity
                                                              -- column in the given table
           COMMIT       
           RETURN 1
       END
       ELSE
       BEGIN
           RETURN -5
       END
   END TRY
   BEGIN CATCH
       -- Displaying some user-friendly error message:
       ROLLBACK
       RETURN -99
   END CATCH
END
GO -- To end the stored procedure







DECLARE @ReturnValue INT, @PurchaseId BIGINT
EXEC @ReturnValue = usp_InsertPurchaseDetails 'Margaret@gmail.com',2208687402112480, 'P107', 2, @PurchaseId OUT
SELECT @ReturnValue AS ReturnValue, @PurchaseId AS PurchaseId

CREATE SEQUENCE Purchase_Sequence  -- Creates a sequence with default values
SELECT * FROM sys.sequences WHERE name = 'Purchase_Sequence'
SELECT NEXT VALUE FOR Purchase_Sequence 
           AS Next_Value -- NEXT VALUE FOR is used to fetch the next value 
                         -- for the given sequence
SELECT NEXT VALUE FOR Purchase_Sequence AS Next_Value 
SELECT name,start_value,increment,minimum_value,maximum_value,current_value 
            FROM sys.sequences WHERE name = 'Purchase_Sequence'
DROP SEQUENCE Purchase_Sequence

CREATE SEQUENCE Purchase_Sequence
     AS INT          -- To declare the data type as INT
     START WITH 10   -- Gives the start value of the sequence(column start_value) 
                     -- in the range of INT data type.
     INCREMENT BY 1  --This value(column increment) can be any integer(1, 2, 3 etc.).
                     -- For a decrementing sequence, use a negative value (-1,-2 etc.)
GO
SELECT name,start_value,increment,minimum_value,maximum_value,current_value 
            FROM sys.sequences WHERE name = 'Purchase_Sequence'

ALTER SEQUENCE Purchase_Sequence
    MINVALUE 1        -- Gives the minimum value that the sequence can 
                      --  contain(column minimum_value) in range of INT datatype
    MAXVALUE 5000  -- Gives the maximum value that the sequence can 
                      --  contain(column maximum_value) in range of INT datatype
GO


SELECT name,start_value,increment,minimum_value,maximum_value,current_value 
       FROM sys.sequences WHERE name = 'Purchase_Sequence'


ALTER SEQUENCE Purchase_Sequence
    CYCLE  -- To generate a cycle for sequence(column is_cycling). 
               --  If cycle is not required, this property can be ignored 
               --  as the default behaviour of sequences is NO CYCLE.
GO


SELECT name,is_cycling,start_value,increment,minimum_value,maximum_value,current_value 
       FROM sys.sequences WHERE name = 'Purchase_Sequence'


ALTER SEQUENCE Purchase_Sequence
    CACHE 50  -- Specifies a cache memory of 50 for the sequence(column is_cached).
              -- If caching is not required, this property is set to NO CACHE. By default, 
              -- sequences have caching enabled with cache size as NULL.
GO


SELECT name, is_cached, cache_size FROM sys.sequences 
            WHERE name = 'Purchase_Sequence'


CREATE TABLE PurchaseDetailsIndia
(
   [PurchaseId] INT,
   [EmailId] VARCHAR(50) CONSTRAINT fk_EmailId_PurchaseDetailsIndia REFERENCES Users(EmailId),
   [ProductId] CHAR(4) CONSTRAINT fk_ProductId_PurchaseDetailsIndia REFERENCES Products(ProductId),
   [QuantityPurchased] SMALLINT CONSTRAINT chk_QuantityPurchased_PurchaseDetailsIndia 
                       CHECK(QuantityPurchased>0) NOT NULL,  
   [DateOfPurchase] SMALLDATETIME CONSTRAINT chk_DateOfPurchase_PurchaseDetailsIndia 
                    CHECK(DateOfPurchase<=GETDATE()) DEFAULT GETDATE() NOT NULL
)
GO
CREATE TABLE PurchaseDetailsUK
(
    [PurchaseId] INT,
    [EmailId] VARCHAR(50) CONSTRAINT fk_EmailId_PurchaseDetailsUK REFERENCES Users(EmailId),
    [ProductId] CHAR(4) CONSTRAINT fk_ProductId_PurchaseDetailsUK REFERENCES Products(ProductId),
    [QuantityPurchased] SMALLINT CONSTRAINT chk_QuantityPurchased_PurchaseDetailsUK 
                        CHECK(QuantityPurchased>0) NOT NULL,  
    [DateOfPurchase] SMALLDATETIME CONSTRAINT chk_DateOfPurchase_PurchaseDetailsUK 
                     CHECK(DateOfPurchase<=GETDATE()) DEFAULT GETDATE() NOT NULL
)
GO



INSERT INTO PurchaseDetailsIndia VALUES
(NEXT VALUE FOR Purchase_Sequence,'Franken@gmail.com','P101',2,'Jan 12 2014 12:00PM')
INSERT INTO PurchaseDetailsUK VALUES
(NEXT VALUE FOR Purchase_Sequence,'Albert@gmail.com','P143',1,'Jan 13 2014 12:01PM')
INSERT INTO PurchaseDetailsIndia VALUES
(NEXT VALUE FOR Purchase_Sequence,'Franken@gmail.com','P112',3,'Jan 14 2014 12:02PM')


SELECT PurchaseId FROM PurchaseDetailsIndia


SELECT PurchaseId FROM PurchaseDetailsUK

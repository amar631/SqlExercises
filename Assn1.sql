CREATE TABLE Roles
(
    RoleId INT IDENTITY CONSTRAINT pk_RoleId PRIMARY KEY ,
    RoleName VARCHAR(50) CONSTRAINT uq_RoleName UNIQUE NOT NULL
)
GO


--DROP TABLE Credentials


/*

CREATE TABLE Credentials
(
    [CredentialId] INT CONSTRAINT pk_CredentialId PRIMARY KEY IDENTITY NOT NULL,
    [UserName] VARCHAR(20) NOT NULL,
    [UserPassword] VARCHAR(20) NOT NULL  ,
    [RoleId] TINYINT CONSTRAINT fk_RoleId_Credentials REFERENCES Roles(RoleId),
    [EmailId] VARCHAR(50),
    CONSTRAINT chk_constraint CHECK (UserPassword <> UserName),
    CONSTRAINT uq_UserName_UserPassword PRIMARY KEY  (UserPassword,UserName)(UserPassword <> UserName),

)
GO
*/

CREATE TABLE Credentials2
(
    [CredentialId] INT  IDENTITY NOT NULL,
    [UserName] VARCHAR(20) NOT NULL,
    [UserPassword] VARCHAR(20) NOT NULL  ,
    [RoleId] TINYINT CONSTRAINT fk_RoleId_Credentials1 REFERENCES Roles(RoleId),
    [EmailId] VARCHAR(50),
    CONSTRAINT chk_constraint2 CHECK (UserPassword <> UserName),
    CONSTRAINT uq_UserName_UserPassword PRIMARY KEY  (UserPassword,UserName) ,  --(UserPassword <> UserName)

)
GO





CREATE TABLE BranchDetails
(
    [BranchId] INT IDENTITY(1000,1) NOT NULL,
    [BranchName] VARCHAR(50) CONSTRAINT uq_BranchName UNIQUE NOT NULL,
    [District] VARCHAR(50) NOT NULL,
    [State] VARCHAR(50) NOT NULL,
    [Country] VARCHAR(50) NOT NULL,
    [BranchManagerId] INT CONSTRAINT fk_BranchManagerId_BranchDetails REFERENCES Credentials(CredentialId),
)
GO







CREATE TABLE Customers
(
    [CustId] INT IDENTITY(1000,1) NOT NULL,
    [Gender] CHAR(1) NOT NULL,
    [PhoneNumber] NUMERIC(10) CONSTRAINT chk_PhoneNumber CHECK (len(PhoneNumber) = 10) NOT NULL,
    [AddressLine1] VARCHAR(50) NOT NULL,
    [City] VARCHAR(50) NOT NULL,
    [State] VARCHAR(50) NOT NULL,
    [Country] VARCHAR(50) NOT NULL,
    [PinNumber] BIGINT NOT NULL,
    [CredentialId] INT CONSTRAINT fk_CredentialId_Customers REFERENCES Credentials(CredentialId),
    [FirstName] VARCHAR(20),
    [LastName] VARCHAR(20),
)
GO













SET IDENTITY_INSERT [Roles] ON 
GO
INSERT [Roles] ([RoleId], [RoleName]) VALUES (1, N'BranchManager')
INSERT [Roles] ([RoleId], [RoleName]) VALUES (2, N'Customer')
SET IDENTITY_INSERT [Roles] OFF
GO

SET IDENTITY_INSERT [Credentials] ON 
GO
INSERT [Credentials] ([CredentialId], [UserName], [UserPassword], [RoleId], [EmailId]) VALUES (1, N'Eric_Hector', N'Insyst@123', 1, N'Eric_Hector@Insyst.com.com')
INSERT [Credentials] ([CredentialId], [UserName], [UserPassword], [RoleId], [EmailId]) VALUES (2, N'Thomas_Edison', N'Insyst@123', 2, N'Thomas_Edison@gmail.com')
INSERT [Credentials] ([CredentialId], [UserName], [UserPassword], [RoleId], [EmailId]) VALUES (3, N'Albert_Styene', N'Insyst@123', 2, N'Albert_Styene@gmail.com')
INSERT [Credentials] ([CredentialId], [UserName], [UserPassword], [RoleId], [EmailId]) VALUES (4, N'Kevin_Pitersen', N'Insyst@123', 2, N'Kevin_Pitersen@gmail.com')
INSERT [Credentials] ([CredentialId], [UserName], [UserPassword], [RoleId], [EmailId]) VALUES (5, N'Henna_Brown', N'Insyst@123', 2, N'Henna_Brown@gmail.com')
INSERT [Credentials] ([CredentialId], [UserName], [UserPassword], [RoleId], [EmailId]) VALUES (6, N'Marget_Brown', N'Insyst@1234', 2, N'Marget_Brown@gmail.com')
SET IDENTITY_INSERT [Credentials] OFF
GO

SET IDENTITY_INSERT [BranchDetails] ON 
GO
INSERT [BranchDetails] ([BranchId], [BranchName], [District], [State], [Country], [BranchManagerId]) VALUES (1000, N'Infosys', N'Mysore', N'Karnataka', N'India', 1)
INSERT [BranchDetails] ([BranchId], [BranchName], [District], [State], [Country], [BranchManagerId]) VALUES (1001, N'Choultry', N'Mysore', N'Karnataka', N'India', NULL)
INSERT [BranchDetails] ([BranchId], [BranchName], [District], [State], [Country], [BranchManagerId]) VALUES (1002, N'Electronic City', N'Bangalore', N'Karnataka', N'India', NULL)
SET IDENTITY_INSERT [BranchDetails] OFF
GO

SET IDENTITY_INSERT [Customers] ON 
GO
INSERT [Customers] ([CustId], [Gender], [PhoneNumber], [AddressLine1], [City], [State], [Country], [PinNumber], [CredentialId], [FirstName], [LastName]) VALUES (1000, N'M', CAST(1231231231 AS Numeric(10, 0)), N'Baker Street', N'London', N'London', N'UK', 987091, 2, N'Thomas', N'Edison')
INSERT [Customers] ([CustId], [Gender], [PhoneNumber], [AddressLine1], [City], [State], [Country], [PinNumber], [CredentialId], [FirstName], [LastName]) VALUES (1001, N'M', CAST(8050658872 AS Numeric(10, 0)), N'Rich Street', N'Bangalore', N'Karnataka', N'India', 560054, 4, N'Kevin', N'Pitersen')
INSERT [Customers] ([CustId], [Gender], [PhoneNumber], [AddressLine1], [City], [State], [Country], [PinNumber], [CredentialId], [FirstName], [LastName]) VALUES (1002, N'F', CAST(7272727272 AS Numeric(10, 0)), N'Hebbal', N'Mysore', N'Karnataka', N'India', 570096, 6, N'Margaret', N'Brown')
INSERT [Customers] ([CustId], [Gender], [PhoneNumber], [AddressLine1], [City], [State], [Country], [PinNumber], [CredentialId], [FirstName], [LastName]) VALUES (1003, N'F', CAST(7445678956 AS Numeric(10, 0)), N'Hebbal 3rd stage ', N'Bangalore', N'Karnataka', N'India', 560021, 5, N'Henna', N'Brown')
INSERT [Customers] ([CustId], [Gender], [PhoneNumber], [AddressLine1], [City], [State], [Country], [PinNumber], [CredentialId], [FirstName], [LastName]) VALUES (1004, N'M', CAST(6578456756 AS Numeric(10, 0)), N'Electronic city', N'Mysore', N'Karnataka', N'India', 560034, 3, N'Albert', N'Steyne')
SET IDENTITY_INSERT [Customers] OFF
GO




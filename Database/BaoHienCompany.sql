/****** Object:  ForeignKey [FK_Bill_Customer]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bill_Customer]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bill]'))
ALTER TABLE [dbo].[Bill] DROP CONSTRAINT [FK_Bill_Customer]
GO
/****** Object:  ForeignKey [FK_Bill_SystemUser]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bill_SystemUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bill]'))
ALTER TABLE [dbo].[Bill] DROP CONSTRAINT [FK_Bill_SystemUser]
GO
/****** Object:  ForeignKey [FK_Customer_Employee]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Customer_Employee]') AND parent_object_id = OBJECT_ID(N'[dbo].[Customer]'))
ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [FK_Customer_Employee]
GO
/****** Object:  ForeignKey [FK_EntranceStock_SystemUser]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EntranceStock_SystemUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[EntranceStock]'))
ALTER TABLE [dbo].[EntranceStock] DROP CONSTRAINT [FK_EntranceStock_SystemUser]
GO
/****** Object:  ForeignKey [FK_MaterialInStock_BaseAttribute]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MaterialInStock_BaseAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[MaterialInStock]'))
ALTER TABLE [dbo].[MaterialInStock] DROP CONSTRAINT [FK_MaterialInStock_BaseAttribute]
GO
/****** Object:  ForeignKey [FK_MaterialInStock_Product]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MaterialInStock_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[MaterialInStock]'))
ALTER TABLE [dbo].[MaterialInStock] DROP CONSTRAINT [FK_MaterialInStock_Product]
GO
/****** Object:  ForeignKey [FK_Order_Customer]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Order_Customer]') AND parent_object_id = OBJECT_ID(N'[dbo].[Order]'))
ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK_Order_Customer]
GO
/****** Object:  ForeignKey [FK_Order_SystemUser]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Order_SystemUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[Order]'))
ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK_Order_SystemUser]
GO
/****** Object:  ForeignKey [FK_OrderDetail_BaseAttribute]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderDetail_BaseAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderDetail]'))
ALTER TABLE [dbo].[OrderDetail] DROP CONSTRAINT [FK_OrderDetail_BaseAttribute]
GO
/****** Object:  ForeignKey [FK_OrderDetail_Order]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderDetail_Order]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderDetail]'))
ALTER TABLE [dbo].[OrderDetail] DROP CONSTRAINT [FK_OrderDetail_Order]
GO
/****** Object:  ForeignKey [FK_OrderDetail_Product]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderDetail_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderDetail]'))
ALTER TABLE [dbo].[OrderDetail] DROP CONSTRAINT [FK_OrderDetail_Product]
GO
/****** Object:  ForeignKey [FK_Price_Product]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Price_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[Price]'))
ALTER TABLE [dbo].[Price] DROP CONSTRAINT [FK_Price_Product]
GO
/****** Object:  ForeignKey [FK_Product_MeasurementUnit]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Product_MeasurementUnit]') AND parent_object_id = OBJECT_ID(N'[dbo].[Product]'))
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Product_MeasurementUnit]
GO
/****** Object:  ForeignKey [FK_Product_ProductType]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Product_ProductType]') AND parent_object_id = OBJECT_ID(N'[dbo].[Product]'))
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Product_ProductType]
GO
/****** Object:  ForeignKey [FK_ProductAttribute_Attribute]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductAttribute_Attribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductAttribute]'))
ALTER TABLE [dbo].[ProductAttribute] DROP CONSTRAINT [FK_ProductAttribute_Attribute]
GO
/****** Object:  ForeignKey [FK_ProductAttribute_Product]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductAttribute_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductAttribute]'))
ALTER TABLE [dbo].[ProductAttribute] DROP CONSTRAINT [FK_ProductAttribute_Product]
GO
/****** Object:  ForeignKey [FK_ProductInStock_BaseAttribute]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductInStock_BaseAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductInStock]'))
ALTER TABLE [dbo].[ProductInStock] DROP CONSTRAINT [FK_ProductInStock_BaseAttribute]
GO
/****** Object:  ForeignKey [FK_ProductInStock_Product]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductInStock_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductInStock]'))
ALTER TABLE [dbo].[ProductInStock] DROP CONSTRAINT [FK_ProductInStock_Product]
GO
/****** Object:  ForeignKey [FK_ProductionRequest_SystemUser]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductionRequest_SystemUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRequest]'))
ALTER TABLE [dbo].[ProductionRequest] DROP CONSTRAINT [FK_ProductionRequest_SystemUser]
GO
/****** Object:  ForeignKey [FK_ProductionRequestDetail_BaseAttribute]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductionRequestDetail_BaseAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRequestDetail]'))
ALTER TABLE [dbo].[ProductionRequestDetail] DROP CONSTRAINT [FK_ProductionRequestDetail_BaseAttribute]
GO
/****** Object:  ForeignKey [FK_ProductionRequestDetail_Product]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductionRequestDetail_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRequestDetail]'))
ALTER TABLE [dbo].[ProductionRequestDetail] DROP CONSTRAINT [FK_ProductionRequestDetail_Product]
GO
/****** Object:  ForeignKey [FK_ProductionRequestDetail_ProductionRequest]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductionRequestDetail_ProductionRequest]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRequestDetail]'))
ALTER TABLE [dbo].[ProductionRequestDetail] DROP CONSTRAINT [FK_ProductionRequestDetail_ProductionRequest]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderDetail]') AND type in (N'U'))
DROP TABLE [dbo].[OrderDetail]
GO
/****** Object:  Table [dbo].[Price]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Price]') AND type in (N'U'))
DROP TABLE [dbo].[Price]
GO
/****** Object:  Table [dbo].[ProductionRequestDetail]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductionRequestDetail]') AND type in (N'U'))
DROP TABLE [dbo].[ProductionRequestDetail]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Bill]') AND type in (N'U'))
DROP TABLE [dbo].[Bill]
GO
/****** Object:  Table [dbo].[MaterialInStock]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MaterialInStock]') AND type in (N'U'))
DROP TABLE [dbo].[MaterialInStock]
GO
/****** Object:  Table [dbo].[ProductAttribute]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductAttribute]') AND type in (N'U'))
DROP TABLE [dbo].[ProductAttribute]
GO
/****** Object:  Table [dbo].[ProductInStock]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductInStock]') AND type in (N'U'))
DROP TABLE [dbo].[ProductInStock]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Order]') AND type in (N'U'))
DROP TABLE [dbo].[Order]
GO
/****** Object:  Table [dbo].[ProductionRequest]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductionRequest]') AND type in (N'U'))
DROP TABLE [dbo].[ProductionRequest]
GO
/****** Object:  Table [dbo].[EntranceStock]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntranceStock]') AND type in (N'U'))
DROP TABLE [dbo].[EntranceStock]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customer]') AND type in (N'U'))
DROP TABLE [dbo].[Customer]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Product]') AND type in (N'U'))
DROP TABLE [dbo].[Product]
GO
/****** Object:  Table [dbo].[ProductType]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductType]') AND type in (N'U'))
DROP TABLE [dbo].[ProductType]
GO
/****** Object:  StoredProcedure [dbo].[sp_GenerateRandomString]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_GenerateRandomString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_GenerateRandomString]
GO
/****** Object:  StoredProcedure [dbo].[StoredProcedure1]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StoredProcedure1]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[StoredProcedure1]
GO
/****** Object:  Table [dbo].[SystemUser]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemUser]') AND type in (N'U'))
DROP TABLE [dbo].[SystemUser]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employee]') AND type in (N'U'))
DROP TABLE [dbo].[Employee]
GO
/****** Object:  Table [dbo].[BaseAttribute]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BaseAttribute]') AND type in (N'U'))
DROP TABLE [dbo].[BaseAttribute]
GO
/****** Object:  Table [dbo].[EntranceStockDetail]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntranceStockDetail]') AND type in (N'U'))
DROP TABLE [dbo].[EntranceStockDetail]
GO
/****** Object:  StoredProcedure [dbo].[GenerateRandomString]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GenerateRandomString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GenerateRandomString]
GO
/****** Object:  Table [dbo].[Liability]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Liability]') AND type in (N'U'))
DROP TABLE [dbo].[Liability]
GO
/****** Object:  Table [dbo].[MeasurementUnit]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MeasurementUnit]') AND type in (N'U'))
DROP TABLE [dbo].[MeasurementUnit]
GO
/****** Object:  Default [DF_Customer_Status]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Customer_Status]') AND parent_object_id = OBJECT_ID(N'[dbo].[Customer]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Customer_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [DF_Customer_Status]
END


End
GO
/****** Object:  Default [DF_Order_VAT]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Order_VAT]') AND parent_object_id = OBJECT_ID(N'[dbo].[Order]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Order_VAT]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Order] DROP CONSTRAINT [DF_Order_VAT]
END


End
GO
/****** Object:  Default [DF_ProductionRequestDetail_Direction]    Script Date: 08/31/2012 01:04:16 ******/
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ProductionRequestDetail_Direction]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRequestDetail]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ProductionRequestDetail_Direction]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ProductionRequestDetail] DROP CONSTRAINT [DF_ProductionRequestDetail_Direction]
END


End
GO
/****** Object:  Table [dbo].[MeasurementUnit]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MeasurementUnit]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MeasurementUnit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UnitCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_MeasurementUnit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
SET IDENTITY_INSERT [dbo].[MeasurementUnit] ON
INSERT [dbo].[MeasurementUnit] ([Id], [Name], [Description], [UnitCode]) VALUES (1, N'Cu?n', N'', N'Cuon')
INSERT [dbo].[MeasurementUnit] ([Id], [Name], [Description], [UnitCode]) VALUES (2, N'Thanh', N'', N'Thanh')
INSERT [dbo].[MeasurementUnit] ([Id], [Name], [Description], [UnitCode]) VALUES (3, N'Kg', N'Kilogam', N'Kg')
SET IDENTITY_INSERT [dbo].[MeasurementUnit] OFF
/****** Object:  Table [dbo].[Liability]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Liability]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Liability](
	[LiabilityID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Id] [int] NOT NULL,
	[Code] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Debit] [float] NULL,
	[Credit] [float] NULL,
	[Type] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_Liability] PRIMARY KEY CLUSTERED 
(
	[LiabilityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateRandomString]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GenerateRandomString]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GenerateRandomString]
(
    @Length int
)

AS

DECLARE @RandomID varchar(32)
DECLARE @counter smallint
DECLARE @RandomNumber float
DECLARE @RandomNumberInt tinyint
DECLARE @CurrentCharacter varchar(1)
DECLARE @ValidCharacters varchar(255)
SET @ValidCharacters = ''ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-=+&$''
DECLARE @ValidCharactersLength int
SET @ValidCharactersLength = len(@ValidCharacters)
SET @CurrentCharacter = ''''
SET @RandomNumber = 0
SET @RandomNumberInt = 0
SET @RandomID = ''''

SET NOCOUNT ON

SET @counter = 1

WHILE @counter < (@Length + 1)

BEGIN

        SET @RandomNumber = Rand()
        SET @RandomNumberInt = Convert(tinyint, ((@ValidCharactersLength - 1) * @RandomNumber + 1))

        SELECT @CurrentCharacter = SUBSTRING(@ValidCharacters, @RandomNumberInt, 1)

        SET @counter = @counter + 1

        SET @RandomID = @RandomID + @CurrentCharacter

END

SELECT @RandomID AS ''RandomString''
' 
END
GO
/****** Object:  Table [dbo].[EntranceStockDetail]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntranceStockDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EntranceStockDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EntranceStockId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[AttributeId] [int] NOT NULL,
	[NumberUnit] [int] NOT NULL,
	[Note] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_EntranceStockDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
SET IDENTITY_INSERT [dbo].[EntranceStockDetail] ON
INSERT [dbo].[EntranceStockDetail] ([Id], [EntranceStockId], [ProductId], [AttributeId], [NumberUnit], [Note]) VALUES (1, 2, 10, 2, 23, N'3')
SET IDENTITY_INSERT [dbo].[EntranceStockDetail] OFF
/****** Object:  Table [dbo].[BaseAttribute]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BaseAttribute]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BaseAttribute](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AttributeName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AttributeCode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Attribute] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
SET IDENTITY_INSERT [dbo].[BaseAttribute] ON
INSERT [dbo].[BaseAttribute] ([Id], [AttributeName], [Description], [AttributeCode]) VALUES (1, N'Dài', N'Chi?u dài cho phép', N'QCD')
INSERT [dbo].[BaseAttribute] ([Id], [AttributeName], [Description], [AttributeCode]) VALUES (2, N'20cmx600m', N'20cmx600m', N'20cmx600m')
INSERT [dbo].[BaseAttribute] ([Id], [AttributeName], [Description], [AttributeCode]) VALUES (3, N'55cmx800m', N'55cmx800m', N'55cmx800m')
INSERT [dbo].[BaseAttribute] ([Id], [AttributeName], [Description], [AttributeCode]) VALUES (4, N'500ml', N'500ml', N'500ml')
INSERT [dbo].[BaseAttribute] ([Id], [AttributeName], [Description], [AttributeCode]) VALUES (5, N'AB123', N'AB123', N'AB123')
INSERT [dbo].[BaseAttribute] ([Id], [AttributeName], [Description], [AttributeCode]) VALUES (6, N'1m2x800m', N'1m2x800m', N'1m2x800m')
SET IDENTITY_INSERT [dbo].[BaseAttribute] OFF
/****** Object:  Table [dbo].[Employee]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FullName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[NickName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Address] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Phone] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MobilePhone] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Type] [smallint] NOT NULL,
	[Description] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Status] [tinyint] NULL,
	[Email] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
SET IDENTITY_INSERT [dbo].[Employee] ON
INSERT [dbo].[Employee] ([Id], [Code], [FullName], [NickName], [Address], [Phone], [MobilePhone], [Type], [Description], [Status], [Email]) VALUES (1, N'Sale001', N'Pham Duc Hung', N'Bryan', N'loremp ipsum', NULL, N'0909282105', 0, N'something', NULL, N'')
SET IDENTITY_INSERT [dbo].[Employee] OFF
/****** Object:  Table [dbo].[SystemUser]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SystemUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[password] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Status] [tinyint] NULL,
	[Type] [smallint] NOT NULL,
	[FullName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
SET IDENTITY_INSERT [dbo].[SystemUser] ON
INSERT [dbo].[SystemUser] ([Id], [username], [password], [Status], [Type], [FullName]) VALUES (1, N'bryanpham85', N'system123', 1, 1, N'Phạm Đức Hùng')
INSERT [dbo].[SystemUser] ([Id], [username], [password], [Status], [Type], [FullName]) VALUES (2, N'bryanpham1', N'system123', 1, 2, N'Pham Duc Hung')
INSERT [dbo].[SystemUser] ([Id], [username], [password], [Status], [Type], [FullName]) VALUES (3, N'admin', N'123456', NULL, 2, N'Adnimistrator')
SET IDENTITY_INSERT [dbo].[SystemUser] OFF
/****** Object:  StoredProcedure [dbo].[StoredProcedure1]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StoredProcedure1]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[StoredProcedure1]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GenerateRandomString]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_GenerateRandomString]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_GenerateRandomString]
(
    @Length int
)

AS

DECLARE @RandomID varchar(32)
DECLARE @counter smallint
DECLARE @RandomNumber float
DECLARE @RandomNumberInt tinyint
DECLARE @CurrentCharacter varchar(1)
DECLARE @ValidCharacters varchar(255)
SET @ValidCharacters = ''ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-=+&$''
DECLARE @ValidCharactersLength int
SET @ValidCharactersLength = len(@ValidCharacters)
SET @CurrentCharacter = ''''
SET @RandomNumber = 0
SET @RandomNumberInt = 0
SET @RandomID = ''''

SET NOCOUNT ON

SET @counter = 1

WHILE @counter < (@Length + 1)

BEGIN

        SET @RandomNumber = Rand()
        SET @RandomNumberInt = Convert(tinyint, ((@ValidCharactersLength - 1) * @RandomNumber + 1))

        SELECT @CurrentCharacter = SUBSTRING(@ValidCharacters, @RandomNumberInt, 1)

        SET @counter = @counter + 1

        SET @RandomID = @RandomID + @CurrentCharacter

END

SELECT @RandomID AS ''RandomString''
' 
END
GO
/****** Object:  Table [dbo].[ProductType]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProductType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TypeCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Status] [tinyint] NULL,
 CONSTRAINT [PK_ProductType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
SET IDENTITY_INSERT [dbo].[ProductType] ON
INSERT [dbo].[ProductType] ([Id], [ProductName], [Description], [TypeCode], [Status]) VALUES (1, N'Decal 1', N'Something ', N'DC', NULL)
INSERT [dbo].[ProductType] ([Id], [ProductName], [Description], [TypeCode], [Status]) VALUES (3, N'Silicon', N'          ', N'SLC', NULL)
INSERT [dbo].[ProductType] ([Id], [ProductName], [Description], [TypeCode], [Status]) VALUES (4, N'Keo ky''', N'ban theo ky', N'SLCKg', NULL)
SET IDENTITY_INSERT [dbo].[ProductType] OFF
/****** Object:  Table [dbo].[Product]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Product]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ProductName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BaseUnit] [int] NULL,
	[ProductType] [int] NOT NULL,
	[Status] [tinyint] NULL,
	[Direction] [tinyint] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'Product', N'COLUMN',N'BaseUnit'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Don vi tinh co ban' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'BaseUnit'
GO
SET IDENTITY_INSERT [dbo].[Product] ON
INSERT [dbo].[Product] ([Id], [ProductCode], [ProductName], [Description], [BaseUnit], [ProductType], [Status], [Direction]) VALUES (1, N'', N'Decal Mau den', N'something', 1, 1, NULL, NULL)
INSERT [dbo].[Product] ([Id], [ProductCode], [ProductName], [Description], [BaseUnit], [ProductType], [Status], [Direction]) VALUES (2, N'', N'Decal mau den', N'dfsafsfsafsdafs', 1, 1, NULL, NULL)
INSERT [dbo].[Product] ([Id], [ProductCode], [ProductName], [Description], [BaseUnit], [ProductType], [Status], [Direction]) VALUES (3, N'', N'Trang Sua (caro) 60cm 200m', N'somehitn note', NULL, 1, NULL, NULL)
INSERT [dbo].[Product] ([Id], [ProductCode], [ProductName], [Description], [BaseUnit], [ProductType], [Status], [Direction]) VALUES (4, N'DCTrangSua', N'Mau trang', N'loremp ipsum', 1, 1, NULL, NULL)
INSERT [dbo].[Product] ([Id], [ProductCode], [ProductName], [Description], [BaseUnit], [ProductType], [Status], [Direction]) VALUES (5, N'Mauden_to', N'Mau den', N'safdfsfd', 1, 1, NULL, NULL)
INSERT [dbo].[Product] ([Id], [ProductCode], [ProductName], [Description], [BaseUnit], [ProductType], [Status], [Direction]) VALUES (6, N'fafdfs', N'fsfsfsfsf', N'fsfsfdfsdfsafsdf', 1, 1, 3, NULL)
INSERT [dbo].[Product] ([Id], [ProductCode], [ProductName], [Description], [BaseUnit], [ProductType], [Status], [Direction]) VALUES (7, N'safsdfd', N'fsafsf', N'fafdsfsfd', 1, 1, NULL, NULL)
INSERT [dbo].[Product] ([Id], [ProductCode], [ProductName], [Description], [BaseUnit], [ProductType], [Status], [Direction]) VALUES (8, N'fsafd', N'safsdafsfd', N'fsafsfafds', 2, 3, NULL, NULL)
INSERT [dbo].[Product] ([Id], [ProductCode], [ProductName], [Description], [BaseUnit], [ProductType], [Status], [Direction]) VALUES (9, N'12345', N'Delcal trang', N'safsdfsafsdfsd', 2, 1, NULL, NULL)
INSERT [dbo].[Product] ([Id], [ProductCode], [ProductName], [Description], [BaseUnit], [ProductType], [Status], [Direction]) VALUES (10, N'1232132', N'San pham chuan', N'eqewqeqwewq', 2, 1, NULL, NULL)
INSERT [dbo].[Product] ([Id], [ProductCode], [ProductName], [Description], [BaseUnit], [ProductType], [Status], [Direction]) VALUES (11, N'Decal_Do', N'Decal mau do', N'Decal mau do choi', 1, 1, NULL, NULL)
INSERT [dbo].[Product] ([Id], [ProductCode], [ProductName], [Description], [BaseUnit], [ProductType], [Status], [Direction]) VALUES (12, N'1234', N'Keo ky dinh chac', N'', 3, 4, NULL, NULL)
INSERT [dbo].[Product] ([Id], [ProductCode], [ProductName], [Description], [BaseUnit], [ProductType], [Status], [Direction]) VALUES (13, N'', N'', N'', 1, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Product] OFF
/****** Object:  Table [dbo].[Customer]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CustCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Address] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Phone] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BankAcc] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BankName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ContactPerson] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ContactPersonPhone] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ContactPersonEmail] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fax] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Status] [tinyint] NULL,
	[SalerId] [int] NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
SET IDENTITY_INSERT [dbo].[Customer] ON
INSERT [dbo].[Customer] ([Id], [CustomerName], [CustCode], [Address], [Phone], [BankAcc], [BankName], [ContactPerson], [ContactPersonPhone], [ContactPersonEmail], [Email], [Fax], [Description], [Status], [SalerId]) VALUES (1, N'', N'', N'', N'', N'', N'', NULL, N'', N'', N'', N'', N'', NULL, NULL)
INSERT [dbo].[Customer] ([Id], [CustomerName], [CustCode], [Address], [Phone], [BankAcc], [BankName], [ContactPerson], [ContactPersonPhone], [ContactPersonEmail], [Email], [Fax], [Description], [Status], [SalerId]) VALUES (2, N'Nguyen Van A', N'123', N'address', N'123456', N'1323232', N'3132', NULL, N'Hung', N'duc', N'hungpham', N'12345678', N'2132', NULL, 1)
SET IDENTITY_INSERT [dbo].[Customer] OFF
/****** Object:  Table [dbo].[EntranceStock]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntranceStock]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EntranceStock](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EntranceCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[EntrancedDate] [datetime] NOT NULL,
	[EntrancedBy] [int] NOT NULL,
	[Status] [tinyint] NULL,
	[Note] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_EntranceStock] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
SET IDENTITY_INSERT [dbo].[EntranceStock] ON
INSERT [dbo].[EntranceStock] ([Id], [EntranceCode], [EntrancedDate], [EntrancedBy], [Status], [Note]) VALUES (1, N'NK1582012jiQp', CAST(0x0000A0AE00182115 AS DateTime), 1, 3, N'')
INSERT [dbo].[EntranceStock] ([Id], [EntranceCode], [EntrancedDate], [EntrancedBy], [Status], [Note]) VALUES (2, N'NK2682012F9rI', CAST(0x0000A0B90130715C AS DateTime), 1, NULL, N'XcSC')
SET IDENTITY_INSERT [dbo].[EntranceStock] OFF
/****** Object:  Table [dbo].[ProductionRequest]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductionRequest]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProductionRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReqCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RequestedDate] [datetime] NOT NULL,
	[RequestedBy] [int] NOT NULL,
	[Status] [tinyint] NULL,
	[Note] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_ProductionRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
SET IDENTITY_INSERT [dbo].[ProductionRequest] ON
INSERT [dbo].[ProductionRequest] ([Id], [ReqCode], [RequestedDate], [RequestedBy], [Status], [Note]) VALUES (6, N'', CAST(0x0000A09D01126865 AS DateTime), 1, NULL, N'Test san xuat 1')
INSERT [dbo].[ProductionRequest] ([Id], [ReqCode], [RequestedDate], [RequestedBy], [Status], [Note]) VALUES (7, N'SX2882012dh3J', CAST(0x0000A0BB000B423F AS DateTime), 1, NULL, N'fdfd')
INSERT [dbo].[ProductionRequest] ([Id], [ReqCode], [RequestedDate], [RequestedBy], [Status], [Note]) VALUES (8, N'SX2882012CkR1', CAST(0x0000A0BB0181A058 AS DateTime), 3, NULL, N'')
INSERT [dbo].[ProductionRequest] ([Id], [ReqCode], [RequestedDate], [RequestedBy], [Status], [Note]) VALUES (9, N'SX2982012mpsh', CAST(0x0000A0BC00232A1B AS DateTime), 3, NULL, N'dsdsa')
SET IDENTITY_INSERT [dbo].[ProductionRequest] OFF
/****** Object:  Table [dbo].[Order]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Order]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Order](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CustId] [int] NOT NULL,
	[Total] [float] NOT NULL,
	[Note] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VAT] [float] NULL,
	[Discount] [float] NULL,
	[Status] [tinyint] NULL,
 CONSTRAINT [PK_Bill] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
SET IDENTITY_INSERT [dbo].[Order] ON
INSERT [dbo].[Order] ([Id], [OrderCode], [CreatedDate], [CreateBy], [CustId], [Total], [Note], [VAT], [Discount], [Status]) VALUES (1, N'', CAST(0x0000A09400205DE8 AS DateTime), 1, 1, 0, N'', 0, 0, 3)
INSERT [dbo].[Order] ([Id], [OrderCode], [CreatedDate], [CreateBy], [CustId], [Total], [Note], [VAT], [Discount], [Status]) VALUES (2, N'', CAST(0x0000A094002A82CA AS DateTime), 1, 2, 0, N'', 0, 0, 3)
INSERT [dbo].[Order] ([Id], [OrderCode], [CreatedDate], [CreateBy], [CustId], [Total], [Note], [VAT], [Discount], [Status]) VALUES (3, N'', CAST(0x0000A094002DC31C AS DateTime), 1, 2, 0, N'sfsfasfsdf', 600000, 100000, NULL)
INSERT [dbo].[Order] ([Id], [OrderCode], [CreatedDate], [CreateBy], [CustId], [Total], [Note], [VAT], [Discount], [Status]) VALUES (4, N'', CAST(0x0000A094002ED66F AS DateTime), 1, 2, 0, N'sfsafsdf', 1322, 1323122, NULL)
INSERT [dbo].[Order] ([Id], [OrderCode], [CreatedDate], [CreateBy], [CustId], [Total], [Note], [VAT], [Discount], [Status]) VALUES (5, N'', CAST(0x0000A09400313959 AS DateTime), 1, 2, 0, N'edadasdad', 323123, 13123213, NULL)
INSERT [dbo].[Order] ([Id], [OrderCode], [CreatedDate], [CreateBy], [CustId], [Total], [Note], [VAT], [Discount], [Status]) VALUES (6, N'', CAST(0x0000A09400992A71 AS DateTime), 1, 2, 0, N'', 50000, 20000, NULL)
INSERT [dbo].[Order] ([Id], [OrderCode], [CreatedDate], [CreateBy], [CustId], [Total], [Note], [VAT], [Discount], [Status]) VALUES (7, N'', CAST(0x0000A09A017E833B AS DateTime), 1, 2, 0, N'', 54353, 545, NULL)
INSERT [dbo].[Order] ([Id], [OrderCode], [CreatedDate], [CreateBy], [CustId], [Total], [Note], [VAT], [Discount], [Status]) VALUES (8, N'BH2682012WvAF', CAST(0x0000A0B9017B536C AS DateTime), 1, 2, 0, N'', 5453, 54545, NULL)
INSERT [dbo].[Order] ([Id], [OrderCode], [CreatedDate], [CreateBy], [CustId], [Total], [Note], [VAT], [Discount], [Status]) VALUES (9, N'BH2882012ZcJ&', CAST(0x0000A0BB000CEA30 AS DateTime), 1, 2, 0, N'fdfdsfsd', 0, 4324, NULL)
INSERT [dbo].[Order] ([Id], [OrderCode], [CreatedDate], [CreateBy], [CustId], [Total], [Note], [VAT], [Discount], [Status]) VALUES (10, N'BH2882012uX66', CAST(0x0000A0BB000D5422 AS DateTime), 1, 2, 0, N'fdfsdf', 43423, 43432, NULL)
INSERT [dbo].[Order] ([Id], [OrderCode], [CreatedDate], [CreateBy], [CustId], [Total], [Note], [VAT], [Discount], [Status]) VALUES (11, N'BH2882012S7Ln', CAST(0x0000A0BB001055C3 AS DateTime), 1, 2, 0, N'sfdfds', 4343, 4343, NULL)
INSERT [dbo].[Order] ([Id], [OrderCode], [CreatedDate], [CreateBy], [CustId], [Total], [Note], [VAT], [Discount], [Status]) VALUES (12, N'BH2882012ZI9r', CAST(0x0000A0BB0011C29A AS DateTime), 1, 2, 0, N'ffdfs', 4343, 434343, NULL)
INSERT [dbo].[Order] ([Id], [OrderCode], [CreatedDate], [CreateBy], [CustId], [Total], [Note], [VAT], [Discount], [Status]) VALUES (13, N'BH2982012iRbF', CAST(0x0000A0BC00000000 AS DateTime), 3, 2, 0, N'5gfgd', 5454, 5454, NULL)
INSERT [dbo].[Order] ([Id], [OrderCode], [CreatedDate], [CreateBy], [CustId], [Total], [Note], [VAT], [Discount], [Status]) VALUES (14, N'BH3082012ogt7', CAST(0x0000A0BD00000000 AS DateTime), 3, 2, 0, N'rere', 4343, 434343, NULL)
INSERT [dbo].[Order] ([Id], [OrderCode], [CreatedDate], [CreateBy], [CustId], [Total], [Note], [VAT], [Discount], [Status]) VALUES (15, N'BH3082012Nca=', CAST(0x0000A0BD00000000 AS DateTime), 3, 2, 0, N'ffdfdssf', 43434, 43432, NULL)
SET IDENTITY_INSERT [dbo].[Order] OFF
/****** Object:  Table [dbo].[ProductInStock]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductInStock]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProductInStock](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[AttributeId] [int] NOT NULL,
	[NumberOfItem] [int] NOT NULL,
	[LatestUpdate] [datetime] NOT NULL,
	[Note] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NumberOfInput] [int] NULL,
	[NumberOfOutput] [int] NULL,
	[StatusOfData] [tinyint] NOT NULL,
 CONSTRAINT [PK_ProductInStock] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
SET IDENTITY_INSERT [dbo].[ProductInStock] ON
INSERT [dbo].[ProductInStock] ([Id], [ProductId], [AttributeId], [NumberOfItem], [LatestUpdate], [Note], [NumberOfInput], [NumberOfOutput], [StatusOfData]) VALUES (1, 10, 3, 0, CAST(0x0000A0BD000536BB AS DateTime), NULL, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[ProductInStock] OFF
/****** Object:  Table [dbo].[ProductAttribute]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductAttribute]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProductAttribute](
	[Id] [int] NOT NULL,
	[AttributeId] [int] NOT NULL,
 CONSTRAINT [PK_ProductAttribute] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[AttributeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
INSERT [dbo].[ProductAttribute] ([Id], [AttributeId]) VALUES (9, 1)
INSERT [dbo].[ProductAttribute] ([Id], [AttributeId]) VALUES (10, 2)
INSERT [dbo].[ProductAttribute] ([Id], [AttributeId]) VALUES (10, 3)
INSERT [dbo].[ProductAttribute] ([Id], [AttributeId]) VALUES (11, 2)
INSERT [dbo].[ProductAttribute] ([Id], [AttributeId]) VALUES (11, 3)
INSERT [dbo].[ProductAttribute] ([Id], [AttributeId]) VALUES (12, 4)
INSERT [dbo].[ProductAttribute] ([Id], [AttributeId]) VALUES (12, 5)
/****** Object:  Table [dbo].[MaterialInStock]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MaterialInStock]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MaterialInStock](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[AttributeId] [int] NOT NULL,
	[NumberOfItem] [int] NOT NULL,
	[LatestUpdate] [datetime] NOT NULL,
	[Note] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NumberOfInput] [int] NULL,
	[NumberOfOutput] [int] NULL,
	[StatusOfData] [tinyint] NULL,
 CONSTRAINT [PK_MaterialInStock] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
SET IDENTITY_INSERT [dbo].[MaterialInStock] ON
INSERT [dbo].[MaterialInStock] ([Id], [ProductId], [AttributeId], [NumberOfItem], [LatestUpdate], [Note], [NumberOfInput], [NumberOfOutput], [StatusOfData]) VALUES (11, 10, 2, 23, CAST(0x0000A0B90130974D AS DateTime), NULL, 23, 0, 1)
SET IDENTITY_INSERT [dbo].[MaterialInStock] OFF
/****** Object:  Table [dbo].[Bill]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Bill]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Bill](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BillCode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CustId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[Note] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Bill_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
SET IDENTITY_INSERT [dbo].[Bill] ON
INSERT [dbo].[Bill] ([Id], [BillCode], [CustId], [UserId], [Amount], [Note], [CreatedDate]) VALUES (2, N'', 2, 1, 565654, N'gfgfgdf', CAST(0x0000A0A7001C7AA8 AS DateTime))
SET IDENTITY_INSERT [dbo].[Bill] OFF
/****** Object:  Table [dbo].[ProductionRequestDetail]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductionRequestDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProductionRequestDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[NumberUnit] [int] NOT NULL,
	[Origin] [smallint] NULL,
	[AttributeId] [int] NOT NULL,
	[Note] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductionRequestId] [int] NOT NULL,
	[Direction] [bit] NOT NULL,
 CONSTRAINT [PK_ProductionRequestDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[ProductionRequestId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
SET IDENTITY_INSERT [dbo].[ProductionRequestDetail] ON
INSERT [dbo].[ProductionRequestDetail] ([Id], [ProductId], [NumberUnit], [Origin], [AttributeId], [Note], [ProductionRequestId], [Direction]) VALUES (14, 10, 4000, NULL, 2, N'g', 6, 1)
INSERT [dbo].[ProductionRequestDetail] ([Id], [ProductId], [NumberUnit], [Origin], [AttributeId], [Note], [ProductionRequestId], [Direction]) VALUES (15, 10, 4000, NULL, 2, N'g2', 6, 1)
INSERT [dbo].[ProductionRequestDetail] ([Id], [ProductId], [NumberUnit], [Origin], [AttributeId], [Note], [ProductionRequestId], [Direction]) VALUES (16, 9, 30000, NULL, 1, N'g3', 6, 1)
INSERT [dbo].[ProductionRequestDetail] ([Id], [ProductId], [NumberUnit], [Origin], [AttributeId], [Note], [ProductionRequestId], [Direction]) VALUES (17, 10, 30000, NULL, 2, N'Ghi chu', 6, 0)
INSERT [dbo].[ProductionRequestDetail] ([Id], [ProductId], [NumberUnit], [Origin], [AttributeId], [Note], [ProductionRequestId], [Direction]) VALUES (18, 9, 50000, NULL, 1, NULL, 6, 0)
INSERT [dbo].[ProductionRequestDetail] ([Id], [ProductId], [NumberUnit], [Origin], [AttributeId], [Note], [ProductionRequestId], [Direction]) VALUES (19, 10, 43, NULL, 2, N'fdfd', 7, 1)
INSERT [dbo].[ProductionRequestDetail] ([Id], [ProductId], [NumberUnit], [Origin], [AttributeId], [Note], [ProductionRequestId], [Direction]) VALUES (20, 10, 4, NULL, 2, N'fdfdsf', 9, 1)
SET IDENTITY_INSERT [dbo].[ProductionRequestDetail] OFF
/****** Object:  Table [dbo].[Price]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Price]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Price](
	[Id] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Price] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[UpdatedDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
INSERT [dbo].[Price] ([Id], [Price], [UpdatedDate]) VALUES (2, 100, CAST(0x0000A08C000C6993 AS DateTime))
INSERT [dbo].[Price] ([Id], [Price], [UpdatedDate]) VALUES (3, 100, CAST(0x0000A08C00D0B8F5 AS DateTime))
INSERT [dbo].[Price] ([Id], [Price], [UpdatedDate]) VALUES (4, 0, CAST(0x0000A0910017A49C AS DateTime))
INSERT [dbo].[Price] ([Id], [Price], [UpdatedDate]) VALUES (5, 0, CAST(0x0000A09100195248 AS DateTime))
INSERT [dbo].[Price] ([Id], [Price], [UpdatedDate]) VALUES (6, 0, CAST(0x0000A091001973E6 AS DateTime))
INSERT [dbo].[Price] ([Id], [Price], [UpdatedDate]) VALUES (7, 0, CAST(0x0000A0910019FF1F AS DateTime))
INSERT [dbo].[Price] ([Id], [Price], [UpdatedDate]) VALUES (8, 122343, CAST(0x0000A091001A5271 AS DateTime))
INSERT [dbo].[Price] ([Id], [Price], [UpdatedDate]) VALUES (9, 0, CAST(0x0000A09400242390 AS DateTime))
INSERT [dbo].[Price] ([Id], [Price], [UpdatedDate]) VALUES (10, 0, CAST(0x0000A0940030F841 AS DateTime))
INSERT [dbo].[Price] ([Id], [Price], [UpdatedDate]) VALUES (11, 0, CAST(0x0000A09400978E95 AS DateTime))
INSERT [dbo].[Price] ([Id], [Price], [UpdatedDate]) VALUES (12, 0, CAST(0x0000A094009B7490 AS DateTime))
INSERT [dbo].[Price] ([Id], [Price], [UpdatedDate]) VALUES (13, 0, CAST(0x0000A0AD0005CD89 AS DateTime))
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 08/31/2012 01:04:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrderDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[NumberUnit] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[Cost] [float] NOT NULL,
	[AttributeId] [int] NOT NULL,
	[Note] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderId] [int] NOT NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[OrderId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON
INSERT [dbo].[OrderDetail] ([Id], [ProductId], [NumberUnit], [Price], [Cost], [AttributeId], [Note], [OrderId]) VALUES (2, 10, 50000, 50000, 4, 2, N'fdfs', 3)
INSERT [dbo].[OrderDetail] ([Id], [ProductId], [NumberUnit], [Price], [Cost], [AttributeId], [Note], [OrderId]) VALUES (3, 10, 5454, 5454, 0, 2, N'ttrterte', 8)
INSERT [dbo].[OrderDetail] ([Id], [ProductId], [NumberUnit], [Price], [Cost], [AttributeId], [Note], [OrderId]) VALUES (4, 10, 43, 433, 0, 2, N'fdfs', 9)
INSERT [dbo].[OrderDetail] ([Id], [ProductId], [NumberUnit], [Price], [Cost], [AttributeId], [Note], [OrderId]) VALUES (5, 10, 43, 4343, 0, 2, N'ffdsfs', 10)
INSERT [dbo].[OrderDetail] ([Id], [ProductId], [NumberUnit], [Price], [Cost], [AttributeId], [Note], [OrderId]) VALUES (6, 10, 43, 434, 0, 2, N'fdfdd', 11)
INSERT [dbo].[OrderDetail] ([Id], [ProductId], [NumberUnit], [Price], [Cost], [AttributeId], [Note], [OrderId]) VALUES (7, 10, 4343, 4343, 0, 2, N'fdfdsfs', 12)
INSERT [dbo].[OrderDetail] ([Id], [ProductId], [NumberUnit], [Price], [Cost], [AttributeId], [Note], [OrderId]) VALUES (8, 10, 5454, 5454, 0, 2, N'gfgf', 13)
INSERT [dbo].[OrderDetail] ([Id], [ProductId], [NumberUnit], [Price], [Cost], [AttributeId], [Note], [OrderId]) VALUES (9, 10, 43, 4343, 0, 2, NULL, 14)
INSERT [dbo].[OrderDetail] ([Id], [ProductId], [NumberUnit], [Price], [Cost], [AttributeId], [Note], [OrderId]) VALUES (10, 10, 4, 4343, 0, 3, N'fdfdf', 15)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
/****** Object:  Default [DF_Customer_Status]    Script Date: 08/31/2012 01:04:16 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Customer_Status]') AND parent_object_id = OBJECT_ID(N'[dbo].[Customer]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Customer_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_Status]  DEFAULT ((1)) FOR [Status]
END


End
GO
/****** Object:  Default [DF_Order_VAT]    Script Date: 08/31/2012 01:04:16 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Order_VAT]') AND parent_object_id = OBJECT_ID(N'[dbo].[Order]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Order_VAT]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_VAT]  DEFAULT ((0)) FOR [VAT]
END


End
GO
/****** Object:  Default [DF_ProductionRequestDetail_Direction]    Script Date: 08/31/2012 01:04:16 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ProductionRequestDetail_Direction]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRequestDetail]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ProductionRequestDetail_Direction]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ProductionRequestDetail] ADD  CONSTRAINT [DF_ProductionRequestDetail_Direction]  DEFAULT ((0)) FOR [Direction]
END


End
GO
/****** Object:  ForeignKey [FK_Bill_Customer]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bill_Customer]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bill]'))
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_Customer] FOREIGN KEY([CustId])
REFERENCES [dbo].[Customer] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bill_Customer]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bill]'))
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_Customer]
GO
/****** Object:  ForeignKey [FK_Bill_SystemUser]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bill_SystemUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bill]'))
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_SystemUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[SystemUser] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Bill_SystemUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[Bill]'))
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_SystemUser]
GO
/****** Object:  ForeignKey [FK_Customer_Employee]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Customer_Employee]') AND parent_object_id = OBJECT_ID(N'[dbo].[Customer]'))
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Employee] FOREIGN KEY([SalerId])
REFERENCES [dbo].[Employee] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Customer_Employee]') AND parent_object_id = OBJECT_ID(N'[dbo].[Customer]'))
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Employee]
GO
/****** Object:  ForeignKey [FK_EntranceStock_SystemUser]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EntranceStock_SystemUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[EntranceStock]'))
ALTER TABLE [dbo].[EntranceStock]  WITH CHECK ADD  CONSTRAINT [FK_EntranceStock_SystemUser] FOREIGN KEY([EntrancedBy])
REFERENCES [dbo].[SystemUser] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EntranceStock_SystemUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[EntranceStock]'))
ALTER TABLE [dbo].[EntranceStock] CHECK CONSTRAINT [FK_EntranceStock_SystemUser]
GO
/****** Object:  ForeignKey [FK_MaterialInStock_BaseAttribute]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MaterialInStock_BaseAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[MaterialInStock]'))
ALTER TABLE [dbo].[MaterialInStock]  WITH CHECK ADD  CONSTRAINT [FK_MaterialInStock_BaseAttribute] FOREIGN KEY([AttributeId])
REFERENCES [dbo].[BaseAttribute] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MaterialInStock_BaseAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[MaterialInStock]'))
ALTER TABLE [dbo].[MaterialInStock] CHECK CONSTRAINT [FK_MaterialInStock_BaseAttribute]
GO
/****** Object:  ForeignKey [FK_MaterialInStock_Product]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MaterialInStock_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[MaterialInStock]'))
ALTER TABLE [dbo].[MaterialInStock]  WITH CHECK ADD  CONSTRAINT [FK_MaterialInStock_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MaterialInStock_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[MaterialInStock]'))
ALTER TABLE [dbo].[MaterialInStock] CHECK CONSTRAINT [FK_MaterialInStock_Product]
GO
/****** Object:  ForeignKey [FK_Order_Customer]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Order_Customer]') AND parent_object_id = OBJECT_ID(N'[dbo].[Order]'))
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustId])
REFERENCES [dbo].[Customer] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Order_Customer]') AND parent_object_id = OBJECT_ID(N'[dbo].[Order]'))
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
/****** Object:  ForeignKey [FK_Order_SystemUser]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Order_SystemUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[Order]'))
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_SystemUser] FOREIGN KEY([CreateBy])
REFERENCES [dbo].[SystemUser] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Order_SystemUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[Order]'))
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_SystemUser]
GO
/****** Object:  ForeignKey [FK_OrderDetail_BaseAttribute]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderDetail_BaseAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderDetail]'))
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_BaseAttribute] FOREIGN KEY([AttributeId])
REFERENCES [dbo].[BaseAttribute] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderDetail_BaseAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderDetail]'))
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_BaseAttribute]
GO
/****** Object:  ForeignKey [FK_OrderDetail_Order]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderDetail_Order]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderDetail]'))
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderDetail_Order]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderDetail]'))
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
/****** Object:  ForeignKey [FK_OrderDetail_Product]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderDetail_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderDetail]'))
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderDetail_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderDetail]'))
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
/****** Object:  ForeignKey [FK_Price_Product]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Price_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[Price]'))
ALTER TABLE [dbo].[Price]  WITH CHECK ADD  CONSTRAINT [FK_Price_Product] FOREIGN KEY([Id])
REFERENCES [dbo].[Product] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Price_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[Price]'))
ALTER TABLE [dbo].[Price] CHECK CONSTRAINT [FK_Price_Product]
GO
/****** Object:  ForeignKey [FK_Product_MeasurementUnit]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Product_MeasurementUnit]') AND parent_object_id = OBJECT_ID(N'[dbo].[Product]'))
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_MeasurementUnit] FOREIGN KEY([BaseUnit])
REFERENCES [dbo].[MeasurementUnit] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Product_MeasurementUnit]') AND parent_object_id = OBJECT_ID(N'[dbo].[Product]'))
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_MeasurementUnit]
GO
/****** Object:  ForeignKey [FK_Product_ProductType]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Product_ProductType]') AND parent_object_id = OBJECT_ID(N'[dbo].[Product]'))
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductType] FOREIGN KEY([ProductType])
REFERENCES [dbo].[ProductType] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Product_ProductType]') AND parent_object_id = OBJECT_ID(N'[dbo].[Product]'))
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductType]
GO
/****** Object:  ForeignKey [FK_ProductAttribute_Attribute]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductAttribute_Attribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductAttribute]'))
ALTER TABLE [dbo].[ProductAttribute]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttribute_Attribute] FOREIGN KEY([AttributeId])
REFERENCES [dbo].[BaseAttribute] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductAttribute_Attribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductAttribute]'))
ALTER TABLE [dbo].[ProductAttribute] CHECK CONSTRAINT [FK_ProductAttribute_Attribute]
GO
/****** Object:  ForeignKey [FK_ProductAttribute_Product]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductAttribute_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductAttribute]'))
ALTER TABLE [dbo].[ProductAttribute]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttribute_Product] FOREIGN KEY([Id])
REFERENCES [dbo].[Product] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductAttribute_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductAttribute]'))
ALTER TABLE [dbo].[ProductAttribute] CHECK CONSTRAINT [FK_ProductAttribute_Product]
GO
/****** Object:  ForeignKey [FK_ProductInStock_BaseAttribute]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductInStock_BaseAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductInStock]'))
ALTER TABLE [dbo].[ProductInStock]  WITH CHECK ADD  CONSTRAINT [FK_ProductInStock_BaseAttribute] FOREIGN KEY([AttributeId])
REFERENCES [dbo].[BaseAttribute] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductInStock_BaseAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductInStock]'))
ALTER TABLE [dbo].[ProductInStock] CHECK CONSTRAINT [FK_ProductInStock_BaseAttribute]
GO
/****** Object:  ForeignKey [FK_ProductInStock_Product]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductInStock_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductInStock]'))
ALTER TABLE [dbo].[ProductInStock]  WITH CHECK ADD  CONSTRAINT [FK_ProductInStock_Product] FOREIGN KEY([Id])
REFERENCES [dbo].[Product] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductInStock_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductInStock]'))
ALTER TABLE [dbo].[ProductInStock] CHECK CONSTRAINT [FK_ProductInStock_Product]
GO
/****** Object:  ForeignKey [FK_ProductionRequest_SystemUser]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductionRequest_SystemUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRequest]'))
ALTER TABLE [dbo].[ProductionRequest]  WITH CHECK ADD  CONSTRAINT [FK_ProductionRequest_SystemUser] FOREIGN KEY([RequestedBy])
REFERENCES [dbo].[SystemUser] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductionRequest_SystemUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRequest]'))
ALTER TABLE [dbo].[ProductionRequest] CHECK CONSTRAINT [FK_ProductionRequest_SystemUser]
GO
/****** Object:  ForeignKey [FK_ProductionRequestDetail_BaseAttribute]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductionRequestDetail_BaseAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRequestDetail]'))
ALTER TABLE [dbo].[ProductionRequestDetail]  WITH CHECK ADD  CONSTRAINT [FK_ProductionRequestDetail_BaseAttribute] FOREIGN KEY([AttributeId])
REFERENCES [dbo].[BaseAttribute] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductionRequestDetail_BaseAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRequestDetail]'))
ALTER TABLE [dbo].[ProductionRequestDetail] CHECK CONSTRAINT [FK_ProductionRequestDetail_BaseAttribute]
GO
/****** Object:  ForeignKey [FK_ProductionRequestDetail_Product]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductionRequestDetail_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRequestDetail]'))
ALTER TABLE [dbo].[ProductionRequestDetail]  WITH CHECK ADD  CONSTRAINT [FK_ProductionRequestDetail_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductionRequestDetail_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRequestDetail]'))
ALTER TABLE [dbo].[ProductionRequestDetail] CHECK CONSTRAINT [FK_ProductionRequestDetail_Product]
GO
/****** Object:  ForeignKey [FK_ProductionRequestDetail_ProductionRequest]    Script Date: 08/31/2012 01:04:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductionRequestDetail_ProductionRequest]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRequestDetail]'))
ALTER TABLE [dbo].[ProductionRequestDetail]  WITH CHECK ADD  CONSTRAINT [FK_ProductionRequestDetail_ProductionRequest] FOREIGN KEY([ProductionRequestId])
REFERENCES [dbo].[ProductionRequest] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductionRequestDetail_ProductionRequest]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRequestDetail]'))
ALTER TABLE [dbo].[ProductionRequestDetail] CHECK CONSTRAINT [FK_ProductionRequestDetail_ProductionRequest]
GO

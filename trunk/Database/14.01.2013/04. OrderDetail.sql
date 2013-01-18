/*
   Monday, January 14, 201310:51:45 PM
   User: 
   Server: BRYANPHAM-PC\SQLEXPRESS
   Database: BaoHienCompany
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.MeasurementUnit SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.MeasurementUnit', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.MeasurementUnit', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.MeasurementUnit', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.OrderDetail
	DROP CONSTRAINT FK_OrderDetail_Product
GO
ALTER TABLE dbo.Product SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.Product', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Product', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Product', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.OrderDetail
	DROP CONSTRAINT FK_OrderDetail_Order
GO
ALTER TABLE dbo.[Order] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.[Order]', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.[Order]', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.[Order]', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.OrderDetail
	DROP CONSTRAINT FK_OrderDetail_BaseAttribute
GO
ALTER TABLE dbo.BaseAttribute SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.BaseAttribute', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.BaseAttribute', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.BaseAttribute', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.OrderDetail
	DROP CONSTRAINT DF_OrderDetail_commission
GO
CREATE TABLE dbo.Tmp_OrderDetail
	(
	Id int NOT NULL IDENTITY (1, 1),
	ProductId int NOT NULL,
	AttributeId int NOT NULL,
	UnitId int NOT NULL,
	NumberUnit int NOT NULL,
	Price float(53) NOT NULL,
	Cost float(53) NOT NULL,
	Note nvarchar(50) NULL,
	OrderId int NOT NULL,
	Commission float(53) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_OrderDetail SET (LOCK_ESCALATION = TABLE)
GO
ALTER TABLE dbo.Tmp_OrderDetail ADD CONSTRAINT
	DF_OrderDetail_commission DEFAULT ((0)) FOR Commission
GO
SET IDENTITY_INSERT dbo.Tmp_OrderDetail ON
GO
IF EXISTS(SELECT * FROM dbo.OrderDetail)
	 EXEC('INSERT INTO dbo.Tmp_OrderDetail (Id, ProductId, AttributeId, NumberUnit, Price, Cost, Note, OrderId, Commission)
		SELECT Id, ProductId, AttributeId, NumberUnit, Price, Cost, Note, OrderId, Commission FROM dbo.OrderDetail WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_OrderDetail OFF
GO
DROP TABLE dbo.OrderDetail
GO
EXECUTE sp_rename N'dbo.Tmp_OrderDetail', N'OrderDetail', 'OBJECT' 
GO
ALTER TABLE dbo.OrderDetail ADD CONSTRAINT
	PK_OrderDetail_1 PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.OrderDetail ADD CONSTRAINT
	FK_OrderDetail_BaseAttribute FOREIGN KEY
	(
	AttributeId
	) REFERENCES dbo.BaseAttribute
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.OrderDetail ADD CONSTRAINT
	FK_OrderDetail_Order FOREIGN KEY
	(
	OrderId
	) REFERENCES dbo.[Order]
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.OrderDetail ADD CONSTRAINT
	FK_OrderDetail_Product FOREIGN KEY
	(
	ProductId
	) REFERENCES dbo.Product
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.OrderDetail ADD CONSTRAINT
	FK_OrderDetail_MeasurementUnit FOREIGN KEY
	(
	UnitId
	) REFERENCES dbo.MeasurementUnit
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.OrderDetail', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.OrderDetail', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.OrderDetail', 'Object', 'CONTROL') as Contr_Per 
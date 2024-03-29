/*
   Sunday, May 05, 201310:21:18 PM
   User: 
   Server: KHANGUYEN-PC\SQLEXPRESS
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
ALTER TABLE dbo.ProductLog
	DROP CONSTRAINT FK_ProductLog_Product
GO
COMMIT
select Has_Perms_By_Name(N'dbo.Product', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Product', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Product', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.ProductLog
	DROP CONSTRAINT FK_ProductLog_MeasurementUnit
GO
COMMIT
select Has_Perms_By_Name(N'dbo.MeasurementUnit', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.MeasurementUnit', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.MeasurementUnit', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.ProductLog
	DROP CONSTRAINT FK_ProductLog_BaseAttribute
GO
COMMIT
select Has_Perms_By_Name(N'dbo.BaseAttribute', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.BaseAttribute', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.BaseAttribute', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_ProductLog
	(
	Id int NOT NULL IDENTITY (1, 1),
	ProductId int NOT NULL,
	AttributeId int NOT NULL,
	UnitId int NOT NULL,
	RecordCode nvarchar(50) NOT NULL,
	BeforeNumber float(53) NOT NULL,
	Amount float(53) NOT NULL,
	AfterNumber float(53) NOT NULL,
	Status int NOT NULL,
	CreatedDate datetime NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_ProductLog ADD CONSTRAINT
	DF_ProductLog_Status DEFAULT 0 FOR Status
GO
SET IDENTITY_INSERT dbo.Tmp_ProductLog ON
GO
IF EXISTS(SELECT * FROM dbo.ProductLog)
	 EXEC('INSERT INTO dbo.Tmp_ProductLog (Id, ProductId, AttributeId, UnitId, RecordCode, BeforeNumber, Amount, AfterNumber, CreatedDate)
		SELECT Id, ProductId, AttributeId, UnitId, RecordCode, BeforeNumber, Amount, AfterNumber, CreatedDate FROM dbo.ProductLog WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_ProductLog OFF
GO
DROP TABLE dbo.ProductLog
GO
EXECUTE sp_rename N'dbo.Tmp_ProductLog', N'ProductLog', 'OBJECT' 
GO
ALTER TABLE dbo.ProductLog ADD CONSTRAINT
	PK_ProductLog PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.ProductLog ADD CONSTRAINT
	FK_ProductLog_BaseAttribute FOREIGN KEY
	(
	AttributeId
	) REFERENCES dbo.BaseAttribute
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.ProductLog ADD CONSTRAINT
	FK_ProductLog_MeasurementUnit FOREIGN KEY
	(
	UnitId
	) REFERENCES dbo.MeasurementUnit
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.ProductLog ADD CONSTRAINT
	FK_ProductLog_Product FOREIGN KEY
	(
	ProductId
	) REFERENCES dbo.Product
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.ProductLog', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.ProductLog', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.ProductLog', 'Object', 'CONTROL') as Contr_Per 
/*
   Monday, January 14, 201310:49:59 PM
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
ALTER TABLE dbo.EntranceStockDetail
	DROP CONSTRAINT FK_EntranceStockDetail_BaseAttribute
GO
ALTER TABLE dbo.BaseAttribute SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.BaseAttribute', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.BaseAttribute', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.BaseAttribute', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.EntranceStockDetail
	DROP CONSTRAINT FK_EntranceStockDetail_Product
GO
ALTER TABLE dbo.Product SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.Product', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Product', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Product', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.EntranceStockDetail
	DROP CONSTRAINT FK_EntranceStockDetail_EntranceStock
GO
ALTER TABLE dbo.EntranceStock SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.EntranceStock', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.EntranceStock', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.EntranceStock', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_EntranceStockDetail
	(
	Id int NOT NULL IDENTITY (1, 1),
	EntranceStockId int NOT NULL,
	ProductId int NOT NULL,
	AttributeId int NOT NULL,
	UnitId int NOT NULL,
	NumberUnit int NOT NULL,
	Note nvarchar(500) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_EntranceStockDetail SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_EntranceStockDetail ON
GO
IF EXISTS(SELECT * FROM dbo.EntranceStockDetail)
	 EXEC('INSERT INTO dbo.Tmp_EntranceStockDetail (Id, EntranceStockId, ProductId, AttributeId, NumberUnit, Note)
		SELECT Id, EntranceStockId, ProductId, AttributeId, NumberUnit, Note FROM dbo.EntranceStockDetail WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_EntranceStockDetail OFF
GO
DROP TABLE dbo.EntranceStockDetail
GO
EXECUTE sp_rename N'dbo.Tmp_EntranceStockDetail', N'EntranceStockDetail', 'OBJECT' 
GO
ALTER TABLE dbo.EntranceStockDetail ADD CONSTRAINT
	PK_EntranceStockDetail PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.EntranceStockDetail ADD CONSTRAINT
	FK_EntranceStockDetail_EntranceStock FOREIGN KEY
	(
	EntranceStockId
	) REFERENCES dbo.EntranceStock
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.EntranceStockDetail ADD CONSTRAINT
	FK_EntranceStockDetail_Product FOREIGN KEY
	(
	ProductId
	) REFERENCES dbo.Product
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.EntranceStockDetail ADD CONSTRAINT
	FK_EntranceStockDetail_BaseAttribute FOREIGN KEY
	(
	AttributeId
	) REFERENCES dbo.BaseAttribute
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.EntranceStockDetail ADD CONSTRAINT
	FK_EntranceStockDetail_MeasurementUnit FOREIGN KEY
	(
	UnitId
	) REFERENCES dbo.MeasurementUnit
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.EntranceStockDetail', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.EntranceStockDetail', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.EntranceStockDetail', 'Object', 'CONTROL') as Contr_Per 
/*
   Saturday, January 05, 20135:16:59 PM
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
ALTER TABLE dbo.EntranceStock SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.EntranceStock', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.EntranceStock', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.EntranceStock', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
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
ALTER TABLE dbo.EntranceStockDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.EntranceStockDetail', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.EntranceStockDetail', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.EntranceStockDetail', 'Object', 'CONTROL') as Contr_Per 
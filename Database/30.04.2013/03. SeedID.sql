/*
   Monday, April 29, 20138:25:42 PM
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
CREATE TABLE dbo.SeedID
	(
	ID bigint NOT NULL,
	Prefix varchar(10) NOT NULL,
	CreateDate datetime NOT NULL,
	Value nvarchar(50) NOT NULL,
	Result nvarchar(50) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.SeedID ADD CONSTRAINT
	PK_SeedID PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
select Has_Perms_By_Name(N'dbo.SeedID', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.SeedID', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.SeedID', 'Object', 'CONTROL') as Contr_Per 
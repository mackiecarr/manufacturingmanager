/*
   Sunday, May 05, 201310:20:46 PM
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
ALTER TABLE dbo.EmployeeLog
	DROP CONSTRAINT FK_EmployeeLog_Employee
GO
COMMIT
select Has_Perms_By_Name(N'dbo.Employee', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Employee', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Employee', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_EmployeeLog
	(
	Id int NOT NULL IDENTITY (1, 1),
	EmployeeId int NOT NULL,
	RecordCode varchar(25) NOT NULL,
	BeforeNumber float(53) NOT NULL,
	Amount float(53) NOT NULL,
	AfterNumber float(53) NOT NULL,
	Status int NOT NULL,
	CreatedDate datetime NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_EmployeeLog ADD CONSTRAINT
	DF_EmployeeLog_Status DEFAULT 0 FOR Status
GO
SET IDENTITY_INSERT dbo.Tmp_EmployeeLog ON
GO
IF EXISTS(SELECT * FROM dbo.EmployeeLog)
	 EXEC('INSERT INTO dbo.Tmp_EmployeeLog (Id, EmployeeId, RecordCode, BeforeNumber, Amount, AfterNumber, CreatedDate)
		SELECT Id, EmployeeId, RecordCode, BeforeNumber, Amount, AfterNumber, CreatedDate FROM dbo.EmployeeLog WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_EmployeeLog OFF
GO
DROP TABLE dbo.EmployeeLog
GO
EXECUTE sp_rename N'dbo.Tmp_EmployeeLog', N'EmployeeLog', 'OBJECT' 
GO
ALTER TABLE dbo.EmployeeLog ADD CONSTRAINT
	PK_EmployeeLog PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.EmployeeLog ADD CONSTRAINT
	FK_EmployeeLog_Employee FOREIGN KEY
	(
	EmployeeId
	) REFERENCES dbo.Employee
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.EmployeeLog', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.EmployeeLog', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.EmployeeLog', 'Object', 'CONTROL') as Contr_Per 
/*
   Saturday, April 27, 20137:52:59 PM
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
ALTER TABLE dbo.Customer
	DROP CONSTRAINT FK_Customer_Employee
GO
COMMIT
select Has_Perms_By_Name(N'dbo.Employee', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Employee', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Employee', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.Customer
	DROP CONSTRAINT DF_Customer_Status
GO
CREATE TABLE dbo.Tmp_Customer
	(
	Id int NOT NULL IDENTITY (1, 1),
	CustomerName nvarchar(50) NOT NULL,
	CustCode nvarchar(50) NOT NULL,
	Address nvarchar(250) NOT NULL,
	Phone varchar(25) NOT NULL,
	BankAcc nvarchar(50) NULL,
	BankName nvarchar(50) NULL,
	ContactPerson nvarchar(50) NULL,
	ContactPersonPhone nvarchar(50) NULL,
	ContactPersonEmail varchar(50) NULL,
	Email varchar(50) NULL,
	Fax varchar(50) NULL,
	Description nvarchar(500) NULL,
	Status tinyint NULL,
	SalerId int NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Customer ADD CONSTRAINT
	DF_Customer_Status DEFAULT ((1)) FOR Status
GO
SET IDENTITY_INSERT dbo.Tmp_Customer ON
GO
IF EXISTS(SELECT * FROM dbo.Customer)
	 EXEC('INSERT INTO dbo.Tmp_Customer (Id, CustomerName, CustCode, Address, Phone, BankAcc, BankName, ContactPerson, ContactPersonPhone, ContactPersonEmail, Email, Fax, Description, Status, SalerId)
		SELECT Id, CustomerName, CONVERT(nvarchar(50), CustCode), Address, Phone, BankAcc, BankName, ContactPerson, ContactPersonPhone, ContactPersonEmail, Email, Fax, Description, Status, SalerId FROM dbo.Customer WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_Customer OFF
GO
ALTER TABLE dbo.Bill
	DROP CONSTRAINT FK_Bill_Customer
GO
ALTER TABLE dbo.[Order]
	DROP CONSTRAINT FK_Order_Customer
GO
ALTER TABLE dbo.CustomerLog
	DROP CONSTRAINT FK_CustomerLog_Customer
GO
DROP TABLE dbo.Customer
GO
EXECUTE sp_rename N'dbo.Tmp_Customer', N'Customer', 'OBJECT' 
GO
ALTER TABLE dbo.Customer ADD CONSTRAINT
	PK_Customer PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Customer ADD CONSTRAINT
	FK_Customer_Employee FOREIGN KEY
	(
	SalerId
	) REFERENCES dbo.Employee
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.Customer', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Customer', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Customer', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.CustomerLog ADD CONSTRAINT
	FK_CustomerLog_Customer FOREIGN KEY
	(
	CustomerId
	) REFERENCES dbo.Customer
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.CustomerLog', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.CustomerLog', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.CustomerLog', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.[Order] ADD CONSTRAINT
	FK_Order_Customer FOREIGN KEY
	(
	CustId
	) REFERENCES dbo.Customer
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.[Order]', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.[Order]', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.[Order]', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.Bill ADD CONSTRAINT
	FK_Bill_Customer FOREIGN KEY
	(
	CustId
	) REFERENCES dbo.Customer
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
select Has_Perms_By_Name(N'dbo.Bill', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Bill', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Bill', 'Object', 'CONTROL') as Contr_Per 
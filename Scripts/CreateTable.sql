/*
   Saturday, September 19, 20208:25:07 PM
   User: 
   Server: DESKTOP-4M6Q63R
   Database: Caso_II
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
CREATE TABLE dbo.Roles
	(
	id int NOT NULL IDENTITY (1, 1),
	name nvarchar(100) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Roles ADD CONSTRAINT
	PK_Roles PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Roles SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.[User]
	(
	id int NOT NULL IDENTITY (1, 1),
	name nvarchar(200) NOT NULL,
	email nvarchar(100) NOT NULL,
	password nvarchar(150) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.[User] ADD CONSTRAINT
	PK_User PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.[User] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.UserPorRol
	(
	id int NOT NULL IDENTITY (1, 1),
	user_id int NOT NULL,
	rol_id int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.UserPorRol ADD CONSTRAINT
	PK_UserPorRol PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.UserPorRol ADD CONSTRAINT
	FK_UserPorRol_User FOREIGN KEY
	(
	user_id
	) REFERENCES dbo.[User]
	(
	id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.UserPorRol ADD CONSTRAINT
	FK_UserPorRol_Roles FOREIGN KEY
	(
	rol_id
	) REFERENCES dbo.Roles
	(
	id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.UserPorRol SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Sucursal
	(
	id int NOT NULL IDENTITY (1, 1),
	saldo decimal(16, 4) NOT NULL,
	nombre nvarchar(100) NOT NULL,
	user_id int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Sucursal ADD CONSTRAINT
	PK_Sucursal PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Sucursal ADD CONSTRAINT
	FK_Sucursal_User FOREIGN KEY
	(
	user_id
	) REFERENCES dbo.[User]
	(
	id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Sucursal SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.CategoriasDePermiso
	(
	id int NOT NULL IDENTITY (1, 1),
	description nvarchar(200) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.CategoriasDePermiso ADD CONSTRAINT
	PK_CategoriasDePermiso PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.CategoriasDePermiso SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Permisos
	(
	id int NOT NULL IDENTITY (1, 1),
	description nvarchar(200) NOT NULL,
	code int NOT NULL,
	type int NOT NULL,
	category_id int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Permisos ADD CONSTRAINT
	PK_Permisos PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Permisos ADD CONSTRAINT
	FK_Permisos_CategoriasDePermiso FOREIGN KEY
	(
	category_id
	) REFERENCES dbo.CategoriasDePermiso
	(
	id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Permisos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.PermisosPorUsuario
	(
	id int NOT NULL IDENTITY (1, 1),
	user_id int NOT NULL,
	permiso_id int NOT NULL,
	postTime datetime NOT NULL,
	deleted bit NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.PermisosPorUsuario ADD CONSTRAINT
	PK_PermisosPorUsuario PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.PermisosPorUsuario ADD CONSTRAINT
	FK_PermisosPorUsuario_Permisos FOREIGN KEY
	(
	permiso_id
	) REFERENCES dbo.Permisos
	(
	id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PermisosPorUsuario ADD CONSTRAINT
	FK_PermisosPorUsuario_User FOREIGN KEY
	(
	user_id
	) REFERENCES dbo.[User]
	(
	id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PermisosPorUsuario SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.PermisosPorRol
	(
	id int NOT NULL IDENTITY (1, 1),
	rol_id int NOT NULL,
	permiso_id int NOT NULL,
	postTime datetime NOT NULL,
	deleted bit NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.PermisosPorRol ADD CONSTRAINT
	PK_PermisosPorRol PRIMARY KEY CLUSTERED 
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.PermisosPorRol ADD CONSTRAINT
	FK_PermisosPorRol_Permisos FOREIGN KEY
	(
	permiso_id
	) REFERENCES dbo.Permisos
	(
	id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PermisosPorRol ADD CONSTRAINT
	FK_PermisosPorRol_Roles FOREIGN KEY
	(
	rol_id
	) REFERENCES dbo.Roles
	(
	id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PermisosPorRol SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

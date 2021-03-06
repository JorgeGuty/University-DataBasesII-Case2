create table CategoriasDePermiso
(
    id          int identity
        constraint PK_CategoriasDePermiso
            primary key,
    description nvarchar(200) not null
)
go

create table Permisos
(
    id          int identity
        constraint PK_Permisos
            primary key,
    description nvarchar(200) not null,
    code        int           not null,
    type        int           not null,
    category_id int           not null
        constraint FK_Permisos_CategoriasDePermiso
            references CategoriasDePermiso
)
go

create table Roles
(
    id   int identity
        constraint PK_Roles
            primary key,
    name nvarchar(100) not null
)
go

create table PermisosPorRol
(
    id         int identity
        constraint PK_PermisosPorRol
            primary key,
    rol_id     int      not null
        constraint FK_PermisosPorRol_Roles
            references Roles,
    permiso_id int      not null
        constraint FK_PermisosPorRol_Permisos
            references Permisos,
    postTime   datetime not null,
    deleted    bit      not null
)
go

create table Sucursal
(
    id     int identity
        constraint PK_Sucursal
            primary key,
    saldo  decimal(16, 4) not null,
    nombre nvarchar(100)  not null
)
go

create table [User]
(
    id          int identity
        constraint PK_User
            primary key,
    name        nvarchar(200) not null,
    email       nvarchar(100) not null,
    password    nvarchar(150) not null,
    sucursal_id int           not null
        constraint User_Sucursal_id_fk
            references Sucursal
)
go

create table PermisosPorUsuario
(
    id         int identity
        constraint PK_PermisosPorUsuario
            primary key,
    user_id    int      not null
        constraint FK_PermisosPorUsuario_User
            references [User],
    permiso_id int      not null
        constraint FK_PermisosPorUsuario_Permisos
            references Permisos,
    postTime   datetime not null,
    deleted    bit      not null
)
go

create table UserPorRol
(
    id      int identity
        constraint PK_UserPorRol
            primary key,
    user_id int not null
        constraint FK_UserPorRol_User
            references [User],
    rol_id  int not null
        constraint FK_UserPorRol_Roles
            references Roles
)
go


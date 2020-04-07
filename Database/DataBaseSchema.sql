
create table users(
	userID int primary key auto_increment,
	userName varchar(30) not null unique,
    password varchar(40) not null,
    Token varchar (50) unique
);

create table Empresas(
EmpresaID int primary key auto_increment,
NombreEmpresa varchar (60) not null,
Docimicilio varchar (150),
Telefono varchar(20)
);
Create table RolesEmpleados(
RolID int primary key auto_increment,
Descripcion varchar(20)
);

Create table Empleados(
EmpleadoID int primary key auto_increment,
Nombres varchar (25) not null,
ApellidoPaterno varchar (15) not null,
ApellidoMaterno varchar(15),
EstaActivo TINYINT(1),
RolID int not null,
FOREIGN KEY (RolID) REFERENCES RolesEmpleados(RolID)
);

Create table Beneficiarios(
BeneficiarioID int primary key auto_increment,
Nombres varchar(25) not null,
ApellidoPaterno varchar(25) not null,
ApellidoMaterno varchar(35),
FechaNacimiento date not null,
Ocupacion varchar(40),
EmpresaID int,
Foreign key (EmpresaID) REFERENCES Empresas(EmpresaID)
);


create table Lados(
LadoID int primary key auto_increment,
Descripcion varchar(10) not null
);
insert into Lados (Descripcion) values ('Izquierdo');
insert into Lados (Descripcion) values ('Derecho');

Create table Ojos(
OjoID int primary Key auto_increment,
LadoID int not null,
Foreign Key (LadoID) references Lados(LadoId),
Esfera int,
Cilindro int,
Eje int,
Adiccion int

);


Create table TipoConjunto(
TipoConjuntoID int primary key auto_increment,
Descripcion varchar(15)
);

Create table ConjuntoOjos(
ConjuntoID int primary key auto_increment,
IzquierdoID int,
DerechoID int,
TipoConjuntoID int,
DpLejos int,
Obl int,
Foreign key (IzquierdoID) References Ojos(OjoID),
Foreign key (DerechoID) References Ojos(OjoID),
Foreign key (TipoConjuntoID) References TipoConjunto(TipoConjuntoID)
);

insert into TipoConjunto (Descripcion) values ('Anterior');
insert into TipoConjunto (Descripcion) values ('Total');
insert into TipoConjunto (Descripcion) values ('Adaptación');

Create table EnfermedadesVisuales(
EnfermedadID int primary key auto_increment,
Descripcion varchar(70) not null

);
insert into enfermedadesVisuales (Descripcion) values ('Miopía');
insert into enfermedadesVisuales (Descripcion) values ('Astigmatismo');
insert into enfermedadesVisuales (Descripcion) values ('Hipermetropía');
insert into enfermedadesVisuales (Descripcion) values ('Presbicia');
insert into enfermedadesVisuales (Descripcion) values ('Miopía con Astigmatismo');
insert into enfermedadesVisuales (Descripcion) values ('Hipermetroía con Astigmatismo');
insert into enfermedadesVisuales (Descripcion) values ('Miopía y Presbicia');
insert into enfermedadesVisuales (Descripcion) values ('Hipermetropía y Presbicia');
insert into enfermedadesVisuales (Descripcion) values ('Astigmatismo y Presbicia');
insert into enfermedadesVisuales (Descripcion) values ('Miopía, Astigmatismo y Presbicia');
insert into enfermedadesVisuales (Descripcion) values ('Hipermetropía, Astigmatismo y Presbicia');
insert into enfermedadesVisuales (Descripcion) values ('Neutro');


Create table Examenes(
ExamenID int primary key auto_increment,
Folio varchar (10) not null unique,
BeneficiarioID int not null,
Anterior int unique,
Total int unique,
Adaptacion int unique,
FechaExamen date,
RequiereLentes TINYINT(1),
ComproLentes TINYINT(1),
EnfermedadID int,
Obervacion varchar(250),
Foreign key (BeneficiarioID) References Beneficiarios(BeneficiarioID),
Foreign key (Anterior) References ConjuntoOjos(ConjuntoID),
Foreign key (Total) References ConjuntoOjos(ConjuntoID),
Foreign key (Adaptacion) References ConjuntoOjos(ConjuntoID),
foreign key(EnfermedadID) references EnfermedadesVisuales(EnfermedadID)
);

create table Materiales(
MaterialID int primary key auto_increment,
Descripcion varchar(40) not null,
EstaActivo TINYINT(1) not null
);

Create table Protecciones(
ProteccionID int primary key auto_increment,
Descripcion varchar(40) not null,
EstaActivo TINYINT(1) not null
);

Create table Tamanios(
TamanioID int primary key auto_increment,
Descripcion varchar(40) not null,
EstaActivo TINYINT(1) not null
);

Create table Modelos(
ModeloID int primary key auto_increment,
Descripcion varchar(40) not null,
EstaActivo TINYINT(1) not null
);

Create table MarcasArmazones(
MarcaID int primary key auto_increment,
Descripcion varchar(20) not null,
EstaActivo TINYINT(1) not null
);

Create table TipoLente(
LenteID int primary key auto_increment,
Descripcion varchar(40) not null,
EstaActivo TINYINT(1) not null
);

Create table colores(
ColorID int primary key auto_increment,
Descripcion varchar(20) not null,
EstaActivo TINYINT(1) not null
);

Create table CasosMaterialesISO(
CasoID int primary key auto_increment,
Descripcion varchar(30) not null,
estaActivo TINYINT(1) not null

);

insert into CasosMaterialesISO (Descripcion, estaActivo) values ('Armazón Oftálmico', 1);
insert into CasosMaterialesISO (Descripcion, estaActivo) values ('Armazón Solar', 1);
insert into CasosMaterialesISO (Descripcion, estaActivo) values ('Cambio de micas', 1);
insert into CasosMaterialesISO (Descripcion, estaActivo) values ('Lente de contacto', 1);
insert into CasosMaterialesISO (Descripcion, estaActivo) values ('Accesorios', 1);

Create table CasosPorBeneficiario(
CasoPorBeneficiarioID int primary key auto_increment,
BeneficiarioID int not null,
CasoID int not null,
Foreign key(BeneficiarioID) references Beneficiarios(BeneficiarioID),
Foreign key(CasoID) references CasosMaterialesISO(CasoID)

);


Create table Armazones(
ArmazonID int primary key auto_increment,
MarcaID int,
ColorID int,
TamanioID int,
ModeloID int,
Foreign key(MarcaId) references MarcasArmazones(MarcaID),
Foreign key(ColorID) references Colores(ColorID),
Foreign key(TamanioID) references Tamanios(TamanioID),
Foreign key(ModeloID) references Modelos(ModeloID)
);

Create table Ventas(
VentaID int primary key auto_increment,
FolioExamen varchar(10) unique,
TotalVenta decimal(13,2) not null,
Anticipo decimal(13,2),
PeriodicidadDias int,
Abonos decimal(13,2),
fechaVenta date not null,
EstaLiquidada TINYINT(1),
ArmazonId int,
MaterialID int,
ProteccionID int,
LenteID int,
BeneficiarioID int,
ExamenID int,
Foreign key(ArmazonId) references Armazones(ArmazonID),
Foreign key(MaterialID) references Materiales(MaterialID),
Foreign key(ProteccionID) references Protecciones(ProteccionID),
Foreign key(LenteID) references TipoLente(LenteID),
Foreign key(BeneficiarioID) references Beneficiarios(BeneficiarioID),
Foreign key(ExamenID) references Examenes(ExamenID)
);

create table Abonos(
AbonoID int primary key auto_increment,
VentaID int not null,
Monto decimal(13,2) not null,
FechaAbono date,
FechaRegistro date not null,
Foreign key(VentaID) references ventas(VentaID)
);

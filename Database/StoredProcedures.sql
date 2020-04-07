
delimiter //
CREATE PROCEDURE UserRegistration(in name varchar(30),in pass varchar(40),in tok varchar (50))
BEGIN
    INSERT INTO users (userName, password, Token) values (name, pass, tok);
END //
delimiter ;

delimiter //
CREATE PROCEDURE GetToken(in name varchar(30),in pass varchar(40))
BEGIN
    SELECT Token FROM users where userName = name and password = pass;
END //
delimiter ;
delimiter //
Create PROCEDURE RegistraEmpresa(in nombre varchar(60),in Domicilio varchar(150), in telefono varchar(20))
BEGIN
	INSERT INTO Empresas (Nombreempresa, Domicilio, telefono) values(nombre, Domicilio, telefono);
END //

delimiter ;
delimiter //
create PROCEDURE RegistraBeneficiario(in nombres varchar(25),in apepat varchar(25), in apemat varchar(35),in fechanac date, ocupacion varchar(40), EmpresaID int)
BEGIN
	INSERT into beneficiarios (nombres, apellidoPaterno, apellidoMaterno, FechaNacimiento, ocupacion, EmpresaID) values (nombres, apepat, apemat, fechanac, ocupacion, EmpresaID);
END //
delimiter ;
delimiter //
CREATE PROCEDURE RegistraYSeleccionaOjo(in LadoId int,in Esfera int, in Cilindro int,in eje int, Addicion int)
BEGIN
	insert into Ojos (LadoID, esfera, cilindro, eje, adiccion) values (LadoId, Esfera, Cilindro, eje, adiccion);
    select OjoID from ojos order by OjoID desc limit 1;
END //
delimiter ;
delimiter //
create PROCEDURE RegistraYSeleccionaConjuntoOjos(in izquierdo int,in derecho int, in tipo int,in dbLejos int, _obl int)
BEGIN
	insert into ConjuntoOjos (IzquierdoID, DerechoID, TipoConjuntoID, DpLejos, Obl) values (izquierdo, derecho, tipo, dbLejos, _obl);
    Select ConjuntoID from ConjuntoOjos order By ConjuntoID desc Limit 1;
END //
delimiter ;

delimiter //
create PROCEDURE RegistraExamen(in Folio varchar(10),in BeneficiarioID INT,in Anterior int,in Total int,in adaptacion int,in fechaExamen date,in requiereLentes bit,in comproLentes bit,in enfermedadID int,in obervacion varchar(250))
BEGIN
	insert into Examenes (Folio, beneficiarioID, anterior, total, adaptacion, fechaExamen, requiereLentes, comproLentes, enfermedadID, observacion) values(folio, beneficiarioID, anterior, total, adaptacion, fechaExamen, requiereLentes, comproLentes, enfermedadID, observacion);
END //
delimiter ;
delimiter //
CREATE PROCEDURE RegistraMarcaArmazon(in descripcion varchar(40))
BEGIN
	insert into marcasarmazones (descripcion, estaActivo) values (descripcion, 1);
END //
delimiter ;
delimiter //
CREATE PROCEDURE DesactivaMarca(in MarcaArmazonID int)
BEGIN
	update marcasArmazones set EstaActivo = 0 where MarcaID = MarcaArmazonID;
END //
delimiter ;

delimiter //
CREATE PROCEDURE ActivaMarca(in MarcaArmazonID int)
BEGIN
	update marcasArmazones set EstaActivo = 1 where MarcaID = MarcaArmazonID;
END //
delimiter ;

delimiter //
CREATE PROCEDURE SeleccionaMarcas()
BEGIN
	select * from marcasarmazones where EstaActivo = 1;
END //
delimiter ;
delimiter //
CREATE PROCEDURE RegistraColor(in descripcion varchar(40))
BEGIN
	insert into colores (descripcion, estaActivo) values (descripcion, 1);
END //
delimiter ;
delimiter //
create PROCEDURE DesactivaColor(in _colorID int)
BEGIN
    update Colores set EstaActivo = 0 where ColorID= _ColorID;
END //
delimiter ;

delimiter //
create PROCEDURE ActivaColor(in _ColorID int)
BEGIN
	update colores set EstaActivo = 1 where colorID = _ColorID;
END //
delimiter ;

delimiter //
CREATE PROCEDURE SeleccionaColores()
BEGIN
	select * from colores where estaActivo = 1;
END //
delimiter ;

delimiter //
CREATE PROCEDURE RegistraTamanio(in descripcion varchar(40))
BEGIN
	insert into tamanios (descripcion, estaActivo) values (descripcion, 1);
END //
delimiter ;
delimiter //
create PROCEDURE DesactivaTamanio(in _tamanioID int)
BEGIN
    update tamanios set EstaActivo = 0 where tamanioID= _tamanioID;
END //
delimiter ;

delimiter //
create PROCEDURE ActivaTamanio(in _ColorID int)
BEGIN
	update tamanios set EstaActivo = 1 where tamanioID= _ColorID ;
END //
delimiter ;

delimiter //
CREATE PROCEDURE SeleccionaTamanios()
BEGIN
	select * from tamanios where estaActivo = 1;
END //
delimiter ;
delimiter //
CREATE PROCEDURE RegistraModelo(in descripcion varchar(40))
BEGIN
	insert into modelos (descripcion, estaActivo) values (descripcion, 1);
END //
delimiter ;
delimiter //
create PROCEDURE DesactivaModelo(in _modeloID int)
BEGIN
    update modelos set EstaActivo = 0 where modeloID = _modeloID;
END //
delimiter ;

delimiter //
create PROCEDURE ActivaModelo(in _modeloID int)
BEGIN
	update modelos set EstaActivo = 1 where modeloID = _modeloID;
END //
delimiter ;

delimiter //
CREATE PROCEDURE SeleccionaModelos()
BEGIN
	select * from modelos where estaActivo = 1;
END //
delimiter ;
delimiter //
CREATE PROCEDURE RegistraYSeleccionaArmazon(in MarcaID int, in ColorID int, in TamanioID int, in ModeloID int)
BEGIN
	insert into armazones (MarcaID, ColorID, TamanioID, ModeloID) values (marcaID, ColorID, TamanioID, ModeloID);
    select ArmazonID from Armazones order by armazonID desc limit 1;
END //
delimiter ;
delimiter //
CREATE PROCEDURE RegistraMaterial(in descripcion varchar(40))
BEGIN
	insert into materiales (descripcion, estaActivo) values (descripcion, 1);
END //
delimiter ;
delimiter //
create PROCEDURE DesactivaMaterial(in _MaterialID int)
BEGIN
    update materiales set EstaActivo = 0 where MaterialID = _MaterialID;
END //
delimiter ;

delimiter //
create PROCEDURE ActivaMaterial(in _materialID int)
BEGIN
	update materiales set EstaActivo = 1 where materialID = _materialID;
END //
delimiter ;

delimiter //
CREATE PROCEDURE SeleccionaMateriales()
BEGIN
	select * from materiales where estaActivo = 1;
END //
delimiter ;

delimiter //
CREATE PROCEDURE RegistraProteccion(in descripcion varchar(40))
BEGIN
	insert into protecciones (descripcion, estaActivo) values (descripcion, 1);
END //
delimiter ;
delimiter //
create PROCEDURE DesactivaProteccion(in _ProteccionID int)
BEGIN
    update protecciones set EstaActivo = 0 where ProteccionID = _ProteccionID;
END //
delimiter ;

delimiter //
create PROCEDURE ActivaProteccion(in _ProteccionID int)
BEGIN
	update protecciones set EstaActivo = 1 where ProteccionID = _ProteccionID;
END //
delimiter ;

delimiter //
CREATE PROCEDURE SeleccionaProtecciones()
BEGIN
	select * from protecciones where estaActivo = 1;
END //
delimiter ;
delimiter //
CREATE PROCEDURE RegistraLente(in descripcion varchar(40))
BEGIN
	insert into TipoLente (descripcion, estaActivo) values (descripcion, 1);
END //
delimiter ;
delimiter //
create PROCEDURE DesactivaLente(in _lenteID int)
BEGIN
    update tipolente set EstaActivo = 0 where lenteID = _lenteID;
END //
delimiter ;

delimiter //
create PROCEDURE ActivaLente(in _lenteID int)
BEGIN
	update tipolente set EstaActivo = 1 where lenteID = _lenteID;
END //
delimiter ;

delimiter //
CREATE PROCEDURE SeleccionaLentes()
BEGIN
	select * from tipoLente where estaActivo = 1;
END //
delimiter ;
delimiter //
CREATE PROCEDURE RegistraYSeleccionaVenta(in FolioExamen varchar(10),in totalVenta decimal(13, 2), in Anticipo decimal(13, 2),in Periodicidad int, in abonos decimal(13, 2), in fechaVenta date, in armazonID int, in materialID int, in proteccionID int, in lenteID int, in beneficiarioID int)
BEGIN
	DECLARE ExamenID INT DEFAULT 0;
	SET ExamenID = (select ExamenID from Examenes where folio = FolioExamen);
    insert into Ventas (folioExamen, totalVenta, anticipo, periodicidadDias, Abonos, fechaVenta, EstaLiquidada, armazonID, materialID, ProteccionID, LenteID, BeneficiarioID, ExamenID) values (folioExamen, totalVenta, anticipo, periodicidad, abonos, fechaventa, 0, armazonID, materialID, proteccionID, lenteID, beneficiarioID, examenID);
	select ventaID from ventas order by ventaID desc limit 1;
END //
delimiter ;

delimiter //
create PROCEDURE liquidaVenta(in _ventaID int)
BEGIN
	update ventas set EstaLiquidada = 1 where ventaID = _ventaID;
END //
delimiter ;

delimiter //
create PROCEDURE validaEmpresa(in Id int)
BEGIN
	select count(*) from empresas where EmpresaId = Id;
END //
delimiter ;
delimiter //
create PROCEDURE seleccionaEmpresas()
BEGIN
	select * from empresas;
END //
delimiter ;
delimiter //
create PROCEDURE seleccionaBeneficiariosPorEmpresa(in empresa_ID int)
BEGIN
	select * from beneficiarios where EmpresaID = empresa_ID;
END //
delimiter ;
delimiter //
create PROCEDURE validaToken(in keyToken varchar(40))
BEGIN
	select count(*) as Result from users where token = keyToken;
END //
delimiter ;
delimiter //
create PROCEDURE seleccionaExamenPorFolio(in _folio varchar(10))
BEGIN
	select * from examenes where folio = _folio;
END //
delimiter ;
delimiter //
create PROCEDURE seleccionaExamenPorBeneficiario(in _beneficiarioId int)
BEGIN
	select * from examenes where beneficiarioId = _beneficiarioId;
END //
delimiter ;
delimiter //
create PROCEDURE conjuntoOjosPorId(in _conjunto_id int)
BEGIN
	select * from conjuntoOjos where conjuntoId = _conjunto_id ;
END //
delimiter ;

delimiter //
create PROCEDURE ojoPorId(in _ojoid int)
BEGIN
	select * from ojos where ojoId = _ojoid ;
END //
delimiter ;

delimiter //
create PROCEDURE GetResumenExamenesPorEmpresa(in _EmpresaId int)
BEGIN

select e.folio, b.Nombres, b.Apellidopaterno, b.ocupacion, ev.descripcion as enfermedad,  YEAR(CURDATE()) - YEAR(fechanacimiento) -
IF(STR_TO_DATE(CONCAT(YEAR(CURDATE()), '-', MONTH(fechanacimiento), '-', DAY(fechanacimiento)) ,'%Y-%c-%e') > CURDATE(), 1, 0)
AS edad, e.requiereLentes from examenes e 
    inner join enfermedadesvisuales ev 
    on e.enfermedadId = ev.enfermedadId 
    inner join beneficiarios b 
    on e.beneficiarioId = b.beneficiarioId
    where b.empresaId = _empresaId;
	
END //
delimiter ;
delimiter //
create PROCEDURE SeleccionaCasosActivos()
BEGIN
	select * from CasosMaterialesISO where estaActivo = 1;  
END //
delimiter ;

delimiter //
create PROCEDURE SeleccionaCasosPorBeneficiario(in _beneficiarioId int)
BEGIN
	select * from CasosPorBeneficiario where beneficiarioId = _beneficiarioId;
END //
delimiter ;
delimiter //
create PROCEDURE RegistraCasosPorBeneficiario(in _beneficiarioId int, in _casoId int)
BEGIN
	insert into CasosPorBeneficiario (BeneficiarioId, casoId) values (_beneficiarioId, _casoId);
END //
delimiter ;
delimiter //
create PROCEDURE validaBeneficiario(in _beneficiarioId int)
BEGIN
	select count(*) as count from beneficiarios where beneficiarioid =  _beneficiarioId;
END //
delimiter ;



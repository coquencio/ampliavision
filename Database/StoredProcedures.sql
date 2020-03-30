
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
CREATE PROCEDURE RegistraEmpresa(in nombre varchar(60),in Domicilio varchar(150), in telefono varchar(20))
BEGIN
	INSERT INTO Empresas (Nombre, Domicilio, telefono) values(nombre, Domicilio, telefono);
END //
delimiter ;
delimiter //
CREATE PROCEDURE RegistraBeneficiario(in nombres varchar(25),in apepat varchar(25), in apemat varchar(35),in fechanac date, ocupacion varchar(40), EmpresaID int)
BEGIN
	INSERT into beneficiarios (nombres, appellidoPaterno, apellidoMaterno, FechaNacimiento, ocupacion, EmpresaID) values (nombres, apepat, apemat, fechanac, ocupacion, EmpresaID);
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
CREATE PROCEDURE RegistraYSeleccionaConjuntoOjos(in izquierdo int,in derecho int, in tipo int,in dpLejos int, obl int)
BEGIN
	insert into ConjuntoOjos (IzquierdoID, DerechoID, TipoConjuntoID, DpLejos, Obl) values (izquierdo, derecho, tipo, dbLejos, obl);
    Select ConjuntoID from ConjuntoOjos order By ConjuntoID desc Limit 1;
END //
delimiter ;

delimiter //
CREATE PROCEDURE RegistraExamen(in Folio varchar(10),in BeneficiarioID INT,in Anterior int,in Total int,in adaptacion int,in fechaExamen date,in requiereLentes bit,in comproLentes bit,in enfermedadID int,in obervacion varchar(250))
BEGIN
	insert into Examenes (Folio, beneficiarioID, anterior, total, adaptacion, fechaExamen, requiereLentes, comproLentes, enfermedadID, obervacion) values(folio, beneficiarioID, anterior, total, adaptacion, fechaExamen, requiereLentes, comproLentes, enfermedadID, observacion);
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
CREATE PROCEDURE DesactivaColor(in colorID int)
BEGIN
    update Colores set EstaActivo = 0 where ColorID= ColorID;
END //
delimiter ;

delimiter //
CREATE PROCEDURE ActivaColor(in ColorID int)
BEGIN
	update colores set EstaActivo = 1 where colorID = ColorID;
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
CREATE PROCEDURE DesactivaTamanio(in tamanioID int)
BEGIN
    update tamanios set EstaActivo = 0 where tamanioID= tamanioID;
END //
delimiter ;

delimiter //
CREATE PROCEDURE ActivaTamanio(in ColorID int)
BEGIN
	update tamanios set EstaActivo = 1 where tamanioID= TamanioID;
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
CREATE PROCEDURE DesactivaModelo(in modeloID int)
BEGIN
    update modelos set EstaActivo = 0 where modeloID = modeloID;
END //
delimiter ;

delimiter //
CREATE PROCEDURE ActivaModelo(in modeloID int)
BEGIN
	update modelos set EstaActivo = 1 where modeloID = modeloID;
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
CREATE PROCEDURE DesactivaMaterial(in MaterialID int)
BEGIN
    update materiales set EstaActivo = 0 where MaterialID = MaterialID;
END //
delimiter ;

delimiter //
CREATE PROCEDURE ActivaMaterial(in materialID int)
BEGIN
	update materiales set EstaActivo = 1 where materialID = materialID;
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
CREATE PROCEDURE DesactivaProteccion(in ProteccionID int)
BEGIN
    update protecciones set EstaActivo = 0 where ProteccionID = ProteccionID;
END //
delimiter ;

delimiter //
CREATE PROCEDURE ActivaProteccion(in ProteccionID int)
BEGIN
	update protecciones set EstaActivo = 1 where ProteccionID = ProteccionID;
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
CREATE PROCEDURE DesactivaLente(in lenteID int)
BEGIN
    update tipolente set EstaActivo = 0 where lenteID = lenteID;
END //
delimiter ;

delimiter //
CREATE PROCEDURE ActivaLente(in lenteID int)
BEGIN
	update tipolente set EstaActivo = 1 where lenteID = lenteID;
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
CREATE PROCEDURE liquidaVenta(in ventaID int)
BEGIN
	update ventas set EstaLiquidada = 1 where ventaID = ventaID;
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

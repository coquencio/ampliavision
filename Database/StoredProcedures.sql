DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActivaMarca`(in MarcaArmazonID int)
BEGIN
	update MarcasArmazones set EstaActivo = 1 where MarcaID = MarcaArmazonID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActivaColor`(in _ColorID int)
BEGIN
	update colores set EstaActivo = 1 where colorID = _ColorID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActivaMaterial`(in _materialID int)
BEGIN
	update Materiales set EstaActivo = 1 where materialID = _materialID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActivaLente`(in _lenteID int)
BEGIN
	update TipoLente set EstaActivo = 1 where lenteID = _lenteID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActivaModelo`(in _modeloID int)
BEGIN
	update Modelos set EstaActivo = 1 where modeloID = _modeloID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActivaTamanio`(in _ColorID int)
BEGIN
	update Tamanios set EstaActivo = 1 where tamanioID= _ColorID ;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActualizaExamen`(IN `_Folio` VARCHAR(10), IN `_BeneficiarioID` INT, IN `_Anterior` INT, IN `_Total` INT, IN `_adaptacion` INT, IN `_requiereLentes` BIT, IN `_comproLentes` BIT, IN `_enfermedadID` INT, IN `_obervacion` VARCHAR(250))
BEGIN
	update Examenes set beneficiarioID = _BeneficiarioID , anterior=_Anterior, total=_Total, adaptacion=_adaptacion, requiereLentes=_requiereLentes , comproLentes=_comproLentes , enfermedadID = _enfermedadID , observacion = _obervacion  where Folio = _Folio;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActualizaAbono`(in _abonoID int, in _fecha date, in _monto decimal(13,2))
BEGIN
	update Abonos set monto=_monto, fechaAbono =  _fecha where abonoId = _abonoID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActualizaBeneficiario`(in _beneficiarioId int, in _nombres varchar(25),in _apepat varchar(25), in _apemat varchar(35),in _fechanac date, _ocupacion varchar(40))
BEGIN
	update Beneficiarios set nombres = _nombres, apellidoPaterno=_apepat, apellidoMaterno=_apemat, FechaNacimiento=_fechanac, ocupacion=_ocupacion where BeneficiarioID = _beneficiarioId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActivaProteccion`(in _ProteccionID int)
BEGIN
	update Protecciones set EstaActivo = 1 where ProteccionID = _ProteccionID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `Admin`(in _token varchar(50))
BEGIN
	select Admin from users where token = _token;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `BorraVenta`(in _ventaId int)
BEGIN
	delete from Ventas where ventaID= _ventaId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `BalanceSinLiquidar`(in _empresaid int)
BEGIN
	select sum(v.TotalVenta) as TotalFake, sum(v.Anticipo) as AnticiposFake from Ventas v inner join Beneficiarios b on v.BeneficiarioID = b.BeneficiarioID where b.empresaID = _empresaid and v.EstaLiquidada=0;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `Chart1`(in _empresaId int)
BEGIN

select count(*) as DataSet, requiereLentes, comproLentes from Examenes e inner join Beneficiarios b on e.BeneficiarioID = b.BeneficiarioID where b.EmpresaID = _empresaId  group by RequiereLentes , comproLentes ;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `Chart2`(in _empresaId int)
BEGIN

select count(*) as Total, s.Descripcion from Examenes e inner join Beneficiarios b on e.BeneficiarioID = b.BeneficiarioID inner join EnfermedadesVisuales s on e.EnfermedadID = s.EnfermedadID where b.EmpresaID = _empresaId group by e.EnfermedadID;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `DeleteIsoRelation`(in _relationId int)
BEGIN
	delete from CasosPorBeneficiario where casoPorBeneficiarioID = _relationId ;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `Chart3`(in _empresaId int)
BEGIN


	select count(*) as Total, i.Descripcion from CasosPorBeneficiario c inner join CasosMaterialesISO i on c.casoID=i.CasoId inner join Beneficiarios b on c.BeneficiarioID = b.BeneficiarioID where i.EstaActivo = 1 and b.EmpresaID = _empresaId  group by c.CasoID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `DesactivaColor`(in _colorID int)
BEGIN
    update colores set EstaActivo = 0 where ColorID= _ColorID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `DesactivaMaterial`(in _MaterialID int)
BEGIN
    update Materiales set EstaActivo = 0 where MaterialID = _MaterialID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `DesactivaMarca`(in MarcaArmazonID int)
BEGIN
	update MarcasArmazones set EstaActivo = 0 where MarcaID = MarcaArmazonID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `DesactivaModelo`(in _modeloID int)
BEGIN
    update Modelos set EstaActivo = 0 where modeloID = _modeloID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `DesactivaProteccion`(in _ProteccionID int)
BEGIN
    update Protecciones set EstaActivo = 0 where ProteccionID = _ProteccionID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `DesactivaLente`(in _lenteID int)
BEGIN
    update TipoLente set EstaActivo = 0 where lenteID = _lenteID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `DesactivaTamanio`(in _tamanioID int)
BEGIN
    update Tamanios set EstaActivo = 0 where tamanioID= _tamanioID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `GetBeneficiarioNombrePorId`(in _beneficiario_id int)
BEGIN
	select nombres, apellidoPaterno, apellidoMaterno from Beneficiarios where beneficiarioid = _beneficiario_id ;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `GetToken`(in name varchar(30),in pass varchar(40))
BEGIN
    SELECT Token FROM users where userName = name and password = pass;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraEmpresa`(IN `nombre` VARCHAR(60), IN `Domicilio` VARCHAR(150), IN `telefono` VARCHAR(20))
BEGIN
	INSERT INTO Empresas (Nombreempresa, Domicilio, telefono) values(nombre, Domicilio, telefono);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraBeneficiario`(in nombres varchar(25),in apepat varchar(25), in apemat varchar(35),in fechanac date, ocupacion varchar(40), EmpresaID int)
BEGIN
	INSERT into Beneficiarios (nombres, apellidoPaterno, apellidoMaterno, FechaNacimiento, ocupacion, EmpresaID) values (nombres, apepat, apemat, fechanac, ocupacion, EmpresaID);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraCasosPorBeneficiario`(in _beneficiarioId int, in _casoId int)
BEGIN
	insert into CasosPorBeneficiario (BeneficiarioId, casoId) values (_beneficiarioId, _casoId);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraColor`(in descripcion varchar(40))
BEGIN
	insert into colores (descripcion, estaActivo) values (descripcion, 1);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `PuedeBorrar`(in _ventaId int)
BEGIN
	select count(*) as total from Abonos where ventaID= _ventaId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraExamen`(IN `Folio` VARCHAR(10), IN `BeneficiarioID` INT, IN `Anterior` INT, IN `Total` INT, IN `adaptacion` INT, IN `fechaExamen` DATE, IN `requiereLentes` BIT, IN `comproLentes` BIT, IN `enfermedadID` INT, IN `obervacion` VARCHAR(250))
BEGIN
	insert into Examenes (Folio, beneficiarioID, anterior, total, adaptacion, fechaExamen, requiereLentes, comproLentes, enfermedadID, observacion) values(folio, beneficiarioID, anterior, total, adaptacion, fechaExamen, requiereLentes, comproLentes, enfermedadID, obervacion);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraLente`(in descripcion varchar(40))
BEGIN
	insert into TipoLente (descripcion, estaActivo) values (descripcion, 1);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraMarcaArmazon`(in descripcion varchar(40))
BEGIN
	insert into MarcasArmazones (descripcion, estaActivo) values (descripcion, 1);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraMaterial`(in descripcion varchar(40))
BEGIN
	insert into Materiales (descripcion, estaActivo) values (descripcion, 1);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraProteccion`(in descripcion varchar(40))
BEGIN
	insert into Protecciones (descripcion, estaActivo) values (descripcion, 1);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraTamanio`(in descripcion varchar(40))
BEGIN
	insert into Tamanios (descripcion, estaActivo) values (descripcion, 1);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraYSeleccionaConjuntoOjos`(in izquierdo int,in derecho int, in tipo int,in dbLejos int, _obl int)
BEGIN
	insert into ConjuntoOjos (IzquierdoID, DerechoID, TipoConjuntoID, DpLejos, Obl) values (izquierdo, derecho, tipo, dbLejos, _obl);
    Select ConjuntoID from ConjuntoOjos order By ConjuntoID desc Limit 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraYSeleccionaArmazon`(in MarcaID int, in ColorID int, in TamanioID int, in ModeloID int, in _DetalleEnArmazon varchar(35))
BEGIN
	insert into Armazones (MarcaID, ColorID, TamanioID, ModeloID, DetalleEnArmazon ) values (marcaID, ColorID, TamanioID, ModeloID, _DetalleEnArmazon);
    select ArmazonID from Armazones order by armazonID desc limit 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraYSeleccionaOjo`(in LadoId int,in Esfera int, in Cilindro int,in eje int, Addicion int)
BEGIN
	insert into Ojos (LadoID, esfera, cilindro, eje, adiccion) values (LadoId, Esfera, Cilindro, eje, Addicion);
    select OjoID from Ojos order by OjoID desc limit 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `GetResumenExamenesPorEmpresa`(IN `_EmpresaId` INT)
BEGIN

select e.folio, b.beneficiarioId as BeneficiarioId, v.VentaID as VentaID, b.Nombres, b.Apellidopaterno, b.ocupacion, ev.descripcion as enfermedad,  YEAR(CURDATE()) - YEAR(fechanacimiento) -
IF(STR_TO_DATE(CONCAT(YEAR(CURDATE()), '-', MONTH(fechanacimiento), '-', DAY(fechanacimiento)) ,'%Y-%c-%e') > CURDATE(), 1, 0)
AS edad, e.requiereLentes from Examenes e 
    inner join EnfermedadesVisuales ev 
    on e.enfermedadId = ev.enfermedadId 
    inner join Beneficiarios b 
    on e.beneficiarioId = b.beneficiarioId
    left join Ventas v on e.folio = v.folioExamen
    where b.empresaId = _empresaId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraYSeleccionaVenta`(in FolioExamen varchar(10),in totalVenta decimal(13, 2), in Anticipo decimal(13, 2),in Periodicidad int, in abonos decimal(13, 2), in fechaVenta date, in armazonID int, in materialID int, in proteccionID int, in lenteID int, in beneficiarioID int, in tipoVentaID int)
BEGIN
	select ExamenID into @ExamenID  from Examenes where folio = FolioExamen;
    insert into Ventas (folioExamen, totalVenta, anticipo, periodicidadDias, Abonos, fechaVenta, EstaLiquidada, armazonID, materialID, ProteccionID, LenteID, BeneficiarioID, ExamenID, TipoVentaID) values (folioExamen, totalVenta, anticipo, periodicidad, abonos, fechaventa, 0, armazonID, materialID, proteccionID, lenteID, beneficiarioID, @ExamenID, tipoVentaID);
	select ventaID from Ventas order by ventaID desc limit 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegresaFolios`(in empresa_Id int)
BEGIN
	select folio from Examenes e inner join Beneficiarios b on b.beneficiarioId = e.BeneficiarioId where b.empresaId = empresa_Id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaBeneficiaroPorFolio`(in _folio varchar(50))
BEGIN
select BeneficiarioID from Examenes where Folio = _folio;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaCasosActivos`()
BEGIN
	select * from CasosMaterialesISO where estaActivo = 1;  
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaColores`()
BEGIN
	select * from colores where estaActivo = 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraModelo`(in descripcion varchar(40))
BEGIN
	insert into Modelos (descripcion, estaActivo) values (descripcion, 1);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaEmpresaIDPorFolio`(in _folio varchar(25))
BEGIN
	
select e.empresaID as EmpresaID from Empresas e inner join Beneficiarios b on e.EmpresaID=b.EmpresaID right join Examenes x on b.BeneficiarioID = x.BeneficiarioID where x.folio = _folio;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaEmpresaIDPorVentaID`(in _ventaID int)
BEGIN
	
select e.empresaID as EmpresaID from Empresas e inner join Beneficiarios b on e.EmpresaID=b.EmpresaID right join Ventas v on b.BeneficiarioID = v.BeneficiarioID where v.ventaId = _ventaID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaMarcas`()
BEGIN
	select * from MarcasArmazones where EstaActivo = 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaLentes`()
BEGIN
	select * from TipoLente where estaActivo = 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaMontoAbono`(in _abonoID int)
BEGIN
	select monto as Monto from Abonos where abonoId = _abonoID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaMateriales`()
BEGIN
	select * from Materiales where estaActivo = 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaModelos`()
BEGIN
	select * from Modelos where estaActivo = 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaNombreConToken`(in _token varchar(50))
BEGIN
	select userName from users where token = _token;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaProtecciones`()
BEGIN
	select * from Protecciones where estaActivo = 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaResumentVentas`(in _empresaid int)
BEGIN
	select sum(v.TotalVenta) as Total, sum(v.Anticipo) as Anticipos from Ventas v inner join Beneficiarios b on v.BeneficiarioID = b.BeneficiarioID where b.empresaID = _empresaid;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaTamanios`()
BEGIN
	select * from Tamanios where estaActivo = 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SelectSaldoVenta`(in _ventaId int)
BEGIN
	select (totalVenta - anticipo) as total from Ventas where ventaId = _ventaId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaTotalAbonos`(in _empresaid int)
BEGIN
	select sum(monto) as Montos from Abonos a inner join Ventas v on a.VentaID = v.VentaID inner join Beneficiarios b on b.BeneficiarioID = v.BeneficiarioID where b.EmpresaID = _empresaid;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaVentaPorAbono`(in _abonoID int)
BEGIN
	select v.VentaID as Id from Ventas v inner join Abonos a on a.VentaID=v.VentaID where a.AbonoID = _abonoID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `UserRegistration`(in name varchar(30),in pass varchar(40),in tok varchar (50))
BEGIN
    INSERT INTO users (userName, password, Token) values (name, pass, tok);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ValidaFolio`(in _FolioExamen varchar(10))
BEGIN
	select count(*) from Ventas where FolioExamen = _FolioExamen;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `conjuntoOjosPorId`(in _conjunto_id int)
BEGIN
	select * from ConjuntoOjos where conjuntoId = _conjunto_id ;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `borraAbono`(in _abonoId int)
BEGIN
	delete from Abonos where abonoId = _abonoId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `desLiquidaVenta`(in _ventaId int)
BEGIN
	update Ventas set EstaLiquidada =  0 where VentaID = _ventaId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `registraAbono`(in _ventaId int, in _monto decimal(13,2), in _fechaAbono date, in _nombre varchar(50))
BEGIN
	insert into Abonos (ventaId, monto, fechaAbono, fechaRegistro, RegistradoPor) values (_ventaId, _monto, _fechaAbono, curdate(), _nombre);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaAbonosPorVenta`(in _ventaId int)
BEGIN
	Select * from Abonos where ventaid = _ventaId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaBeneficiariosPorEmpresa`(in empresa_ID int)
BEGIN
	select * from Beneficiarios where EmpresaID = empresa_ID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaEmpresas`()
BEGIN
	select * from Empresas;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaExamenPorBeneficiario`(in _beneficiarioId int)
BEGIN
	select * from Examenes where beneficiarioId = _beneficiarioId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `liquidaVenta`(in _ventaID int)
BEGIN
	update Ventas set EstaLiquidada = 1 where ventaID = _ventaID;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaDetallesDeArmazonPorVenta`(in _ventaId int)
BEGIN
	select a.armazonId as Id, m.Descripcion as Marca, c.descripcion as Color, t.descripcion as Tamanio, mo.descripcion as Modelo, a.detalleenarmazon as Detalle from Ventas v inner join Armazones a on v.armazonId = a.armazonId inner join MarcasArmazones m on a.marcaId = m.marcaId inner join colores c on a.colorId = c.colorId inner join Tamanios t on a.tamanioId = t.tamanioId inner join Modelos mo on a.modeloId = mo.modeloId where v.ventaId = _ventaId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaExamenPorFolio`(in _folio varchar(10))
BEGIN
	select * from Examenes where folio = _folio;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaResumenVentasPorEmpresa`(in _empresaId int)
BEGIN
		select v.ventaId as VentaId, v.TipoVentaID as Tipo, v.FolioExamen, b.nombres as Nombres, v.EstaLiquidada as EstaLiquidada, v.fechaVenta as Fecha ,b.apellidoPaterno as Apellido, b.Ocupacion as Puesto, ex.RequiereLentes, ex.comprolentes,  m.descripcion as Material, p.descripcion as Proteccion, t.descripcion as Lente, v.totalventa as Total, v.anticipo as Aticipo, v.abonos as Abonos from Ventas v inner join Beneficiarios b on v.beneficiarioId = b.beneficiarioId inner join Materiales m on v.materialId = m.materialId inner join Protecciones p on v.proteccionId = p.proteccionId inner join TipoLente t on v.lenteId = t.lenteId left join Examenes ex on v.examenId= ex.ExamenId where b.empresaId = _empresaId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaSumAbonosPorVenta`(in _ventaId int)
BEGIN
	Select sum(Monto) from Abonos where ventaid = _ventaId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ojoPorId`(in _ojoid int)
BEGIN
	select * from Ojos where ojoId = _ojoid ;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `validaBeneficiario`(in _beneficiarioId int)
BEGIN
	select count(*) as count from Beneficiarios where beneficiarioid =  _beneficiarioId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `validaToken`(in keyToken varchar(40))
BEGIN
	select count(*) as Result from users where token = keyToken;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `validaEmpresa`(in Id int)
BEGIN
	select count(*) from Empresas where EmpresaId = Id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaCasosPorBeneficiario`(in _beneficiarioId int)
BEGIN
	select * from CasosPorBeneficiario where beneficiarioId = _beneficiarioId;
END$$
DELIMITER ;

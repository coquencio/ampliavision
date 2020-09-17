-- phpMyAdmin SQL Dump
-- version 4.9.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 17, 2020 at 10:25 AM
-- Server version: 5.6.47-cll-lve
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ampliavision`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActivaColor` (IN `_ColorID` INT)  BEGIN
	update colores set EstaActivo = 1 where colorID = _ColorID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActivaLente` (IN `_lenteID` INT)  BEGIN
	update TipoLente set EstaActivo = 1 where lenteID = _lenteID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActivaMarca` (IN `MarcaArmazonID` INT)  BEGIN
	update MarcasArmazones set EstaActivo = 1 where MarcaID = MarcaArmazonID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActivaMaterial` (IN `_materialID` INT)  BEGIN
	update Materiales set EstaActivo = 1 where materialID = _materialID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActivaModelo` (IN `_modeloID` INT)  BEGIN
	update Modelos set EstaActivo = 1 where modeloID = _modeloID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActivaProteccion` (IN `_ProteccionID` INT)  BEGIN
	update Protecciones set EstaActivo = 1 where ProteccionID = _ProteccionID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActivaTamanio` (IN `_ColorID` INT)  BEGIN
	update Tamanios set EstaActivo = 1 where tamanioID= _ColorID ;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActualizaAbono` (IN `_abonoID` INT, IN `_fecha` DATE, IN `_monto` DECIMAL(13,2))  BEGIN
	update Abonos set monto=_monto, fechaAbono =  _fecha where abonoId = _abonoID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActualizaBeneficiario` (IN `_beneficiarioId` INT, IN `_nombres` VARCHAR(25), IN `_apepat` VARCHAR(25), IN `_apemat` VARCHAR(35), IN `_fechanac` DATE, `_ocupacion` VARCHAR(40))  BEGIN
	update Beneficiarios set nombres = _nombres, apellidoPaterno=_apepat, apellidoMaterno=_apemat, FechaNacimiento=_fechanac, ocupacion=_ocupacion where BeneficiarioID = _beneficiarioId;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActualizaContra` (IN `_mail` VARCHAR(100), IN `_pswd` VARCHAR(10000))  BEGIN
	update emails set pswd = _pswd where mail = _mail;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActualizaEmpresa` (IN `_id` INT, IN `_nombre` VARCHAR(60), IN `_Domicilio` VARCHAR(150), IN `_telefono` VARCHAR(20))  BEGIN
	update Empresas set Nombreempresa = _nombre, Domicilio=_Domicilio, telefono= _telefono where EmpresaID = _id;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActualizaExamen` (IN `_Folio` VARCHAR(10), IN `_BeneficiarioID` INT, IN `_Anterior` INT, IN `_Total` INT, IN `_adaptacion` INT, IN `_requiereLentes` BIT, IN `_comproLentes` BIT, IN `_enfermedadID` INT, IN `_obervacion` VARCHAR(250))  BEGIN
	update Examenes set beneficiarioID = _BeneficiarioID , anterior=_Anterior, total=_Total, adaptacion=_adaptacion, requiereLentes=_requiereLentes , comproLentes=_comproLentes , enfermedadID = _enfermedadID , observacion = _obervacion  where Folio = _Folio;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActualizaPropiedad` (IN `_name` VARCHAR(100), IN `_value` VARCHAR(10000))  BEGIN
	update properties set propertyValue = _value where propertyName = _name;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `Admin` (IN `_token` VARCHAR(50))  BEGIN
	select Admin from users where token = _token;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `BalanceSinLiquidar` (IN `_empresaid` INT)  BEGIN
	select sum(v.TotalVenta) as TotalFake, sum(v.Anticipo) as AnticiposFake from Ventas v inner join Beneficiarios b on v.BeneficiarioID = b.BeneficiarioID where b.empresaID = _empresaid and v.EstaLiquidada=0;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `borraAbono` (IN `_abonoId` INT)  BEGIN
	delete from Abonos where abonoId = _abonoId;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `BorraVenta` (IN `_ventaId` INT)  BEGIN
	delete from Ventas where ventaID= _ventaId;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `Chart1` (IN `_empresaId` INT)  BEGIN

select count(*) as DataSet, requiereLentes, comproLentes from Examenes e inner join Beneficiarios b on e.BeneficiarioID = b.BeneficiarioID where b.EmpresaID = _empresaId  group by RequiereLentes , comproLentes ;

END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `Chart2` (IN `_empresaId` INT)  BEGIN

select count(*) as Total, s.Descripcion from Examenes e inner join Beneficiarios b on e.BeneficiarioID = b.BeneficiarioID inner join EnfermedadesVisuales s on e.EnfermedadID = s.EnfermedadID where b.EmpresaID = _empresaId group by e.EnfermedadID;

END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `Chart3` (IN `_empresaId` INT)  BEGIN


	select count(*) as Total, i.Descripcion from CasosPorBeneficiario c inner join CasosMaterialesISO i on c.casoID=i.CasoId inner join Beneficiarios b on c.BeneficiarioID = b.BeneficiarioID where i.EstaActivo = 1 and b.EmpresaID = _empresaId  group by c.CasoID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `conjuntoOjosPorId` (IN `_conjunto_id` INT)  BEGIN
	select * from ConjuntoOjos where conjuntoId = _conjunto_id ;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ConsultaPropiedad` (IN `_name` VARCHAR(100))  BEGIN
	select propertyValue from properties where propertyName = _name;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `DeleteIsoRelation` (IN `_relationId` INT)  BEGIN
	delete from CasosPorBeneficiario where casoPorBeneficiarioID = _relationId ;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `DesactivaColor` (IN `_colorID` INT)  BEGIN
    update colores set EstaActivo = 0 where ColorID= _ColorID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `DesactivaLente` (IN `_lenteID` INT)  BEGIN
    update TipoLente set EstaActivo = 0 where lenteID = _lenteID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `DesactivaMarca` (IN `MarcaArmazonID` INT)  BEGIN
	update MarcasArmazones set EstaActivo = 0 where MarcaID = MarcaArmazonID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `DesactivaMaterial` (IN `_MaterialID` INT)  BEGIN
    update Materiales set EstaActivo = 0 where MaterialID = _MaterialID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `DesactivaModelo` (IN `_modeloID` INT)  BEGIN
    update Modelos set EstaActivo = 0 where modeloID = _modeloID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `DesactivaProteccion` (IN `_ProteccionID` INT)  BEGIN
    update Protecciones set EstaActivo = 0 where ProteccionID = _ProteccionID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `DesactivaTamanio` (IN `_tamanioID` INT)  BEGIN
    update Tamanios set EstaActivo = 0 where tamanioID= _tamanioID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `desLiquidaVenta` (IN `_ventaId` INT)  BEGIN
	update Ventas set EstaLiquidada =  0 where VentaID = _ventaId;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `EliminaMail` (IN `_mail` VARCHAR(100))  BEGIN
	delete from emails where mail = _mail;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `EliminaPropiedad` (IN `_name` VARCHAR(100))  BEGIN
	DELETE from properties where propertyName = _name;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `GetBeneficiarioNombrePorId` (IN `_beneficiario_id` INT)  BEGIN
	select nombres, apellidoPaterno, apellidoMaterno from Beneficiarios where beneficiarioid = _beneficiario_id ;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `GetResumenExamenesPorEmpresa` (IN `_EmpresaId` INT)  BEGIN

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

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `GetToken` (IN `name` VARCHAR(30), IN `pass` VARCHAR(40))  BEGIN
    SELECT Token FROM users where userName = name and password = pass;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `InsertaMail` (IN `_mail` VARCHAR(100), `_pswd` VARCHAR(100))  BEGIN
	insert into emails (mail, pswd) values (_mail, _pswd);
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `InsertaPropiedad` (IN `_name` VARCHAR(100), IN `_value` VARCHAR(10000))  BEGIN
	insert into properties (propertyName, propertyValue) values (_name, _value);
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `liquidaVenta` (IN `_ventaID` INT)  BEGIN
	update Ventas set EstaLiquidada = 1 where ventaID = _ventaID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ojoPorId` (IN `_ojoid` INT)  BEGIN
	select * from Ojos where ojoId = _ojoid ;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `PuedeBorrar` (IN `_ventaId` INT)  BEGIN
	select count(*) as total from Abonos where ventaID= _ventaId;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `registraAbono` (IN `_ventaId` INT, IN `_monto` DECIMAL(13,2), IN `_fechaAbono` DATE, IN `_nombre` VARCHAR(50))  BEGIN
	insert into Abonos (ventaId, monto, fechaAbono, fechaRegistro, RegistradoPor) values (_ventaId, _monto, _fechaAbono, curdate(), _nombre);
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraBeneficiario` (IN `nombres` VARCHAR(25), IN `apepat` VARCHAR(25), IN `apemat` VARCHAR(35), IN `fechanac` DATE, `ocupacion` VARCHAR(40), `EmpresaID` INT)  BEGIN
	INSERT into Beneficiarios (nombres, apellidoPaterno, apellidoMaterno, FechaNacimiento, ocupacion, EmpresaID) values (nombres, apepat, apemat, fechanac, ocupacion, EmpresaID);
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraCasosPorBeneficiario` (IN `_beneficiarioId` INT, IN `_casoId` INT)  BEGIN
	insert into CasosPorBeneficiario (BeneficiarioId, casoId) values (_beneficiarioId, _casoId);
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraColor` (IN `descripcion` VARCHAR(40))  BEGIN
	insert into colores (descripcion, estaActivo) values (descripcion, 1);
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraEmpresa` (IN `nombre` VARCHAR(60), IN `Domicilio` VARCHAR(150), IN `telefono` VARCHAR(20))  BEGIN
	INSERT INTO Empresas (Nombreempresa, Domicilio, telefono) values(nombre, Domicilio, telefono);
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraExamen` (IN `Folio` VARCHAR(10), IN `BeneficiarioID` INT, IN `Anterior` INT, IN `Total` INT, IN `adaptacion` INT, IN `fechaExamen` DATE, IN `requiereLentes` BIT, IN `comproLentes` BIT, IN `enfermedadID` INT, IN `obervacion` VARCHAR(250))  BEGIN
	insert into Examenes (Folio, beneficiarioID, anterior, total, adaptacion, fechaExamen, requiereLentes, comproLentes, enfermedadID, observacion) values(folio, beneficiarioID, anterior, total, adaptacion, fechaExamen, requiereLentes, comproLentes, enfermedadID, obervacion);
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraLente` (IN `descripcion` VARCHAR(40))  BEGIN
	insert into TipoLente (descripcion, estaActivo) values (descripcion, 1);
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraMarcaArmazon` (IN `descripcion` VARCHAR(40))  BEGIN
	insert into MarcasArmazones (descripcion, estaActivo) values (descripcion, 1);
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraMaterial` (IN `descripcion` VARCHAR(40))  BEGIN
	insert into Materiales (descripcion, estaActivo) values (descripcion, 1);
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraModelo` (IN `descripcion` VARCHAR(40))  BEGIN
	insert into Modelos (descripcion, estaActivo) values (descripcion, 1);
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraProteccion` (IN `descripcion` VARCHAR(40))  BEGIN
	insert into Protecciones (descripcion, estaActivo) values (descripcion, 1);
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraTamanio` (IN `descripcion` VARCHAR(40))  BEGIN
	insert into Tamanios (descripcion, estaActivo) values (descripcion, 1);
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraYSeleccionaArmazon` (IN `MarcaID` INT, IN `ColorID` INT, IN `TamanioID` INT, IN `ModeloID` INT, IN `_DetalleEnArmazon` VARCHAR(35))  BEGIN
	insert into Armazones (MarcaID, ColorID, TamanioID, ModeloID, DetalleEnArmazon ) values (marcaID, ColorID, TamanioID, ModeloID, _DetalleEnArmazon);
    select ArmazonID from Armazones order by armazonID desc limit 1;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraYSeleccionaConjuntoOjos` (IN `izquierdo` INT, IN `derecho` INT, IN `tipo` INT, IN `dbLejos` VARCHAR(10), IN `_obl` VARCHAR(10))  BEGIN
	insert into ConjuntoOjos (IzquierdoID, DerechoID, TipoConjuntoID, DpLejos, Obl) values (izquierdo, derecho, tipo, dbLejos, _obl);
    Select ConjuntoID from ConjuntoOjos order By ConjuntoID desc Limit 1;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraYSeleccionaOjo` (IN `LadoId` INT, IN `Esfera` VARCHAR(10), IN `Cilindro` VARCHAR(10), IN `eje` VARCHAR(10), IN `Addicion` VARCHAR(10))  BEGIN
	insert into Ojos (LadoID, esfera, cilindro, eje, adiccion) values (LadoId, Esfera, Cilindro, eje, Addicion);
    select OjoID from Ojos order by OjoID desc limit 1;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraYSeleccionaVenta` (IN `FolioExamen` VARCHAR(10), IN `totalVenta` DECIMAL(13,2), IN `Anticipo` DECIMAL(13,2), IN `Periodicidad` INT, IN `fechaVenta` DATE, IN `armazonID` INT, IN `materialID` INT, IN `proteccionID` INT, IN `lenteID` INT, IN `beneficiarioID` INT, IN `tipoVentaID` INT, IN `numeroPagos` INT)  BEGIN
	select ExamenID into @ExamenID  from Examenes where folio = FolioExamen;
    insert into Ventas (folioExamen, totalVenta, anticipo, periodicidadDias, Abonos, fechaVenta, EstaLiquidada, armazonID, materialID, ProteccionID, LenteID, BeneficiarioID, ExamenID, TipoVentaID, NumeroPagos) values (folioExamen, totalVenta, anticipo, periodicidad, (totalVenta - anticipo)/numeroPagos, fechaventa, 0, armazonID, materialID, proteccionID, lenteID, beneficiarioID, @ExamenID, tipoVentaID, numeroPagos);
	select ventaID from Ventas order by ventaID desc limit 1;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegresaContra` (IN `_mail` VARCHAR(100))  BEGIN
	select pswd from emails where mail = _mail;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegresaFolios` (IN `empresa_Id` INT)  BEGIN
	select folio from Examenes e inner join Beneficiarios b on b.beneficiarioId = e.BeneficiarioId where b.empresaId = empresa_Id;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegresaMails` ()  BEGIN
	select mail from emails;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RestriccionesPorUsuario` (IN `_token` VARCHAR(40))  BEGIN
	select r.Empresa from Restricciones r inner join users u on r.userID = u.userID where u.token = _token;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaAbonosPorVenta` (IN `_ventaId` INT)  BEGIN
	Select * from Abonos where ventaid = _ventaId;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaBeneficiariosPorEmpresa` (IN `empresa_ID` INT)  BEGIN
	select * from Beneficiarios where EmpresaID = empresa_ID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaBeneficiaroPorFolio` (IN `_folio` VARCHAR(50))  BEGIN
select BeneficiarioID from Examenes where Folio = _folio;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaCasosActivos` ()  BEGIN
	select * from CasosMaterialesISO where estaActivo = 1;  
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaCasosPorBeneficiario` (IN `_beneficiarioId` INT)  BEGIN
	select * from CasosPorBeneficiario where beneficiarioId = _beneficiarioId;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaColores` ()  BEGIN
	select * from colores where estaActivo = 1;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaDetallesDeArmazonPorVenta` (IN `_ventaId` INT)  BEGIN
	select a.armazonId as Id, m.Descripcion as Marca, c.descripcion as Color, t.descripcion as Tamanio, mo.descripcion as Modelo, a.detalleenarmazon as Detalle from Ventas v inner join Armazones a on v.armazonId = a.armazonId inner join MarcasArmazones m on a.marcaId = m.marcaId inner join colores c on a.colorId = c.colorId inner join Tamanios t on a.tamanioId = t.tamanioId inner join Modelos mo on a.modeloId = mo.modeloId where v.ventaId = _ventaId;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaEmpresaIDPorFolio` (IN `_folio` VARCHAR(25))  BEGIN
	
select e.empresaID as EmpresaID from Empresas e inner join Beneficiarios b on e.EmpresaID=b.EmpresaID right join Examenes x on b.BeneficiarioID = x.BeneficiarioID where x.folio = _folio;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaEmpresaIDPorVentaID` (IN `_ventaID` INT)  BEGIN
	
select e.empresaID as EmpresaID from Empresas e inner join Beneficiarios b on e.EmpresaID=b.EmpresaID right join Ventas v on b.BeneficiarioID = v.BeneficiarioID where v.ventaId = _ventaID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaEmpresas` ()  BEGIN
	select * from Empresas;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaExamenPorBeneficiario` (IN `_beneficiarioId` INT)  BEGIN
	select * from Examenes where beneficiarioId = _beneficiarioId;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaExamenPorFolio` (IN `_folio` VARCHAR(10))  BEGIN
	select * from Examenes where folio = _folio;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaLentes` ()  BEGIN
	select * from TipoLente where estaActivo = 1;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaMarcas` ()  BEGIN
	select * from MarcasArmazones where EstaActivo = 1;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaMateriales` ()  BEGIN
	select * from Materiales where estaActivo = 1;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaModelos` ()  BEGIN
	select * from Modelos where estaActivo = 1;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaMontoAbono` (IN `_abonoID` INT)  BEGIN
	select monto as Monto from Abonos where abonoId = _abonoID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaNombreConToken` (IN `_token` VARCHAR(50))  BEGIN
	select userName from users where token = _token;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaProtecciones` ()  BEGIN
	select * from Protecciones where estaActivo = 1;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaResumentVentas` (IN `_empresaid` INT)  BEGIN
	select sum(v.TotalVenta) as Total, sum(v.Anticipo) as Anticipos from Ventas v inner join Beneficiarios b on v.BeneficiarioID = b.BeneficiarioID where b.empresaID = _empresaid;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaResumenVentasPorEmpresa` (IN `_empresaId` INT)  BEGIN
		select v.ventaId as VentaId, v.TipoVentaID as Tipo, v.FolioExamen, b.nombres as Nombres, v.EstaLiquidada as EstaLiquidada, v.fechaVenta as Fecha ,b.apellidoPaterno as Apellido, b.Ocupacion as Puesto, ex.RequiereLentes, ex.comprolentes,  m.descripcion as Material, p.descripcion as Proteccion, t.descripcion as Lente, v.totalventa as Total, v.anticipo as Aticipo, v.abonos as Abonos, v.NumeroPagos as TotalPagos from Ventas v inner join Beneficiarios b on v.beneficiarioId = b.beneficiarioId inner join Materiales m on v.materialId = m.materialId inner join Protecciones p on v.proteccionId = p.proteccionId inner join TipoLente t on v.lenteId = t.lenteId left join Examenes ex on v.examenId= ex.ExamenId where b.empresaId = _empresaId;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaSumAbonosPorVenta` (IN `_ventaId` INT)  BEGIN
	Select sum(Monto) from Abonos where ventaid = _ventaId;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaTamanios` ()  BEGIN
	select * from Tamanios where estaActivo = 1;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaTotalAbonos` (IN `_empresaid` INT)  BEGIN
	select sum(monto) as Montos from Abonos a inner join Ventas v on a.VentaID = v.VentaID inner join Beneficiarios b on b.BeneficiarioID = v.BeneficiarioID where b.EmpresaID = _empresaid;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `seleccionaTotalAbonosSinLiquidar` (IN `_empresaid` INT)  BEGIN
	select sum(monto) as Montos from Abonos a inner join Ventas v on a.VentaID = v.VentaID inner join Beneficiarios b on b.BeneficiarioID = v.BeneficiarioID where b.EmpresaID = _empresaid and v.EstaLiquidada = 0;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SeleccionaVentaPorAbono` (IN `_abonoID` INT)  BEGIN
	select v.VentaID as Id from Ventas v inner join Abonos a on a.VentaID=v.VentaID where a.AbonoID = _abonoID;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `SelectSaldoVenta` (IN `_ventaId` INT)  BEGIN
	select (totalVenta - anticipo) as total from Ventas where ventaId = _ventaId;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `UserRegistration` (IN `name` VARCHAR(30), IN `pass` VARCHAR(40), IN `tok` VARCHAR(50))  BEGIN
    INSERT INTO users (userName, password, Token) values (name, pass, tok);
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `validaBeneficiario` (IN `_beneficiarioId` INT)  BEGIN
	select count(*) as count from Beneficiarios where beneficiarioid =  _beneficiarioId;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `validaEmpresa` (IN `Id` INT)  BEGIN
	select count(*) from Empresas where EmpresaId = Id;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `validaExistenciaUsuario` (IN `_nombre` VARCHAR(100))  BEGIN
	select count(*) from users where userName = _nombre;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ValidaFolio` (IN `_FolioExamen` VARCHAR(10))  BEGIN
	select count(*) from Ventas where FolioExamen = _FolioExamen;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `validaToken` (IN `keyToken` VARCHAR(40))  BEGIN
	select count(*) as Result from users where token = keyToken;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Abonos`
--

CREATE TABLE `Abonos` (
  `AbonoID` int(11) NOT NULL,
  `VentaID` int(11) NOT NULL,
  `Monto` decimal(13,2) NOT NULL,
  `FechaAbono` date DEFAULT NULL,
  `FechaRegistro` date NOT NULL,
  `RegistradoPor` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Abonos`
--

INSERT INTO `Abonos` (`AbonoID`, `VentaID`, `Monto`, `FechaAbono`, `FechaRegistro`, `RegistradoPor`) VALUES
(11, 18, 3009.00, '2020-07-24', '2020-07-24', 'enrique'),
(10, 10, 445.00, '2020-07-24', '2020-07-24', 'enrique'),
(9, 11, 2030.00, '2020-07-24', '2020-07-24', 'enrique'),
(12, 16, 700.00, '2020-07-24', '2020-07-24', 'enrique'),
(13, 17, 890.00, '2020-07-24', '2020-07-24', 'enrique'),
(14, 19, 597.00, '2020-07-27', '2020-07-28', 'enrique'),
(15, 2, 1400.00, '2020-08-18', '2020-08-19', 'enrique'),
(16, 4, 1250.00, '2020-08-18', '2020-08-19', 'enrique'),
(17, 7, 1050.00, '2020-08-18', '2020-08-19', 'enrique'),
(18, 3, 1330.00, '2020-08-17', '2020-08-19', 'enrique');

-- --------------------------------------------------------

--
-- Table structure for table `Armazones`
--

CREATE TABLE `Armazones` (
  `ArmazonID` int(11) NOT NULL,
  `DetalleEnArmazon` varchar(35) DEFAULT NULL,
  `MarcaID` int(11) DEFAULT NULL,
  `ColorID` int(11) DEFAULT NULL,
  `TamanioID` int(11) DEFAULT NULL,
  `ModeloID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Armazones`
--

INSERT INTO `Armazones` (`ArmazonID`, `DetalleEnArmazon`, `MarcaID`, `ColorID`, `TamanioID`, `ModeloID`) VALUES
(1, 'No  Aplica', 1, 5, 2, 2),
(2, 'No  Aplica', 1, 5, 2, 2),
(3, 'No  Aplica', 1, 5, 2, 2),
(4, 'Biselado', 2, 6, 3, 3),
(5, 'Bicelado', 1, 6, 2, 2),
(6, 'Bicelado', 4, 6, 9, 5),
(7, 'Bicelado', 5, 6, 10, 6),
(8, 'Bicelado', 1, 6, 1, 7),
(9, 'No  Aplica', 1, 6, 1, 2),
(10, 'Biselado', 6, 1, 11, 8),
(11, 'Biselado', 2, 9, 12, 2),
(12, 'Biselado', 5, 1, 10, 6),
(13, 'Biselado', 4, 1, 13, 5),
(14, '334', 12, 13, 8, 10),
(15, 'Biselado', 3, 35, 8, 73),
(16, 'Biselado', 27, 5, 22, 87),
(17, 'Biselado', 32, 14, 14, 113),
(18, 'Biselado', 7, 13, 18, 10),
(19, 'Biselado', 4, 10, 13, 5),
(20, 'Biselado', 4, 14, 10, 65),
(21, 'Biselado', 7, 23, 16, 13),
(22, 'Ranurado', 33, 13, 8, 2),
(23, 'Biselado', 11, 23, 3, 33),
(24, 'Biselado', 6, 35, 16, 43),
(25, 'Biselado', 14, 16, 25, 41),
(26, 'Biselado', 4, 14, 26, 56),
(27, 'Biselado', 4, 14, 26, 56),
(28, 'Biselado', 4, 18, 27, 55),
(29, 'Biselado', 7, 13, 28, 10),
(30, 'Biselado', 7, 15, 29, 16),
(31, 'Ranurado', 4, 16, 9, 23),
(32, 'Biselado', 4, 14, 31, 57),
(33, 'Biselado', 12, 14, 32, 68),
(34, 'Biselado', 33, 10, 15, 23),
(35, 'Biselado', 13, 14, 15, 9),
(36, 'Biselado', 2, 19, 33, 25),
(37, 'Biselado', 6, 14, 10, 46),
(38, 'Biselado', 2, 14, 12, 2),
(39, 'Biselado', 2, 16, 34, 30),
(40, 'Biselado', 2, 13, 35, 20),
(41, 'Biselado', 9, 10, 20, 38),
(42, 'Biselado', 7, 15, 33, 8);

-- --------------------------------------------------------

--
-- Table structure for table `Beneficiarios`
--

CREATE TABLE `Beneficiarios` (
  `BeneficiarioID` int(11) NOT NULL,
  `Nombres` varchar(25) NOT NULL,
  `ApellidoPaterno` varchar(25) NOT NULL,
  `ApellidoMaterno` varchar(35) DEFAULT NULL,
  `FechaNacimiento` date NOT NULL,
  `Ocupacion` varchar(40) DEFAULT NULL,
  `EmpresaID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Beneficiarios`
--

INSERT INTO `Beneficiarios` (`BeneficiarioID`, `Nombres`, `ApellidoPaterno`, `ApellidoMaterno`, `FechaNacimiento`, `Ocupacion`, `EmpresaID`) VALUES
(1, 'jose luis', 'martinez', '.', '1980-01-01', 'soldador', 1),
(2, 'Ana Silvia ', 'Olivares', 'R.', '1973-01-01', 'Hogar', 2),
(3, 'Maria Moserrat', 'Serrano', 'Avila', '1980-01-01', 'Ama de casa', 2),
(4, 'Cristina', 'Matehuala', 'Gomez', '1978-01-01', 'ama de casa', 2),
(5, 'Yazalet Yadira', 'Reyes', 'Ramirez', '1997-01-01', 'ama de casa', 2),
(6, 'Martin A. ', 'Martinez', '.', '1995-01-01', 'Ama de casa', 2),
(7, 'Denisse', 'Ibarra', 'Cardoza', '1980-01-01', 'Ama de casa', 2),
(8, 'Lorena', 'Lopez', 'Escobar', '1995-01-01', 'Ama de casa', 2),
(9, 'Araceli ', 'Ronco', 'Gazca', '1969-07-16', 'Hogar', 7),
(10, 'Juan Carlos', 'Martinez', 'Franco', '1994-01-01', 'Ventas', 8),
(11, 'Alejandro', 'Bueno', 'Aguiñaga', '1992-01-01', 'Ventas', 8),
(12, 'Salvador Jr', 'Martinez', 'Acevedo', '1967-01-01', 'Licenciado', 8),
(13, 'Irma de Jesus', ' Gonzalez', 'Romero', '1985-01-01', 'Conauto', 10),
(14, 'Abigail Margarita', 'Lopez', 'Lopez', '1997-01-01', 'Gerencia', 10),
(15, 'Victor Hugo', 'Morales ', 'Rodriguez', '1993-01-01', 'Servicio', 10),
(16, 'Carlos Ivan', 'Ruiz', 'Pineda', '1994-01-01', 'Servicio', 10),
(17, 'Jaime Alberto', 'Juarez', 'Luna', '1989-01-01', 'Ventas', 10),
(18, 'Paula Vanessa', 'Rodriguez', 'Escobar', '1997-01-01', 'Servicio', 10),
(19, 'Josefina ', 'Lara', 'Delgado', '1990-01-01', 'Resercivo', 10),
(20, 'Olga Olivia', 'Castro', 'Lopez', '1980-01-01', 'Ventas', 8),
(21, 'Yuhema ', 'Contreras', 'Garcia', '1991-01-01', 'Ventas', 8),
(22, 'Paula Vanessa', 'Rodriguez', 'Escobar', '1997-01-01', 'Servicio', 10),
(23, 'Ma del Carmen', 'Galvan', 'Valtazar', '1974-01-01', 'Hogar', 7),
(24, 'Abigail', 'Lopez', '0', '1995-01-01', 'Ventas', 10),
(25, 'Lorena', 'Lopez', 'Escobar', '1982-01-01', 'Hogar', 7),
(26, 'Karla Viridiana', 'Aguilar', 'Garcia', '1984-01-01', 'Ventas', 11),
(27, 'Oscar  ', 'Chavez', 'Andrade', '1985-01-01', 'Ventas', 12),
(28, 'Miguel Maximiliano', 'Cortez', 'Ramirez', '1998-01-01', 'Ventas', 12),
(29, 'Guadalupe', 'Velazquez', 'Vazquez', '1991-01-01', 'Ventas', 12),
(30, 'Rafael Diego', 'Contreras', '0', '1961-01-01', 'Ventas', 12),
(31, 'Mayra Daniela', 'Martinez', 'Rivera', '1995-01-01', 'Secretaria', 12),
(32, 'Job Israel', 'Amaya', '0', '2000-01-01', 'Ventas', 12),
(33, 'Everardo', 'Orozco', 'Montelongo', '1986-01-01', 'Cobranza', 12),
(34, 'Gerardo', 'De Anda', 'Martinez', '1983-01-01', '0', 12),
(35, 'Fernando', 'Andrade', 'Cifuentes', '1981-01-01', 'Gerencia', 13),
(36, 'Luis Angel', 'Ramirez', 'Medina', '1992-01-01', 'Corte', 13),
(37, 'Victor Manuel', 'Ramirez', '0', '1958-01-01', 'Produccion', 13),
(38, 'Graciela', 'Echeveste', 'Sanchez', '1974-01-01', 'Administracion', 13),
(39, 'Fernando Javier', 'Murillo', 'Palomares', '1978-01-01', 'Chofer', 13),
(40, 'Francisco Javier', 'Ramirez', 'Quintero', '1962-01-01', 'Corte', 13),
(41, 'Juan de Jesus', 'Martinez', 'Lira', '1990-01-01', 'Armado', 13),
(42, 'Miguel Angel', 'Perez', 'Espinoza', '1975-01-01', 'Corte', 13),
(43, 'Gustavo Angel', 'Sanchez', 'Ramirez', '1999-01-01', 'Armado', 13),
(44, 'Jose Guadalupe', 'Ramirez', 'Gonzalez', '2001-01-01', 'Armado', 13),
(45, 'Jose Francisco', 'Aguirre', '0', '1964-01-01', 'Armado', 13),
(46, 'Blanca Estela', 'Villagomez', 'Luna', '1991-01-01', 'Administracion', 13),
(47, 'Yesenia Guadalupe', 'Saucedo', 'Padilla', '1994-01-01', 'Produccion', 13),
(48, 'Ricardo', 'Ramirez', 'Rangel', '1967-01-01', 'Produccion', 13);

-- --------------------------------------------------------

--
-- Table structure for table `CasosMaterialesISO`
--

CREATE TABLE `CasosMaterialesISO` (
  `CasoID` int(11) NOT NULL,
  `Descripcion` varchar(30) NOT NULL,
  `estaActivo` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CasosMaterialesISO`
--

INSERT INTO `CasosMaterialesISO` (`CasoID`, `Descripcion`, `estaActivo`) VALUES
(1, 'Armazón Oftálmico', 1),
(2, 'Armazón Solar', 1),
(3, 'Cambio de micas', 1),
(4, 'Lente de contacto', 1),
(5, 'Accesorios', 1);

-- --------------------------------------------------------

--
-- Table structure for table `CasosPorBeneficiario`
--

CREATE TABLE `CasosPorBeneficiario` (
  `CasoPorBeneficiarioID` int(11) NOT NULL,
  `BeneficiarioID` int(11) NOT NULL,
  `CasoID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CasosPorBeneficiario`
--

INSERT INTO `CasosPorBeneficiario` (`CasoPorBeneficiarioID`, `BeneficiarioID`, `CasoID`) VALUES
(4, 3, 4),
(5, 3, 5),
(6, 6, 2);

-- --------------------------------------------------------

--
-- Table structure for table `colores`
--

CREATE TABLE `colores` (
  `ColorID` int(11) NOT NULL,
  `Descripcion` varchar(20) NOT NULL,
  `EstaActivo` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `colores`
--

INSERT INTO `colores` (`ColorID`, `Descripcion`, `EstaActivo`) VALUES
(1, 'Azul', 0),
(2, 'Amarillo', 0),
(3, 'Verde', 0),
(4, 'Marca', 0),
(5, 'Pink', 1),
(6, 'Black', 0),
(7, 'Vino', 0),
(8, 'Cafe', 0),
(9, 'Negro', 0),
(10, 'Blue', 1),
(11, 'Yellow', 1),
(12, 'Green', 1),
(13, 'Brown', 1),
(14, 'Black', 1),
(15, 'Red', 1),
(16, 'Grey', 1),
(17, 'Cristal', 1),
(18, 'Gold', 1),
(19, 'Gun', 1),
(20, 'Blue-black', 1),
(21, 'Green-blue', 1),
(22, 'Black-red', 1),
(23, 'Purple', 1),
(24, 'Black-purple', 1),
(25, 'Carey', 1),
(26, 'Brown-cristal', 1),
(27, 'White', 1),
(28, 'Blue-cristal', 1),
(29, 'Black-cristal', 1),
(30, 'Verde%20acua', 1),
(31, 'Pink-red', 1),
(32, 'Black-grey', 1),
(33, 'Blue-brown', 1),
(34, 'Black-yellow', 1),
(35, 'Blue-pink', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ConjuntoOjos`
--

CREATE TABLE `ConjuntoOjos` (
  `ConjuntoID` int(11) NOT NULL,
  `IzquierdoID` int(11) DEFAULT NULL,
  `DerechoID` int(11) DEFAULT NULL,
  `TipoConjuntoID` int(11) DEFAULT NULL,
  `DpLejos` varchar(10) DEFAULT NULL,
  `Obl` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ConjuntoOjos`
--

INSERT INTO `ConjuntoOjos` (`ConjuntoID`, `IzquierdoID`, `DerechoID`, `TipoConjuntoID`, `DpLejos`, `Obl`) VALUES
(1, 3, 4, 1, '12', '12'),
(2, 5, 6, 1, '12', '12'),
(3, 7, 8, 1, '0', '0'),
(4, 9, 10, 2, '0', '0'),
(5, 11, 12, 3, '0', '0'),
(6, 13, 14, 1, '0', '0'),
(7, 15, 16, 2, '0', '0'),
(8, 17, 18, 3, '0', '0'),
(9, 19, 20, 2, '0', '0'),
(10, 21, 22, 3, '0', '0'),
(11, 23, 24, 2, '0', '0'),
(12, 25, 26, 3, '0', '0'),
(13, 27, 28, 2, '0', '0'),
(14, 29, 30, 2, '0', '0'),
(15, 31, 32, 3, '0', '0'),
(16, 33, 34, 2, '0', '0'),
(17, 35, 36, 3, '0', '0'),
(18, 37, 38, 2, '0', '0'),
(19, 39, 40, 3, '0', '0'),
(20, 41, 42, 1, '0', '0'),
(21, 43, 44, 2, '0', '0'),
(22, 45, 46, 3, '0', '0'),
(23, 47, 48, 2, '0', '0'),
(24, 49, 50, 3, '0', '0'),
(25, 51, 52, 2, '0', '0'),
(26, 53, 54, 3, '0', '0'),
(27, 55, 56, 2, '0', '0'),
(28, 57, 58, 3, '0', '0'),
(29, 59, 60, 1, '60', '19'),
(30, 61, 62, 2, '60', '19'),
(31, 63, 64, 3, '60', '19'),
(32, 65, 66, 2, '64', '0'),
(33, 67, 68, 3, '64', '0'),
(34, 69, 70, 2, '64', '0'),
(35, 71, 72, 3, '64', '0'),
(36, 73, 74, 1, '64', '0'),
(37, 75, 76, 2, '64', '0'),
(38, 77, 78, 3, '64', '0'),
(39, 79, 80, 2, '64', '0'),
(40, 81, 82, 3, '64', '0'),
(41, 83, 84, 2, '64', '0'),
(42, 85, 86, 3, '64', '0'),
(43, 87, 88, 2, '64', '0'),
(44, 89, 90, 3, '64', '0'),
(45, 91, 92, 2, '64', '0'),
(46, 93, 94, 3, '64', '0'),
(47, 95, 96, 2, '63', '0'),
(48, 97, 98, 3, '63', '0'),
(49, 99, 100, 1, '63', '0'),
(50, 101, 102, 2, '63', '0'),
(51, 103, 104, 3, '63', '0'),
(52, 105, 106, 1, '63', '0'),
(53, 107, 108, 2, '63', '0'),
(54, 109, 110, 3, '63', '0'),
(55, 111, 112, 2, '64', '0'),
(56, 113, 114, 3, '64', '0'),
(57, 115, 116, 2, '64', '0'),
(58, 117, 118, 3, '64', '0'),
(59, 119, 120, 2, '64', '0'),
(60, 121, 122, 3, '64', '0'),
(61, 123, 124, 2, '64', '0'),
(62, 125, 126, 3, '64', '0'),
(63, 127, 128, 2, '64', '0'),
(64, 129, 130, 3, '64', '0'),
(65, 131, 132, 2, '63', '0'),
(66, 133, 134, 3, '63', '0'),
(67, 135, 136, 2, '64', '0'),
(68, 137, 138, 3, '64', '0'),
(69, 139, 140, 2, '64', '0'),
(70, 141, 142, 3, '64', '0'),
(71, 143, 144, 2, '64', '0'),
(72, 145, 146, 3, '64', '0'),
(73, 147, 148, 1, '63', '0'),
(74, 149, 150, 2, '63', '0'),
(75, 151, 152, 3, '63', '0'),
(76, 153, 154, 2, '63', '0'),
(77, 155, 156, 3, '63', '0'),
(78, 157, 158, 1, '63', '0'),
(79, 159, 160, 2, '63', '0'),
(80, 161, 162, 3, '63', '0'),
(81, 163, 164, 2, '59', '13'),
(82, 165, 166, 3, '59', '13'),
(83, 167, 168, 2, '63', '0'),
(84, 169, 170, 3, '63', '0'),
(85, 171, 172, 3, '63', '0'),
(86, 173, 174, 2, '63', '0'),
(87, 175, 176, 3, '63', '0'),
(88, 177, 178, 2, '64', '0'),
(89, 179, 180, 3, '64', '0'),
(90, 181, 182, 2, '64', '0'),
(91, 183, 184, 3, '64', '0'),
(92, 185, 186, 2, '63', '0'),
(93, 187, 188, 3, '63', '0'),
(94, 189, 190, 2, '60', '18'),
(95, 191, 192, 3, '60', '18'),
(96, 193, 194, 2, '63', '0'),
(97, 195, 196, 3, '63', '0'),
(98, 197, 198, 2, '64', '0'),
(99, 199, 200, 3, '64', '0'),
(100, 201, 202, 2, '64', '0'),
(101, 203, 204, 3, '64', '0'),
(102, 205, 206, 2, '64', '0'),
(103, 207, 208, 3, '64', '0'),
(104, 209, 210, 2, '64', '0'),
(105, 211, 212, 3, '64', '0'),
(106, 213, 214, 2, '64', '0'),
(107, 215, 216, 3, '64', '0'),
(108, 217, 218, 2, '64', '0'),
(109, 219, 220, 3, '64', '0'),
(110, 221, 222, 3, '0', '0'),
(111, 223, 224, 2, '64', '0'),
(112, 225, 226, 3, '64', '0'),
(113, 227, 228, 2, '64', '0'),
(114, 229, 230, 3, '64', '0'),
(115, 233, 234, 2, '60', '12'),
(116, 235, 236, 3, '60', '12'),
(117, 237, 238, 2, '63', '0'),
(118, 239, 240, 3, '63', '0'),
(119, 241, 242, 2, '64', '0'),
(120, 243, 244, 3, '64', '0'),
(121, 245, 246, 2, '64', '0'),
(122, 247, 248, 3, '64', '0'),
(123, 249, 250, 2, '64', '0'),
(124, 251, 252, 3, '64', '0'),
(125, 253, 254, 2, '64', '0'),
(126, 255, 256, 3, '64', '0'),
(127, 257, 258, 2, '64', '0'),
(128, 259, 260, 3, '64', '0'),
(129, 261, 262, 2, '64', '0'),
(130, 263, 264, 3, '64', '0'),
(131, 265, 266, 2, '62', '18'),
(132, 267, 268, 3, '62', '18'),
(133, 269, 270, 2, '63', '0'),
(134, 271, 272, 3, '63', '0'),
(135, 273, 274, 2, '63', '0'),
(136, 275, 276, 3, '63', '0'),
(137, 277, 278, 2, '64', '0'),
(138, 279, 280, 3, '64', '0');

-- --------------------------------------------------------

--
-- Table structure for table `emails`
--

CREATE TABLE `emails` (
  `mailId` int(11) NOT NULL,
  `mail` varchar(100) NOT NULL,
  `pswd` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Empleados`
--

CREATE TABLE `Empleados` (
  `EmpleadoID` int(11) NOT NULL,
  `Nombres` varchar(25) NOT NULL,
  `ApellidoPaterno` varchar(15) NOT NULL,
  `ApellidoMaterno` varchar(15) DEFAULT NULL,
  `EstaActivo` tinyint(1) DEFAULT NULL,
  `RolID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Empresas`
--

CREATE TABLE `Empresas` (
  `EmpresaID` int(11) NOT NULL,
  `NombreEmpresa` varchar(60) NOT NULL,
  `Domicilio` varchar(150) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Empresas`
--

INSERT INTO `Empresas` (`EmpresaID`, `NombreEmpresa`, `Domicilio`, `Telefono`) VALUES
(1, 'Dormirey', 'Paseo de jerez 530, Col jardinez de Jerez, León Guanajuato', '477 711 9224'),
(2, 'Externos', 'Junio', '0000'),
(7, 'Externos', 'julio', '0000'),
(8, 'Mitsubishi', 'Blvd Adolfo Lopez Mateos 2710 Industrial Julian de Obregon, León Guanajuato', '0000'),
(10, 'Ford Capital', 'Carretera Guanajuato-juventino Rosas kilometro 5.5 36250 Marfil Gto.', '4737332122'),
(11, 'Limsa Campestre', 'Blvd Campestre 35, la Florida', '0000'),
(12, 'Externos', 'Dormirey Aguascalientes', '4777119224'),
(13, 'Externos', 'La Astilleria', '0000');

-- --------------------------------------------------------

--
-- Table structure for table `EnfermedadesVisuales`
--

CREATE TABLE `EnfermedadesVisuales` (
  `EnfermedadID` int(11) NOT NULL,
  `Descripcion` varchar(70) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `EnfermedadesVisuales`
--

INSERT INTO `EnfermedadesVisuales` (`EnfermedadID`, `Descripcion`) VALUES
(1, 'Miopía'),
(2, 'Astigmatismo'),
(3, 'Hipermetropía'),
(4, 'Presbicia'),
(5, 'Miopía con Astigmatismo'),
(6, 'Hipermetroía con Astigmatismo'),
(7, 'Miopía y Presbicia'),
(8, 'Hipermetropía y Presbicia'),
(9, 'Astigmatismo y Presbicia'),
(10, 'Miopía, Astigmatismo y Presbicia'),
(11, 'Hipermetropía, Astigmatismo y Presbicia'),
(12, 'Neutro');

-- --------------------------------------------------------

--
-- Table structure for table `Examenes`
--

CREATE TABLE `Examenes` (
  `ExamenID` int(11) NOT NULL,
  `Folio` varchar(10) NOT NULL,
  `BeneficiarioID` int(11) NOT NULL,
  `Anterior` int(11) DEFAULT NULL,
  `Total` int(11) DEFAULT NULL,
  `Adaptacion` int(11) DEFAULT NULL,
  `FechaExamen` date DEFAULT NULL,
  `RequiereLentes` tinyint(1) DEFAULT NULL,
  `ComproLentes` tinyint(1) DEFAULT NULL,
  `EnfermedadID` int(11) DEFAULT NULL,
  `observacion` varchar(250) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Examenes`
--

INSERT INTO `Examenes` (`ExamenID`, `Folio`, `BeneficiarioID`, `Anterior`, `Total`, `Adaptacion`, `FechaExamen`, `RequiereLentes`, `ComproLentes`, `EnfermedadID`, `observacion`) VALUES
(1, '038', 2, 3, 4, 5, '2020-07-04', 1, 1, 5, 'lentes perrones'),
(2, '052', 3, 6, 7, 8, '2020-07-04', 1, 1, 5, 'SIN OBS'),
(3, '040', 4, NULL, 18, 19, '2020-07-04', 1, 1, 12, 'NULL'),
(4, '039', 5, 20, 21, 22, '2020-07-05', 1, 1, 5, ' '),
(5, '042', 6, NULL, 23, 24, '2020-07-05', 1, 1, 2, ' '),
(6, '041', 7, NULL, 25, 26, '2020-07-05', 1, 1, 5, ' '),
(7, '043', 8, NULL, 27, 28, '2020-07-05', 1, 1, 3, ' '),
(8, '050', 9, 29, 30, 31, '2020-07-08', 1, 1, 8, 'Anticipo $1,000'),
(9, '048', 10, NULL, 34, 35, '2020-07-09', 1, 1, 5, 'NULL'),
(10, '047', 11, 36, 37, 38, '2020-07-09', 1, 1, 5, '5 pagos quincenales'),
(11, '46', 12, NULL, 43, 44, '2020-07-09', 1, 1, 7, 'NULL'),
(12, '053', 13, NULL, 47, 48, '2020-07-14', 1, 1, 2, ' '),
(13, '054', 14, 52, 53, 54, '2020-07-14', 1, 1, 5, 'NULL'),
(14, '0', 15, NULL, 55, 56, '2020-07-14', 1, 0, 5, ' '),
(15, '1', 16, NULL, 61, 62, '2020-07-14', 1, 0, 2, ' '),
(16, '2', 17, NULL, 63, 64, '2020-07-14', 1, 0, 5, ' '),
(17, '3', 19, NULL, 65, 66, '2020-07-14', 1, 0, 5, ' '),
(18, '45', 20, 73, 74, 75, '2020-07-17', 1, 1, 2, ' '),
(19, '044', 21, NULL, 76, 77, '2020-07-17', 1, 1, 5, ' '),
(20, '055', 18, 78, 79, 80, '2020-07-21', 1, 1, 5, ' '),
(21, '049', 23, NULL, 81, 82, '2020-07-28', 1, 1, 9, ' '),
(22, '056', 24, NULL, 83, 84, '2020-07-30', 1, 1, 5, 'Solo micas'),
(23, 'Bosque Mer', 25, NULL, NULL, 85, '2020-08-11', 1, 1, 4, ' '),
(24, '057', 26, NULL, 86, 87, '2020-09-04', 1, 1, 5, ' '),
(25, '058', 27, NULL, 88, 89, '2020-09-10', 1, 1, 5, 'son dos lentes el de èl y el de su hijo'),
(26, '059', 28, NULL, 90, 91, '2020-09-10', 1, 1, 5, ' '),
(27, '060', 29, NULL, 92, 93, '2020-09-10', 1, 1, 5, ' '),
(28, '062', 30, NULL, 94, 95, '2020-09-10', 1, 1, 7, ' '),
(29, '063', 31, NULL, 96, 97, '2020-09-10', 1, 1, 5, 'son dos lentes el de su esposo y el de ella'),
(30, '0001', 32, NULL, 108, 109, '2020-09-10', 1, 0, 5, 'NULL'),
(31, '0002', 33, NULL, 106, 107, '2020-09-10', 1, 0, 3, ' '),
(32, '0003', 34, NULL, NULL, 110, '2020-09-10', 0, 0, 12, ' '),
(33, '064', 35, NULL, 111, 112, '2020-09-15', 1, 1, 1, ' '),
(34, '065', 36, NULL, 113, 114, '2020-09-15', 1, 1, 5, ' '),
(35, '066', 37, NULL, 115, 116, '2020-09-15', 1, 1, 8, ' '),
(36, '067', 38, NULL, 117, 118, '2020-09-15', 1, 1, 3, 'solo lectura'),
(37, '068', 39, NULL, 119, 120, '2020-09-15', 1, 1, 2, ' '),
(38, '069', 40, NULL, 121, 122, '2020-09-15', 1, 1, 3, 'solo lectura'),
(39, '070', 41, NULL, 123, 124, '2020-09-15', 1, 1, 1, ' '),
(40, '071', 42, NULL, 125, 126, '2020-09-15', 1, 1, 5, ' '),
(41, '072', 43, NULL, 127, 128, '2020-09-15', 1, 1, 1, ' '),
(42, '073', 44, NULL, 129, 130, '2020-09-15', 1, 1, 2, ' '),
(43, '074', 45, NULL, 131, 132, '2020-09-15', 1, 1, 8, ' '),
(44, '075', 46, NULL, 133, 134, '2020-09-15', 1, 1, 1, ' '),
(45, '001', 47, NULL, 135, 136, '2020-09-15', 1, 0, 1, ' '),
(46, '002', 48, NULL, 137, 138, '2020-09-15', 1, 0, 1, ' ');

-- --------------------------------------------------------

--
-- Table structure for table `Lados`
--

CREATE TABLE `Lados` (
  `LadoID` int(11) NOT NULL,
  `Descripcion` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Lados`
--

INSERT INTO `Lados` (`LadoID`, `Descripcion`) VALUES
(1, 'Izquierdo'),
(2, 'Derecho');

-- --------------------------------------------------------

--
-- Table structure for table `MarcasArmazones`
--

CREATE TABLE `MarcasArmazones` (
  `MarcaID` int(11) NOT NULL,
  `Descripcion` varchar(20) NOT NULL,
  `EstaActivo` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `MarcasArmazones`
--

INSERT INTO `MarcasArmazones` (`MarcaID`, `Descripcion`, `EstaActivo`) VALUES
(1, 'Guka', 0),
(2, 'Tito', 1),
(3, 'Cool%20bear', 1),
(4, 'Zendaya', 1),
(5, 'Gemma', 1),
(6, 'Colors', 1),
(7, 'Life', 1),
(8, 'Vachel', 1),
(9, 'Elegancia', 1),
(10, 'Botox', 1),
(11, 'Elizabeth', 1),
(12, 'Caffsen', 1),
(13, 'JD%20Plus', 1),
(14, 'Blue%20plus', 1),
(15, 'Hazen', 1),
(16, 'Annie', 1),
(17, 'Guca', 1),
(18, 'Indigo', 1),
(19, 'Fu%20ruikang', 1),
(20, 'Hs', 1),
(21, 'DBose', 1),
(22, 'Mosson', 1),
(23, 'Musenna', 1),
(24, 'Version', 1),
(25, 'Funky%20fred', 1),
(26, 'Rose%20lo', 1),
(27, 'Vittorio%20P', 1),
(28, 'S.T%20Bar', 1),
(29, 'Ju%20Retro', 1),
(30, 'Levis', 1),
(31, 'Reebok', 1),
(32, 'Rayban%20%20%20propi', 1),
(33, 'Propio', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Materiales`
--

CREATE TABLE `Materiales` (
  `MaterialID` int(11) NOT NULL,
  `Descripcion` varchar(40) NOT NULL,
  `EstaActivo` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Materiales`
--

INSERT INTO `Materiales` (`MaterialID`, `Descripcion`, `EstaActivo`) VALUES
(1, 'Policarbonato', 1),
(2, 'Hi-Index', 1),
(3, 'Plastico%20CR39', 1),
(4, 'Transitions VI Gris', 1),
(5, 'Cristal', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Modelos`
--

CREATE TABLE `Modelos` (
  `ModeloID` int(11) NOT NULL,
  `Descripcion` varchar(40) NOT NULL,
  `EstaActivo` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Modelos`
--

INSERT INTO `Modelos` (`ModeloID`, `Descripcion`, `EstaActivo`) VALUES
(1, 'Azul', 0),
(2, '1002', 1),
(3, '1025', 1),
(4, '818%2022', 1),
(5, '1019', 1),
(6, '8031', 1),
(7, '1001', 1),
(8, '014', 1),
(9, '002', 1),
(10, '003', 1),
(11, '007', 1),
(12, '008', 1),
(13, '010', 1),
(14, '015', 1),
(15, '017', 1),
(16, '022', 1),
(17, '023', 1),
(18, '024', 1),
(19, '025', 1),
(20, '1006', 1),
(21, '1009', 1),
(22, '1013', 1),
(23, '1016', 1),
(24, '1017', 1),
(25, '1018', 1),
(26, '1029', 1),
(27, '1031', 1),
(28, '1034', 1),
(29, '1036', 1),
(30, '1038', 1),
(31, '1040', 1),
(32, '1107', 1),
(33, '2046', 1),
(34, '6556', 1),
(35, '6557', 1),
(36, '8010', 1),
(37, '8011', 1),
(38, '9805', 1),
(39, '9814', 1),
(40, '001', 1),
(41, '005', 1),
(42, '006', 1),
(43, '009', 1),
(44, '009', 0),
(45, '011', 1),
(46, '013', 1),
(47, '014', 1),
(48, '615', 1),
(49, '805', 1),
(50, '1003', 1),
(51, '1004', 1),
(52, '1010', 1),
(53, '1011', 1),
(54, '1019', 1),
(55, '1023', 1),
(56, '1030', 1),
(57, '1027', 1),
(58, '1032', 1),
(59, '1035', 1),
(60, '1037', 1),
(61, '1037', 0),
(62, '2001', 1),
(63, '2004', 1),
(64, '2008', 1),
(65, '2009', 1),
(66, '2011', 1),
(67, '2404', 1),
(68, '6021', 1),
(69, 'TR90', 1),
(70, '004', 1),
(71, '625', 1),
(72, '818', 1),
(73, '819', 1),
(74, '2034', 1),
(75, '2034', 0),
(76, '2204', 1),
(77, '2976', 1),
(78, '2978', 1),
(79, '3002', 1),
(80, '3006', 1),
(81, '3028', 1),
(82, '3502', 1),
(83, '3504', 1),
(84, '6008', 1),
(85, '6009', 1),
(86, '7206', 1),
(87, '7350', 1),
(88, '8013', 1),
(89, '8031', 1),
(90, '9040', 1),
(91, '9259', 1),
(92, '9372', 1),
(93, '402', 1),
(94, '405', 1),
(95, '407', 1),
(96, '408', 1),
(97, '409', 1),
(98, '503', 1),
(99, '506', 1),
(100, '507', 1),
(101, '509', 1),
(102, '510', 1),
(103, '7005', 1),
(104, '7023', 1),
(105, '7024', 1),
(106, '7028', 1),
(107, '7031', 1),
(108, '8003', 1),
(109, '8011', 1),
(110, '8012', 1),
(111, '8014', 1),
(112, '8021', 1),
(113, '5228%20%20%20%202479', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Ojos`
--

CREATE TABLE `Ojos` (
  `OjoID` int(11) NOT NULL,
  `LadoID` int(11) NOT NULL,
  `Esfera` varchar(10) DEFAULT NULL,
  `Cilindro` varchar(10) DEFAULT NULL,
  `Eje` varchar(10) DEFAULT NULL,
  `Adiccion` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Ojos`
--

INSERT INTO `Ojos` (`OjoID`, `LadoID`, `Esfera`, `Cilindro`, `Eje`, `Adiccion`) VALUES
(1, 1, '12.00', '12.00', '12.00', '12.00'),
(2, 2, '12.00', '12.00', '12.00', '12.00'),
(3, 1, '12.00', '12.00', '12.00', '12.00'),
(4, 2, '12.00', '12.00', '12.00', '12.00'),
(5, 1, '12.00', '12.00', '12.00', '12.00'),
(6, 2, '12.00', '12.00', '12.00', '12.00'),
(7, 1, '-175.00', '-175.00', '0.00', '0.00'),
(8, 2, '-150.00', '-200.00', '-180.00', '0.00'),
(9, 1, '-175.00', '-200.00', '10.00', '0.00'),
(10, 2, '-175.00', '-225.00', '-15.00', '0.00'),
(11, 1, '-175.00', '-200.00', '10.00', '0.00'),
(12, 2, '-175.00', '-225.00', '15.00', '0.00'),
(13, 1, '-475.00', '-250.00', '0.00', '0.00'),
(14, 2, '-475.00', '-475.00', '5.00', '0.00'),
(15, 1, '-500.00', '-300.00', '0.00', '0.00'),
(16, 2, '-500.00', '-500.00', '20.00', '0.00'),
(17, 1, '-500.00', '-300.00', '0.00', '0.00'),
(18, 2, '-500.00', '-500.00', '20.00', '0.00'),
(19, 1, '0.00', '-25.00', '0.00', '0.00'),
(20, 2, '0.00', '-25.00', '180.00', '0.00'),
(21, 1, '0.00', '-25.00', '0.00', '0.00'),
(22, 2, '0.00', '-25.00', '180.00', '0.00'),
(23, 1, '0.00', '-25.00', '0.00', '0.00'),
(24, 2, '0.00', '-25.00', '180.00', '0.00'),
(25, 1, '0.00', '-25.00', '0.00', '0.00'),
(26, 2, '0.00', '-25.00', '180.00', '0.00'),
(27, 1, '0.00', '-25.00', '0.00', '0.00'),
(28, 2, '0.00', '-25.00', '180.00', '0.00'),
(29, 1, '0', '-25', '0', '0'),
(30, 2, '0', '0', '180', '0'),
(31, 1, '0', '-25', '0', '0'),
(32, 2, '0', '-25', '180', '0'),
(33, 1, '0', '-25', '0', '0'),
(34, 2, '0', '0', '180', '0'),
(35, 1, '0', '-25', '0', '0'),
(36, 2, '0', '-25', '180', '0'),
(37, 1, '0', '-025', '0', '0'),
(38, 2, '0', '0', '180', '0'),
(39, 1, '0', '-25', '0', '0'),
(40, 2, '0', '-25', '180', '0'),
(41, 1, '-050', '-325', '0', '0'),
(42, 2, '-050', '-300', '0', '0'),
(43, 1, '-025', '-075', '0', '0'),
(44, 2, '-025', '-075', '180', '0'),
(45, 1, '-025', '-075', '0', '0'),
(46, 2, '-025', '-075', '180', '0'),
(47, 1, '0', '-125', '180', '0'),
(48, 2, '0', '-125', '0', '0'),
(49, 1, '0', '-125', '0', '0'),
(50, 2, '0', '-125', '0', '0'),
(51, 1, '-300', '-075', '0', '0'),
(52, 2, '-350', '-075', '0', '0'),
(53, 1, '-300', '-075', '0', '0'),
(54, 2, '-350', '-075', '0', '0'),
(55, 1, '075', '0', '0', '0'),
(56, 2, '-050', '0', '0', '0'),
(57, 1, '075', '0', '0', '0'),
(58, 2, '050', '0', '0', '0'),
(59, 1, '+025', '+175', '0', '+225'),
(60, 2, '+025', '+175', '0', '+225'),
(61, 1, '+100', '0', '0', '+225'),
(62, 2, '+075', '0', '0', '+225'),
(63, 1, '+100', '0', '0', '+225'),
(64, 2, '+075', '0', '0', '+225'),
(65, 1, '-050', '0', '0', '0'),
(66, 2, '0', '-050', '0', '0'),
(67, 1, '-050', '0', '0', '0'),
(68, 2, '0', '-050', '0', '0'),
(69, 1, '-050', '0', '0', '0'),
(70, 2, '0', '-050', '0', '0'),
(71, 1, '-050', '0', '0', '0'),
(72, 2, '0', '-050', '0', '0'),
(73, 1, '-250', '-100', '0', '0'),
(74, 2, '-225', '-100', '0', '0'),
(75, 1, '-325', '-150', '165', '0'),
(76, 2, '-300', '-100', '165', '0'),
(77, 1, '-325', '-150', '165', '0'),
(78, 2, '-300', '-100', '165', '0'),
(79, 1, '-025', '0', '0', '+200'),
(80, 2, '-050', '0', '0', '+200'),
(81, 1, '-025', '0', '0', '+200'),
(82, 2, '-050', '0', '0', '+200'),
(83, 1, '-025', '0', '0', '+200'),
(84, 2, '-050', '0', '0', '+200'),
(85, 1, '-025', '0', '0', '+200'),
(86, 2, '-050', '0', '0', '+200'),
(87, 1, '-025', '0', '0', '+200'),
(88, 2, '-050', '0', '0', '+200'),
(89, 1, '-025', '0', '0', '+200'),
(90, 2, '-050', '0', '0', '+200'),
(91, 1, '-025', '0', '0', '+200'),
(92, 2, '-050', '0', '0', '+200'),
(93, 1, '-025', '0', '0', '+200'),
(94, 2, '-050', '0', '0', '+200'),
(95, 1, '0', '-025', '0', '0'),
(96, 2, '0', '-025', '180', '0'),
(97, 1, '0', '-025', '0', '0'),
(98, 2, '0', '-025', '180', '0'),
(99, 1, '-150', '-050', '0', '0'),
(100, 2, '-175', '-050', '0', '0'),
(101, 1, '-150', '-050', '0', '0'),
(102, 2, '-175', '-025', '0', '0'),
(103, 1, '-150', '-050', '0', '0'),
(104, 2, '-175', '-025', '0', '0'),
(105, 1, '-150', '-050', '0', '0'),
(106, 2, '-175', '-050', '0', '0'),
(107, 1, '-150', '-050', '0', '0'),
(108, 2, '-175', '-025', '0', '0'),
(109, 1, '-150', '-050', '0', '0'),
(110, 2, '-175', '-025', '0', '0'),
(111, 1, '-025', '0', '0', '0'),
(112, 2, '-025', '-025', '0', '0'),
(113, 1, '-025', '0', '0', '0'),
(114, 2, '-025', '-025', '0', '0'),
(115, 1, '0', '-025', '0', '0'),
(116, 2, '0', '-025', '180', '0'),
(117, 1, '0', '-025', '0', '0'),
(118, 2, '0', '-025', '180', '0'),
(119, 1, '0', '-025', '0', '0'),
(120, 2, '0', '-025', '180', '0'),
(121, 1, '0', '-025', '0', '0'),
(122, 2, '0', '-025', '180', '0'),
(123, 1, '0', '-025', '0', '0'),
(124, 2, '0', '-025', '180', '0'),
(125, 1, '0', '-025', '0', '0'),
(126, 2, '0', '-025', '180', '0'),
(127, 1, '-050', '-025', '0', '0'),
(128, 2, '-025', '-025', '180', '0'),
(129, 1, '-050', '-025', '0', '0'),
(130, 2, '-025', '-025', '180', '0'),
(131, 1, '-050', '-025', '0', '0'),
(132, 2, '-025', '-025', '180', '0'),
(133, 1, '-050', '-025', '0', '0'),
(134, 2, '-025', '-025', '180', '0'),
(135, 1, '-025', '0', '0', '0'),
(136, 2, '-025', '-025', '0', '0'),
(137, 1, '-025', '0', '0', '0'),
(138, 2, '-025', '-025', '0', '0'),
(139, 1, '0', '-025', '0', '0'),
(140, 2, '0', '-025', '180', '0'),
(141, 1, '0', '-025', '0', '0'),
(142, 2, '0', '-025', '180', '0'),
(143, 1, '-025', '0', '0', '0'),
(144, 2, '-025', '-025', '0', '0'),
(145, 1, '-025', '0', '0', '0'),
(146, 2, '-025', '-025', '0', '0'),
(147, 1, '-025', '0', '0', '0'),
(148, 2, '-025', '0', '0', '0'),
(149, 1, '0', '-025', '90', '0'),
(150, 2, '0', '-025', '90', '0'),
(151, 1, '0', '-025', '90', '0'),
(152, 2, '0', '-025', '90', '0'),
(153, 1, '-075', '-025', '0', '0'),
(154, 2, '-075', '-025', '180', '0'),
(155, 1, '-075', '-025', '0', '0'),
(156, 2, '-075', '-025', '180', '0'),
(157, 1, '-800', '-175', '175', '0'),
(158, 2, '-900', '-175', '10', '0'),
(159, 1, '-825', '-175', '175', '0'),
(160, 2, '-925', '-175', '10', '0'),
(161, 1, '-825', '-175', '175', '0'),
(162, 2, '-925', '-175', '10', '0'),
(163, 1, '0', '-025', '90', '+175'),
(164, 2, '0', '-025', '90', '+175'),
(165, 1, '0', '-025', '90', '+175'),
(166, 2, '0', '-025', '90', '+175'),
(167, 1, '-150', '-025', '90', '0'),
(168, 2, '-150', '-125', '71', '0'),
(169, 1, '-150', '-025', '90', '0'),
(170, 2, '-150', '-125', '71', '0'),
(171, 1, '+150', '0', '0', '0'),
(172, 2, '+150', '0', '0', '0'),
(173, 1, '-200', '-200', '0', '0'),
(174, 2, '-200', '-150', '15', '0'),
(175, 1, '-200', '-200', '175', '0'),
(176, 2, '-200', '-150', '15', '0'),
(177, 1, '-275', '-175', '175', '0'),
(178, 2, '-150', '-100', '180', '0'),
(179, 1, '-175', '-175', '175', '0'),
(180, 2, '-125', '-100', '180', '0'),
(181, 1, '-150', '-100', '120', '0'),
(182, 2, '-100', '-025', '120', '0'),
(183, 1, '-150', '-100', '120', '0'),
(184, 2, '-100', '-025', '120', '0'),
(185, 1, '-025', '-175', '30', '0'),
(186, 2, '-200', '-050', '180', '0'),
(187, 1, '-025', '-125', '30', '0'),
(188, 2, '-200', '-050', '180', '0'),
(189, 1, '-025', '0', '0', '+150'),
(190, 2, '-025', '0', '0', '+150'),
(191, 1, '-025', '0', '0', '+150'),
(192, 2, '-025', '0', '0', '+150'),
(193, 1, '-150', '-075', '160', '0'),
(194, 2, '-275', '-050', '160', '0'),
(195, 1, '-150', '-075', '160', '0'),
(196, 2, '-275', '-050', '160', '0'),
(197, 1, '-075', '-175', '180', '0'),
(198, 2, '-200', '-300', '0', '0'),
(199, 1, '-075', '-175', '180', '0'),
(200, 2, '-200', '-250', '0', '0'),
(201, 1, '-075', '-175', '180', '0'),
(202, 2, '-200', '-300', '0', '0'),
(203, 1, '-075', '-175', '180', '0'),
(204, 2, '-200', '-250', '0', '0'),
(205, 1, '-075', '-175', '180', '0'),
(206, 2, '-200', '-300', '0', '0'),
(207, 1, '-075', '-175', '180', '0'),
(208, 2, '-200', '-250', '0', '0'),
(209, 1, '-075', '-175', '180', '0'),
(210, 2, '-200', '-300', '0', '0'),
(211, 1, '-075', '-175', '180', '0'),
(212, 2, '-200', '-250', '0', '0'),
(213, 1, '+025', '0', '+175', '0'),
(214, 2, '+025', '0', '+175', '0'),
(215, 1, '+175', '0', '0', '0'),
(216, 2, '+175', '0', '0', '0'),
(217, 1, '-075', '-175', '180', '0'),
(218, 2, '-200', '-300', '0', '0'),
(219, 1, '-075', '-175', '180', '0'),
(220, 2, '-200', '-250', '0', '0'),
(221, 1, '0', '0', '0', '0'),
(222, 2, '0', '0', '0', '0'),
(223, 1, '-025', '0', '0', '0'),
(224, 2, '-075', '0', '0', '0'),
(225, 1, '-025', '0', '0', '0'),
(226, 2, '-075', '0', '0', '0'),
(227, 1, '-025', '-050', '0', '0'),
(228, 2, '-125', '-050', '180', '0'),
(229, 1, '-025', '-050', '0', '0'),
(230, 2, '-075', '-050', '180', '0'),
(231, 1, '+075', '0', '0', '+200'),
(232, 2, '+100', '0', '0', '+200'),
(233, 1, '+075', '0', '0', '+200'),
(234, 2, '+100', '0', '0', '+200'),
(235, 1, '+075', '0', '0', '+200'),
(236, 2, '+100', '0', '0', '+200'),
(237, 1, '+025', '0', '0', '+150'),
(238, 2, '+025', '0', '0', '+150'),
(239, 1, '+150', '0', '0', '0'),
(240, 2, '+150', '0', '0', '0'),
(241, 1, '0', '-025', '0.', '0'),
(242, 2, '0', '-175', '180', '0'),
(243, 1, '0', '-025', '0', '0'),
(244, 2, '0', '-075', '180', '0'),
(245, 1, '0', '0', '0', '+200'),
(246, 2, '0', '0', '0', '+200'),
(247, 1, '+200', '0', '0', '0'),
(248, 2, '+200', '0', '0', '0'),
(249, 1, '-225', '0', '0', '0'),
(250, 2, '-225', '0', '0', '0'),
(251, 1, '-225', '0', '0', '0'),
(252, 2, '-225', '0', '0', '0'),
(253, 1, '-125', '-025', '180', '0'),
(254, 2, '-175', '-025', '180', '0'),
(255, 1, '-125', '-025', '180', '0'),
(256, 2, '-175', '-025', '180', '0'),
(257, 1, '-200', '-025', '90', '0'),
(258, 2, '-250', '-025', '90', '0'),
(259, 1, '-200', '0', '0', '0'),
(260, 2, '-250', '0', '0', '0'),
(261, 1, '0', '-025', '0', '0'),
(262, 2, '0', '-025', '0', '0'),
(263, 1, '0', '-025', '0', '0'),
(264, 2, '0', '-025', '0', '0'),
(265, 1, '+050', '0', '0', '+175'),
(266, 2, '+050', '0', '0', '+175'),
(267, 1, '+050', '0', '0', '+175'),
(268, 2, '+050', '0', '0', '+175'),
(269, 1, '-025', '0', '0', '0'),
(270, 2, '-050', '0', '0', '0'),
(271, 1, '-025', '0', '0', '0'),
(272, 2, '-050', '0', '0', '0'),
(273, 1, '-025', '0', '0', '0'),
(274, 2, '-025', '0', '0', '0'),
(275, 1, '-025', '0', '0', '0'),
(276, 2, '-025', '0', '0', '0'),
(277, 1, '-050', '0', '0', '0'),
(278, 2, '-050', '0', '0', '0'),
(279, 1, '-050', '0', '0', '0'),
(280, 2, '-050', '0', '0', '0');

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE `properties` (
  `propertyId` int(11) NOT NULL,
  `propertyName` varchar(100) NOT NULL,
  `propertyValue` varchar(10000) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Protecciones`
--

CREATE TABLE `Protecciones` (
  `ProteccionID` int(11) NOT NULL,
  `Descripcion` varchar(40) NOT NULL,
  `EstaActivo` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Protecciones`
--

INSERT INTO `Protecciones` (`ProteccionID`, `Descripcion`, `EstaActivo`) VALUES
(1, 'Anti-reflejante', 1),
(2, 'Anti%20Rayas', 0),
(3, 'Crizal%20Forte', 1),
(4, 'Crizal%20Alize', 1),
(5, 'Photogray', 1),
(6, 'Anti%20rayas', 1),
(7, 'Anti%20reflejante%20y%20Fotocromatico%20', 1),
(8, 'Nada', 0),
(9, 'Ninguno', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Restricciones`
--

CREATE TABLE `Restricciones` (
  `RestriccionID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `Empresa` varchar(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Restricciones`
--

INSERT INTO `Restricciones` (`RestriccionID`, `userID`, `Empresa`) VALUES
(3, 10, 'Externos');

-- --------------------------------------------------------

--
-- Table structure for table `RolesEmpleados`
--

CREATE TABLE `RolesEmpleados` (
  `RolID` int(11) NOT NULL,
  `Descripcion` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Tamanios`
--

CREATE TABLE `Tamanios` (
  `TamanioID` int(11) NOT NULL,
  `Descripcion` varchar(40) NOT NULL,
  `EstaActivo` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Tamanios`
--

INSERT INTO `Tamanios` (`TamanioID`, `Descripcion`, `EstaActivo`) VALUES
(1, 'No%20aplica', 0),
(2, 'Normal', 0),
(3, '53-17-145', 1),
(4, 'Prueba%20de%20tama%c3%b1o', 0),
(5, 'Tama%c3%b1o%20de%20prueba', 0),
(6, 'prueba%20tama%c3%b1o', 0),
(7, 'asda%20%20asdasd%20%c3%b1o', 0),
(8, '57-17-145', 1),
(9, '55-34-18-138', 1),
(10, '54-18-140', 1),
(11, '53-16-147', 1),
(12, '55-18-145', 1),
(13, '34-18-138', 1),
(14, '53-17-140', 1),
(15, '54-17-140', 1),
(16, '50-18-140', 1),
(17, '54-17-129', 1),
(18, '51-17-140', 1),
(19, '51-18-135', 1),
(20, '55-16-140', 1),
(21, '53-15-138', 1),
(22, '52-17-142', 1),
(23, '50-21-140', 1),
(24, '50-43-19-140', 1),
(25, '56-18-140', 1),
(26, '54-41-18-140', 1),
(27, '42-18-136', 1),
(28, '51-19-140', 1),
(29, '54-15-140', 1),
(30, '55-18-145', 1),
(31, '56-39-16-140', 1),
(32, '54-18-138', 1),
(33, '49-18-135', 1),
(34, '53-19-140', 1),
(35, '52-19-140', 1);

-- --------------------------------------------------------

--
-- Table structure for table `TipoConjunto`
--

CREATE TABLE `TipoConjunto` (
  `TipoConjuntoID` int(11) NOT NULL,
  `Descripcion` varchar(15) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `TipoConjunto`
--

INSERT INTO `TipoConjunto` (`TipoConjuntoID`, `Descripcion`) VALUES
(1, 'Anterior'),
(2, 'Total'),
(3, 'Adaptación');

-- --------------------------------------------------------

--
-- Table structure for table `TipoLente`
--

CREATE TABLE `TipoLente` (
  `LenteID` int(11) NOT NULL,
  `Descripcion` varchar(40) NOT NULL,
  `EstaActivo` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `TipoLente`
--

INSERT INTO `TipoLente` (`LenteID`, `Descripcion`, `EstaActivo`) VALUES
(1, 'Monofocal', 1),
(2, 'Flat%20Top', 1),
(3, 'Invisible', 1),
(4, 'Progresivo', 1),
(5, 'Di%c3%a1metro', 1),
(6, 'Progresivo%20ovation', 1);

-- --------------------------------------------------------

--
-- Table structure for table `TipoVenta`
--

CREATE TABLE `TipoVenta` (
  `TipoVentaID` int(11) NOT NULL,
  `Descripcion` varchar(30) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `TipoVenta`
--

INSERT INTO `TipoVenta` (`TipoVentaID`, `Descripcion`) VALUES
(1, 'Efectivo'),
(2, 'Tarjeta de crédito'),
(3, 'Nómina');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` int(11) NOT NULL,
  `userName` varchar(30) NOT NULL,
  `password` varchar(40) NOT NULL,
  `Token` varchar(50) DEFAULT NULL,
  `Admin` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `userName`, `password`, `Token`, `Admin`) VALUES
(7, 'jorge', 'a7bf1569f72157c8367a56d7240cc9ae8cef0b84', '9984dac47536628dedb99c743f4ee789fa904977', 1),
(6, 'enrique', '53a9e5c1378e16741f277c2a941b19fdacb90361', '6b78ccf204b0ebeedceef8db6aaee2e14833b6ba', 1),
(8, 'lorena1', '7c4a8d09ca3762af61e59520943dc26494f8941b', '3dc10aec8b1908220a96988c2e65d0a30d6d7972', NULL),
(10, 'nataly', '278600eabdd94474959c497c1eb481713f38bb10', '23f2b171a13b73e35c049f1238c4c156ec4f5170', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Ventas`
--

CREATE TABLE `Ventas` (
  `VentaID` int(11) NOT NULL,
  `FolioExamen` varchar(10) DEFAULT NULL,
  `TotalVenta` decimal(13,2) NOT NULL,
  `Anticipo` decimal(13,2) DEFAULT NULL,
  `PeriodicidadDias` int(11) DEFAULT NULL,
  `Abonos` decimal(13,2) DEFAULT NULL,
  `fechaVenta` date NOT NULL,
  `EstaLiquidada` tinyint(1) DEFAULT NULL,
  `ArmazonId` int(11) DEFAULT NULL,
  `MaterialID` int(11) DEFAULT NULL,
  `ProteccionID` int(11) DEFAULT NULL,
  `LenteID` int(11) DEFAULT NULL,
  `BeneficiarioID` int(11) DEFAULT NULL,
  `ExamenID` int(11) DEFAULT NULL,
  `TipoVentaID` int(11) DEFAULT NULL,
  `NumeroPagos` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Ventas`
--

INSERT INTO `Ventas` (`VentaID`, `FolioExamen`, `TotalVenta`, `Anticipo`, `PeriodicidadDias`, `Abonos`, `fechaVenta`, `EstaLiquidada`, `ArmazonId`, `MaterialID`, `ProteccionID`, `LenteID`, `BeneficiarioID`, `ExamenID`, `TipoVentaID`, `NumeroPagos`) VALUES
(2, '038', 2900.00, 600.00, 7, 193.33, '2020-06-01', 0, 3, 1, 1, 1, 2, 1, 1, 12),
(3, '052', 2750.00, 0.00, 7, 182.00, '2020-07-03', 0, 4, 2, 1, 1, 3, 2, 1, 15),
(4, '039', 3240.00, 0.00, 7, 249.23, '2020-06-01', 0, 5, 3, 1, 1, 5, 4, 1, 13),
(17, '044', 890.00, 0.00, 30, 445.00, '2020-07-06', 1, 18, 3, 1, 1, 21, 19, 3, 2),
(7, '043', 4256.00, 0.00, 7, 4256.00, '2020-06-01', 0, 8, 3, 1, 1, 8, 7, 1, 1),
(9, '050', 3120.00, 1000.00, 7, 212.00, '2020-07-08', 0, 10, 3, 7, 3, 9, 8, 1, 10),
(10, '048', 890.00, 0.00, 30, 445.00, '2020-07-06', 1, 11, 3, 1, 1, 10, 9, 3, 2),
(11, '047', 2030.00, 0.00, 15, 406.00, '2020-07-06', 1, 12, 2, 1, 1, 11, 10, 3, 5),
(16, '45', 700.00, 0.00, 15, 140.00, '2020-07-06', 1, 17, 3, 1, 1, 20, 18, 3, 5),
(19, '055', 2597.00, 2000.00, 0, 298.50, '2020-07-20', 1, 20, 2, 1, 1, 18, 20, 1, 2),
(18, '46', 3009.00, 0.00, 15, 601.80, '2020-07-06', 1, 19, 3, 1, 6, 12, 11, 3, 5),
(14, '053', 2300.00, 700.00, 0, 800.00, '2020-07-13', 1, 15, 3, 7, 1, 13, 12, 1, 2),
(15, '054', 1611.00, 500.00, 0, 555.50, '2020-07-13', 1, 16, 3, 1, 1, 14, 13, 1, 2),
(20, '049', 5533.00, 0.00, 7, 291.21, '2020-07-07', 0, 21, 3, 7, 2, 23, 21, 1, 19),
(21, '056', 1356.00, 500.00, 0, 428.00, '2020-07-27', 0, 22, 3, 7, 1, 24, 22, 1, 2),
(22, 'Bosque Mer', 450.00, 0.00, 7, 37.50, '2020-08-10', 0, 23, 3, 8, 1, 25, 23, 1, 12),
(23, '057', 2575.00, 0.00, 8, 286.11, '2020-09-02', 0, 24, 1, 1, 1, 26, 24, 3, 9),
(24, '058', 3106.00, 0.00, 8, 310.60, '2020-09-08', 0, 25, 3, 7, 1, 27, 25, 3, 10),
(26, '059', 2156.00, 0.00, 8, 215.60, '2020-09-08', 0, 27, 3, 7, 1, 28, 26, 3, 10),
(27, '060', 2156.00, 0.00, 8, 215.60, '2020-09-08', 0, 28, 3, 7, 1, 29, 27, 3, 10),
(28, '062', 2520.00, 0.00, 8, 252.00, '2020-09-08', 0, 29, 3, 7, 2, 30, 28, 3, 10),
(29, '063', 1780.00, 0.00, 8, 178.00, '2020-09-08', 0, 30, 3, 1, 1, 31, 29, 3, 10),
(30, '064', 2156.00, 1556.00, 0, 600.00, '2020-09-14', 0, 31, 3, 7, 1, 35, 33, 1, 1),
(31, '065', 1390.00, 0.00, 8, 173.75, '2020-09-14', 0, 32, 3, 1, 1, 36, 34, 3, 8),
(32, '066', 1273.00, 0.00, 8, 159.13, '2020-09-14', 0, 33, 3, 9, 2, 37, 35, 3, 8),
(33, '067', 1400.00, 0.00, 8, 175.00, '2020-09-14', 0, 34, 3, 1, 1, 38, 36, 3, 8),
(34, '068', 2156.00, 0.00, 8, 269.50, '2020-09-14', 0, 35, 3, 7, 1, 39, 37, 3, 8),
(35, '069', 399.00, 0.00, 8, 49.88, '2020-09-14', 0, 36, 3, 9, 1, 40, 38, 3, 8),
(36, '070', 2156.00, 0.00, 8, 269.50, '2020-09-14', 0, 37, 3, 7, 1, 41, 39, 3, 8),
(37, '071', 1856.00, 0.00, 8, 232.00, '2020-09-14', 0, 38, 3, 7, 1, 42, 40, 3, 8),
(38, '072', 1856.00, 0.00, 8, 232.00, '2020-09-14', 0, 39, 3, 7, 1, 43, 41, 3, 8),
(39, '073', 399.00, 0.00, 8, 49.88, '2020-09-14', 0, 40, 3, 9, 1, 44, 42, 3, 8),
(40, '074', 973.00, 0.00, 8, 121.63, '2020-09-14', 0, 41, 3, 9, 2, 45, 43, 3, 8),
(41, '075', 399.00, 0.00, 8, 49.88, '2020-09-14', 0, 42, 3, 9, 1, 46, 44, 3, 8);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Abonos`
--
ALTER TABLE `Abonos`
  ADD PRIMARY KEY (`AbonoID`),
  ADD KEY `VentaID` (`VentaID`);

--
-- Indexes for table `Armazones`
--
ALTER TABLE `Armazones`
  ADD PRIMARY KEY (`ArmazonID`),
  ADD KEY `MarcaID` (`MarcaID`),
  ADD KEY `ColorID` (`ColorID`),
  ADD KEY `TamanioID` (`TamanioID`),
  ADD KEY `ModeloID` (`ModeloID`);

--
-- Indexes for table `Beneficiarios`
--
ALTER TABLE `Beneficiarios`
  ADD PRIMARY KEY (`BeneficiarioID`),
  ADD KEY `EmpresaID` (`EmpresaID`);

--
-- Indexes for table `CasosMaterialesISO`
--
ALTER TABLE `CasosMaterialesISO`
  ADD PRIMARY KEY (`CasoID`);

--
-- Indexes for table `CasosPorBeneficiario`
--
ALTER TABLE `CasosPorBeneficiario`
  ADD PRIMARY KEY (`CasoPorBeneficiarioID`),
  ADD KEY `BeneficiarioID` (`BeneficiarioID`),
  ADD KEY `CasoID` (`CasoID`);

--
-- Indexes for table `colores`
--
ALTER TABLE `colores`
  ADD PRIMARY KEY (`ColorID`);

--
-- Indexes for table `ConjuntoOjos`
--
ALTER TABLE `ConjuntoOjos`
  ADD PRIMARY KEY (`ConjuntoID`),
  ADD KEY `IzquierdoID` (`IzquierdoID`),
  ADD KEY `DerechoID` (`DerechoID`),
  ADD KEY `TipoConjuntoID` (`TipoConjuntoID`);

--
-- Indexes for table `emails`
--
ALTER TABLE `emails`
  ADD PRIMARY KEY (`mailId`),
  ADD UNIQUE KEY `mail` (`mail`);

--
-- Indexes for table `Empleados`
--
ALTER TABLE `Empleados`
  ADD PRIMARY KEY (`EmpleadoID`),
  ADD KEY `RolID` (`RolID`);

--
-- Indexes for table `Empresas`
--
ALTER TABLE `Empresas`
  ADD PRIMARY KEY (`EmpresaID`);

--
-- Indexes for table `EnfermedadesVisuales`
--
ALTER TABLE `EnfermedadesVisuales`
  ADD PRIMARY KEY (`EnfermedadID`);

--
-- Indexes for table `Examenes`
--
ALTER TABLE `Examenes`
  ADD PRIMARY KEY (`ExamenID`),
  ADD UNIQUE KEY `Folio` (`Folio`),
  ADD UNIQUE KEY `Anterior` (`Anterior`),
  ADD UNIQUE KEY `Total` (`Total`),
  ADD UNIQUE KEY `Adaptacion` (`Adaptacion`),
  ADD KEY `BeneficiarioID` (`BeneficiarioID`),
  ADD KEY `EnfermedadID` (`EnfermedadID`);

--
-- Indexes for table `Lados`
--
ALTER TABLE `Lados`
  ADD PRIMARY KEY (`LadoID`);

--
-- Indexes for table `MarcasArmazones`
--
ALTER TABLE `MarcasArmazones`
  ADD PRIMARY KEY (`MarcaID`);

--
-- Indexes for table `Materiales`
--
ALTER TABLE `Materiales`
  ADD PRIMARY KEY (`MaterialID`);

--
-- Indexes for table `Modelos`
--
ALTER TABLE `Modelos`
  ADD PRIMARY KEY (`ModeloID`);

--
-- Indexes for table `Ojos`
--
ALTER TABLE `Ojos`
  ADD PRIMARY KEY (`OjoID`),
  ADD KEY `LadoID` (`LadoID`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`propertyId`),
  ADD UNIQUE KEY `propertyName` (`propertyName`);

--
-- Indexes for table `Protecciones`
--
ALTER TABLE `Protecciones`
  ADD PRIMARY KEY (`ProteccionID`);

--
-- Indexes for table `Restricciones`
--
ALTER TABLE `Restricciones`
  ADD PRIMARY KEY (`RestriccionID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `RolesEmpleados`
--
ALTER TABLE `RolesEmpleados`
  ADD PRIMARY KEY (`RolID`);

--
-- Indexes for table `Tamanios`
--
ALTER TABLE `Tamanios`
  ADD PRIMARY KEY (`TamanioID`);

--
-- Indexes for table `TipoConjunto`
--
ALTER TABLE `TipoConjunto`
  ADD PRIMARY KEY (`TipoConjuntoID`);

--
-- Indexes for table `TipoLente`
--
ALTER TABLE `TipoLente`
  ADD PRIMARY KEY (`LenteID`);

--
-- Indexes for table `TipoVenta`
--
ALTER TABLE `TipoVenta`
  ADD PRIMARY KEY (`TipoVentaID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`),
  ADD UNIQUE KEY `userName` (`userName`),
  ADD UNIQUE KEY `Token` (`Token`);

--
-- Indexes for table `Ventas`
--
ALTER TABLE `Ventas`
  ADD PRIMARY KEY (`VentaID`),
  ADD UNIQUE KEY `FolioExamen` (`FolioExamen`),
  ADD KEY `ArmazonId` (`ArmazonId`),
  ADD KEY `MaterialID` (`MaterialID`),
  ADD KEY `ProteccionID` (`ProteccionID`),
  ADD KEY `LenteID` (`LenteID`),
  ADD KEY `BeneficiarioID` (`BeneficiarioID`),
  ADD KEY `ExamenID` (`ExamenID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Abonos`
--
ALTER TABLE `Abonos`
  MODIFY `AbonoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `Armazones`
--
ALTER TABLE `Armazones`
  MODIFY `ArmazonID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `Beneficiarios`
--
ALTER TABLE `Beneficiarios`
  MODIFY `BeneficiarioID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `CasosMaterialesISO`
--
ALTER TABLE `CasosMaterialesISO`
  MODIFY `CasoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `CasosPorBeneficiario`
--
ALTER TABLE `CasosPorBeneficiario`
  MODIFY `CasoPorBeneficiarioID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `colores`
--
ALTER TABLE `colores`
  MODIFY `ColorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `ConjuntoOjos`
--
ALTER TABLE `ConjuntoOjos`
  MODIFY `ConjuntoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=139;

--
-- AUTO_INCREMENT for table `emails`
--
ALTER TABLE `emails`
  MODIFY `mailId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Empleados`
--
ALTER TABLE `Empleados`
  MODIFY `EmpleadoID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Empresas`
--
ALTER TABLE `Empresas`
  MODIFY `EmpresaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `EnfermedadesVisuales`
--
ALTER TABLE `EnfermedadesVisuales`
  MODIFY `EnfermedadID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `Examenes`
--
ALTER TABLE `Examenes`
  MODIFY `ExamenID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `Lados`
--
ALTER TABLE `Lados`
  MODIFY `LadoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `MarcasArmazones`
--
ALTER TABLE `MarcasArmazones`
  MODIFY `MarcaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `Materiales`
--
ALTER TABLE `Materiales`
  MODIFY `MaterialID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Modelos`
--
ALTER TABLE `Modelos`
  MODIFY `ModeloID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `Ojos`
--
ALTER TABLE `Ojos`
  MODIFY `OjoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=281;

--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `propertyId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Protecciones`
--
ALTER TABLE `Protecciones`
  MODIFY `ProteccionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `Restricciones`
--
ALTER TABLE `Restricciones`
  MODIFY `RestriccionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `RolesEmpleados`
--
ALTER TABLE `RolesEmpleados`
  MODIFY `RolID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Tamanios`
--
ALTER TABLE `Tamanios`
  MODIFY `TamanioID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `TipoConjunto`
--
ALTER TABLE `TipoConjunto`
  MODIFY `TipoConjuntoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `TipoLente`
--
ALTER TABLE `TipoLente`
  MODIFY `LenteID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `TipoVenta`
--
ALTER TABLE `TipoVenta`
  MODIFY `TipoVentaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Ventas`
--
ALTER TABLE `Ventas`
  MODIFY `VentaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

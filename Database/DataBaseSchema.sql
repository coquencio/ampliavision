-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 04, 2020 at 05:46 PM
-- Server version: 5.6.47-cll-lve
-- PHP Version: 7.2.7

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

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActualizaExamen` (IN `_Folio` VARCHAR(10), IN `_BeneficiarioID` INT, IN `_Anterior` INT, IN `_Total` INT, IN `_adaptacion` INT, IN `_requiereLentes` BIT, IN `_comproLentes` BIT, IN `_enfermedadID` INT, IN `_obervacion` VARCHAR(250))  BEGIN
	update Examenes set beneficiarioID = _BeneficiarioID , anterior=_Anterior, total=_Total, adaptacion=_adaptacion, requiereLentes=_requiereLentes , comproLentes=_comproLentes , enfermedadID = _enfermedadID , observacion = _obervacion  where Folio = _Folio;
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

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE  `RegistraYSeleccionaVenta` (IN `FolioExamen` VARCHAR(10), IN `totalVenta` DECIMAL(13,2), IN `Anticipo` DECIMAL(13,2), IN `Periodicidad` INT, IN `fechaVenta` DATE, IN `armazonID` INT, IN `materialID` INT, IN `proteccionID` INT, IN `lenteID` INT, IN `beneficiarioID` INT, IN `tipoVentaID` INT, IN `numeroPagos` INT)  BEGIN
	select ExamenID into @ExamenID  from Examenes where folio = FolioExamen;
    insert into Ventas (folioExamen, totalVenta, anticipo, periodicidadDias, Abonos, fechaVenta, EstaLiquidada, armazonID, materialID, ProteccionID, LenteID, BeneficiarioID, ExamenID, TipoVentaID, NumeroPagos) values (folioExamen, totalVenta, anticipo, periodicidad, (totalVenta - anticipo)/numeroPagos, fechaventa, 0, armazonID, materialID, proteccionID, lenteID, beneficiarioID, @ExamenID, tipoVentaID, numeroPagos);
	select ventaID from Ventas order by ventaID desc limit 1;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegistraYSeleccionaVenta` (IN `FolioExamen` VARCHAR(10), IN `totalVenta` DECIMAL(13,2), IN `Anticipo` DECIMAL(13,2), IN `Periodicidad` INT, IN `abonos` DECIMAL(13,2), IN `fechaVenta` DATE, IN `armazonID` INT, IN `materialID` INT, IN `proteccionID` INT, IN `lenteID` INT, IN `beneficiarioID` INT, IN `tipoVentaID` INT, IN `numeroPagos` INT)  BEGIN
	select ExamenID into @ExamenID  from Examenes where folio = FolioExamen;
    insert into Ventas (folioExamen, totalVenta, anticipo, periodicidadDias, Abonos, fechaVenta, EstaLiquidada, armazonID, materialID, ProteccionID, LenteID, BeneficiarioID, ExamenID, TipoVentaID, NumeroPagos) values (folioExamen, totalVenta, anticipo, periodicidad, abonos, fechaventa, 0, armazonID, materialID, proteccionID, lenteID, beneficiarioID, @ExamenID, tipoVentaID, numeroPagos);
	select ventaID from Ventas order by ventaID desc limit 1;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `RegresaFolios` (IN `empresa_Id` INT)  BEGIN
	select folio from Examenes e inner join Beneficiarios b on b.beneficiarioId = e.BeneficiarioId where b.empresaId = empresa_Id;
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
		select v.ventaId as VentaId, v.TipoVentaID as Tipo, v.FolioExamen, b.nombres as Nombres, v.EstaLiquidada as EstaLiquidada, v.fechaVenta as Fecha ,b.apellidoPaterno as Apellido, b.Ocupacion as Puesto, ex.RequiereLentes, ex.comprolentes,  m.descripcion as Material, p.descripcion as Proteccion, t.descripcion as Lente, v.totalventa as Total, v.anticipo as Aticipo, v.abonos as Abonos,  v.NumeroPagos as TotalPagos from Ventas v inner join Beneficiarios b on v.beneficiarioId = b.beneficiarioId inner join Materiales m on v.materialId = m.materialId inner join Protecciones p on v.proteccionId = p.proteccionId inner join TipoLente t on v.lenteId = t.lenteId left join Examenes ex on v.examenId= ex.ExamenId where b.empresaId = _empresaId;
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

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ValidaFolio` (IN `_FolioExamen` VARCHAR(10))  BEGIN
	select count(*) from Ventas where FolioExamen = _FolioExamen;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `validaToken` (IN `keyToken` VARCHAR(40))  BEGIN
	select count(*) as Result from users where token = keyToken;
END$$

CREATE DEFINER=`dormirey2`@`localhost` PROCEDURE `ActualizaEmpresa` (IN `_id` INT, IN `_nombre` VARCHAR(60), IN `_Domicilio` VARCHAR(150), IN `_telefono` VARCHAR(20))  BEGIN
	update Empresas set Nombreempresa = _nombre, Domicilio=_Domicilio, telefono= _telefono where EmpresaID = _id;
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
(1, 'Azul', 1),
(2, 'Amarillo', 1),
(3, 'Verde', 1),
(4, 'Marca', 1),
(5, 'Pink', 1),
(6, 'Black', 1);

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
(1, 'Dormirey', 'Paseo de jerez 530, Col jardinez de Jerez, León Guanajuato', '477 711 9224');

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
(1, 'Guka', 1),
(2, 'Tito', 1);

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
(3, '1025', 1);

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
(6, 'Anti%20rayas', 1);

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
(1, 'No%20aplica', 1),
(2, 'Normal', 1),
(3, '53-17-145', 1),
(4, 'Prueba%20de%20tama%c3%b1o', 0),
(5, 'Tama%c3%b1o%20de%20prueba', 0),
(6, 'prueba%20tama%c3%b1o', 0),
(7, 'asda%20%20asdasd%20%c3%b1o', 0);

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
(5, 'Di%c3%a1metro', 1);

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
  `TipoVentaID` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Ventas`
--

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
-- Indexes for table `Protecciones`
--
ALTER TABLE `Protecciones`
  ADD PRIMARY KEY (`ProteccionID`);

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
  MODIFY `AbonoID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Armazones`
--
ALTER TABLE `Armazones`
  MODIFY `ArmazonID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Beneficiarios`
--
ALTER TABLE `Beneficiarios`
  MODIFY `BeneficiarioID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `CasosMaterialesISO`
--
ALTER TABLE `CasosMaterialesISO`
  MODIFY `CasoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `CasosPorBeneficiario`
--
ALTER TABLE `CasosPorBeneficiario`
  MODIFY `CasoPorBeneficiarioID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `colores`
--
ALTER TABLE `colores`
  MODIFY `ColorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ConjuntoOjos`
--
ALTER TABLE `ConjuntoOjos`
  MODIFY `ConjuntoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `Empleados`
--
ALTER TABLE `Empleados`
  MODIFY `EmpleadoID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Empresas`
--
ALTER TABLE `Empresas`
  MODIFY `EmpresaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `EnfermedadesVisuales`
--
ALTER TABLE `EnfermedadesVisuales`
  MODIFY `EnfermedadID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `Examenes`
--
ALTER TABLE `Examenes`
  MODIFY `ExamenID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Lados`
--
ALTER TABLE `Lados`
  MODIFY `LadoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `MarcasArmazones`
--
ALTER TABLE `MarcasArmazones`
  MODIFY `MarcaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Materiales`
--
ALTER TABLE `Materiales`
  MODIFY `MaterialID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Modelos`
--
ALTER TABLE `Modelos`
  MODIFY `ModeloID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Ojos`
--
ALTER TABLE `Ojos`
  MODIFY `OjoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `Protecciones`
--
ALTER TABLE `Protecciones`
  MODIFY `ProteccionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `RolesEmpleados`
--
ALTER TABLE `RolesEmpleados`
  MODIFY `RolID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Tamanios`
--
ALTER TABLE `Tamanios`
  MODIFY `TamanioID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `TipoConjunto`
--
ALTER TABLE `TipoConjunto`
  MODIFY `TipoConjuntoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `TipoLente`
--
ALTER TABLE `TipoLente`
  MODIFY `LenteID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `TipoVenta`
--
ALTER TABLE `TipoVenta`
  MODIFY `TipoVentaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Ventas`
--
ALTER TABLE `Ventas`
  MODIFY `VentaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

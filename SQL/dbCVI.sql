create database if not exists dbcvierp2;
use dbcvierp2;
#Base de datos Seguridad-----------------------------------------------------------------------------------
create table if not exists LOGIN(
	pk_id_login 						int(10) auto_increment,
    usuario_login 						varchar(45),
    contraseña_login 					varchar(45),
    nombreCompleto_login				varchar(100),
    estado_login						int(2),
    primary key(pk_id_login)
);
create table if not exists MODULO(
	pk_id_modulo 						int(10)auto_increment,
    nombre_modulo 						varchar(30)not null,
    descripcion_modulo 					varchar(50)not null,
    estado_modulo 						int(1)not null,
    primary key(pk_id_modulo),
    key(pk_id_modulo)
);
create table if not exists APLICACION(
	pk_id_aplicacion 					int(10)auto_increment,
    fk_id_modulo 						int(10)not null,
    nombre_aplicacion 					varchar(40)not null,
    descripcion_aplicacion 				varchar(45)not null,
    estado_aplicacion 					int(1)not null,
    primary key(pk_id_aplicacion),
    key(pk_id_aplicacion)
);
alter table APLICACION add constraint fk_aplicacion_modulo foreign key(fk_id_modulo) references MODULO(pk_id_modulo);
alter table APLICACION add archivoCHM varchar(250) after descripcion_aplicacion;
alter table APLICACION add archivoHTML varchar(250) after archivoCHM;


create table if not exists PERFIL(
	pk_id_perfil						int(10)auto_increment,
    nombre_perfil						varchar(50),
    descripcion_perfil					varchar(100),
    estado_perfil						int(2),
    primary key(pk_id_perfil)
);
create table if not exists PERMISO(
	pk_id_permiso						int(10)auto_increment,
    insertar_permiso					boolean,
    modificar_permiso					boolean,
    eliminar_permiso					boolean,
    consultar_permiso					boolean,
    imprimir_permiso					boolean,
    primary key(pk_id_permiso)
);
create table if not exists APLICACION_PERFIL(
	pk_id_aplicacion_perfil				int(10)auto_increment,
    fk_idaplicacion_aplicacion_perfil	int(10),
    fk_idperfil_aplicacion_perfil		int(10),
    fk_idpermiso_aplicacion_perfil		int(10),
    primary key(pk_id_aplicacion_perfil)
);
alter table APLICACION_PERFIL add constraint fk_aplicacionperfil_aplicacion foreign key (fk_idaplicacion_aplicacion_perfil) references APLICACION(pk_id_aplicacion)on delete restrict on update cascade;
alter table APLICACION_PERFIL add constraint fk_aplicacionperfil_perfil foreign key (fk_idperfil_aplicacion_perfil) references PERFIL(pk_id_perfil)on delete restrict on update cascade;
alter table APLICACION_PERFIL add constraint fk_aplicacionperfil_permiso foreign key (fk_idpermiso_aplicacion_perfil) references PERMISO (pk_id_permiso)on delete restrict on update cascade;

create table if not exists PERFIL_USUARIO(
	pk_id_perfil_usuario				int(10) not null auto_increment,
    fk_idusuario_perfil_usuario			int(10),
    fk_idperfil_perfil_usuario			int(10),
    primary key(pk_id_perfil_usuario)
);
alter table PERFIL_USUARIO add constraint fk_perfil_usuario_login foreign key(fk_idusuario_perfil_usuario) references LOGIN(pk_id_login) on delete restrict on update cascade;
alter table PERFIL_USUARIO add constraint fk_perfil_usuario_perfil foreign key (fk_idperfil_perfil_usuario) references PERFIL(pk_id_perfil) on delete restrict on update cascade;

create table if not exists APLICACION_USUARIO(
	pk_id_aplicacion_usuario			int(10) not null auto_increment,
    fk_idlogin_aplicacion_usuario		int(10),
    fk_idaplicacion_aplicacion_usuario	int(10),
    fk_idpermiso_aplicacion_usuario		int(10),
    primary key(pk_id_aplicacion_usuario)
);
alter table APLICACION_USUARIO add constraint fk_aplicacionusuario_login foreign key(fk_idlogin_aplicacion_usuario) references LOGIN(pk_id_login) on delete restrict on update cascade;
alter table APLICACION_USUARIO add constraint fk_aplicacionusuario_aplicacion foreign key (fk_idaplicacion_aplicacion_usuario) references APLICACION(pk_id_aplicacion) on delete restrict on update cascade;
alter table APLICACION_USUARIO add constraint fk_aplicacionusuario_permiso foreign key(fk_idpermiso_aplicacion_usuario) references PERMISO (pk_id_permiso)on delete restrict on update cascade;

create table if not exists BITACORA(
	pk_id_bitacora						int(10)auto_increment, #pk
    fk_idusuario_bitacora				int(10),
    fk_idaplicacion_bitacora			int(10),
    fechahora_bitacora					varchar(50),
    direccionhost_bitacora				varchar(20),
    nombrehost_bitacora					varchar(20),
    accion_bitacora						varchar(250),
    primary key(pk_id_bitacora)
);
CREATE TABLE IF NOT EXISTS DETALLE_BITACORA (
    pk_id_detalle_bitacora 				INT(10)AUTO_INCREMENT,
    fk_idbitacora_detalle_bitacora 		INT(10),
    querryantigua_detalle_bitacora 		VARCHAR(50),
    querrynueva_detalle_bitacora 		VARCHAR(50),
    primary key(pk_id_detalle_bitacora)
);
alter table BITACORA add constraint fk_login_bitacora foreign key (fk_idusuario_bitacora) references LOGIN (pk_id_login) on delete restrict on update cascade;
alter table BITACORA add constraint fk_aplicacion_bitacora foreign key (fk_idaplicacion_bitacora) references APLICACION(pk_id_aplicacion) on delete restrict on update cascade;
alter table DETALLE_BITACORA add constraint fk_bitacora_detallebitacora foreign key(fk_idbitacora_detalle_bitacora) references BITACORA(pk_id_bitacora) on delete restrict on update cascade;

#REPORTEADOR---------------------------------------------------------------------------------------
create table if not exists REPORTE(
	pk_id_reporte 						int(10)not null auto_increment,
    nombre_reporte 						varchar(40)not null,
    ruta_reporte 						varchar(100)not null,
    estado_reporte 						int(1)not null,
    primary key(pk_id_reporte),
    key(pk_id_reporte)
);
create table if not exists REPORTE_MODULO(
	fk_id_reporte 						int(10)not null ,
    fk_id_modulo 						int(10)not null,
    estado_reporte_modulo 				int(1)not null,
    primary key(fk_id_reporte,fk_id_modulo),
    key(fk_id_reporte,fk_id_modulo)
);
alter table REPORTE_MODULO add constraint fk_reporte_de_modulo foreign key(fk_id_reporte) references REPORTE(pk_id_reporte);
alter table REPORTE_MODULO add constraint fk_reporte_de_modulo_reportes foreign key(fk_id_modulo) references MODULO(pk_id_modulo);

create table if not exists REPORTE_APLICATIVO(
	fk_id_reporte 						int(10)not null,
    fk_id_aplicacion 					int(10)not null,
    fk_id_modulo 						int(10)not null,
    estado_reporte_aplicativo 			int(1)not null,
    primary key(fk_id_reporte,fk_id_aplicacion,fk_id_modulo),
    key(fk_id_reporte,fk_id_aplicacion,fk_id_modulo)
);
alter table REPORTE_APLICATIVO add constraint fk_reporte_aplicativo_reporte foreign key(fk_id_reporte) references REPORTE(pk_id_reporte);
alter table REPORTE_APLICATIVO add constraint fk_reporte_aplicativo_modulo foreign key(fk_id_modulo) references MODULO(pk_id_modulo);
alter table REPORTE_APLICATIVO add constraint fk_report_aplicativo foreign key(fk_id_aplicacion) references APLICACION(pk_id_aplicacion);
#DATOS DE SEGURIDAD----------------------------------------------------------------------------------------
#DATOS DE SEGURIDAD----------------------------------------------------------------------------------------
INSERT INTO `login` VALUES (1,'sistema','bi0PL96rbxVRPKJQsLJJAg==','Usuario de prueba',1),
(2,'admin','T+4Ai6O3CR0kJYxCgXy2jA==','Administrador',1),(3,'morataya','5g2jpUc7tYd0Q0iop9+lfA==','Julio Morataya',1);

INSERT INTO `perfil` VALUES (1,'Admin','Administracion del programa',1);

INSERT INTO `modulo` VALUES (1,'Seguridad','Aplicaciones de seguridad',1),(2,'Consultas','Consultas Inteligentes',1),
(3,'Reporteador','Aplicaciones de Reporteador',1),(4,'Inventarios','Sistema de Gestion Inventarios',1),
(5,'Compras','Sistema De Gestion Compras',1),(6,'Ventas','Sistema de Gestion Ventas',1),(7,'Cobros','Sistema De Gestion Cobros',1);

INSERT INTO `aplicacion` (`pk_id_aplicacion`, `fk_id_modulo`, `nombre_aplicacion`, `descripcion_aplicacion`, `estado_aplicacion`) 
VALUES (1,1,'Login','Ventana de Ingreso',1),(2,1,'Mantenimiento Usuario','Mantenimientos de usuario',1),
(3,1,'Mantenimiento Aplicacion','ABC de las Aplicaciones',1),(4,1,'Mantenimiento Perfil','ABC de perfiles',1),
(5,1,'Asignacion de Aplicaciones a Perfil','Asignacion Aplicacion y perfil',1),(6,1,'Asignacaion de Aplicaciones','Asignacion especificas a un usuario',1),
(7,1,'Consulta Aplicacion','Mantenimiento de Aplicaciones',1),(8,1,'Agregar Modulo','Mantenimientos de Modulos',1),
(9,1,'Consultar Perfil','Consultas de perfiles disponibles',1),(10,1,'Permisos','Asignar permisos a perfiles y aplicaciones',1),
(11,1,'Cambio de Contraseña','Cambia las contraseñas',1),(12,1,'Reporte De Bitacora','Reporte de bitacora',1),
(301,4,'Mantenimiento Linea','Mantenimiento de Linea',1),(302,4,'Mantenimineto Marca','Mantenimiento Marca',1),
(303,4,'Mantenimiento Producto','Mantenimiento Producto',1),(304,4,'Mantenimiento Bodegas','Mantenimiento Bodegas',1),
(305,4,'Existencias','Verificar las existencias en bodega',1),(306,4,'Verificar Cita','Proceso para la verifiacacion de Citas',1),
(307,4,'Modificar Cita','Proceso para la modificacion de citas',1),(308,4,'Proceso Verificacion de datos','Para nuevos y renovacion de pasaporte',1),
(309,4,'Proceso Primer pasaporte','Proceso para renovar o nuevo pasaporte',1),(310,4,'Impresion de pasaporte','Impresion de pasaporte',1),
(311,4,'Reporte De Citas','Reporte De Citas',1),(312,4,'Reporte De Pasaportes','Reporte De Pasaportes',1);


INSERT INTO `permiso` VALUES (1,1,1,1,1,1),(2,1,1,1,1,1),(3,1,1,1,0,0),(4,1,1,1,1,1),(5,1,1,1,1,1),(6,1,1,1,1,1),(7,1,1,1,1,1),
(8,1,0,1,1,1),(9,1,1,1,1,1),(10,1,1,1,1,1),(11,1,1,1,1,1),(12,1,1,1,1,1),(13,1,1,1,1,1),(14,1,1,1,1,1),(15,1,1,1,1,1),(16,1,1,1,1,1),
(17,1,1,1,1,1),(18,1,1,1,1,1),(19,1,1,1,1,1),(20,1,1,1,1,1),(21,1,1,1,1,1),(22,1,1,1,1,1),(23,1,1,1,1,1),(24,1,1,1,1,1),(25,1,1,1,1,1),
(26,1,1,1,1,1),(27,1,1,1,1,1),(28,1,1,1,1,1),(29,1,1,1,1,1),(30,1,1,1,1,1),(31,1,1,1,1,1),(32,1,1,1,1,1),(33,1,1,1,1,1),(34,1,1,1,1,1),
(35,1,1,1,1,1),(36,1,1,1,1,1);

INSERT INTO `aplicacion_perfil` VALUES (1,1,1,1),(2,2,1,2),(3,3,1,3),(4,4,1,4),(5,5,1,5),(6,6,1,6),
(7,7,1,7),(8,8,1,8),(9,9,1,9),(10,10,1,10),(11,11,1,11),(12,12,1,12);

INSERT INTO `aplicacion_usuario` VALUES (1,1,1,13),(2,1,2,14),(3,1,3,15),(4,1,4,16),(5,1,5,17),(6,1,6,18),(7,1,7,19),(8,1,8,20),
(9,1,9,21),(10,1,10,22),(11,1,11,23),(12,1,12,24),(13,1,301,25),(14,1,302,26),(15,1,303,27),(16,1,304,28),(17,1,305,29),(18,1,306,30),
(19,1,307,31),(20,1,308,32),(21,1,309,33),(22,1,310,34),(23,1,311,35),(24,1,312,36);

INSERT INTO `perfil_usuario` VALUES (1,1,1),(2,2,1),(3,3,1);

#COMPRAS---------------------------------------------------------------------------------------------------
create table if not exists PAIS(
	pkIdPais 					int(10)not null primary key auto_increment,
    nombrePais 					varchar(40)not null,
    capitalPais 				varchar(40)not null,
    estadoPais 					int(1)not null
);
create table if not exists DEPARTAMENTO(
	pkIdDepar					int(10)auto_increment,
    nombreDepar 				varchar(30),
    descripcionDepar 			varchar(45),
    estadoDepar					int(1),
    primary key(pkIdDepar)
);
create table if not exists MUNICIPIO(
	pkIdMuni 					int(10)not null primary key auto_increment,
    fkIdDepar 					int(10)not null,
    nombreMuni 					varchar(30)not null,
    descripcionMuni 			varchar(45)not null,
    estadoMuni 					int(1)not null
);
alter table MUNICIPIO add constraint fk_municipio_departamento foreign key(fkIdDepar) references DEPARTAMENTO(pkIdDepar);

create table if not exists EMPRESA(
	pkIdEmpresa					int(10)auto_increment,
    nombreEmpresa				varchar(100),
    fkIdPais					int(10),
    direccionDeLugar			varchar(50),
    fkIdDepar					int(10),
    fkIdMuni					int(10),
    estadoEmpresa				int(1),
    primary key(pkIdEmpresa)
);
alter table EMPRESA add constraint fk_empresa_pais foreign key(fkIdPais) references PAIS(pkIdPais);
alter table EMPRESA add constraint fk_empresa_departamento foreign key(fkIdDepar) references DEPARTAMENTO(pkIdDepar);
alter table EMPRESA add constraint fk_empresa_municipio foreign key(fkIdMuni) references MUNICIPIO(pkIdMuni);

create table if not exists SUCURSAL(
	pkIdSucursal				int(10)auto_increment,
    fkIdEmpresa					int(10),
    nombreSucursal				varchar(50),
    fkIdPais					int(10),
    direccionDeLugar			varchar(50),
    fkIdDepar					int(10),
    fkIdMuni					int(10),
    estadoSucursal				int(1),
    primary key(pkIdSucursal)
);
alter table SUCURSAL add constraint fk_sucursal_empresa foreign key(fkIdEmpresa) references EMPRESA(pkIdEmpresa);
alter table SUCURSAL add constraint fk_sucursal_pais foreign key(fkIdPais) references PAIS(pkIdPais);
alter table SUCURSAL add constraint fk_sucursal_departamento foreign key(fkIdDepar) references DEPARTAMENTO(pkIdDepar);
alter table SUCURSAL add constraint fk_sucursal_municipio foreign key(fkIdMuni) references MUNICIPIO(pkIdMuni);

create table if not exists BODEGA(
	pkIdBodega 					int(10)auto_increment,
    fkIdEmpresa					int(10),
    fkIdSucursal				int(10),
    fkIdDepar					int(10),
    fkIdMuni 					int(10)not null,
    descripcionBodega 			varchar(250)not null,
    direccionBodega 			varchar(45)not null,
    telefonoBodega 				int(8)not null,
    estadoBodega 				int(1)not null,
    primary key(pkIdBodega)
);
alter table BODEGA add constraint fk_bodega_empresa foreign key(fkIdEmpresa) references EMPRESA(pkIdEmpresa);
alter table BODEGA add constraint fk_bodega_sucursal foreign key(fkIdSucursal) references SUCURSAL(pkIdSucursal);
alter table BODEGA add constraint fk_bodega_departamento foreign key(fkIdDepar) references DEPARTAMENTO(pkIdDepar);
alter table BODEGA add constraint fk_bodega_municipio foreign key(fkIdMuni) references MUNICIPIO(pkIdMuni);
#---------------------------------------------------------------------------------------------------------------------------

create table if not exists LINEAPRODUCTO(
	pkIdLineaPro 				int(10)auto_increment,
    fkIdEmpresa					int(10),
    nombreLineaPro 				varchar(25)not null,
    descripcionLineaPro 		varchar(50) not null,
    estadoLineaPro 				int(1) not null,
    primary key(pkIdLineaPro)
);
alter table LINEAPRODUCTO add constraint fk_linea_empresa foreign key(fkIdEmpresa) references EMPRESA(pkIdEmpresa);

create table if not exists MARCAPRODUCTO(
	pkIdMarcaPro 				int(10)auto_increment,
    fkIdEmpresa					int(10),
    nombreMarcaPro 				varchar(35)not null,
    descripcionMarcaPro 		varchar(60)not null,
    estadoMarcaPro 				int(1)not null,
    primary key(pkIdMarcaPro)
);
alter table MARCAPRODUCTO add constraint fk_marca_empresa foreign key(fkIdEmpresa) references EMPRESA(pkIdEmpresa);

create table if not exists PROVEEDOR(
	pkIdProv 					int(10)auto_increment,
    fkIdPais 					int(10)not null,
    direccionProv				varchar(50)not null,
    nitProv 					varchar(20)not null,
    telProv						int(8)not null,
    correoProv					varchar(30)not null,
    estadoProv 					int(1)not null,
    primary key(pkIdProv)
);
alter table PROVEEDOR add constraint fk_proveedor_pais foreign key(fkIdPais) references PAIS(pkIdPais);

create table if not exists PRODUCTO(
	pkIdProducto				int(10)auto_increment,
    fkProv                      int(10)not null,
    fkIdEmpresa					int(10),
    fkIdLineaPro 				int(10)not null,
    fkIdMarcaPro 				int(10)not null,
    nombrePro 					varchar(50)not null,
    precioPro 					double(12,2)not null,
    descripcionPro 				varchar(45)not null,
    estadoPro 					int(1)not null,
    primary key(pkIdProducto)
);
alter table PRODUCTO add constraint fk_producto_empresa foreign key(fkIdEmpresa) references EMPRESA(pkIdEmpresa);
alter table PRODUCTO add constraint fk_producto_proveedor foreign key(fkProv) references PROVEEDOR(pkIdProv);
alter table PRODUCTO add constraint fk_producto_lineaProducto foreign key(fkIdLineaPro) references LINEAPRODUCTO(pkIdLineaPro);
alter table PRODUCTO add constraint fk_producto_categoriaProducto foreign key(fkIdMarcaPro) references MARCAPRODUCTO(pkIdMarcaPro);


create table if not exists EXISTENCIA(
    pkIdExis 					int(10) auto_increment,
    fkIdEmpresa					int(10),
    fkIdSucursal				int(10),
    fkIdBodega 					int(10)not null,
    fkIdPro 					int(10)not null,
    cantidad_existencia 		int(10)not null,
    existencia_minima	 		int(10)not null,
    existencia_maxima	 		int(10)not null,
    estado_existencia 			int(1)not null,
    primary key(pkIdExis,fkIdEmpresa,fkIdBodega,fkIdPro)
);
alter table EXISTENCIA add constraint fk_existencia_empresa foreign key(fkIdEmpresa) references EMPRESA(pkIdEmpresa);
alter table EXISTENCIA add constraint fk_existencia_sucursal foreign key(fkIdSucursal) references SUCURSAL(pkIdSucursal);
alter table EXISTENCIA add constraint fk_existencia_producto foreign key(fkIdPro) references PRODUCTO(pkIdProducto);
alter table EXISTENCIA add constraint fk_existencia_bodega foreign key(fkIdBodega) references BODEGA(pkIdBodega);
#------------------------------------------------------------------------------------------------------------------------------------
#Puestos de bodegas
create table if not exists PUESTO(
	pkIdPuesto					int(10)auto_increment,
    nombrePuesto				varchar(50) not null,
    descripcionPuesto			varchar(250) not null,
    estadoPuesto				int(1) not null,
    primary key(pkIdPuesto)
);
#Tabla de empleados temporal.
create table if not exists EMPLEADO(
	pkIdEmpleado 				int(10)auto_increment,
    idManager                   int(10),
    fkIdEmpresa					int(10),
    fkIdSucursal				int(10),
    fkIdPuesto					int(10),
    nombreEmpleado				varchar(30),
    apellidoEmpleado			varchar(30),
    cuiEmpleado					varchar(15),
    telefonoEmpleado			varchar(15),
    emailEmpleado				varchar(30),
    estadoEmpleado				int(1),
    primary key(pkIdEmpleado),
    FOREIGN KEY(idManager) REFERENCES EMPLEADO(pkIdEmpleado) ON DELETE NO ACTION ON UPDATE NO ACTION
);
alter table EMPLEADO add constraint fk_empleado_empresa foreign key(fkIdEmpresa) references EMPRESA(pkIdEmpresa);
alter table EMPLEADO add constraint fk_empleado_sucursal foreign key (fkIdSucursal) references SUCURSAL(pkIdSucursal);
alter table EMPLEADO add constraint fk_empleado_puesto foreign key(fkIdPuesto) references PUESTO(pkIdPuesto);

create table if not exists PERSONALBODEGA(
	pkIdpersonal				int(10)auto_increment,
    fkIdEmpresa					int(10),
    fkIdSucursal				int(10),
    fkIdEmpleado				int(10) not null,
    fkIdBodega					int(10) not null,
    fkIdCargo					int(10) not null,
    estadoPerBodega				int(1),
    primary key(pkIdPersonal)
); 
alter table PERSONALBODEGA add constraint fk_personal_empleado foreign key(fkIdEmpleado) references EMPLEADO(pkIdEmpleado);
alter table PERSONALBODEGA add constraint fk_personal_empresa foreign key(fkIdEmpresa) references EMPRESA(pkIdEmpresa);
alter table PERSONALBODEGA add constraint fk_personal_sucursal foreign key(fkIdSucursal) references SUCURSAL(pkIdSucursal);
alter table PERSONALBODEGA add constraint fk_personal_bodega foreign key(fkIdBodega) references BODEGA(pkIdBodega);
alter table PERSONALBODEGA add constraint fk_personal_cargo foreign key(fkIdCargo) references PUESTO(pkIdPuesto);

#--------------------------------------------------------------------------------------------------------------------------
 create table if not exists TIPOCOMPRA(
 pktipocompra int(10) not null auto_increment,
 nombretipocompra varchar(50),
 descripciontipocompra varchar(75),
 estado int(1),
 primary key (pktipocompra)
 );
 
create table if not exists METODOPAGO(
	pkIdMetodoPago				int(10)not null auto_increment,
    descripcionMetodo			varchar(150)not null,
    estadoMetodo				int(1),
    primary key(pkIdMetodoPago)
);

create table if not exists COMPRAENCABEZADO(
	pkNoDocumentoEnca 			int(10)not null auto_increment,
    fkIdProv 					int(10)not null,
    fkIdEmpleado				int(10)not null,
    fkIdEmpresa					int(10)not null,
    fkIdSucursal				int(10)not null,
	fkIdBodegadestino 			int(10)not null,
    fechaCompra 				varchar(15),
    totalCompra 				double(12,2) not null,
    fktipocompra                int(10) not null,
    fkmetodoPago                int(10),
    estadoCompra 				int(1)not null,
    primary key(pkNoDocumentoEnca)
);
alter table COMPRAENCABEZADO add constraint fk_compra_empresa foreign key(fkIdEmpresa) references EMPRESA(pkIdEmpresa);
alter table COMPRAENCABEZADO add constraint fk_compra_sucursal foreign key(fkIdSucursal) references SUCURSAL(pkIdSucursal);
alter table COMPRAENCABEZADO add constraint fk_compra_empleado foreign key(fkIdEmpleado) references EMPLEADO(pkIdEmpleado);
alter table COMPRAENCABEZADO add constraint fk_compra_proveedor foreign key(fkIdProv) references PROVEEDOR(pkIdProv);
alter table COMPRAENCABEZADO add constraint fk_compra_tipocompra foreign key(fktipocompra) references TIPOCOMPRA(pktipocompra);
alter table COMPRAENCABEZADO add constraint fk_compra_metodopago foreign key(fkmetodopago) references METODOPAGO(pkIdMetodoPago);
alter table COMPRAENCABEZADO add constraint fk_compra_bodega foreign key(fkIdBodegadestino) references BODEGA(pkIdBodega);


create table COMPRADETALLE(
	fkNoDocumentoEnca 			int(10)not null,
	fkIdPro 					int(10)not null,
    cantidadCompraDe 			int(10)not null,
    costoCompraDe 				double(8,2)not null,
    estado                      int(1),
    primary key(fkNoDocumentoEnca,fkIdPro)
);
alter table COMPRADETALLE add constraint fk_compra_detalle_encabezado foreign key(fkNoDocumentoEnca) references COMPRAENCABEZADO(pkNoDocumentoEnca);
alter table COMPRADETALLE add constraint fk_compra_producto foreign key(fkIdPro) references PRODUCTO(pkIdProducto);

create table if not exists SALDOSCOMRPA(
pksaldocompra     			int(10) not null auto_increment,
fkNoDocumentoEnca    		int(10)not null,
saldo       	    		double(10,2),
primary key (pksaldocompra)
);
create table if not exists SALDOHISTORICOCOMPRA(
pksaldohistoricocompra      int(10) not null auto_increment,
fechamovimientocompra       varchar(15) not null,
fkNoDocumentoEnca            int(10)not null,
fkmetodopago				int(10),
saldoanterior                double(10,2),
abono                        double(10,2),
primary key (pksaldohistoricocompra)
);
alter table SALDOHISTORICOCOMPRA add constraint fk_DocumentoEnca  foreign key(fkNoDocumentoEnca) references COMPRAENCABEZADO(pkNoDocumentoEnca);
alter table SALDOHISTORICOCOMPRA add constraint fk_metodopago  foreign key(fkmetodopago) references METODOPAGO(pkIdMetodoPago);
#VENTAS---------------------------------------------------------------------------------------------------------------------------
create table if not exists CLIENTE(
	pkIdCliente 				int(5)not null auto_increment,
    nombreCliente 				varchar(30),
    apellidoCliente				varchar(30),
    direccionCliente 			varchar(60),
    fkIdDepar					int(10),
    fkIdMuni					int(10),
    codigoPostal				varchar(5),
    nitCliente 					varchar(20),
    telCliente 					varchar(50),
    estadoCliente 				int(1),
    primary key(pkIdCliente)
);
create table if not exists VENTAENCABEZADO(
	pkDocumentoVentaEnca 		int(10)not null auto_increment,
    fkIdCliente 				int(10)not null,
    fkIdEmpresa					int(10)not null,
    fkIdSucursal				int(10)not null,
	fkIdEmpleado				int(10)not null,
    fechaRequerida				varchar(15)not null,
    fechaEnvio					varchar(15)not null,
    totalVenta 					float(10,2)not null,
    estadoVentaEnca 			int(1),
    primary key(pkDocumentoVentaEnca)
);
alter table VENTAENCABEZADO add constraint fk_venta_empresa foreign key(fkIdEmpresa) references EMPRESA(pkIdEmpresa);
alter table VENTAENCABEZADO add constraint fk_venta_sucursal foreign key(fkIdSucursal) references SUCURSAL(pkIdSucursal);
alter table VENTAENCABEZADO add constraint fk_venta_cliente foreign key(fkIdCliente) references CLIENTE(pkIdCliente);
alter table VENTAENCABEZADO add constraint fk_venta_empleado foreign key(fkIdEmpleado) references EMPLEADO(pkIdEmpleado);

create table if not exists VENTADETALLE(
	pkIdVentaDetalle 			int(10)not null,
    fkDocumentoVentaEnca		int(10),
	fkIdPro						int(10),
    cantidadVenta 				int(10),
    costoVenta 					float(10,2),
    precioVenta 				float(10,2),
    fkIdBodega 					int(10),
    primary key(pkIdVentaDetalle,fkDocumentoVentaEnca,fkIdPro)
);
alter table VENTADETALLE add constraint fk_venta_encabezado foreign key(fkDocumentoVentaEnca) references VENTAENCABEZADO(pkDocumentoVentaEnca);
alter table VENTADETALLE add constraint fk_venta_producto foreign key(fkIdPro) references PRODUCTO(pkIdProducto);
alter table VENTADETALLE add constraint fk_venta_bodega foreign key(fkIdBodega) references BODEGA(pkIdBodega);

create table if not exists COTIZAENCABEZADO(
	pkDocumentoCotizaEnca 		int(10)not null auto_increment,
    fkIdCliente 				int(10)not null,
    fkIdEmpresa					int(10)not null,
    fkIdSucursal				int(10)not null,
	fkIdEmpleado				int(10)not null,
    fechaRequerida				varchar(15)not null,
    fechaEnvio					varchar(15)not null,
    vigenciaCotizacion			varchar(15)not null,
    totalCotizacion				float(10,2)not null,
    estadoCotizacion 			int(1),
    primary key(pkDocumentoCotizaEnca)
);
alter table COTIZAENCABEZADO add constraint fk_cotiza_empresa foreign key(fkIdEmpresa) references EMPRESA(pkIdEmpresa);
alter table COTIZAENCABEZADO add constraint fk_cotiza_sucursal foreign key(fkIdSucursal) references SUCURSAL(pkIdSucursal);
alter table COTIZAENCABEZADO add constraint fk_cotiza_empleado foreign key(fkIdEmpleado) references EMPLEADO(pkIdEmpleado);
alter table COTIZAENCABEZADO add constraint fk_cotiza_cliente foreign key(fkIdCliente) references CLIENTE(pkIdCliente);

create table if not exists COTIZADETALLE(
	pkIdCotizaDetalle 			int(10)not null auto_increment,
    fkDocumentoCotizaEnca		int(10),
	fkIdPro						int(10),
    cantidadCotizar				int(10),
    precioCotiza 				float(10,2),
    primary key(pkIdCotizaDetalle)
);
alter table COTIZADETALLE add constraint fk_cotiza_encabezado foreign key(fkDocumentoCotizaEnca) references COTIZAENCABEZADO(pkDocumentoCotizaEnca);
alter table COTIZADETALLE add constraint fk_cotiza_producto foreign key(fkIdPro) references PRODUCTO(pkIdProducto);

create table if not exists APARTADO(
	pkIdApartado				int(10)not null auto_increment,
    fkIdEmpresa					int(10)not null,
    fkIdSucursal				int(10)not null,
    fkIdCliente					int(10)not null,
    fechaApartado				varchar(15)not null,
    totalApartado				float(10,2)not null,
    estadoApartado				int(1),
    primary key(pkIdApartado)
);
alter table APARTADO add constraint fk_apartado_empresa foreign key(fkIdEmpresa) references EMPRESA(pkIdEmpresa);
alter table APARTADO add constraint fk_apartado_sucursal foreign key(fkIdSucursal) references SUCURSAL(pkIdSucursal);
alter table APARTADO add constraint fk_apartado_cliente foreign key(fkIdCliente) references CLIENTE(pkIdCliente);

create table if not exists APARTADODETALLE(
	pkApartadoDetalle			int(10)not null auto_increment,
    fkIdApartado				int(10)not null,
    fkIdProducto				int(10)not null,
    cantidadApartada			int(10)not null,
    costoApartado				float(10,2)not null,
    precioApartado				float(10,2)not null,
    fkIdBodega					int(10),
    primary key(pkApartadoDetalle)
);
alter table APARTADODETALLE add constraint fk_adetalle_apartado foreign key(fkIdApartado) references APARTADO(pkIdApartado);
alter table APARTADODETALLE add constraint fk_adetalle_producto foreign key(fkIdProducto) references PRODUCTO(pkIdProducto);
alter table APARTADODETALLE add constraint fk_adetalle_bodega foreign key(fkIdBodega) references BODEGA(pkIdBodega);

create table if not exists PEDIDO(
	pkIdPedido					int(10)not null auto_increment,
    fkIdEmpresa					int(10)not null,
    fkIdSucursal				int(10)not null,
    fkIdCliente					int(10)not null,
    fechaRequerida				varchar(15)not null,
    fechaEnvio					varchar(15)not null,
    totalPedido					float(10,2)not null,
    estadoPedido				int(1),
    primary key(pkIdPedido)
);
alter table PEDIDO add constraint fk_pedido_empresa foreign key(fkIdEmpresa) references EMPRESA(pkIdEmpresa);
alter table PEDIDO add constraint fk_pedido_sucursal foreign key(fkIdSucursal) references SUCURSAL(pkIdSucursal);
alter table PEDIDO add constraint fk_pedido_cliente foreign key(fkIdCliente) references CLIENTE(pkIdCliente);

create table if not exists DETALLEPEDIDO(
	pkIdDetallePedido			int(10)not null auto_increment,
    fkIdPedido					int(10)not null,
    fkIdProducto				int(10)not null,
    cantidadDetalle				int(10)not null,
    costoDetalle				float(10,2)not null,
    precioDetalle				float(10,2)not null,
    primary key(pkIdDetallePedido)
);
alter table DETALLEPEDIDO add constraint fk_detalle_pedido foreign key(fkIdPedido) references PEDIDO(pkIdPedido);
alter table DETALLEPEDIDO add constraint fk_detalle_producto foreign key(fkIdProducto) references PRODUCTO(PkIdProducto);

#-----------------------------------------------------------------------------------------------------------
create table if not exists CUENTAS(
	pkIdRegistroCuentas			int(10)not null auto_increment,
    fkIdEmpresa					int(10)not null,
    fkIdSucursal				int(10)not null,
    NoDocumento					int(10)not null,
    tipoCuenta					int(2)not null,
    fkIdEmpleado				int(10)not null,
    fechaRealizada				varchar(15)not null,
    tiempoDeCredito				int(5)not null,
    montoPagado					float(10,2)not null,
    montoPendiente				float(10,2)not null,
    montoTotal					float(10,2)not null,
    primary key(pkIdRegistroCuentas)
);
alter table CUENTAS add constraint fk_cuentas_empresa foreign key(fkIdEmpresa) references EMPRESA(pkIdEmpresa);
alter table CUENTAS add constraint fk_cuentas_sucursal foreign key(fkIdSucursal) references SUCURSAL(pkIdSucursal);
alter table CUENTAS add constraint fk_cuentas_empleado foreign key(fkIdEmpleado) references EMPLEADO(pkIdEmpleado);

create table if not exists COBRO(
	pkNoRegistroCobro			int(10)not null auto_increment,
    fkIdRegistroCuenta			int(10)not null,
    fkIdEmpleado				int(10)not null,
    descripcionCobro			int(10)not null,
    fechaPago					varchar(15)not null,
    fkIdMetodoPago				int(10)not null,
    montoAbonado				float(10,2)not null,
    primary key(pkNoRegistroCobro)
);
alter table COBRO add constraint fk_cobro_cuentas foreign key(fkIdRegistroCuenta) references CUENTAS(pkIdRegistroCuentas);
alter table COBRO add constraint fk_cobro_empleado foreign key(fkIdEmpleado) references EMPLEADO(pkIdEmpleado);
alter table COBRO add constraint fk_cobro_metodopago foreign key(fkIdMetodoPago) references METODOPAGO(pkIdMetodoPago);

 create table if not exists RAZONMOVIMIENTO(
 pkrazon int(10) not null auto_increment,
 nombrerazon varchar(50),
 descripcionrazon varchar(75),
 estadorazon int(1),
 primary key (pkrazon)
 );
 
create table if not exists MOVIMIENTOINVENTARIOENCABEZADO(
pkmovimientoe int(10)not null auto_increment,
fkempresa int(10) not null,
fksucursal int(10),
fkbodegaorigen int(10),
fkbodegadestino int(10),
fkrazon int(10) not null,
fkproveedor int(10),
fkcliente int(10),
fkencargado int(10),
fecha varchar(15),
estado int(1) not null,
primary key(pkmovimientoe)
);
alter table MOVIMIENTOINVENTARIOENCABEZADO add constraint fk_bodega_empresaa foreign key(fkempresa) references EMPRESA(pkIdEmpresa);
alter table MOVIMIENTOINVENTARIOENCABEZADO add constraint fk_bodega_razonn foreign key(fkrazon) references razonmovimiento(pkrazon);
alter table MOVIMIENTOINVENTARIOENCABEZADO add constraint fk_bodega_origenn foreign key(fkbodegaorigen) references bodega(pkIdBodega);
alter table MOVIMIENTOINVENTARIOENCABEZADO add constraint fk_bodega_destinoo foreign key(fkbodegadestino) references bodega(pkIdBodega);
alter table MOVIMIENTOINVENTARIOENCABEZADO add constraint fk_bodega_encargadoo foreign key(fkencargado) references login(pk_id_login);
alter table MOVIMIENTOINVENTARIOENCABEZADO add constraint fk_bodega_sucursall foreign key(fksucursal) references sucursal(pkIdSucursal);


create table if not exists MOVIMIENTOINVENTARIODETALLE(
fkmovimiento int(10)not null,
fkidproducto int(10)not null,
cantidad int(50)not null,
estado int(1) not null,
primary key(fkmovimiento, fkidproducto)
);
alter table MOVIMIENTOINVENTARIODETALLE add constraint fk_detalleproductoo foreign key(fkidproducto) references PRODUCTO(pkIdProducto);
alter table MOVIMIENTOINVENTARIODETALLE add constraint fk_detallemovimiento foreign key(fkmovimiento) references MOVIMIENTOINVENTARIOENCABEZADO(pkmovimientoe);



#PROCEDIMIENTO ALMACENADO LOGIN --------------------------------------------------------------------------------------------------------------------------
DROP procedure IF EXISTS sp_Login;
DELIMITER $$
USE dbcvierp2$$
CREATE PROCEDURE sp_Login(
	in UserLogin varchar(45),
	in PassLogin varchar(45)
)
BEGIN
select usuario_login, contraseña_login from login where usuario_login=UserLogin and contraseña_login=PassLogin and  estado_login = 1;
END$$
DELIMITER ;

#Cambio en la tabla de aplicacion
#alter table APLICACION add archivoCHM varchar(100) after descripcion_aplicacion;
#alter table APLICACION add archivoHTML varchar(100) after archivoCHM;



-- Procedimiento para Mover Inventarios
DELIMITER $$
CREATE PROCEDURE sp_MovimientoInventario(
	in idMovmiento int,
    in idEmpresaOrigen int,
    in idSucursalOrigen int,
    in idBodegaOrigen int,
    
    in idEmpresaDestino int,
    in idSucursalDestino int,
    in idBodegaDestino int,
    
    in idProducto int,
    in CantidadMover int,
    in Razon varchar(100),
    in idUsuario int,
    in Accion int#1agregar, 2Eliminar Movimiento
)
BEGIN
if (select cantidad_existencia from existencia where fkIdEmpresa=idEmpresaOrigen and fkIdSucursal=idSucursalOrigen and fkIdBodega=idBodegaOrigen and fkIdPro=idProducto) > CantidadMover and Accion = 1 then
	update existencia set cantidad_existencia = cantidad_existencia - CantidadMover where fkIdEmpresa=idEmpresaOrigen and fkIdSucursal=idSucursalOrigen and fkIdBodega=idBodegaOrigen and fkIdPro=idProducto;
    update existencia set cantidad_existencia = cantidad_existencia + CantidadMover where fkIdEmpresa=idEmpresaDestino and fkIdSucursal=idSucursalDestino and fkIdBodega=idBodegaDestino and fkIdPro=idProducto;
    INSERT INTO `dbcvierp2`.`movimientoinventario` (`fkidproducto`, `fkbodegaorigen`, `fkbodegadestino`, `cantidad`, `razon`, `fkencargado`) VALUES (idProducto, idBodegaOrigen, idBodegaDestino, CantidadMover, Razon, idUsuario);

else
	update existencia set cantidad_existencia = cantidad_existencia + CantidadMover where fkIdEmpresa=idEmpresaOrigen and fkIdSucursal=idSucursalOrigen and fkIdBodega=idBodegaOrigen and fkIdPro=idProducto;
    update existencia set cantidad_existencia = cantidad_existencia - CantidadMover where fkIdEmpresa=idEmpresaDestino and fkIdSucursal=idSucursalDestino and fkIdBodega=idBodegaDestino and fkIdPro=idProducto;
    DELETE FROM `movimientoinventario` WHERE (`pkmovimiento` = idMovmiento);
end if;
END$$
DELIMITER ;
-- Procedimiento Para Verificar Existencia
DELIMITER $$
CREATE PROCEDURE sp_ExistenciaProducto (
	in IdEmpresa int,
    in IdSucursal int,
    in IdBodega int,
    in Producto int
)
BEGIN
	select cantidad_existencia from existencia where fkIdEmpresa=IdEmpresa and fkIdSucursal=IdSucursal and fkIdBodega=IdBodega and fkIdPro=Producto;
END$$
DELIMITER ;

ALTER TABLE `dbcvierp2`.`saldohistoricocompra` 
ADD COLUMN `notas` VARCHAR(45) NULL AFTER `abono`;

-- #### VALORES
INSERT INTO `PAIS` VALUES ('1', 'GUATEMALA', 'GUATEMALA', '1'),('2', 'MEXICO ', 'DF', '1'),('3', 'SALVADOR', 'SAN SALVADOR', '1');
INSERT INTO `DEPARTAMENTO` VALUES (1,'DEPARTA1','DESCRIPCION1',1),(2,'DEPART2','DESCRIP2',1);
INSERT INTO `MUNICIPIO` VALUES (1,1,'MUNICIPIO1','DESCRI1',1),(2,1,'MUNICIPIO2','DESCRI2',1);
INSERT INTO `EMPRESA` VALUES (1,'EMPRESA1',1,'DIRECCION1',1,1,1),(2,'EMPRESA2',1,'DIRECCION2',1,1,1);
INSERT INTO `SUCURSAL` VALUES (1,1,'SUCURSAL1',1,'DIRECCION2',1,1,1),(2,1,'SUCURSAL2',1,'DIRECCION2',1,1,1);
INSERT INTO `BODEGA` VALUES (1,1,1,1,1,'DESCRIPCION1','DIRECCION1',12345678,1),(2,2,1,1,1,'DESCRIPCION2','DIRECCION2',12345678,1);
INSERT INTO `LINEAPRODUCTO` VALUES (1,1,'LINEA1','DESCRIPCION1',1),(2,2,'LINEA2','DESCRIPCION2',1);
INSERT INTO `MARCAPRODUCTO` VALUES (1,1,'NOMBRE1','DESCRIPCION1',1),(2,2,'NOMBRE2','DESCRIPCION2',1);
INSERT INTO `PROVEEDOR` VALUES ('1', '1', 'JULIO', '6516513', '84621', 'hola@gmail.com', '1'),('2', '2', 'BRIAN', '7465', '3216544', 'hola2@gamil.com', '1');
INSERT INTO `PRODUCTO`  VALUES ('1', '1', '1', '1', '1', 'JAMON', '85.00', 'RICO', '1'),('2', '1', '1', '1', '1', 'QUESO', '50.00', 'RICO', '1'),('3', '1', '1', '1', '1', 'PAN', '2.00', 'RICO ', '1'),('4', '1', '1', '1', '1', 'AGUA', '10.00', 'RICO', '1'),('5', '1', '1', '1', '1', 'TORTILLA', '5.00', 'RICO', '1');
INSERT INTO `EXISTENCIA` VALUES ('1', '1', '1', '1', '1', '100', '50', '200', '1');
INSERT INTO `METODOPAGO`  VALUES ('1', 'EFECTIVO', '1'),('2', 'CHEQUE', '1'),('3', 'TARJETA', '1'),('4', 'CREDITO', '1');
INSERT INTO `PUESTO` VALUES ('1', 'GERENTE', 'BUENO', '1');
INSERT INTO `EMPLEADO`  VALUES ('1', '1', '1', '1', '1', 'Julio', 'Morataya', '1010', '898491', 'hola@gmail.com', '1');
INSERT INTO `TIPOCOMPRA` VALUES ('1', 'SOLICITUD', 'NECESITA APROBACION ', '1'),('2',  'ORDEN ', 'SOLICITUD APROBADA', '1'),('3', 'PROCESO', 'ENVIADA A PROVEEDOR', '1'),('4', 'EN CURSO', 'DESPACHADA POR PROVEEDOR', '1'),('5', 'RECIBIDA', 'ORDEN INGRESADA', '1'),('6', 'SOLICITUD RECHAZADA', 'NO ACEPTADA', '1'),('7', 'ORDEN RECHAZADA', 'RECHAZADA POR INCONFORMIDAD', '1'),('8', 'DEVOLUCION', 'REGRESO DE ORDEN A PROVEEDOR', '1'),('9', 'ALMACENADA', 'ORDEN ALMACENADA EN BODEGA', '1');
INSERT INTO `COMPRAENCABEZADO` VALUES ('1', '1', '1', '1', '1', '1', '04052021', '10', '1', '1', '1');
INSERT INTO razonmovimiento VALUES ('1','Compras','Compra A Proveedores','1'),('2','Ventas','Venta a Clientes','1'),('3','Devolucion Sobre Compras','Devolucion Sobre Compras','1'),('4','Devolucion sobre Ventas','Devolucion sobre Ventas','1'),('5','Movimiento De Inventarios','Movimiento De Bodega a Bodega','1');
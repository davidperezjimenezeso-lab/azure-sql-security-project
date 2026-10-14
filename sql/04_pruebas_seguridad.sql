
-- PROYECTO: Azure SQL Database Security
--  Pruebas de seguridad y autorizacion
-- Base de datos: sqldb-security-dev

-- Requisitos:
-- Haber ejecutado los scripts 01, 02 y 03.
--
-- Estas pruebas utilizan EXECUTE AS USER para simular usuarios con diferentes permisos.
-- No son inicios de sesion reales con Microsoft Entra.



-- PRUEBA 1: LECTOR - ACCESO AUTORIZADO
-- El lector puede consultar empleados sin salarios.

EXECUTE AS USER = 'usuario_lector';

SELECT
    USER_NAME() AS UsuarioActual,
    EmpleadoID,
    Nombre,
    Email,
    DepartamentoID
FROM dbo.vw_EmpleadosPublicos;

REVERT;


-- PRUEBA 2: LECTOR - ACCESO DENEGADO
-- No debe poder consultar la tabla original.

EXECUTE AS USER = 'usuario_lector';

SELECT
    Nombre,
    Salario
FROM dbo.Empleados;

REVERT;

-- Resultado esperado:
-- The SELECT permission was denied on
-- the object 'Empleados'.


-- PRUEBA 3: AUDITOR - ACCESO AUTORIZADO
-- Puede consultar los registros de acceso.

EXECUTE AS USER = 'usuario_auditor';

SELECT
    USER_NAME() AS UsuarioActual,
    AccesoID,
    EmpleadoID,
    Fecha,
    Accion
FROM dbo.RegistroAccesos;

REVERT;


-- PRUEBA 4: AUDITOR - ACCESO DENEGADO
-- No debe poder consultar salarios.

EXECUTE AS USER = 'usuario_auditor';

SELECT
    Nombre,
    Salario
FROM dbo.Empleados;

REVERT;

-- Resultado esperado:
-- The SELECT permission was denied.


-- PRUEBA 5: RECURSOS HUMANOS
-- Puede consultar empleados y salarios.

EXECUTE AS USER = 'usuario_rrhh';

SELECT
    USER_NAME() AS UsuarioActual,
    Nombre,
    Email,
    Salario
FROM dbo.Empleados;

REVERT;


-- PRUEBA 6: PERMISOS DEL LECTOR
-- Comprobar permisos efectivos sin modificar datos.

EXECUTE AS USER = 'usuario_lector';

SELECT
    USER_NAME() AS Usuario,
    HAS_PERMS_BY_NAME(
        'dbo.Empleados', 'OBJECT', 'SELECT'
    ) AS PermisoSELECT,
    HAS_PERMS_BY_NAME(
        'dbo.Empleados', 'OBJECT', 'UPDATE'
    ) AS PermisoUPDATE,
    HAS_PERMS_BY_NAME(
        'dbo.Empleados', 'OBJECT', 'DELETE'
    ) AS PermisoDELETE;

REVERT;

-- Resultado esperado:
-- SELECT = 0
-- UPDATE = 0
-- DELETE = 0


-- PRUEBA 7: CIFRADO TDE
-- Verificar que la base de datos esta cifrada.

SELECT
    DB_NAME(database_id) AS BaseDeDatos,
    encryption_state AS EstadoCifrado
FROM sys.dm_database_encryption_keys
WHERE database_id = DB_ID();

-- Resultado esperado:
-- EstadoCifrado = 3 (Cifrada)

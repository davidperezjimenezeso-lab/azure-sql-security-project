


-- 1. CREACION DE ROLES
-- Cada rol representa una funcion de la empresa.

CREATE ROLE rol_recursos_humanos;
CREATE ROLE rol_auditor;
CREATE ROLE rol_lector;


-- 2. VISTA DE EMPLEADOS SIN SALARIOS
-- Permite consultar datos basicos sin exponer informacion salarial.

CREATE VIEW dbo.vw_EmpleadosPublicos AS
SELECT
    EmpleadoID,
    Nombre,
    Email,
    DepartamentoID
FROM dbo.Empleados;


-- 3. ASIGNACION DE PERMISOS
-- Aplicacion del principio de minimo privilegio.

-- Recursos Humanos: lectura de empleados y salarios
GRANT SELECT ON OBJECT::dbo.Empleados
TO rol_recursos_humanos;

-- Auditor: lectura de registros de acceso
GRANT SELECT ON OBJECT::dbo.RegistroAccesos
TO rol_auditor;

-- Lector: lectura exclusiva de la vista publica
GRANT SELECT ON OBJECT::dbo.vw_EmpleadosPublicos
TO rol_lector;


-- 4. CREACION DE USUARIOS DE PRUEBA
-- Usuarios sin login para simular identidades.

CREATE USER usuario_rrhh WITHOUT LOGIN;
CREATE USER usuario_auditor WITHOUT LOGIN;
CREATE USER usuario_lector WITHOUT LOGIN;


-- 5. ASIGNACION DE ROLES A USUARIOS

ALTER ROLE rol_recursos_humanos
ADD MEMBER usuario_rrhh;

ALTER ROLE rol_auditor
ADD MEMBER usuario_auditor;

ALTER ROLE rol_lector
ADD MEMBER usuario_lector;


-- 6. VERIFICACION DE ROLES

SELECT
    name AS NombreRol,
    type_desc AS Tipo
FROM sys.database_principals
WHERE name IN (
    'rol_recursos_humanos',
    'rol_auditor',
    'rol_lector'
);


-- 7. VERIFICACION DE PERMISOS

SELECT
    USER_NAME(grantee_principal_id) AS Rol,
    OBJECT_NAME(major_id) AS Objeto,
    permission_name AS Permiso,
    state_desc AS Estado
FROM sys.database_permissions
WHERE grantee_principal_id IN (
    DATABASE_PRINCIPAL_ID('rol_recursos_humanos'),
    DATABASE_PRINCIPAL_ID('rol_auditor'),
    DATABASE_PRINCIPAL_ID('rol_lector')
);

# Azure SQL Database — Seguridad y Control de Accesos

## 1. Descripción del proyecto

Este proyecto consiste en el despliegue y la securización de una base de datos empresarial ficticia en Microsoft Azure, utilizando Azure SQL Database y diferentes mecanismos de protección de datos.

El objetivo principal es aplicar conocimientos prácticos de seguridad en la nube, administración de bases de datos, gestión de identidades y control de accesos, utilizando servicios gratuitos de Azure.

Durante el proyecto se han implementado controles de autenticación mediante Microsoft Entra ID, restricciones de red mediante firewall, permisos basados en roles, cifrado de datos y monitorización.

## 2. Objetivos

- Desplegar y administrar una base de datos en Microsoft Azure.
- Configurar autenticación mediante Microsoft Entra ID.
- Restringir conexiones utilizando reglas de firewall.
- Aplicar el principio de mínimo privilegio mediante roles SQL.
- Proteger información confidencial utilizando vistas y permisos.
- Verificar el cifrado TDE y la configuración de TLS.
- Supervisar el rendimiento mediante Azure Monitor.
- Mantener el proyecto dentro de la oferta gratuita de Azure.


## 3. Arquitectura de Azure

La infraestructura se ha desplegado en Microsoft Azure,
utilizando Azure SQL Database en modalidad Serverless.

La solución incorpora autenticación mediante Microsoft
Entra ID, restricciones de acceso mediante firewall,
control de permisos SQL y mecanismos de cifrado.

El siguiente diagrama representa los componentes
principales y los controles de seguridad implementados.


![Arquitectura Azure SQL](architecture/Arquitectura%20segura%20de%20Azure%20SQL.png)


### Recursos principales

- **Grupo de recursos:** rg-secure-sql-project
- **Servidor SQL:** sqlsrv-securesql-2026
- **Base de datos:** sqldb-security-dev
- **Región de Azure SQL:** Australia East
- **Modalidad:** Azure SQL Database Free

[Consultar documentación de arquitectura](Docs/01_arquitectura.md)


## 4. Tecnologías utilizadas

Durante el desarrollo del proyecto se han utilizado las siguientes tecnologías y servicios:

- **Microsoft Azure:** plataforma cloud donde se ha desplegado la infraestructura.
- **Azure SQL Database:** servicio PaaS de bases de datos relacionales, configurado en modalidad Serverless.
- **Microsoft Entra ID:** autenticación centralizada para acceder y administrar Azure SQL.
- **Azure SQL Firewall:** control de conexiones mediante reglas de direcciones IP autorizadas.
- **Transact-SQL (T-SQL):** creación de tablas, relaciones, vistas, usuarios, roles y permisos.
- **Azure RBAC:** revisión de los permisos administrativos asignados sobre los recursos de Azure.
- **Transparent Data Encryption (TDE):** cifrado de los datos almacenados.
- **TLS 1.2:** versión mínima configurada para proteger las comunicaciones.
- **Azure Monitor:** consulta de métricas de rendimiento y utilización de recursos.
- **GitHub:** control de versiones y documentación técnica del proyecto.


## 5. Controles de seguridad implementados

### 5.1. Identidad y autenticación

Se ha configurado Microsoft Entra ID como sistema de autenticación para la administración de Azure SQL Database.

Este mecanismo permite centralizar la gestión de identidades y evita depender de cuentas SQL tradicionales para la administración del entorno.

### 5.2. Seguridad de red

Se ha configurado el firewall del servidor Azure SQL para restringir las conexiones mediante una regla que permite únicamente una dirección IP pública autorizada.

También se ha deshabilitado la opción que permite conexiones generales desde servicios y recursos de Azure.

Esta configuración reduce la exposición de la base de datos a conexiones no autorizadas.

### 5.3. Control de acceso y mínimo privilegio

Se han creado tres roles personalizados dentro de Azure SQL Database:

- **rol_recursos_humanos:** permite consultar información de empleados, incluidos sus salarios.
- **rol_auditor:** permite consultar registros ficticios de acceso.
- **rol_lector:** permite consultar información de empleados sin acceder a sus salarios.

Para separar la información sensible se ha creado la vista `vw_EmpleadosPublicos`, que excluye la columna `Salario`.

Los permisos se han configurado mediante instrucciones `GRANT`, concediendo únicamente los accesos necesarios para cada función.

### 5.4. Protección de datos

Se han verificado dos mecanismos complementarios de cifrado:

**Cifrado en reposo (TDE)**

Se ha comprobado el estado de Transparent Data Encryption mediante una consulta SQL.

El resultado `encryption_state = 3` confirma que la base de datos está cifrada.

**Cifrado en tránsito (TLS)**

Se ha verificado que el servidor Azure SQL tiene configurada TLS 1.2 como versión mínima aceptada para las conexiones.

### 5.5. Monitorización

Se ha utilizado Azure Monitor para consultar métricas de rendimiento de la base de datos, incluyendo la utilización de CPU.

También se ha revisado la configuración de auditoría de Azure SQL.

La auditoría nativa no se ha habilitado debido a los posibles costes de almacenamiento y procesamiento de registros.


## 6. Pruebas y resultados de seguridad

Para verificar los controles implementados se han utilizado usuarios de prueba sin inicio de sesión y la instrucción `EXECUTE AS USER`.

Esto permite simular diferentes contextos de autorización dentro de SQL Database sin crear cuentas adicionales de Microsoft Entra.

### 6.1. Accesos autorizados

Se ha comprobado que:

- El usuario lector puede consultar la vista de empleados sin salarios.
- El usuario auditor puede consultar los registros ficticios de acceso.
- El usuario de Recursos Humanos puede consultar los datos de empleados, incluidos sus salarios.

### 6.2. Accesos denegados

Se han realizado consultas no autorizadas para verificar que Azure SQL aplica correctamente los permisos configurados.

Los resultados confirman que:

- El usuario lector no puede consultar directamente la tabla `Empleados`.
- El auditor no puede acceder a la información salarial.
- El usuario lector no dispone de permisos efectivos `SELECT`, `UPDATE` ni `DELETE` sobre la tabla `Empleados`.

Las denegaciones se verificaron mediante mensajes de error SQL y consultas con `HAS_PERMS_BY_NAME()`.

### 6.3. Evidencias

Las capturas de las pruebas realizadas se encuentran en la documentación técnica.

[Ver pruebas y evidencias de seguridad](Docs/02_pruebas_seguridad.md)


## 7. Documentación y scripts

El repositorio contiene los siguientes recursos:

### Documentación técnica

- [Arquitectura de Azure](Docs/01_arquitectura.md)
- [Pruebas de seguridad](Docs/02_pruebas_seguridad.md)

### Scripts SQL

- [01 - Creación de tablas](SQL/01_creacion_tablas.sql)
- [02 - Inserción de datos ficticios](SQL/02_insercion_datos.sql)
- [03 - Roles y permisos](SQL/03_roles_permisos.sql)
- [04 - Pruebas de seguridad](SQL/04_pruebas_seguridad.sql)

### Evidencias y arquitectura

- [Capturas del proyecto](screenshots/)
- [Diagrama de arquitectura](architecture/azure-sql-architecture.png)

Los scripts permiten comprender y reproducir los principales componentes de la base de datos y sus controles de acceso en un entorno de pruebas.


## 8. Costes y limitaciones

El proyecto se ha desarrollado utilizando la oferta gratuita de Azure SQL Database.

La configuración incluye:

- Modalidad General Purpose Serverless.
- Cuota gratuita mensual de computación y almacenamiento.
- Facturación por exceso deshabilitada.
- Pausa de la base de datos al agotar los límites gratuitos.

Durante la revisión de Azure Cost Management no se observaron costes registrados en el grupo de recursos.

Esta comprobación corresponde al momento de la consulta y no garantiza la ausencia de cargos futuros por otros servicios.

### Limitaciones

- No se ha habilitado Microsoft Defender for SQL.
- La auditoría nativa no se ha activado para evitar posibles costes adicionales.
- Se han utilizado datos empresariales ficticios.
- Las pruebas de autorización se han realizado mediante usuarios SQL simulados.
- La infraestructura representa un entorno de desarrollo y aprendizaje, no un sistema de producción.

Estas decisiones permiten desarrollar y verificar controles fundamentales de seguridad en Azure manteniendo el proyecto dentro de las funcionalidades gratuitas utilizadas.

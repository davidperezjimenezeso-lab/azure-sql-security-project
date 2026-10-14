1. Arquitectura de la infraestructura Azure
   1.1. Descripción general
   El proyecto utiliza Microsoft Azure para alojar una base de datos SQL empresarial ficticia,
   con el objetivo de implementar y verificar diferentes mecanismos de seguridad en la nube.
La infraestructura se ha desplegado mediante Azure Portal, utilizando Azure SQL Database en su modalidad gratuita Serverless.

1.2. Recursos desplegados

Para el desarrollo del proyecto se han utilizado los siguientes recursos de Microsoft Azure:

Grupo de recursos (rg-secure-sql-project): permite organizar y administrar de forma centralizada los recursos utilizados en el proyecto.

Servidor lógico SQL (sqlsrv-securesql-2026): se encarga de gestionar la configuración de conectividad, autenticación y seguridad de la base de datos.

Base de datos SQL (sqldb-security-dev): almacena la información empresarial ficticia utilizada para realizar consultas y pruebas de seguridad.

Microsoft Entra ID: proporciona un sistema de autenticación centralizado que permite verificar la identidad del administrador y controlar el acceso a Azure SQL.

Azure Monitor: permite supervisar el rendimiento y el consumo de recursos de la base de datos mediante métricas como el porcentaje de utilización de CPU.

1.4. Arquitectura de seguridad

La infraestructura emplea diferentes mecanismos de protección:

Microsoft Entra ID: autenticación centralizada para la administración de la base de datos.

Firewall de Azure SQL: restricción del acceso público mediante una regla para la IP del administrador.

Roles SQL: separación de permisos entre Recursos Humanos, Auditor y Lector.

Vistas SQL: acceso controlado a información de empleados sin exponer salarios.

Transparent Data Encryption (TDE): cifrado de datos en reposo, verificado mediante SQL.

TLS 1.2: versión mínima configurada para las conexiones cifradas.

Azure Monitor: supervisión de las métricas de rendimiento.

1.5. Consideraciones económicas

La base de datos utiliza la oferta gratuita de Azure SQL, con facturación por exceso deshabilitada y pausa automática al alcanzar los límites gratuitos.

No se habilitaron Microsoft Defender for SQL ni la auditoría nativa con almacenamiento de registros, para evitar servicios que pudieran generar costes.

Durante la revisión de Azure Cost Management no se observaron costes registrados en el grupo de recursos, teniendo en cuenta que los datos de facturación pueden actualizarse con retraso.

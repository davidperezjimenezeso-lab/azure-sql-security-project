


INSERT INTO dbo.Departamentos (DepartamentoID, Nombre)
VALUES
(1, 'Recursos Humanos'),
(2, 'Informática'),
(3, 'Finanzas'),
(4, 'Ciberseguridad');


INSERT INTO dbo.Empleados
(EmpleadoID, Nombre, Email, DepartamentoID, Salario)
VALUES
(1, 'Carlos García', 'carlos@empresa.example', 2, 35000),
(2, 'Laura Martínez', 'laura@empresa.example', 1, 32000),
(3, 'Pablo López', 'pablo@empresa.example', 4, 42000),
(4, 'Ana Fernández', 'ana@empresa.example', 3, 38000),
(5, 'Marta Sánchez', 'marta@empresa.example', 4, 45000);


INSERT INTO dbo.RegistroAccesos
(AccesoID, EmpleadoID, Fecha, Accion)
VALUES
(1, 1, SYSDATETIME(), 'Inicio de sesión'),
(2, 3, SYSDATETIME(), 'Consulta de registros'),
(3, 5, SYSDATETIME(), 'Acceso a sistema'),
(4, 2, SYSDATETIME(), 'Inicio de sesión');

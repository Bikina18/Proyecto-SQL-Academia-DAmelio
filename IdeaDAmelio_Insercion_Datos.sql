USE IdeaDAmelio;
-- Se cargaran información a las tablas, en el mismo orden en el cual fueron creadas, En el siguiente orden: 
-- Tabla 4 Categoria, Tabla 7 Habilidades, tabla 9 Estado_Resultados, Tabla 11 Conceptos_Ingresos, Tabla 13 Conceptos_Egresos

-- Tabla 4 Categorías
INSERT INTO Categoria (Nombre_Categoria) VALUES
('Sub-7'), ('Sub-10'), ('Sub-12'), ('Sub-15'), ('Sub-17'); 

-- Tabla 7 Habilidades
INSERT INTO Habilidades (Nombre_Habilidad) VALUES
('Técnica'), ('Física'), ('Táctica'), ('Psicológica');

-- Tabla 9 Estado de resultados
INSERT INTO Estado_Resultados (Nombre_Estado_Resultados) VALUES
('Ganado'), ('Empatado'), ('Perdido'), ('Suspendido'); 

-- Tabla 11 Conceptos de ingresos
INSERT INTO Conceptos_Ingresos (Nombre_Conceptos_Ingresos) VALUES
('Mensualidad'), ('Inscripción'), ('Donación'), ('Uniforme'); 

-- Tabla 13 Conceptos de egresos
INSERT INTO Conceptos_Egresos (Nombre_Conceptos_Egresos) VALUES
('Pago de entrenador'), ('Pago de administrativo'), ('Compra de materiales'), ('Mantenimiento del campo');

-- Ahora ingresaremos información a las tablas que dependen de las anteriores, en el siguiente orden:
-- Tabla 1 Jugadores, Tabla 2 Padres_Representantes, Tabla 3 Entrenadores, Tabla 5 Entrenamientos, Tabla 6 Evaluacion_Jugadores
-- Tabla 8 Partidos, Tabla 10 Finanzas_Ingresos, Tabla 12 Finanzas_Egresos

-- Tabla 1 Jugadores
INSERT INTO Jugadores (Nombre_jugador, Apellido_jugador, Fecha_Nacimiento, Id_Categoria) VALUES
-- Sub-7
('Lucas', 'Martínez', '2017-05-01', 1),
('Valentina', 'Gómez', '2016-09-14', 1),
('Samuel', 'Pérez', '2017-03-10', 1),
('Isabella', 'Torres', '2016-07-22', 1),
('Diego', 'Ramírez', '2017-01-30', 1),

-- Sub-10
('Mateo', 'Fernández', '2014-04-12', 2),
('Sofía', 'López', '2015-08-09', 2),
('Tomás', 'Herrera', '2014-11-03', 2),
('Martina', 'Cruz', '2015-06-20', 2),
('Emiliano', 'Morales', '2014-02-28', 2),

-- Sub-12
('Juan', 'Castillo', '2012-01-18', 3),
('Camila', 'Ríos', '2013-05-26', 3),
('Nicolás', 'Silva', '2012-10-30', 3),
('Julieta', 'Peña', '2013-03-11', 3),
('Benjamín', 'Mendoza', '2012-07-17', 3),

-- Sub-15
('Thiago', 'Navarro', '2010-09-05', 4),
('Catalina', 'Ibáñez', '2011-12-22', 4),
('Agustín', 'Campos', '2010-06-08', 4),
('Renata', 'Salazar', '2011-03-29', 4),
('Facundo', 'González', '2010-11-16', 4),

-- Sub-17
('Joaquín', 'Paredes', '2008-05-07', 5),
('Emilia', 'Soto', '2009-08-12', 5),
('Luciano', 'Fuentes', '2008-12-01', 5),
('Mía', 'Valenzuela', '2009-09-25', 5),
('Bruno', 'Delgado', '2008-10-19', 5);

-- Tabla 2 Padres o representantes 
INSERT INTO Padres_Representantes (Id_Jugador, Nombre_PR, Apellido_PR, Telefono_PR, Correo_PR) VALUES
(1, 'Carlos', 'Martínez', '600000001', 'cmartinez1@ejemplo.com'),
(2, 'Laura', 'Gómez', '600000002', 'lgomez2@ejemplo.com'),
(3, 'Jorge', 'Pérez', '600000003', 'jperez3@ejemplo.com'),
(4, 'Elena', 'Torres', '600000004', 'etorres4@ejemplo.com'),
(5, 'Antonio', 'Ramírez', '600000005', 'aramirez5@ejemplo.com'),
(6, 'Luisa', 'Fernández', '600000006', 'lfernandez6@ejemplo.com'),
(7, 'Andrés', 'López', '600000007', 'alopez7@ejemplo.com'),
(8, 'Carmen', 'Herrera', '600000008', 'cherrera8@ejemplo.com'),
(9, 'Miguel', 'Cruz', '600000009', 'mcruz9@ejemplo.com'),
(10, 'Sandra', 'Morales', '600000010', 'smorales10@ejemplo.com'),
(11, 'Pedro', 'Castillo', '600000011', 'pcastillo11@ejemplo.com'),
(12, 'Marina', 'Ríos', '600000012', 'mrios12@ejemplo.com'),
(13, 'Sergio', 'Silva', '600000013', 'ssilva13@ejemplo.com'),
(14, 'Patricia', 'Peña', '600000014', 'ppenna14@ejemplo.com'),
(15, 'Luis', 'Mendoza', '600000015', 'lmendoza15@ejemplo.com'),
(16, 'Gabriela', 'Navarro', '600000016', 'gnavarro16@ejemplo.com'),
(17, 'Rafael', 'Ibáñez', '600000017', 'ribanez17@ejemplo.com'),
(18, 'Viviana', 'Campos', '600000018', 'vcampos18@ejemplo.com'),
(19, 'Héctor', 'Salazar', '600000019', 'hsalazar19@ejemplo.com'),
(20, 'Tamara', 'González', '600000020', 'tgonzalez20@ejemplo.com'),
(21, 'Esteban', 'Paredes', '600000021', 'eparedes21@ejemplo.com'),
(22, 'Cecilia', 'Soto', '600000022', 'csoto22@ejemplo.com'),
(23, 'Rodrigo', 'Fuentes', '600000023', 'rfuentes23@ejemplo.com'),
(24, 'Claudia', 'Valenzuela', '600000024', 'cvalenzuela24@ejemplo.com'),
(25, 'Marcos', 'Delgado', '600000025', 'mdelgado25@ejemplo.com');

-- Tabla 3 Entrenadores
INSERT INTO Entrenadores (Nombre_entrenador, Apellido_entrenador, Correo_entrenador, Telefono_entrenador, Id_Categoria) VALUES
('Javier', 'Gómez', 'javier.gomez@academia.com', '600111222', 1), -- Sub-7
('Ana', 'Ruiz', 'ana.ruiz@academia.com', '600333444', 2),         -- Sub-10
('Carlos', 'Muñoz', 'carlos.munoz@academia.com', '600555666', 3), -- Sub-12
('Valeria', 'Santos', 'valeria.santos@academia.com', '600777888', 4), -- Sub-15
('Andrés', 'Del Valle', 'andres.delvalle@academia.com', '600999000', 5); -- Sub-17

-- Tabla 5 Entrenamientos
INSERT INTO Entrenamientos (Id_Categoria, Id_Entrenador, Fecha_Entrenamiento, Hora_Entrenamiento) VALUES
-- Sub-7 (lunes y miércoles)
(1, 1, '2025-05-05', '17:00:00'),
(1, 1, '2025-05-07', '17:00:00'),
(1, 1, '2025-05-12', '17:00:00'),
(1, 1, '2025-05-14', '17:00:00'),
(1, 1, '2025-05-19', '17:00:00'),
(1, 1, '2025-05-21', '17:00:00'),

-- Sub-10 (martes y jueves)
(2, 2, '2025-05-06', '17:00:00'),
(2, 2, '2025-05-08', '17:00:00'),
(2, 2, '2025-05-13', '17:00:00'),
(2, 2, '2025-05-15', '17:00:00'),
(2, 2, '2025-05-20', '17:00:00'),
(2, 2, '2025-05-22', '17:00:00'),

-- Sub-12 (lunes y jueves)
(3, 3, '2025-05-05', '18:00:00'),
(3, 3, '2025-05-08', '18:00:00'),
(3, 3, '2025-05-12', '18:00:00'),
(3, 3, '2025-05-15', '18:00:00'),
(3, 3, '2025-05-19', '18:00:00'),
(3, 3, '2025-05-22', '18:00:00'),

-- Sub-15 (miércoles y viernes)
(4, 4, '2025-05-07', '18:00:00'),
(4, 4, '2025-05-09', '18:00:00'),
(4, 4, '2025-05-14', '18:00:00'),
(4, 4, '2025-05-16', '18:00:00'),
(4, 4, '2025-05-21', '18:00:00'),
(4, 4, '2025-05-23', '18:00:00'),

-- Sub-17 (martes y viernes)
(5, 5, '2025-05-06', '19:00:00'),
(5, 5, '2025-05-09', '19:00:00'),
(5, 5, '2025-05-13', '19:00:00'),
(5, 5, '2025-05-16', '19:00:00'),
(5, 5, '2025-05-20', '19:00:00'),
(5, 5, '2025-05-23', '19:00:00');

-- Tabla 6 Evaluaciones por jugador
INSERT INTO Evaluacion_Jugadores (Id_Jugador, Id_Entrenador, Calificacion_Evaluacion, Id_Habilidad, Comentario, Fecha_Evaluacion) VALUES
-- Sub-7
(1, 1, 'Bueno', 1, 'Muestra buen dominio del balón.', '2025-05-10'),
(2, 1, 'Excelente', 2, 'Destaca en velocidad y resistencia.', '2025-05-10'),
(3, 1, 'Regular', 3, 'Le falta comprensión táctica.', '2025-05-10'),
(4, 1, 'Bueno', 4, 'Participa con buena actitud.', '2025-05-10'),
(5, 1, 'Debe mejorar', 1, 'Dificultades en control del balón.', '2025-05-10'),

-- Sub-10 
(6, 2, 'Excelente', 1, 'Gran capacidad técnica.', '2025-05-11'),
(7, 2, 'Bueno', 2, 'Físicamente fuerte y rápido.', '2025-05-11'),
(8, 2, 'Regular', 4, 'Debe mejorar su concentración.', '2025-05-11'),
(9, 2, 'Bueno', 3, 'Sabe posicionarse en el campo.', '2025-05-11'),
(10, 2, 'Debe mejorar', 2, 'Falta constancia en entrenamientos.', '2025-05-11'),

-- Sub-12 
(11, 3, 'Bueno', 1, 'Buen pase corto y largo.', '2025-05-12'),
(12, 3, 'Excelente', 4, 'Motiva al equipo.', '2025-05-12'),
(13, 3, 'Regular', 2, 'Debe trabajar su resistencia.', '2025-05-12'),
(14, 3, 'Bueno', 3, 'Buena visión de juego.', '2025-05-12'),
(15, 3, 'Debe mejorar', 4, 'Le falta disciplina táctica.', '2025-05-12'),

-- Sub-15
(16, 4, 'Bueno', 1, 'Sabe definir en el área.', '2025-05-13'),
(17, 4, 'Excelente', 2, 'Gran estado físico.', '2025-05-13'),
(18, 4, 'Regular', 3, 'Necesita mejorar su ubicación.', '2025-05-13'),
(19, 4, 'Bueno', 4, 'Tiene buen liderazgo.', '2025-05-13'),
(20, 4, 'Debe mejorar', 1, 'Errores frecuentes en control.', '2025-05-13'),

-- Sub-17
(21, 5, 'Bueno', 2, 'Juega con intensidad.', '2025-05-14'),
(22, 5, 'Excelente', 3, 'Lee bien las jugadas.', '2025-05-14'),
(23, 5, 'Regular', 4, 'Debe enfocarse más en los partidos.', '2025-05-14'),
(24, 5, 'Bueno', 1, 'Control y pase acertado.', '2025-05-14'),
(25, 5, 'Debe mejorar', 2, 'No mantiene el ritmo del grupo.', '2025-05-14');

-- Tabla 8 Partidos
INSERT INTO Partidos (Nombre_Partido, Id_Categoria, Fecha, Resultado, Id_Estado_Resultados) VALUES
('Sub-7 vs Escuela A', 1, '2025-05-10', '2-1', 1),
('Sub-10 vs Escuela B', 2, '2025-05-11', '0-0', 2),
('Sub-12 vs Escuela C', 3, '2025-05-12', '1-3', 3),
('Sub-15 vs Escuela D', 4, '2025-05-13', 'No jugado', 4),
('Sub-17 vs Escuela E', 5, '2025-05-14', '4-2', 1),
('Sub-7 vs Escuela A', 1, '2025-05-17', '1-1', 2),
('Sub-7 vs Escuela A', 1, '2025-05-24', '3-0', 1),
('Sub-10 vs Escuela B', 2, '2025-05-18', '1-2', 3),
('Sub-10 vs Escuela B', 2, '2025-05-25', '2-0', 1),
('Sub-12 vs Escuela C', 3, '2025-05-19', '2-2', 2),
('Sub-12 vs Escuela C', 3, '2025-05-26', '0-0', 2), 
('Sub-15 vs Escuela D', 4, '2025-05-20', '1-0', 1),
('Sub-15 vs Escuela D', 4, '2025-05-27', '0-1', 3),
('Sub-17 vs Escuela E', 5, '2025-05-21', '3-3', 2),
('Sub-17 vs Escuela E', 5, '2025-05-28', 'Susp.', 4);

-- Tabla 10 Ingresos:
INSERT INTO Finanzas_Ingresos (Id_Conceptos_Ingresos, Id_Jugador, Descripcion, Fecha_ingreso, Monto) VALUES
(1, 1, 'Mensualidad mayo - Lucas Martínez', '2025-05-01', 50.00),
(1, 2, 'Mensualidad mayo - Valentina Gómez', '2025-05-01', 50.00),
(2, 3, 'Inscripción 2025 - Samuel Pérez', '2025-05-01', 100.00),
(4, 4, 'Uniforme oficial - Isabella Torres', '2025-05-02', 30.00),
(1, 5, 'Mensualidad mayo - Diego Ramírez', '2025-05-02', 50.00),
(1, 11, 'Mensualidad mayo - Juan Castillo', '2025-05-03', 50.00),
(4, 12, 'Uniforme oficial - Camila Ríos', '2025-05-03', 30.00),
(1, 17, 'Mensualidad mayo - Catalina Ibáñez', '2025-05-04', 50.00),
(2, 18, 'Inscripción 2025 - Agustín Campos', '2025-05-05', 100.00),
(1, 22, 'Mensualidad mayo - Emilia Soto', '2025-05-06', 50.00);

-- Tabla 12 Egresos:
INSERT INTO Finanzas_Egresos (Id_Conceptos_Egresos, Descripcion, Fecha_egreso, Monto) VALUES
(1, 'Pago mensual entrenador Javier Gómez (Sub-7)', '2025-05-05', 80.00),
(1, 'Pago mensual entrenador Ana Ruiz (Sub-10)', '2025-05-05', 80.00),
(1, 'Pago mensual entrenador Carlos Muñoz (Sub-12)', '2025-05-05', 80.00),
(1, 'Pago mensual entrenador Valeria Santos (Sub-15)', '2025-05-05', 80.00),
(1, 'Pago mensual entrenador Andrés Del Valle (Sub-17)', '2025-05-05', 80.00),
(2, 'Pago administrativo por gestión', '2025-05-06', 100.00),
(2, 'Honorario administrativo extra por reunión de padres', '2025-05-10', 50.00),
(3, 'Compra de balones y conos de entrenamiento', '2025-05-07', 45.50),
(3, 'Compra de chalecos y aros deportivos', '2025-05-09', 38.00),
(4, 'Mantenimiento de césped y porterías', '2025-05-08', 60.00);

-- ===================================================================================================================================
-- PRUEBA DE FUNCIONAMIENTO
-- ===================================================================================================================================
-- STORED PROCEDURES
-- Stored Procedures 1: sp_inscribir_jugador
CALL sp_inscribir_jugador(
    'Andrés', 'López', '2016-04-10', 1,
    'Laura', 'López', '600123123', 'laura.lopez@example.com'
);
-- Verificacion jugador sp1
SELECT * FROM Jugadores WHERE Nombre_jugador = 'Andrés' AND Apellido_jugador = 'López';
-- Verificacion Padre y/o representante
SELECT * FROM Padres_Representantes WHERE Correo_PR = 'laura.lopez@example.com';

-- Stored Procedures 2: sp_registrar_entrenamiento
CALL sp_registrar_entrenamiento(3, 3, '2025-06-03', '18:00:00');

-- Verificacion de registro correctamente sp2
SELECT * FROM Entrenamientos
WHERE Id_Categoria = 3 AND Id_Entrenador = 3
ORDER BY Fecha_Entrenamiento DESC;

-- Stored Procedures 3: sp_insertar_ingreso
CALL sp_insertar_ingreso(
    1, -- Id_Conceptos_Ingresos: Mensualidad
    1, -- Id_Jugador: Jugador existente
    'Pago mensual junio - Lucas Martínez',
    '2025-06-08',
    50.00
);
-- Verificacion de registro correctamente sp3
SELECT * FROM Finanzas_Ingresos
ORDER BY Fecha_ingreso DESC;


-- Stored Procedures 4: sp_insertar_egreso
CALL sp_insertar_egreso(
    1, -- Id_Conceptos_Egresos: Pago de entrenador
    'Pago entrenador Sub-10 - junio',
    '2025-06-08',
    80.00
);
-- Verificacion de registro correctamente sp4
SELECT * FROM Finanzas_Egresos
ORDER BY Fecha_egreso DESC;

-- TRIGGER
-- Se eliminará un ingreso y egreso para verificar el correcto funcionamiento de Trigger 3 y 4.

DELETE FROM Finanzas_Ingresos
WHERE Id_Ingreso = 1;

DELETE FROM Finanzas_Egresos
WHERE Id_Egreso = 1;

-- Verificacion del funcionamiento tabla auditoria contable
SELECT * FROM Auditoria_Contable
ORDER BY Fecha_Registro DESC;

-- Creación e ingresos de usuarios al sistema (tabala 15)
-- Insertar usuarios del sistema
INSERT INTO Usuarios_Sistema (Nombre_Usuario, Correo, Rol)
VALUES
('Bianca D’Amelio', 'root@localhost', 'Administrador'),
('Carlos Reyes', 'contabilidad@academia.com', 'Contador'),
('Laura Gómez', 'asistente@academia.com', 'AsistenteAdministrativo');

-- Visualizar tabla 15 Usuarios del sistema
SELECT * FROM Usuarios_Sistema
ORDER BY Nombre_Usuario ASC;
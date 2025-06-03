USE IdeaDAmelio;
-- =========================================================================================================================
-- BLOQUE DE VISTAS Y FUNCIONES
-- =========================================================================================================================

-- Se crean vistas SQL para optimizar el acceso a la información clave por parte del personal administrativo y entrenadores
-- mejorando así la consulta y comprensión de los datos registrados en la base.

-- 1. Vista: Detalle de jugadores con su representante y categoría
CREATE VIEW vista_detalle_jugadores AS
SELECT 
    j.Id_Jugador,
    j.Nombre_jugador,
    j.Apellido_jugador,
    j.Fecha_Nacimiento,
    c.Nombre_Categoria,
    pr.Nombre_PR,
    pr.Apellido_PR,
    pr.Telefono_PR,
    pr.Correo_PR
FROM Jugadores j
JOIN Categoria c ON j.Id_Categoria = c.Id_Categoria
LEFT JOIN Padres_Representantes pr ON j.Id_Jugador = pr.Id_Jugador;

-- 2. Vista: Evaluaciones detalladas de jugadores
CREATE VIEW vista_evaluaciones_jugadores AS
SELECT 
    ej.Id_Evaluacion_Jugadores,
    j.Nombre_jugador,
    j.Apellido_jugador,
    e.Nombre_entrenador,
    e.Apellido_entrenador,
    h.Nombre_Habilidad,
    ej.Calificacion_Evaluacion,
    ej.Comentario,
    ej.Fecha_Evaluacion
FROM Evaluacion_Jugadores ej
JOIN Jugadores j ON ej.Id_Jugador = j.Id_Jugador
JOIN Entrenadores e ON ej.Id_Entrenador = e.Id_Entrenador
JOIN Habilidades h ON ej.Id_Habilidad = h.Id_Habilidad;

-- 3. Vista: Resumen de partidos con su categoría y estado
CREATE VIEW vista_resumen_partidos AS
SELECT 
    p.Nombre_Partido,
    c.Nombre_Categoria,
    p.Fecha,
    p.Resultado,
    er.Nombre_Estado_Resultados
FROM Partidos p
JOIN Categoria c ON p.Id_Categoria = c.Id_Categoria
JOIN Estado_Resultados er ON p.Id_Estado_Resultados = er.Id_Estado_Resultados;

-- 4. Vista: Entrenamientos programados con categoría y entrenador
CREATE VIEW vista_entrenamientos_programados AS
SELECT 
    et.Id_Entrenamiento,
    c.Nombre_Categoria,
    en.Nombre_entrenador,
    en.Apellido_entrenador,
    et.Fecha_Entrenamiento,
    et.Hora_Entrenamiento
FROM Entrenamientos et
JOIN Categoria c ON et.Id_Categoria = c.Id_Categoria
JOIN Entrenadores en ON et.Id_Entrenador = en.Id_Entrenador;

-- 5. Vista: Ingresos agrupados por tipo de concepto
CREATE VIEW vista_finanzas_ingresos_por_concepto AS
SELECT 
    ci.Nombre_Conceptos_Ingresos AS Concepto,
    fi.Fecha_ingreso,
    fi.Descripcion,
    fi.Monto,
    j.Nombre_jugador,
    j.Apellido_jugador
FROM Finanzas_Ingresos fi
JOIN Conceptos_Ingresos ci ON fi.Id_Conceptos_Ingresos = ci.Id_Conceptos_Ingresos
LEFT JOIN Jugadores j ON fi.Id_Jugador = j.Id_Jugador
ORDER BY ci.Nombre_Conceptos_Ingresos, fi.Fecha_ingreso;

-- 6. Vista: Egresos agrupados por tipo de concepto
CREATE VIEW vista_finanzas_egresos_por_concepto AS
SELECT 
    ce.Nombre_Conceptos_Egresos AS Concepto,
    fe.Fecha_egreso,
    fe.Descripcion,
    fe.Monto
FROM Finanzas_Egresos fe
JOIN Conceptos_Egresos ce ON fe.Id_Conceptos_Egresos = ce.Id_Conceptos_Egresos
ORDER BY ce.Nombre_Conceptos_Egresos, fe.Fecha_egreso;

-- Ahora realizaremos la creación de unas funciones a utilizar
-- Función edad del jugador: Calcula la edad actual del jugador.
DELIMITER //
CREATE FUNCTION fn_edad_jugador(fecha_nac DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, fecha_nac, CURDATE());
END;
//
DELIMITER ;

-- Función total puntos en partidos: Devuelve la suma de puntos obtenidos.
DELIMITER //
CREATE FUNCTION fn_total_puntos_partidos(id_categoria INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE puntos_total INT;

    SELECT SUM(
        CASE
            WHEN er.Nombre_Estado_Resultados = 'Ganado' THEN 3
            WHEN er.Nombre_Estado_Resultados = 'Empatado' THEN 1
            ELSE 0
        END
    ) INTO puntos_total
    FROM Partidos p
    JOIN Estado_Resultados er ON p.Id_Estado_Resultados = er.Id_Estado_Resultados
    WHERE p.Id_Categoria = id_categoria;

    RETURN IFNULL(puntos_total, 0);
END;
//
DELIMITER ;

-- Total Ingresos: Suma el total de ingresos registrados.
DELIMITER //
CREATE FUNCTION fn_total_ingresos()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(Monto) INTO total FROM Finanzas_Ingresos;
    RETURN IFNULL(total, 0);
END;
//
DELIMITER ;

-- Total egresos: Suma el total de egresos registrados.
DELIMITER //
CREATE FUNCTION fn_total_egresos()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(Monto) INTO total FROM Finanzas_Egresos;
    RETURN IFNULL(total, 0);
END;
//
DELIMITER ;

-- Estado del Balance: Evalúa si el balance es positivo o negativo, devolviendo “Ganancia” o “Pérdida”.
DELIMITER //
CREATE FUNCTION fn_estado_balance()
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE balance DECIMAL(10,2);

    SET balance = fn_total_ingresos() - fn_total_egresos();

    RETURN CASE
        WHEN balance < 0 THEN 'Pérdida'
        ELSE 'Ganancia'
    END;
END;
//
DELIMITER ;

-- Actualizaremos unas Vistas, para aprovechar complementarla con las funciones creadas, asimismo, se agrega una vista de Balance mensual.
-- Actualizacion Vista detalle jugadores
CREATE OR REPLACE VIEW vista_detalle_jugadores AS
SELECT 
    j.Id_Jugador,
    j.Nombre_jugador,
    j.Apellido_jugador,
    j.Fecha_Nacimiento,
    fn_edad_jugador(j.Fecha_Nacimiento) AS Edad,
    c.Nombre_Categoria,
    pr.Nombre_PR,
    pr.Apellido_PR,
    pr.Telefono_PR,
    pr.Correo_PR
FROM Jugadores j
JOIN Categoria c ON j.Id_Categoria = c.Id_Categoria
LEFT JOIN Padres_Representantes pr ON j.Id_Jugador = pr.Id_Jugador
ORDER BY j.Id_Jugador;

-- Actualización de Vista resumen de partido
CREATE OR REPLACE VIEW vista_resumen_partidos AS
SELECT 
    p.Nombre_Partido,
    c.Nombre_Categoria,
    p.Fecha,
    p.Resultado,
    er.Nombre_Estado_Resultados,
    CASE
        WHEN er.Nombre_Estado_Resultados = 'Ganado' THEN 3
        WHEN er.Nombre_Estado_Resultados = 'Empatado' THEN 1
        ELSE 0
    END AS Puntos_Obtenidos,
    fn_total_puntos_partidos(c.Id_Categoria) AS Puntos_Acumulados
FROM Partidos p
JOIN Categoria c ON p.Id_Categoria = c.Id_Categoria
JOIN Estado_Resultados er ON p.Id_Estado_Resultados = er.Id_Estado_Resultados;

-- Creación de Vista resumen financiero mes a mes
CREATE OR REPLACE VIEW vista_resumen_financiero_mensual AS
SELECT 
    resumen.Ano,
    resumen.Mes,
    resumen.Total_Ingresos,
    IFNULL(egresos.Total_Egresos, 0) AS Total_Egresos,
    resumen.Total_Ingresos - IFNULL(egresos.Total_Egresos, 0) AS Diferencia,
    CASE
        WHEN resumen.Total_Ingresos - IFNULL(egresos.Total_Egresos, 0) < 0 THEN 'Pérdida'
        ELSE 'Ganancia'
    END AS Estado
FROM (
    SELECT 
        YEAR(Fecha_ingreso) AS Ano,
        MONTH(Fecha_ingreso) AS Mes,
        SUM(Monto) AS Total_Ingresos
    FROM Finanzas_Ingresos
    GROUP BY YEAR(Fecha_ingreso), MONTH(Fecha_ingreso)
) AS resumen
LEFT JOIN (
    SELECT 
        YEAR(Fecha_egreso) AS Ano,
        MONTH(Fecha_egreso) AS Mes,
        SUM(Monto) AS Total_Egresos
    FROM Finanzas_Egresos
    GROUP BY YEAR(Fecha_egreso), MONTH(Fecha_egreso)
) AS egresos
ON resumen.Ano = egresos.Ano AND resumen.Mes = egresos.Mes
ORDER BY resumen.Ano, resumen.Mes;

-- ================================================================================================================================
-- BLOQUE DE STORED PROCEDURES
-- A continuación se definen los procedimientos almacenados (SP) que automatizan acciones clave del sistema, como el registro
-- de entrenamientos, evaluaciones e ingresos. Estos SP permiten simplificar operaciones frecuentes y asegurar la integridad
-- de los datos desde el propio servidor SQL.
-- ================================================================================================================================

-- Stored Procedures 1: para Inserta un jugador y su representante en un solo paso.
DELIMITER //
CREATE PROCEDURE sp_inscribir_jugador (
    IN p_nombre_jugador VARCHAR(50),
    IN p_apellido_jugador VARCHAR(50),
    IN p_fecha_nacimiento DATE,
    IN p_id_categoria INT,
    IN p_nombre_pr VARCHAR(50),
    IN p_apellido_pr VARCHAR(50),
    IN p_telefono_pr VARCHAR(20),
    IN p_correo_pr VARCHAR(100)
)
BEGIN
    DECLARE v_id_jugador INT;

    -- Insertar jugador
    INSERT INTO Jugadores (Nombre_jugador, Apellido_jugador, Fecha_Nacimiento, Id_Categoria)
    VALUES (p_nombre_jugador, p_apellido_jugador, p_fecha_nacimiento, p_id_categoria);

    SET v_id_jugador = LAST_INSERT_ID();

    -- Insertar padre o representante
    INSERT INTO Padres_Representantes (Id_Jugador, Nombre_PR, Apellido_PR, Telefono_PR, Correo_PR)
    VALUES (v_id_jugador, p_nombre_pr, p_apellido_pr, p_telefono_pr, p_correo_pr);
END;
//
DELIMITER ;

-- Stored Procedures 2: para registrar un entrenamiento
DELIMITER //
CREATE PROCEDURE sp_registrar_entrenamiento (
    IN p_id_categoria INT,
    IN p_id_entrenador INT,
    IN p_fecha DATE,
    IN p_hora TIME
)
BEGIN
    INSERT INTO Entrenamientos (Id_Categoria, Id_Entrenador, Fecha_Entrenamiento, Hora_Entrenamiento)
    VALUES (p_id_categoria, p_id_entrenador, p_fecha, p_hora);
END;
//
DELIMITER ;

-- Stored Procedures 3: para registrar un ingreso contable
DELIMITER //
CREATE PROCEDURE sp_insertar_ingreso (
    IN p_id_concepto INT,
    IN p_id_jugador INT,
    IN p_descripcion VARCHAR(255),
    IN p_fecha DATE,
    IN p_monto DECIMAL(10,2)
)
BEGIN
    INSERT INTO Finanzas_Ingresos (Id_Conceptos_Ingresos, Id_Jugador, Descripcion, Fecha_ingreso, Monto)
    VALUES (p_id_concepto, p_id_jugador, p_descripcion, p_fecha, p_monto);
END;
//
DELIMITER ;

-- Stored Procedures 4: para registrar un egreso contable
DELIMITER //
CREATE PROCEDURE sp_insertar_egreso (
    IN p_id_concepto INT,
    IN p_descripcion VARCHAR(255),
    IN p_fecha DATE,
    IN p_monto DECIMAL(10,2)
)
BEGIN
    INSERT INTO Finanzas_Egresos (Id_Conceptos_Egresos, Descripcion, Fecha_egreso, Monto)
    VALUES (p_id_concepto, p_descripcion, p_fecha, p_monto);
END;
//
DELIMITER ;


-- ===================================================================================================================================
-- AUDITORÍA CONTABLE - TRIGGERS
-- 
-- A continuación se crea la tabla 'Auditoria_Contable' y dos triggers que registran automáticamente todos los ingresos y
-- egresos que se insertan en el sistema.
--
-- Esto permite mantener un historial detallado y trazable de cada operación financiera realizada, mejorando el control
-- contable y la transparencia del sistema.
-- 
-- Triggers:
-- - trg_auditoria_ingreso: AFTER INSERT en Finanzas_Ingresos
-- - trg_auditoria_egreso:  AFTER INSERT en Finanzas_Egresos
-- ===================================================================================================================================

-- Se crea la tabla 14 Auditoria contable, donde se llevara el hisotrial detallado de los movimientos
CREATE TABLE Auditoria_Contable (
    Id_Auditoria INT AUTO_INCREMENT PRIMARY KEY,
    Tipo_Operacion ENUM('Ingreso', 'Egreso'),
    Id_Operacion INT,
    Descripcion VARCHAR(255),
    Monto DECIMAL(10,2),
    Fecha_Operacion DATE,
    Usuario VARCHAR(100),
    Fecha_Registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

 -- Trigger de registro de ingresos contables
 DELIMITER //
CREATE TRIGGER trg_auditoria_ingreso
AFTER INSERT ON Finanzas_Ingresos
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria_Contable (
        Tipo_Operacion, Id_Operacion, Descripcion, Monto, Fecha_Operacion, Usuario
    )
    VALUES (
        'Ingreso', NEW.Id_Ingreso, NEW.Descripcion, NEW.Monto, NEW.Fecha_ingreso, CURRENT_USER()
    );
END;
//
DELIMITER ;

-- Trigger de registros de egresos contables
DELIMITER //
CREATE TRIGGER trg_auditoria_egreso
AFTER INSERT ON Finanzas_Egresos
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria_Contable (
        Tipo_Operacion, Id_Operacion, Descripcion, Monto, Fecha_Operacion, Usuario
    )
    VALUES (
        'Egreso', NEW.Id_Egreso, NEW.Descripcion, NEW.Monto, NEW.Fecha_egreso, CURRENT_USER()
    );
END;
//
DELIMITER ;

-- Trigger 3: : registros de eliminación de ingresos contables
DELIMITER //

CREATE TRIGGER trg_auditoria_delete_ingreso
AFTER DELETE ON Finanzas_Ingresos
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria_Contable (
        Tipo_Operacion, Id_Operacion, Descripcion, Monto, Fecha_Operacion, Usuario
    )
    VALUES (
        'Ingreso', OLD.Id_Ingreso, CONCAT('[ELIMINADO] ', OLD.Descripcion), OLD.Monto, OLD.Fecha_ingreso, CURRENT_USER()
    );
END;
//

DELIMITER ;

-- Trigger 4: registros de eliminación de egresos contables
DELIMITER //

CREATE TRIGGER trg_auditoria_delete_egreso
AFTER DELETE ON Finanzas_Egresos
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria_Contable (
        Tipo_Operacion, Id_Operacion, Descripcion, Monto, Fecha_Operacion, Usuario
    )
    VALUES (
        'Egreso', OLD.Id_Egreso, CONCAT('[ELIMINADO] ', OLD.Descripcion), OLD.Monto, OLD.Fecha_egreso, CURRENT_USER()
    );
END;
//

DELIMITER ;

-- CREACION DE USUARIOS
-- Primero se crea la Tabla 15: Usuarios_Sistema, quienes alimnetaran el sistema
CREATE TABLE Usuarios_Sistema (
    Id_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Usuario VARCHAR(50),
    Correo VARCHAR(100),
    Rol ENUM('Administrador', 'Contador', 'AsistenteAdministrativo'),
    Activo BOOLEAN DEFAULT TRUE
);


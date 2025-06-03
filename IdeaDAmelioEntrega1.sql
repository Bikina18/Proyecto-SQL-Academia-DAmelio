-- Se Crea la base de datos IdeaDAmelio
CREATE DATABASE IdeaDAmelio;
USE IdeaDAmelio;


-- Primero, se crean las tablas que no dependen de otras o que otras tablas dependen de ellas, como: 
-- Tabla 4 Categoria, Tabla 7 Habilidades, tabla 9 Estado_Resultados, Tabla 11 Conceptos_Ingresos, Tabla 13 Conceptos_Egresos

-- Se Crea tabla 4 Categoria
CREATE TABLE Categoria (
    Id_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Categoria VARCHAR(50)
);

-- Se Crea tabla 7 Habilidades
CREATE TABLE Habilidades (
    Id_Habilidad INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Habilidad VARCHAR(50)
);

-- Se Crea tabla 9 Estado_Resultados
CREATE TABLE Estado_Resultados (
    Id_Estado_Resultados INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Estado_Resultados VARCHAR(50)
);

-- Se Crea tabla 11 Conceptos_Ingresos
CREATE TABLE Conceptos_Ingresos (
    Id_Conceptos_Ingresos INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Conceptos_Ingresos VARCHAR(100)
);

-- Se Crea tabla 13 Conceptos_Egresos
CREATE TABLE Conceptos_Egresos (
    Id_Conceptos_Egresos INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Conceptos_Egresos VARCHAR(100)
);

-- Luego, se crean las tablas que dependen de las anteriores, en el siguiente orden y sus consideraciones:
-- Tabla 1 Jugadores (depende de Categoria)
-- Tabla 2 Padres_Representantes (depende de Jugadores)
-- Tabla 3 Entrenadores (depende de Categoria)
-- Tabla 5 Entrenamientos (depende de Categoria y Entrenadores)
-- Tabla 6 Evaluacion_Jugadores (depende de Jugadores, Entrenadores, y Habilidades)
-- Tabla 8 Partidos (depende de Categoria y Estado_Resultados)
-- Tabla 10 Finanzas_Ingresos (depende de Conceptos_Ingresos y Jugadores)
-- Tabla 12 Finanzas_Egresos (depende de Conceptos_Egresos)

-- Se Crea tabla 1 Jugadores
CREATE TABLE Jugadores (
    Id_Jugador INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_jugador VARCHAR(50),
    Apellido_jugador VARCHAR(50),
    Fecha_Nacimiento DATE,
    Id_Categoria INT,
    FOREIGN KEY (Id_Categoria) REFERENCES Categoria(Id_Categoria)
);

-- Se Crea tabla 2 Padres_Representantes
CREATE TABLE Padres_Representantes (
    Id_PR INT AUTO_INCREMENT PRIMARY KEY,
    Id_Jugador INT,
    Nombre_PR VARCHAR(50),
    Apellido_PR VARCHAR(50),
    Telefono_PR VARCHAR(20),
    Correo_PR VARCHAR(100),
    FOREIGN KEY (Id_Jugador) REFERENCES Jugadores(Id_Jugador)
);

-- Se Crea tabla 3 Entrenadores
CREATE TABLE Entrenadores (
    Id_Entrenador INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_entrenador VARCHAR(50),
    Apellido_entrenador VARCHAR(50),
    Correo_entrenador VARCHAR(100),
    Telefono_entrenador VARCHAR(20),
    Id_Categoria INT,
    FOREIGN KEY (Id_Categoria) REFERENCES Categoria(Id_Categoria)
);

-- Se Crea tabla 5 Entrenamientos
CREATE TABLE Entrenamientos (
    Id_Entrenamiento INT AUTO_INCREMENT PRIMARY KEY,
    Id_Categoria INT,
    Id_Entrenador INT,
    Fecha_Entrenamiento DATE,
    Hora_Entrenamiento TIME,
    FOREIGN KEY (Id_Categoria) REFERENCES Categoria(Id_Categoria),
    FOREIGN KEY (Id_Entrenador) REFERENCES Entrenadores(Id_Entrenador)
);

-- Se Crea tabla 6 Evaluacion_Jugadores
CREATE TABLE Evaluacion_Jugadores (
    Id_Evaluacion_Jugadores INT AUTO_INCREMENT PRIMARY KEY,
    Id_Jugador INT,
    Id_Entrenador INT,
    Calificacion_Evaluacion ENUM('Excelente', 'Bueno', 'Regular', 'Debe mejorar'),
    Id_Habilidad INT,
    Comentario TEXT,
    Fecha_Evaluacion DATE,
    FOREIGN KEY (Id_Jugador) REFERENCES Jugadores(Id_Jugador),
    FOREIGN KEY (Id_Entrenador) REFERENCES Entrenadores(Id_Entrenador),
    FOREIGN KEY (Id_Habilidad) REFERENCES Habilidades(Id_Habilidad)
);


-- Se Crea tabla 8 Partidos
CREATE TABLE Partidos (
    Id_Partidos INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Partido VARCHAR(100),
    Id_Categoria INT,
    Fecha DATE,
    Resultado VARCHAR(50),
    Id_Estado_Resultados INT,
    FOREIGN KEY (Id_Categoria) REFERENCES Categoria(Id_Categoria),
    FOREIGN KEY (Id_Estado_Resultados) REFERENCES Estado_Resultados(Id_Estado_Resultados)
);


-- Se Crea tabla 10 Finanzas_Ingresos
CREATE TABLE Finanzas_Ingresos (
    Id_Ingreso INT AUTO_INCREMENT PRIMARY KEY,
    Id_Conceptos_Ingresos INT,
    Id_Jugador INT DEFAULT -1,  -- Asumiendo que -1 representa 'Entidad Externa'
    Descripcion VARCHAR(255),
    Fecha_ingreso DATE,
    Monto DECIMAL(10, 2),
    FOREIGN KEY (Id_Conceptos_Ingresos) REFERENCES Conceptos_Ingresos(Id_Conceptos_Ingresos),
    FOREIGN KEY (Id_Jugador) REFERENCES Jugadores(Id_Jugador)
);


-- Se Crea tabla 12 Finanzas_Egresos
CREATE TABLE Finanzas_Egresos (
    Id_Egreso INT AUTO_INCREMENT PRIMARY KEY,
    Id_Conceptos_Egresos INT,
    Descripcion VARCHAR(255),
    Fecha_egreso DATE,
    Monto DECIMAL(10, 2),
    FOREIGN KEY (Id_Conceptos_Egresos) REFERENCES Conceptos_Egresos(Id_Conceptos_Egresos)
);


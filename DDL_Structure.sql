-- Creación de base de datos y tablas (DDL)

CREATE DATABASE IF NOT EXISTS mi_mejor_amigo_DB;

USE mi_mejor_amigo_DB;

CREATE TABLE Dueno (
	cedula INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(45) NOT NULL
);

CREATE TABLE Mascota (
    idMascota INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especie VARCHAR(50) NOT NULL,
    sexo CHAR(1) CHECK (sexo IN ('M', 'F')),
    raza VARCHAR(50),
    Dueno_Cedula INT,
    FOREIGN KEY (Dueno_Cedula) REFERENCES Dueno(cedula)
);

CREATE TABLE Cita (
    idCita INT AUTO_INCREMENT PRIMARY KEY,
    fecha_cita DATE NOT NULL,
    hora TIME NOT NULL,
    motivo VARCHAR(255),
    Mascota_idMascota INT,
    Servicio_idServicio INT,
    FOREIGN KEY (Mascota_idMascota) REFERENCES Mascota(idMascota),
    FOREIGN KEY (Servicio_idServicio) REFERENCES Servicio(idServicio)
);


CREATE TABLE Vacunacion (
    idVacunacion INT AUTO_INCREMENT PRIMARY KEY,
    fecha_vacuna DATE NOT NULL,
    enfermedad VARCHAR(100) NOT NULL,
    Mascota_idMascota INT,
    Cita_idCita INT,
    FOREIGN KEY (Mascota_idMascota) REFERENCES Mascota(idMascota),
    FOREIGN KEY (Cita_idCita) REFERENCES Cita(idCita)
);

CREATE TABLE Servicio (
	idServicio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE Tratamiento (
    idTratamiento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    observaciones TEXT NOT NULL,
    Cita_idCita INT NOT NULL,
    FOREIGN KEY (Cita_idCita) REFERENCES Cita(idCita)
);
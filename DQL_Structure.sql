-- Mascotas con citas en julio de 2025
CREATE TABLE Mascotas_Citas_Julio2025 AS
SELECT m.idMascota, m.nombre AS nombre_mascota, c.fecha_cita AS fecha_cita
FROM Mascota m
JOIN Cita c ON m.idMascota = c.Mascota_idMascota
WHERE c.fecha_cita BETWEEN '2025-07-01' AND '2025-07-31';

-- Mascotas con numero de citas asistidas
CREATE TABLE Mascotas_Con_Citas AS
SELECT mc.idMascota, mc.nombre AS nombre_mascota, datos.num_citas
FROM Mascota mc
JOIN (
    SELECT c.Mascota_idMascota, 
        COUNT(*) AS num_citas
    FROM Cita c
    GROUP BY c.Mascota_idMascota) AS datos ON mc.idMascota = datos.Mascota_idMascota;

-- Servicios mas caros
SELECT nombre 
FROM Servicio 
WHERE precio > (
    SELECT AVG(precio) 
    FROM Servicio
);

-- Servicios mas económicos
SELECT nombre 
FROM Servicio 
WHERE precio < (
    SELECT AVG(precio) 
    FROM Servicio
);

-- Promedio de los precios
SELECT ROUND(AVG(precio), 2) AS promedio_redondeado
FROM Servicio;

-- Número de mascotas registradas por especie
SELECT especie, COUNT(*) AS cantidad_mascotas
FROM Mascota
GROUP BY especie;

-- Nombres de los servicios en mayuscula
SELECT nombre, UPPER(nombre) AS nombre_mayuscula
FROM Servicio;

-- Nombres de los servicios en minuscula
SELECT nombre, LOWER(nombre) AS nombre_minuscula
FROM Dueno;

-- Longuitud del nombre de cada mascota
SELECT nombre, LENGTH(nombre) AS longitud_nombre
FROM Mascota;

-- Extraer los primeros 3 caracteres de la especie
SELECT especie, SUBSTRING(especie, 1, 3) AS especie_corta
FROM Mascota;

-- Eliminar espacios al inicio y final del nombre del dueño
SELECT nombre, TRIM(nombre) AS nombre_sin_espacios
FROM Dueno;

-- Clasificar Servicios como caros o economicos
SELECT nombre, precio,
  IF(precio > 50000, 'Costoso', 'Económico') AS tipo_servicio
FROM Servicio;

-- Mostar el genero de cada mascota completamente
SELECT nombre, sexo,
	IF(sexo = 'M', 'Macho', 'Hembra') AS genero_texto
FROM Mascota;

-- Mostrar cita con nombre de la mascota y la fecha
SELECT CONCAT(m.nombre, ' tiene cita el ', c.fecha_cita) AS resumen_cita
FROM Mascota m
JOIN Cita c ON m.idMascota = c.Mascota_idMascota;

-- Clasificacion de la hora ("Mañana, "Tarde")
SELECT idCita, hora,
    IF(hora < '12:00:00', 'Mañana', 'Tarde') AS turno
FROM Cita;
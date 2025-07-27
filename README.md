<p align="center">
  <img src="./Readme_images/Header_image.png" alt="Encabezado Mi Mejor Amigo" width="100%" />
</p>


# My-Best-Friend-veterinary 🐾

El centro de atención para mascotas "Mi Mejor Amigo" requiere la creación de una base de datos con el objetivo de optimizar sus procesos administrativos, permitiendo un acceso más ágil y eficiente a la información relacionada con:

- 📅 Citas veterinarias

- 💊 Tratamientos médicos

- 👤 Propietarios de las mascotas

- 🐶🐱 Mascotas registradas

- 🧾 Servicios ofrecidos por el centro

Esta sección documenta el proceso seguido para diseñar y construir la base de datos, desde el análisis inicial hasta el modelo final implementado.

## Planeación | Diagrama UML E-R

Para la creación del diagrama entidad-relación se establecieron seis entidades principales, que representan las tablas fundamentales de la base de datos:

- **Dueño:** Representa a los propietarios de las mascotas.

- **Mascota:** Contiene la información individual de cada animal atendido.

- **Cita:** Registra los encuentros programados entre el cliente y el centro.

- **Servicio:** Describe los servicios que ofrece el centro veterinario.

- **Tratamiento:** Detalla los procedimientos médicos aplicados a las mascotas.

- **Vacunación:** (Entidad adicional) Almacena la información relacionada con las vacunas aplicadas.

Estas entidades se relacionan entre sí para garantizar la integridad y consistencia de los datos, permitiendo una gestión eficiente de las operaciones diarias del centro veterinario.

<p align="center">
  <img src="./Readme_images/Diagrama_UML.png" alt="Diagrama UML del sistema veterinario" width="600"/>
</p>


### 🔗 Cardinalidades del Modelo
Las relaciones entre las entidades fueron definidas con las siguientes cardinalidades, lo cual permite representar con precisión la lógica del negocio del centro veterinario:

- Dueño 🧑‍⚕️ – Mascota 🐾
1 : N → Un dueño puede tener varias mascotas, pero cada mascota tiene un solo dueño.

- Mascota 🐾 – Vacunación 💉
1 : N → Una mascota puede recibir múltiples vacunaciones a lo largo del tiempo.

- Mascota 🐾 – Cita 📅
1 : N → Una mascota puede tener varias citas médicas.

- Vacunación 💉 – Cita 📅
N : 1 → Varias vacunaciones pueden registrarse en una misma cita.

- Cita 📅 – Servicio 🧾
1 : 1 → En una cita se puede aplicar 1 servicio.

- Cita 📅 – Tratamiento 💊
1 : N → Una cita puede incluir múltiples tratamientos.

## Estructura DDL (Data Definition Language)

### 📌 Creacion de la base de datos:
```sql
CREATE DATABASE IF NOT EXISTS mi_mejor_amigo_DB;

USE mi_mejor_amigo_DB;
```
Como primer paso, se crea la base de datos denominada "Mi Mejor Amigo DB", la cual servirá como repositorio central para almacenar y gestionar la información relacionada con el sistema veterinario. Una vez creada la base de datos, se procede a la construcción de las tablas que componen el modelo relacional, siguiendo una estructura lógica y normalizada que permite mantener la integridad de los datos y las relaciones entre las entidades.

### Creacion de las entidades:

#### 🧾 Tabla: Dueño

```sql
CREATE TABLE Dueno (
	cedula INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(45) NOT NULL
);
```
Esta tabla almacena la información básica de los propietarios de las mascotas que visitan la veterinaria.

- cedula: Identificador único del dueño. Se utiliza como clave primaria.

- nombre: Nombre completo del propietario. Es obligatorio.

- telefono: Número de contacto del propietario. Es obligatorio.

- direccion: Dirección de residencia del propietario. Es obligatoria.

La clave primaria cedula asegura que cada dueño esté registrado de manera única en el sistema, permitiendo establecer relaciones con otras tablas como Mascota.

#### 🐾 Tabla: Mascota

```sql
CREATE TABLE Mascota (
    idMascota INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especie VARCHAR(50) NOT NULL,
    sexo CHAR(1) CHECK (sexo IN ('M', 'F')),
    raza VARCHAR(50),
    Dueno_Cedula INT,
    FOREIGN KEY (Dueno_Cedula) REFERENCES Dueno(cedula)
);
```


Esta tabla contiene la información de las mascotas registradas en la veterinaria, asociadas a un dueño.

- idMascota: Identificador único de cada mascota. Clave primaria con incremento automático.

- nombre: Nombre de la mascota. Campo obligatorio.

- especie: Tipo de animal (ej. perro, gato, ave, etc.). Obligatorio.

- sexo: Sexo de la mascota. Se restringe a dos valores posibles: 'M' (macho) y 'F' (hembra).

- raza: Raza de la mascota. Campo opcional.

- Dueno_Cedula: Clave foránea que referencia a la cédula del dueño en la tabla Dueno.

La relación con Dueno permite identificar rápidamente quién es el propietario de cada mascota y gestionar su historial clínico de forma ordenada.


#### 🛠️ Tabla: Servicio

```sql
CREATE TABLE Servicio (
	idServicio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);
```

Esta tabla define los distintos servicios veterinarios que ofrece la clínica.

- idServicio: Identificador único del servicio. Es la clave primaria con incremento automático.

- nombre: Nombre del servicio ofrecido (por ejemplo: consulta general, baño, desparasitación). Campo obligatorio.

- descripcion: Breve explicación del servicio, su finalidad o procedimiento. Campo obligatorio.

- precio: Costo del servicio, expresado con precisión de dos decimales. Campo obligatorio.

Gracias a esta tabla, se puede mantener un catálogo estructurado de todos los servicios disponibles en el sistema, lo cual es clave para gestionar citas, facturación y reportes.

#### 📅 Tabla: Cita

```sql
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
```


Esta tabla almacena la información de cada cita médica agendada para una mascota.

- idCita: Identificador único de la cita. Es la clave primaria con incremento automático.

- fecha_cita: Fecha programada para la cita. Campo obligatorio.

- hora: Hora exacta de la cita. Campo obligatorio.

- motivo: Descripción del motivo de la cita. Es un campo opcional que permite especificar síntomas, chequeo general, etc.

- Mascota_idMascota: Clave foránea que hace referencia a la mascota que asiste a la cita (Mascota.idMascota).

- Servicio_idServicio: Clave foránea que indica el tipo de servicio prestado durante la cita (Servicio.idServicio).

Esta estructura permite registrar cuándo, por qué y para qué fue atendida una mascota, manteniendo así un historial clínico organizado y relacionado con los servicios prestados.

#### 💊 Tabla: Tratamiento

```sql
CREATE TABLE Tratamiento (
    idTratamiento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    observaciones TEXT NOT NULL,
    Cita_idCita INT NOT NULL,
    FOREIGN KEY (Cita_idCita) REFERENCES Cita(idCita)
);
```

La tabla Tratamiento almacena la información de los procedimientos médicos realizados a las mascotas durante una cita.

- idTratamiento: Identificador único del tratamiento. Es la clave primaria y se genera automáticamente.

- nombre: Nombre del tratamiento aplicado (por ejemplo: antibiótico, curación, control de parásitos). Campo obligatorio.

- observaciones: Campo de texto para registrar detalles importantes del tratamiento, como evolución, reacciones o recomendaciones posteriores. Campo obligatorio.

- Cita_idCita: Clave foránea que relaciona el tratamiento con la cita en la cual fue aplicado. Hace referencia a Cita(idCita).

Esta tabla permite llevar un historial clínico detallado de los tratamientos proporcionados, vinculando cada intervención médica con una cita específica.

#### 💉 Tabla: Vacunacion

```sql
CREATE TABLE Vacunacion (
    idVacunacion INT AUTO_INCREMENT PRIMARY KEY,
    fecha_vacuna DATE NOT NULL,
    enfermedad VARCHAR(100) NOT NULL,
    Mascota_idMascota INT,
    Cita_idCita INT,
    FOREIGN KEY (Mascota_idMascota) REFERENCES Mascota(idMascota),
    FOREIGN KEY (Cita_idCita) REFERENCES Cita(idCita)
);
```

La tabla Vacunacion registra las vacunas aplicadas a las mascotas, con el fin de mantener un historial de inmunización y controlar enfermedades prevenibles.

- idVacunacion: Identificador único de cada registro de vacunación. Se genera automáticamente.

- fecha_vacuna: Fecha en que fue aplicada la vacuna. Campo obligatorio.

- enfermedad: Nombre de la enfermedad contra la cual inmuniza la vacuna (por ejemplo: rabia, moquillo, parvovirus). Campo obligatorio.

- Mascota_idMascota: Clave foránea que relaciona la vacuna con la mascota correspondiente. Hace referencia a Mascota(idMascota).

- Cita_idCita: Clave foránea que vincula la vacunación con la cita médica donde fue aplicada. Hace referencia a Cita(idCita).

Esta tabla fortalece el control veterinario, asegurando el seguimiento correcto del esquema de vacunación de cada mascota.


## Estructura DML (Data Manipulation Language)

### Inserción de los datos: 

En esta sección se presentan las inserciones de datos realizadas sobre las entidades previamente definidas. Estas inserciones permiten poblar las tablas creadas en la sección anterior con información representativa para su posterior consulta y prueba del modelo.

#### Tabla Dueno:

```sql
INSERT INTO Dueno (cedula, nombre, telefono, direccion)
VALUES 
(1001001001, 'Carlos Ramírez', '3001234567', 'Cra 10 #20-45'),
(1002002002, 'Mariana López', '3109876543', 'Calle 85 #15-30'),
(1003003003, 'Luis Fernando Gómez', '3205557890', 'Av. Siempre Viva #123'),
(1004004004, 'Joan Sebastian Gómez', '3052349000', 'Av. Piedecusta Km 4'),
(1005005005, 'Luciana Gomez', '3249834021', 'Cra 20 #40-35');
```

En este bloque se realiza la inserción de registros en la tabla Dueno, la cual almacena la información personal de los propietarios de las mascotas. Esta entidad es clave dentro del modelo de base de datos, ya que establece una relación directa con las mascotas registradas.

Cada fila insertada representa un dueño diferente e incluye los siguientes campos:

- cedula: Identificador único del dueño (clave primaria).

- nombre: Nombre completo del propietario.

- telefono: Número de contacto personal.

- direccion: Dirección de residencia del dueño.

A continuación se detallan los registros ingresados:

- Carlos Ramírez – Cédula: 1001001001, Tel: 3001234567, Dirección: Cra 10 #20-45

- Mariana López – Cédula: 1002002002, Tel: 3109876543, Dirección: Calle 85 #15-30

- Luis Fernando Gómez – Cédula: 1003003003, Tel: 3205557890, Dirección: Av. Siempre Viva #123

- Joan Sebastian Gómez – Cédula: 1004004004, Tel: 3052349000, Dirección: Av. Piedecuesta Km 4

- Luciana Gomez – Cédula: 1005005005, Tel: 3249834021, Dirección: Cra 20 #40-35

Esta inserción permite alimentar la base de datos con una muestra representativa de clientes que posteriormente se relacionarán con sus respectivas mascotas en el sistema de gestión veterinaria.

#### Tabla Mascota:

```sql
INSERT INTO Mascota (nombre, especie, sexo, raza, Dueno_Cedula)
VALUES
('Max', 'Perro', 'M', 'Labrador Retriever', 1001001001),
('Luna', 'Gato', 'F', 'Siamesa', 1002002002),
('Rocky', 'Perro', 'M', 'Bulldog Inglés', 1001001001),
('Mila', 'Perro', 'F', 'Golden Retriever', 1002002002),
('Nube', 'Gato', 'F', 'Persa', 1003003003),
('Toby', 'Conejo', 'M', 'Holland Lop', 1001001001),
('Kiwi', 'Ave', 'F', 'Periquito Australiano', 1003003003),
('Spike', 'Reptil', 'M', 'Iguana Verde', 1003003003),
('Mango', 'Ave', 'M', 'Cacatúa', 1004004004),
('Copo', 'Conejo', 'F', 'Angora Inglés', 1005005005);
```

Este bloque SQL se encarga de insertar múltiples registros en la tabla Mascota, que representa a los animales registrados en el sistema veterinario. Esta entidad está relacionada directamente con la tabla Dueno mediante la clave foránea Dueno_Cedula, lo que permite establecer qué mascota pertenece a qué dueño.

Los campos que se insertan son:

- nombre: Nombre de la mascota.

- especie: Tipo de animal (por ejemplo, perro, gato, ave, etc.).

- sexo: Sexo de la mascota (M para macho, F para hembra).

- raza: Raza específica del animal.

- Dueno_Cedula: Cédula del dueño correspondiente (clave foránea vinculada con la tabla Dueno).

A continuación se describen las 10 mascotas registradas:

- Max – Perro, macho, Labrador Retriever, dueño: Carlos Ramírez

- Luna – Gato, hembra, Siamesa, dueña: Mariana López

- Rocky – Perro, macho, Bulldog Inglés, dueño: Carlos Ramírez

- Mila – Perro, hembra, Golden Retriever, dueña: Mariana López

- Nube – Gato, hembra, Persa, dueño: Luis Fernando Gómez

- Toby – Conejo, macho, Holland Lop, dueño: Carlos Ramírez

- Kiwi – Ave, hembra, Periquito Australiano, dueño: Luis Fernando Gómez

- Spike – Reptil, macho, Iguana Verde, dueño: Luis Fernando Gómez

- Mango – Ave, macho, Cacatúa, dueño: Joan Sebastian Gómez

- wCopo – Conejo, hembra, Angora Inglés, dueña: Luciana Gomez

Este conjunto de registros permite demostrar la diversidad de especies que pueden ser atendidas en el centro veterinario, no limitándose solo a perros y gatos, sino incluyendo aves, conejos y reptiles. Además, se evidencia la relación uno-a-muchos entre un dueño y sus múltiples mascotas.

#### Tabla Servicio:

```sql
INSERT INTO Servicio (nombre, descripcion, precio)
VALUES
('Consulta general', 'Revisión básica del estado de salud de la mascota.', 35000.00),
('Vacunación', 'Aplicación de vacunas preventivas contra enfermedades comunes.', 50000.00),
('Desparasitación', 'Tratamiento para eliminar parásitos internos y externos.', 30000.00),
('Esterilización', 'Procedimiento quirúrgico para esterilizar al animal.', 120000.00),
('Limpieza dental', 'Higiene bucal y remoción de sarro bajo sedación.', 80000.00);
```

Este bloque SQL inserta cinco registros en la tabla Servicio, que contiene los distintos procedimientos o atenciones que ofrece la veterinaria. Cada fila representa un tipo de servicio que puede ser solicitado para una mascota durante una cita.

Los campos que se insertan son:

- nombre: Nombre del servicio ofrecido.

- descripcion: Detalle breve del procedimiento o finalidad del servicio.

- precio: Valor monetario del servicio, expresado en pesos colombianos (COP).

A continuación, se describen los servicios registrados:

**Consulta general**

- Descripción: Revisión básica del estado de salud de la mascota.

- Precio: $35,000

**Vacunación**

Descripción: Aplicación de vacunas preventivas contra enfermedades comunes.

Precio: $50,000

**Desparasitación**

Descripción: Tratamiento para eliminar parásitos internos y externos.

Precio: $30,000

**Esterilización**

Descripción: Procedimiento quirúrgico para esterilizar al animal.

Precio: $120,000

**Limpieza dental**

Descripción: Higiene bucal y remoción de sarro bajo sedación.

Precio: $80,000

#### Tabla Cita

```sql
INSERT INTO Cita (fecha_cita, hora, motivo, Mascota_idMascota, Servicio_idServicio)
VALUES
('2025-07-01', '09:00:00', 'Revisión general anual', 1, 1),  -- Max, Consulta general
('2025-07-02', '10:30:00', 'Aplicación de vacuna antirrábica', 2, 2), -- Luna, Vacunación
('2025-07-03', '14:00:00', 'Desparasitación semestral', 6, 3), -- Toby, Desparasitación
('2025-07-04', '11:15:00', 'Esterilización programada', 4, 4), -- Mila, Esterilización
('2025-07-05', '16:45:00', 'Limpieza dental preventiva', 10, 5), -- Copo, Limpieza dental
('2025-07-06', '08:30:00', 'Chequeo postoperatorio', 3, 1),       -- Rocky, Consulta general
('2025-07-07', '13:00:00', 'Vacuna de refuerzo triple felina', 5, 2), -- Nube, Vacunación
('2025-07-08', '15:30:00', 'Desparasitación preventiva', 7, 3),   -- Kiwi, Desparasitación
('2025-07-09', '10:45:00', 'Consulta por cambio de comportamiento', 8, 1), -- Spike, Consulta general
('2025-07-10', '17:00:00', 'Control de peso y revisión', 9, 1);   -- Mango, Consulta general
```

Esta sentencia SQL inserta 10 registros en la tabla Cita, que representa cada visita o atención veterinaria registrada para una mascota.

Los campos insertados son:

- fecha_cita: Fecha programada de la cita.

- hora: Hora de la cita.

- motivo: Breve descripción del motivo de la visita.

- Mascota_idMascota: Llave foránea que indica qué mascota tiene la cita.

- Servicio_idServicio: Llave foránea que indica el tipo de servicio solicitado para esa cita.

🐾 Detalles de las Citas Registradas:

**Max** (id: 1)

Fecha: 2025-07-01

Hora: 09:00

Motivo: Revisión general anual

Servicio: Consulta general

**Luna** (id: 2)

Fecha: 2025-07-02

Hora: 10:30

Motivo: Aplicación de vacuna antirrábica

Servicio: Vacunación

**Toby** (id: 6)

Fecha: 2025-07-03

Hora: 14:00

Motivo: Desparasitación semestral

Servicio: Desparasitación

**Mila** (id: 4)

Fecha: 2025-07-04

Hora: 11:15

Motivo: Esterilización programada

Servicio: Esterilización

**Copo** (id: 10)

Fecha: 2025-07-05

Hora: 16:45

Motivo: Limpieza dental preventiva

Servicio: Limpieza dental

**Rocky** (id: 3)

Fecha: 2025-07-06

Hora: 08:30

Motivo: Chequeo postoperatorio

Servicio: Consulta general

**Nube** (id: 5)

Fecha: 2025-07-07

Hora: 13:00

Motivo: Vacuna de refuerzo triple felina

Servicio: Vacunación

**Kiwi** (id: 7)

Fecha: 2025-07-08

Hora: 15:30

Motivo: Desparasitación preventiva

Servicio: Desparasitación

**Spike** (id: 8)

Fecha: 2025-07-09

Hora: 10:45

Motivo: Consulta por cambio de comportamiento

Servicio: Consulta general

**Mango** (id: 9)

Fecha: 2025-07-10

Hora: 17:00

Motivo: Control de peso y revisión

Servicio: Consulta general

#### Tabla Tratamiento

```sql
INSERT INTO Tratamiento (nombre, observaciones, Cita_idCita)
VALUES
('Curación de herida', 'Se limpió la herida en la pata trasera y se aplicó vendaje. Se recomienda reposo por 3 días.', 6),
('Seguimiento vacunación', 'No se presentaron reacciones adversas. Se programó próxima dosis en 6 meses.', 7),
('Desparasitación interna', 'Administrado antiparasitario oral. Se recomienda repetir dosis en 3 semanas.', 8),
('Evaluación de comportamiento', 'Se observó actitud defensiva por cambios en el entorno. Se sugirió enriquecimiento ambiental.', 9),
('Chequeo metabólico', 'Peso adecuado. Se indicó ajuste leve en dieta por nivel de actividad bajo.', 10);
```

Objetivo:
Registrar en la base de datos los tratamientos que se han realizado a las mascotas durante sus respectivas citas veterinarias.

Campos utilizados:

- nombre: Describe brevemente el tratamiento realizado.

- observaciones: Detalla el procedimiento, hallazgos o recomendaciones posteriores al tratamiento.

- Cita_idCita: Llave foránea que enlaza cada tratamiento con una cita específica previamente registrada en la tabla Cita.

Explicación de las filas insertadas:

- Curación de herida (Cita 6): Se realizó atención a una herida en la pata trasera. Se recomendó reposo.

- Seguimiento vacunación (Cita 7): Se observó buena respuesta a la vacuna, sin efectos adversos.

- Desparasitación interna (Cita 8): Se administró tratamiento antiparasitario oral.

- Evaluación de comportamiento (Cita 9): Se diagnosticó cambio de comportamiento posiblemente por entorno.

- Chequeo metabólico (Cita 10): Revisión de peso y recomendación de ajuste en dieta.

**Importancia:**
Este registro permite llevar un historial clínico detallado de las mascotas, útil para seguimientos, nuevas consultas o auditorías veterinarias.


#### Tabla Vacunación

```sql
INSERT INTO Vacunacion (fecha_vacuna, enfermedad, Mascota_idMascota, Cita_idCita)
VALUES
('2025-07-01', 'Rabia', 1, 1),
('2025-07-02', 'Moquillo Canino', 3, 2),
('2025-07-03', 'Panleucopenia Felina', 2, 3),
('2025-07-04', 'Enfermedad Hemorrágica Viral', 6, 4),
('2025-07-05', 'Psitacosis', 7, 5);
```

Objetivo:
Registrar las vacunas administradas a las mascotas durante citas veterinarias, especificando la enfermedad cubierta, la fecha de vacunación y la relación con la cita correspondiente.

Campos utilizados:

- fecha_vacuna: Fecha en que se aplicó la vacuna.

- enfermedad: Enfermedad que previene la vacuna aplicada.

- Mascota_idMascota: Identificador de la mascota vacunada (llave foránea hacia Mascota).

- Cita_idCita: Relación con la cita durante la cual se administró la vacuna (llave foránea hacia Cita).

Descripción de los registros insertados:

- Rabia (Mascota 1, Cita 1): Se aplicó vacuna contra la rabia a Max.

- Moquillo Canino (Mascota 3, Cita 2): Vacunación preventiva para Rocky.

- Panleucopenia Felina (Mascota 2, Cita 3): Vacuna aplicada a Luna.

- Enfermedad Hemorrágica Viral (Mascota 6, Cita 4): Vacuna para Toby.

- Psitacosis (Mascota 7, Cita 5): Kiwi recibió la vacuna correspondiente a esta enfermedad aviar.

**Importancia:**
Este registro permite:

- Llevar un control histórico de vacunas aplicadas por mascota.

- Verificar cumplimiento del esquema de vacunación.

- Coordinar refuerzos y próximas aplicaciones.

- Garantizar la salud preventiva de los animales bajo cuidado.



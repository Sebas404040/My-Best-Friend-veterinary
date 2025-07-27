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
  <img src="./Readme_images/" alt="Diagrama UML del sistema veterinario" width="600"/>
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
1 : N → En una cita se pueden aplicar varios servicios.

- Cita 📅 – Tratamiento 💊
1 : N → Una cita puede incluir múltiples tratamientos.


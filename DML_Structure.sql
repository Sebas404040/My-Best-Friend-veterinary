INSERT INTO Dueno (cedula, nombre, telefono, direccion)
VALUES 
(1001001001, 'Carlos Ramírez', '3001234567', 'Cra 10 #20-45'),
(1002002002, 'Mariana López', '3109876543', 'Calle 85 #15-30'),
(1003003003, 'Luis Fernando Gómez', '3205557890', 'Av. Siempre Viva #123'),
(1004004004, 'Joan Sebastian Gómez', '3052349000', 'Av. Piedecusta Km 4'),
(1005005005, 'Luciana Gomez', '3249834021', 'Cra 20 #40-35');

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

INSERT INTO Servicio (nombre, descripcion, precio)
VALUES
('Consulta general', 'Revisión básica del estado de salud de la mascota.', 35000.00),
('Vacunación', 'Aplicación de vacunas preventivas contra enfermedades comunes.', 50000.00),
('Desparasitación', 'Tratamiento para eliminar parásitos internos y externos.', 30000.00),
('Esterilización', 'Procedimiento quirúrgico para esterilizar al animal.', 120000.00),
('Limpieza dental', 'Higiene bucal y remoción de sarro bajo sedación.', 80000.00);

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

INSERT INTO Tratamiento (nombre, observaciones, Cita_idCita)
VALUES
('Curación de herida', 'Se limpió la herida en la pata trasera y se aplicó vendaje. Se recomienda reposo por 3 días.', 6),
('Seguimiento vacunación', 'No se presentaron reacciones adversas. Se programó próxima dosis en 6 meses.', 7),
('Desparasitación interna', 'Administrado antiparasitario oral. Se recomienda repetir dosis en 3 semanas.', 8),
('Evaluación de comportamiento', 'Se observó actitud defensiva por cambios en el entorno. Se sugirió enriquecimiento ambiental.', 9),
('Chequeo metabólico', 'Peso adecuado. Se indicó ajuste leve en dieta por nivel de actividad bajo.', 10);

INSERT INTO Vacunacion (fecha_vacuna, enfermedad, Mascota_idMascota, Cita_idCita)
VALUES
('2025-07-01', 'Rabia', 1, 1),
('2025-07-02', 'Moquillo Canino', 3, 2),
('2025-07-03', 'Panleucopenia Felina', 2, 3),
('2025-07-04', 'Enfermedad Hemorrágica Viral', 6, 4),
('2025-07-05', 'Psitacosis', 7, 5);
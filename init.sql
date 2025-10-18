-- Script de inicialización de base de datos

-- Tabla FACULTAD
CREATE TABLE IF NOT EXISTS facultad (
    facultad_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    descripcion TEXT,
    ubicacion VARCHAR(100),
    decano VARCHAR(100),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla CARRERA
CREATE TABLE IF NOT EXISTS carrera (
    carrera_id SERIAL PRIMARY KEY,
    facultad_id INTEGER NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    duracion_semestres INTEGER NOT NULL,
    titulo_otorgado VARCHAR(100),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_facultad FOREIGN KEY (facultad_id) REFERENCES facultad(facultad_id) ON DELETE RESTRICT,
    CONSTRAINT uk_carrera_nombre UNIQUE (nombre)
);

-- Datos de prueba
INSERT INTO facultad (nombre, descripcion, ubicacion, decano) VALUES
('Ingeniería', 'Facultad de Ingeniería y Arquitectura', 'Edificio A', 'Dr. Juan Pérez'),
('Ciencias', 'Facultad de Ciencias Naturales', 'Edificio B', 'Dra. María González'),
('Medicina', 'Facultad de Medicina Humana', 'Edificio C', 'Dr. Carlos Ramírez'),
('Derecho', 'Facultad de Derecho y Ciencias Políticas', 'Edificio D', 'Dr. Roberto Sánchez'),
('Economía', 'Facultad de Ciencias Económicas y Empresariales', 'Edificio E', 'Dra. Ana Torres'),
('Educación', 'Facultad de Ciencias de la Educación', 'Edificio F', 'Dr. Luis Mendoza'),
('Arquitectura', 'Facultad de Arquitectura y Urbanismo', 'Edificio G', 'Arq. Patricia Vargas'),
('Comunicación', 'Facultad de Ciencias de la Comunicación', 'Edificio H', 'Dra. Carmen Flores')
ON CONFLICT DO NOTHING;

-- Datos de prueba para carreras
INSERT INTO carrera (facultad_id, nombre, descripcion, duracion_semestres, titulo_otorgado) VALUES
-- Carreras de Ingeniería (facultad_id = 1)
(1, 'Ingeniería de Sistemas', 'Carrera enfocada en desarrollo de sistemas de información y software', 10, 'Ingeniero de Sistemas'),
(1, 'Ingeniería Industrial', 'Carrera enfocada en optimización de procesos y gestión industrial', 10, 'Ingeniero Industrial'),
(1, 'Ingeniería Civil', 'Carrera enfocada en diseño y construcción de infraestructura', 10, 'Ingeniero Civil'),
(1, 'Ingeniería Electrónica', 'Carrera enfocada en sistemas electrónicos y telecomunicaciones', 10, 'Ingeniero Electrónico'),

-- Carreras de Ciencias (facultad_id = 2)
(2, 'Biología', 'Carrera enfocada en el estudio de los seres vivos', 10, 'Licenciado en Biología'),
(2, 'Química', 'Carrera enfocada en el estudio de la materia y sus transformaciones', 10, 'Licenciado en Química'),
(2, 'Física', 'Carrera enfocada en el estudio de las propiedades de la materia y energía', 10, 'Licenciado en Física'),
(2, 'Matemática', 'Carrera enfocada en el estudio de las estructuras abstractas', 10, 'Licenciado en Matemática'),

-- Carreras de Medicina (facultad_id = 3)
(3, 'Medicina Humana', 'Carrera enfocada en la prevención, diagnóstico y tratamiento de enfermedades', 14, 'Médico Cirujano'),
(3, 'Enfermería', 'Carrera enfocada en el cuidado integral de la salud', 10, 'Licenciado en Enfermería'),
(3, 'Obstetricia', 'Carrera enfocada en la salud reproductiva y materno-infantil', 10, 'Licenciado en Obstetricia'),

-- Carreras de Derecho (facultad_id = 4)
(4, 'Derecho', 'Carrera enfocada en el estudio del sistema jurídico y legal', 12, 'Abogado'),
(4, 'Ciencia Política', 'Carrera enfocada en el análisis de sistemas políticos', 10, 'Licenciado en Ciencia Política'),

-- Carreras de Economía (facultad_id = 5)
(5, 'Economía', 'Carrera enfocada en el análisis económico y financiero', 10, 'Economista'),
(5, 'Administración de Empresas', 'Carrera enfocada en la gestión empresarial', 10, 'Licenciado en Administración'),
(5, 'Contabilidad', 'Carrera enfocada en el registro y análisis contable', 10, 'Contador Público'),

-- Carreras de Educación (facultad_id = 6)
(6, 'Educación Primaria', 'Carrera enfocada en la enseñanza en nivel primario', 10, 'Licenciado en Educación Primaria'),
(6, 'Educación Inicial', 'Carrera enfocada en la enseñanza en nivel inicial', 10, 'Licenciado en Educación Inicial'),
(6, 'Educación Secundaria', 'Carrera enfocada en la enseñanza en nivel secundario', 10, 'Licenciado en Educación Secundaria'),

-- Carreras de Arquitectura (facultad_id = 7)
(7, 'Arquitectura', 'Carrera enfocada en diseño arquitectónico y urbanismo', 12, 'Arquitecto'),
(7, 'Diseño de Interiores', 'Carrera enfocada en diseño de espacios interiores', 10, 'Licenciado en Diseño de Interiores'),

-- Carreras de Comunicación (facultad_id = 8)
(8, 'Ciencias de la Comunicación', 'Carrera enfocada en medios y comunicación social', 10, 'Licenciado en Comunicación'),
(8, 'Periodismo', 'Carrera enfocada en el periodismo y medios informativos', 10, 'Licenciado en Periodismo'),
(8, 'Publicidad', 'Carrera enfocada en marketing y publicidad', 10, 'Licenciado en Publicidad')
ON CONFLICT DO NOTHING;

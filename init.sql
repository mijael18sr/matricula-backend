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

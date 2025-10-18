-# Sistema de Matrícula - Backend (Dockerizado)

Sistema de gestión de matrículas desarrollado con Spring Boot 3.5.6, PostgreSQL y Docker.

## 🏗️ Arquitectura

- **Arquitectura por Capas** (Controller → Service → Repository)
- **Principios SOLID**
- **MapStruct** para mapeo de DTOs
- **Lombok** para reducir código boilerplate
- **Docker Compose** para orquestación de servicios

## 🚀 Requisitos Previos

- Docker Desktop 20.x o superior
- Docker Compose 2.x o superior
- Java 21 (solo para desarrollo local sin Docker)
- Maven 3.9+ (solo para desarrollo local sin Docker)

## 📦 Estructura del Proyecto

```
matricula-backend/
├── src/
│   ├── main/
│   │   ├── java/org/softprimesolutions/matriculabackend/
│   │   │   ├── controller/      # Controladores REST
│   │   │   ├── service/         # Lógica de negocio
│   │   │   ├── repository/      # Acceso a datos
│   │   │   ├── entity/          # Entidades JPA
│   │   │   ├── dto/             # DTOs (request/response)
│   │   │   ├── mapper/          # MapStruct mappers
│   │   │   └── exception/       # Manejo de excepciones
│   │   └── resources/
│   │       └── application.yml  # Configuración Spring
├── Dockerfile                   # Multi-stage build
├── docker-compose.yaml          # Orquestación Docker
├── .env                         # Variables de entorno
├── .env.example                 # Template de variables
├── init.sql                     # Script inicial de BD
└── pom.xml                      # Dependencias Maven
```

## 🐳 Dockerización

### Servicios Configurados

1. **PostgreSQL 15-alpine**
   - Puerto: 5432
   - Base de datos: `matricula_db`
   - Usuario: `matricula_user`
   - Inicialización automática con `init.sql`

2. **Backend Spring Boot**
   - Puerto: 8080
   - Contexto: `/api`
   - Build multi-stage (Maven + JRE)
   - Healthcheck configurado

## 🚀 Comandos Docker

### 1️⃣ Primera vez (Construir e iniciar)

```bash
docker-compose up --build
```

### 2️⃣ Iniciar servicios (contenedores ya construidos)

```bash
docker-compose up
```

### 3️⃣ Iniciar en modo detached (segundo plano)

```bash
docker-compose up -d
```

### 4️⃣ Ver logs en tiempo real

```bash
# Todos los servicios
docker-compose logs -f

# Solo backend
docker-compose logs -f backend

# Solo base de datos
docker-compose logs -f postgres
```

### 5️⃣ Detener servicios

```bash
docker-compose down
```

### 6️⃣ Detener y eliminar volúmenes (CUIDADO: borra la BD)

```bash
docker-compose down -v
```

### 7️⃣ Reconstruir solo el backend

```bash
docker-compose build backend
docker-compose up -d backend
```

### 8️⃣ Ver estado de contenedores

```bash
docker-compose ps
```

## 🔧 Configuración de Variables de Entorno

Copia el archivo `.env.example` a `.env` y ajusta los valores:

```bash
cp .env.example .env
```

Variables disponibles:

```env
POSTGRES_DB=matricula_db
POSTGRES_USER=matricula_user
POSTGRES_PASSWORD=matricula_password
POSTGRES_PORT=5432

SPRING_DATASOURCE_URL=jdbc:postgresql://postgres:5432/matricula_db
SPRING_DATASOURCE_USERNAME=matricula_user
SPRING_DATASOURCE_PASSWORD=matricula_password
SERVER_PORT=8080
```

## 📡 Endpoints API

Base URL: `http://localhost:8080/api`

### Facultades

- `GET    /api/facultades` - Listar todas
- `GET    /api/facultades/{id}` - Obtener por ID
- `POST   /api/facultades` - Crear nueva
- `PUT    /api/facultades/{id}` - Actualizar
- `DELETE /api/facultades/{id}` - Eliminar

### Carreras

- `GET    /api/carreras` - Listar todas
- `GET    /api/carreras/{id}` - Obtener por ID
- `POST   /api/carreras` - Crear nueva
- `PUT    /api/carreras/{id}` - Actualizar
- `DELETE /api/carreras/{id}` - Eliminar

## 🧪 Probar la API

### Con curl (Windows CMD)

```bash
# Listar facultades
curl http://localhost:8080/api/facultades

# Crear facultad
curl -X POST http://localhost:8080/api/facultades ^
  -H "Content-Type: application/json" ^
  -d "{\"nombre\":\"Ingeniería Industrial\",\"descripcion\":\"Facultad de Ingeniería Industrial\"}"
```

### Con PowerShell

```powershell
# Listar facultades
Invoke-RestMethod -Uri http://localhost:8080/api/facultades -Method GET

# Crear facultad
$body = @{
    nombre = "Ingeniería Industrial"
    descripcion = "Facultad de Ingeniería Industrial"
} | ConvertTo-Json

Invoke-RestMethod -Uri http://localhost:8080/api/facultades -Method POST -Body $body -ContentType "application/json"
```

## 🗄️ Base de Datos

### Conectarse a PostgreSQL

```bash
docker exec -it matricula-postgres psql -U matricula_user -d matricula_db
```

### Comandos útiles en psql

```sql
-- Ver tablas
\dt

-- Describir tabla
\d facultad

-- Consultar facultades
SELECT * FROM facultad;

-- Salir
\q
```

## 🔍 Troubleshooting

### Error: Puerto 8080 ya está en uso

```bash
# Windows - Liberar puerto
netstat -ano | findstr :8080
taskkill /PID <PID> /F
```

### Error: No se puede conectar a la base de datos

```bash
# Verificar que postgres esté saludable
docker-compose ps

# Ver logs de postgres
docker-compose logs postgres

# Reiniciar servicios
docker-compose restart
```

### Reconstruir desde cero

```bash
# Detener todo
docker-compose down -v

# Limpiar imágenes huérfanas
docker system prune -f

# Reconstruir
docker-compose up --build
```

## 📚 Tecnologías Utilizadas

- **Spring Boot 3.5.6**
- **Java 21**
- **PostgreSQL 15**
- **Spring Data JPA**
- **MapStruct 1.5.5**
- **Lombok**
- **Maven**
- **Docker & Docker Compose**

## 🎯 Principios Aplicados

- ✅ **SOLID** - Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion
- ✅ **Arquitectura por Capas** - Separación de responsabilidades
- ✅ **Clean Code** - Código limpio y mantenible
- ✅ **RESTful API** - Diseño de APIs REST
- ✅ **DTO Pattern** - Separación de datos de entrada/salida

## 👨‍💻 Desarrollo Local (Sin Docker)

Si prefieres ejecutar sin Docker:

```bash
# 1. Iniciar PostgreSQL localmente en puerto 5432

# 2. Actualizar .env con localhost
SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/matricula_db

# 3. Compilar y ejecutar
mvnw spring-boot:run
```

## 📝 Notas

- El archivo `init.sql` se ejecuta automáticamente al crear el contenedor de PostgreSQL
- Los datos se persisten en el volumen Docker `postgres_data`
- El backend espera a que PostgreSQL esté saludable antes de iniciar (healthcheck)
- Para producción, cambiar las credenciales en `.env`

---

**Desarrollado con ❤️ usando Spring Boot + Docker**

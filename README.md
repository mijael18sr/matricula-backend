# 🚀 Sistema de Matrícula - Backend

Sistema CRUD para gestión de Facultades y Carreras con Docker.

---

## 📋 Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:

- ✅ **Docker Desktop** (versión 20.x o superior)
- ✅ **Git**

---

## ⚡ Pasos para Clonar y Ejecutar el Proyecto

### 1️⃣ Clonar el Repositorio

```bash
git clone <url-del-repositorio-gitlab>
cd matricula-backend
```

### 2️⃣ Levantar los Contenedores

Ejecuta el siguiente comando para construir y levantar los servicios:

```bash
docker compose up -d
```

> **¿Qué hace este comando?**
> - Descarga las imágenes de PostgreSQL y Java
> - Construye la imagen del backend
> - Inicia PostgreSQL en el puerto 5433
> - Inicia el backend en el puerto 8080
> - Crea la base de datos con datos de prueba

**Espera aproximadamente 2-3 minutos** mientras se construye la imagen (solo la primera vez).

### 3️⃣ Verificar que Todo Esté Funcionando

Verifica el estado de los contenedores:

```bash
docker compose ps
```

Deberías ver algo como:

```
NAME                 STATUS                   PORTS
matricula-backend    Up (healthy)            0.0.0.0:8080->8080/tcp
matricula-postgres   Up (healthy)            0.0.0.0:5433->5432/tcp
```

### 4️⃣ Ver los Logs (Opcional)

Para ver los logs del backend en tiempo real:

```bash
docker compose logs -f backend
```

Presiona `Ctrl+C` para salir de los logs.

---

## 🎯 Probar el API

Una vez que los contenedores estén ejecutándose, puedes probar el API:

### Verificar Health Check

Abre tu navegador y visita:
```
http://localhost:8080/api/actuator/health
```

Deberías ver:
```json
{"status":"UP"}
```

### Probar Endpoints con PowerShell

Ejecuta el script de pruebas:

```powershell
powershell -ExecutionPolicy Bypass -File test-api.ps1
```

### Probar con CURL (Manual)

**Listar todas las facultades:**
```bash
curl http://localhost:8080/api/v1/facultades
```

**Crear una facultad:**
```bash
curl -X POST http://localhost:8080/api/v1/facultades \
  -H "Content-Type: application/json" \
  -d "{\"nombre\":\"Facultad de Ingenieria\",\"descripcion\":\"Facultad de Ingenieria\",\"ubicacion\":\"Edificio A\",\"decano\":\"Dr. Juan Perez\",\"activo\":true}"
```

---

## 🛑 Detener el Proyecto

Para detener los contenedores:

```bash
docker compose down
```

Para detener y **eliminar también los volúmenes** (base de datos):

```bash
docker compose down -v
```

---

## 📋 Endpoints Disponibles

### **Base URL:** `http://localhost:8080/api`

### Facultades

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| POST   | `/v1/facultades` | Crear facultad |
| GET    | `/v1/facultades` | Listar todas |
| GET    | `/v1/facultades?soloActivos=true` | Listar activas |
| GET    | `/v1/facultades/{id}` | Obtener por ID |
| PUT    | `/v1/facultades/{id}` | Actualizar |
| PATCH  | `/v1/facultades/{id}/desactivar` | Desactivar |
| DELETE | `/v1/facultades/{id}` | Eliminar |

### Carreras

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| POST   | `/v1/carreras` | Crear carrera |
| GET    | `/v1/carreras` | Listar todas |
| GET    | `/v1/carreras?soloActivos=true` | Listar activas |
| GET    | `/v1/carreras?facultadId=1` | Por facultad |
| GET    | `/v1/carreras/{id}` | Obtener por ID |
| PUT    | `/v1/carreras/{id}` | Actualizar |
| PATCH  | `/v1/carreras/{id}/desactivar` | Desactivar |
| DELETE | `/v1/carreras/{id}` | Eliminar |

---

## 🔧 Configuración

### Puertos Utilizados

- **Backend:** `8080`
- **PostgreSQL:** `5433` (externo) / `5432` (interno Docker)

### Credenciales de Base de Datos

- **Host:** `localhost`
- **Puerto:** `5433`
- **Base de datos:** `matricula_db`
- **Usuario:** `matricula_user`
- **Contraseña:** `matricula_password`

> **Nota:** Puedes conectarte con cualquier cliente PostgreSQL (DBeaver, pgAdmin, etc.)

---

## 🏗️ Arquitectura del Proyecto

### Capas del Sistema

```
┌─────────────────────────────────────────┐
│         CONTROLLER LAYER                │
│  (CarreraController, FacultadController)│
├─────────────────────────────────────────┤
│            DTO LAYER                    │
│    (Request DTOs / Response DTOs)       │
├─────────────────────────────────────────┤
│          SERVICE LAYER                  │
│ (CarreraService, FacultadService)       │
├─────────────────────────────────────────┤
│          MAPPER LAYER                   │
│      (MapStruct Mappers)                │
├─────────────────────────────────────────┤
│        REPOSITORY LAYER                 │
│      (Spring Data JPA)                  │
├─────────────────────────────────────────┤
│          ENTITY LAYER                   │
│     (Carrera, Facultad)                 │
└─────────────────────────────────────────┘
```

### Principios SOLID Aplicados

- ✅ **Single Responsibility:** Cada clase tiene una única responsabilidad
- ✅ **Open/Closed:** Uso de interfaces extensibles
- ✅ **Liskov Substitution:** Implementaciones intercambiables
- ✅ **Interface Segregation:** Interfaces específicas por servicio
- ✅ **Dependency Inversion:** Inyección de dependencias con Spring

---

## 💻 Tecnologías

- **Java:** 21
- **Spring Boot:** 3.5.6
- **PostgreSQL:** 15 Alpine
- **MapStruct:** 1.5.5
- **Lombok**
- **Docker & Docker Compose**
- **Undertow** (servidor web optimizado)

---

## 🐛 Solución de Problemas

### El puerto 5433 está ocupado

Si ves un error como `port is already allocated`, cambia el puerto en el archivo `.env`:

```env
POSTGRES_PORT=5434  # O cualquier otro puerto disponible
```

Luego reinicia:
```bash
docker compose down
docker compose up -d
```

### Los contenedores no inician

1. Verifica que Docker Desktop esté ejecutándose
2. Revisa los logs:
   ```bash
   docker compose logs
   ```

### Error de conexión a la base de datos

Espera unos segundos más, PostgreSQL tarda en inicializarse. Verifica con:
```bash
docker compose logs postgres
```

---

## 📚 Documentación Adicional

- Ver ejemplos de uso del API: `API_EXAMPLES.md`
- Probar endpoints automáticamente: `test-api.ps1`
- Scripts de utilidad: `start-docker.bat`, `stop-docker.bat`, `logs-docker.bat`

---

## ✅ Checklist de Implementación

- ✅ Arquitectura por capas
- ✅ Principios SOLID
- ✅ Docker optimizado (225MB)
- ✅ DTOs separados (Request/Response)
- ✅ MapStruct para mapeo
- ✅ Manejo global de excepciones
- ✅ Validaciones con Bean Validation
- ✅ Variables de entorno (.env)
- ✅ Health checks configurados

---

## 🎉 ¡Listo!

Tu proyecto está funcionando. Ahora puedes:

1. ✅ Desarrollar nuevas funcionalidades
2. ✅ Probar los endpoints del API
3. ✅ Conectarte a la base de datos
4. ✅ Revisar los logs en tiempo real

**¿Necesitas ayuda?** Revisa la sección de solución de problemas o consulta los archivos de documentación.

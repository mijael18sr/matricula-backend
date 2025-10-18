<<<<<<< HEAD
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
=======
# matricula-backend



## Getting started

To make it easy for you to get started with GitLab, here's a list of recommended next steps.

Already a pro? Just edit this README.md and make it your own. Want to make it easy? [Use the template at the bottom](#editing-this-readme)!

## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/topics/git/add_files/#add-files-to-a-git-repository) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://gitlab.com/matricula-universidad-capas/matricula-backend.git
git branch -M main
git push -uf origin main
```

## Integrate with your tools

- [ ] [Set up project integrations](https://gitlab.com/matricula-universidad-capas/matricula-backend/-/settings/integrations)

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Set auto-merge](https://docs.gitlab.com/user/project/merge_requests/auto_merge/)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing (SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***

# Editing this README

When you're ready to make this README your own, just edit this file and use the handy template below (or feel free to structure it however you want - this is just a starting point!). Thanks to [makeareadme.com](https://www.makeareadme.com/) for this template.

## Suggestions for a good README

Every project is different, so consider which of these sections apply to yours. The sections used in the template are suggestions for most open source projects. Also keep in mind that while a README can be too long and detailed, too long is better than too short. If you think your README is too long, consider utilizing another form of documentation rather than cutting out information.

## Name
Choose a self-explaining name for your project.

## Description
Let people know what your project can do specifically. Provide context and add a link to any reference visitors might be unfamiliar with. A list of Features or a Background subsection can also be added here. If there are alternatives to your project, this is a good place to list differentiating factors.

## Badges
On some READMEs, you may see small images that convey metadata, such as whether or not all the tests are passing for the project. You can use Shields to add some to your README. Many services also have instructions for adding a badge.

## Visuals
Depending on what you are making, it can be a good idea to include screenshots or even a video (you'll frequently see GIFs rather than actual videos). Tools like ttygif can help, but check out Asciinema for a more sophisticated method.

## Installation
Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew. However, consider the possibility that whoever is reading your README is a novice and would like more guidance. Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible. If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.

## Usage
Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Support
Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.

## Roadmap
If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing
State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## License
For open source projects, say how it is licensed.

## Project status
If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.
>>>>>>> 37a81c8602bca53e658b921f3b65e9ce48404d06

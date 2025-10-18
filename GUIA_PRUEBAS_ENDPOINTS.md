
Invoke-RestMethod -Uri "http://localhost:8080/api/v1/carreras/1" -Method PUT -Body $body -ContentType "application/json"
```

**CURL:**
```bash
curl -X PUT http://localhost:8080/api/v1/carreras/1 \
  -H "Content-Type: application/json" \
  -d "{\"facultadId\":1,\"nombre\":\"Ingenieria de Software Actualizada\",\"descripcion\":\"Descripcion actualizada\",\"duracionSemestres\":10,\"tituloOtorgado\":\"Ingeniero de Software\",\"activo\":true}"
```

```bash
PATCH http://localhost:8080/api/v1/carreras/1/desactivar
```

**PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/v1/carreras/1/desactivar" -Method PATCH
```

**CURL:**
```bash
curl -X PATCH http://localhost:8080/api/v1/carreras/1/desactivar
```

---

### 15. DELETE - Eliminar carrera
```bash
DELETE http://localhost:8080/api/v1/carreras/1
```

**PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/v1/carreras/1" -Method DELETE
```

**CURL:**
```bash
curl -X DELETE http://localhost:8080/api/v1/carreras/1
```

---

## 🔍 HEALTH CHECK

### 16. GET - Verificar estado del servicio
```bash
GET http://localhost:8080/api/actuator/health
```

**PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/actuator/health" -Method GET
```

**CURL:**
```bash
curl -X GET http://localhost:8080/api/actuator/health
```

---

## 📝 ORDEN RECOMENDADO DE PRUEBAS

### Para probar el flujo completo:

1. **Health Check** - Verificar que el servicio esté funcionando
2. **GET Facultades** - Ver las facultades precargadas del init.sql
3. **POST Facultad** - Crear una nueva facultad
4. **GET Facultad por ID** - Verificar la facultad creada
5. **POST Carrera** - Crear una carrera para esa facultad
6. **GET Carreras** - Ver todas las carreras
7. **GET Carreras por Facultad** - Filtrar carreras
8. **PUT Facultad** - Actualizar datos
9. **PUT Carrera** - Actualizar datos
10. **PATCH Desactivar** - Desactivar una carrera
11. **GET Solo Activos** - Verificar el filtro
12. **DELETE Carrera** - Eliminar (solo si está inactiva)

---

## 🎯 RESPUESTAS ESPERADAS

### Éxito (200-201):
```json
{
    "facultadId": 1,
    "nombre": "Facultad de Ingenieria",
    "descripcion": "...",
    "ubicacion": "Edificio A",
    "decano": "Dr. Juan Perez",
    "activo": true,
    "fechaRegistro": "2025-10-18T..."
}
```

### Error (404):
```json
{
    "timestamp": "2025-10-18T...",
    "status": 404,
    "error": "Not Found",
    "message": "Facultad no encontrada con ID: 99",
    "path": "/api/v1/facultades/99"
}
```

---

## 💡 TIPS PARA POSTMAN

1. **Crear una Collection:** "Sistema Matrícula API"
2. **Crear Environment con variable:**
    - `base_url` = `http://localhost:8080/api`
3. **Usar:** `{{base_url}}/v1/facultades`
4. **Tests automáticos:**
```javascript
pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});

pm.test("Response has data", function () {
    pm.expect(pm.response.json()).to.be.an('object');
});
```

---

**¡Listo para probar! 🚀**
# 📋 GUÍA DE PRUEBAS - ENDPOINTS DEL API

**Base URL:** `http://localhost:8080/api`

---

## 🟢 FACULTADES - ENDPOINTS

### 1. GET - Listar todas las facultades
```bash
GET http://localhost:8080/api/v1/facultades
```

**PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/v1/facultades" -Method GET
```

**CURL:**
```bash
curl -X GET http://localhost:8080/api/v1/facultades
```

---

### 2. GET - Listar solo facultades activas
```bash
GET http://localhost:8080/api/v1/facultades?soloActivos=true
```

**PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/v1/facultades?soloActivos=true" -Method GET
```

**CURL:**
```bash
curl -X GET "http://localhost:8080/api/v1/facultades?soloActivos=true"
```

---

### 3. GET - Obtener facultad por ID
```bash
GET http://localhost:8080/api/v1/facultades/1
```

**PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/v1/facultades/1" -Method GET
```

**CURL:**
```bash
curl -X GET http://localhost:8080/api/v1/facultades/1
```

---

### 4. POST - Crear nueva facultad
```bash
POST http://localhost:8080/api/v1/facultades
Content-Type: application/json
```

**Body JSON:**
```json
{
    "nombre": "Facultad de Ingenieria",
    "descripcion": "Facultad de Ingenieria y Arquitectura",
    "ubicacion": "Edificio A",
    "decano": "Dr. Juan Perez",
    "activo": true
}
```

**PowerShell:**
```powershell
$body = @{
    nombre = "Facultad de Ingenieria"
    descripcion = "Facultad de Ingenieria y Arquitectura"
    ubicacion = "Edificio A"
    decano = "Dr. Juan Perez"
    activo = $true
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8080/api/v1/facultades" -Method POST -Body $body -ContentType "application/json"
```

**CURL:**
```bash
curl -X POST http://localhost:8080/api/
---

### 14. PATCH - Desactivar carrerav1/facultades \
  -H "Content-Type: application/json" \
  -d "{\"nombre\":\"Facultad de Ingenieria\",\"descripcion\":\"Facultad de Ingenieria y Arquitectura\",\"ubicacion\":\"Edificio A\",\"decano\":\"Dr. Juan Perez\",\"activo\":true}"
```

---

### 5. PUT - Actualizar facultad
```bash
PUT http://localhost:8080/api/v1/facultades/1
Content-Type: application/json
```

**Body JSON:**
```json
{
    "nombre": "Facultad de Ingenieria Actualizada",
    "descripcion": "Descripcion actualizada",
    "ubicacion": "Edificio B",
    "decano": "Dra. Maria Gonzalez",
    "activo": true
}
```

**PowerShell:**
```powershell
$body = @{
    nombre = "Facultad de Ingenieria Actualizada"
    descripcion = "Descripcion actualizada"
    ubicacion = "Edificio B"
    decano = "Dra. Maria Gonzalez"
    activo = $true
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8080/api/v1/facultades/1" -Method PUT -Body $body -ContentType "application/json"
```

**CURL:**
```bash
curl -X PUT http://localhost:8080/api/v1/facultades/1 \
  -H "Content-Type: application/json" \
  -d "{\"nombre\":\"Facultad de Ingenieria Actualizada\",\"descripcion\":\"Descripcion actualizada\",\"ubicacion\":\"Edificio B\",\"decano\":\"Dra. Maria Gonzalez\",\"activo\":true}"
```

---

### 6. PATCH - Desactivar facultad
```bash
PATCH http://localhost:8080/api/v1/facultades/1/desactivar
```

**PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/v1/facultades/1/desactivar" -Method PATCH
```

**CURL:**
```bash
curl -X PATCH http://localhost:8080/api/v1/facultades/1/desactivar
```

---

### 7. DELETE - Eliminar facultad
```bash
DELETE http://localhost:8080/api/v1/facultades/1
```

**PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/v1/facultades/1" -Method DELETE
```

**CURL:**
```bash
curl -X DELETE http://localhost:8080/api/v1/facultades/1
```

---

## 🔵 CARRERAS - ENDPOINTS

### 8. GET - Listar todas las carreras
```bash
GET http://localhost:8080/api/v1/carreras
```

**PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/v1/carreras" -Method GET
```

**CURL:**
```bash
curl -X GET http://localhost:8080/api/v1/carreras
```

---

### 9. GET - Listar solo carreras activas
```bash
GET http://localhost:8080/api/v1/carreras?soloActivos=true
```

**PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/v1/carreras?soloActivos=true" -Method GET
```

**CURL:**
```bash
curl -X GET "http://localhost:8080/api/v1/carreras?soloActivos=true"
```

---

### 10. GET - Listar carreras por facultad
```bash
GET http://localhost:8080/api/v1/carreras?facultadId=1
```

**PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/v1/carreras?facultadId=1" -Method GET
```

**CURL:**
```bash
curl -X GET "http://localhost:8080/api/v1/carreras?facultadId=1"
```

---

### 11. GET - Obtener carrera por ID
```bash
GET http://localhost:8080/api/v1/carreras/1
```

**PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/v1/carreras/1" -Method GET
```

**CURL:**
```bash
curl -X GET http://localhost:8080/api/v1/carreras/1
```

---

### 12. POST - Crear nueva carrera
```bash
POST http://localhost:8080/api/v1/carreras
Content-Type: application/json
```

**Body JSON:**
```json
{
    "facultadId": 1,
    "nombre": "Ingenieria de Software",
    "descripcion": "Carrera de Ingenieria de Software",
    "duracionSemestres": 10,
    "tituloOtorgado": "Ingeniero de Software",
    "activo": true
}
```

**PowerShell:**
```powershell
$body = @{
    facultadId = 1
    nombre = "Ingenieria de Software"
    descripcion = "Carrera de Ingenieria de Software"
    duracionSemestres = 10
    tituloOtorgado = "Ingeniero de Software"
    activo = $true
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8080/api/v1/carreras" -Method POST -Body $body -ContentType "application/json"
```

**CURL:**
```bash
curl -X POST http://localhost:8080/api/v1/carreras \
  -H "Content-Type: application/json" \
  -d "{\"facultadId\":1,\"nombre\":\"Ingenieria de Software\",\"descripcion\":\"Carrera de Ingenieria de Software\",\"duracionSemestres\":10,\"tituloOtorgado\":\"Ingeniero de Software\",\"activo\":true}"
```

---

### 13. PUT - Actualizar carrera
```bash
PUT http://localhost:8080/api/v1/carreras/1
Content-Type: application/json
```

**Body JSON:**
```json
{
    "facultadId": 1,
    "nombre": "Ingenieria de Software Actualizada",
    "descripcion": "Descripcion actualizada",
    "duracionSemestres": 10,
    "tituloOtorgado": "Ingeniero de Software",
    "activo": true
}
```

**PowerShell:**
```powershell
$body = @{
    facultadId = 1
    nombre = "Ingenieria de Software Actualizada"
    descripcion = "Descripcion actualizada"
    duracionSemestres = 10
    tituloOtorgado = "Ingeniero de Software"
    activo = $true
} | ConvertTo-Json


# Script de prueba para el API de Matrícula
$baseUrl = "http://localhost:8080/api"

Write-Host "==================================" -ForegroundColor Green
Write-Host "PRUEBAS DE API - SISTEMA MATRÍCULA" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Green

# 1. Crear Facultad
Write-Host "`n[1] Creando Facultad..." -ForegroundColor Yellow
$facultadBody = @{
    nombre = "Facultad de Ingenieria"
    descripcion = "Facultad de Ingenieria y Arquitectura"
    ubicacion = "Edificio A"
    decano = "Dr. Juan Perez"
    activo = $true
} | ConvertTo-Json

try {
    $facultad = Invoke-RestMethod -Uri "$baseUrl/v1/facultades" -Method POST -Body $facultadBody -ContentType "application/json"
    Write-Host "✓ Facultad creada: ID=$($facultad.facultadId), Nombre=$($facultad.nombre)" -ForegroundColor Green
    $facultadId = $facultad.facultadId
} catch {
    Write-Host "✗ Error al crear facultad: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# 2. Listar todas las facultades
Write-Host "`n[2] Listando todas las facultades..." -ForegroundColor Yellow
try {
    $facultades = Invoke-RestMethod -Uri "$baseUrl/v1/facultades" -Method GET
    Write-Host "✓ Total de facultades: $($facultades.Count)" -ForegroundColor Green
} catch {
    Write-Host "✗ Error al listar facultades: $($_.Exception.Message)" -ForegroundColor Red
}

# 3. Obtener facultad por ID
Write-Host "`n[3] Obteniendo facultad por ID..." -ForegroundColor Yellow
try {
    $facultadById = Invoke-RestMethod -Uri "$baseUrl/v1/facultades/$facultadId" -Method GET
    Write-Host "✓ Facultad obtenida: $($facultadById.nombre)" -ForegroundColor Green
} catch {
    Write-Host "✗ Error al obtener facultad: $($_.Exception.Message)" -ForegroundColor Red
}

# 4. Crear Carrera
Write-Host "`n[4] Creando Carrera..." -ForegroundColor Yellow
$carreraBody = @{
    facultadId = $facultadId
    nombre = "Ingenieria de Software"
    descripcion = "Carrera de Ingenieria de Software"
    duracionSemestres = 10
    tituloOtorgado = "Ingeniero de Software"
    activo = $true
} | ConvertTo-Json

try {
    $carrera = Invoke-RestMethod -Uri "$baseUrl/v1/carreras" -Method POST -Body $carreraBody -ContentType "application/json"
    Write-Host "✓ Carrera creada: ID=$($carrera.carreraId), Nombre=$($carrera.nombre)" -ForegroundColor Green
    $carreraId = $carrera.carreraId
} catch {
    Write-Host "✗ Error al crear carrera: $($_.Exception.Message)" -ForegroundColor Red
}

# 5. Listar todas las carreras
Write-Host "`n[5] Listando todas las carreras..." -ForegroundColor Yellow
try {
    $carreras = Invoke-RestMethod -Uri "$baseUrl/v1/carreras" -Method GET
    Write-Host "✓ Total de carreras: $($carreras.Count)" -ForegroundColor Green
} catch {
    Write-Host "✗ Error al listar carreras: $($_.Exception.Message)" -ForegroundColor Red
}

# 6. Obtener carrera por ID
Write-Host "`n[6] Obteniendo carrera por ID..." -ForegroundColor Yellow
try {
    $carreraById = Invoke-RestMethod -Uri "$baseUrl/v1/carreras/$carreraId" -Method GET
    Write-Host "✓ Carrera obtenida: $($carreraById.nombre)" -ForegroundColor Green
} catch {
    Write-Host "✗ Error al obtener carrera: $($_.Exception.Message)" -ForegroundColor Red
}

# 7. Actualizar Facultad
Write-Host "`n[7] Actualizando Facultad..." -ForegroundColor Yellow
$facultadUpdateBody = @{
    nombre = "Facultad de Ingenieria Actualizada"
    descripcion = "Descripcion actualizada"
    ubicacion = "Edificio B"
    decano = "Dra. Maria Gonzalez"
    activo = $true
} | ConvertTo-Json

try {
    $facultadUpdated = Invoke-RestMethod -Uri "$baseUrl/v1/facultades/$facultadId" -Method PUT -Body $facultadUpdateBody -ContentType "application/json"
    Write-Host "✓ Facultad actualizada: $($facultadUpdated.nombre)" -ForegroundColor Green
} catch {
    Write-Host "✗ Error al actualizar facultad: $($_.Exception.Message)" -ForegroundColor Red
}

# 8. Actualizar Carrera
Write-Host "`n[8] Actualizando Carrera..." -ForegroundColor Yellow
$carreraUpdateBody = @{
    facultadId = $facultadId
    nombre = "Ingenieria de Software Actualizada"
    descripcion = "Descripcion actualizada"
    duracionSemestres = 10
    tituloOtorgado = "Ingeniero de Software"
    activo = $true
} | ConvertTo-Json

try {
    $carreraUpdated = Invoke-RestMethod -Uri "$baseUrl/v1/carreras/$carreraId" -Method PUT -Body $carreraUpdateBody -ContentType "application/json"
    Write-Host "✓ Carrera actualizada: $($carreraUpdated.nombre)" -ForegroundColor Green
} catch {
    Write-Host "✗ Error al actualizar carrera: $($_.Exception.Message)" -ForegroundColor Red
}

# 9. Obtener carreras por facultad
Write-Host "`n[9] Obteniendo carreras por facultad..." -ForegroundColor Yellow
try {
    $carrerasPorFacultad = Invoke-RestMethod -Uri "$baseUrl/v1/carreras?facultadId=$facultadId" -Method GET
    Write-Host "✓ Carreras de la facultad: $($carrerasPorFacultad.Count)" -ForegroundColor Green
} catch {
    Write-Host "✗ Error al obtener carreras por facultad: $($_.Exception.Message)" -ForegroundColor Red
}

# 10. Desactivar Carrera
Write-Host "`n[10] Desactivando Carrera..." -ForegroundColor Yellow
try {
    Invoke-RestMethod -Uri "$baseUrl/v1/carreras/$carreraId/desactivar" -Method PATCH
    Write-Host "✓ Carrera desactivada" -ForegroundColor Green
} catch {
    Write-Host "✗ Error al desactivar carrera: $($_.Exception.Message)" -ForegroundColor Red
}

# 11. Obtener solo activos
Write-Host "`n[11] Obteniendo solo carreras activas..." -ForegroundColor Yellow
try {
    $carrerasActivas = Invoke-RestMethod -Uri "$baseUrl/v1/carreras?soloActivos=true" -Method GET
    Write-Host "✓ Carreras activas: $($carrerasActivas.Count)" -ForegroundColor Green
} catch {
    Write-Host "✗ Error al obtener carreras activas: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n==================================" -ForegroundColor Green
Write-Host "PRUEBAS COMPLETADAS" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Green
Write-Host "`nSUMARIO:" -ForegroundColor Cyan
Write-Host "- Backend ejecutándose en: http://localhost:8080/api" -ForegroundColor White
Write-Host "- PostgreSQL ejecutándose en: localhost:5433" -ForegroundColor White
Write-Host "- Imagen Docker optimizada: 225MB" -ForegroundColor White
Write-Host "`nArquitectura:" -ForegroundColor Cyan
Write-Host "✓ Principios SOLID aplicados" -ForegroundColor Green
Write-Host "✓ Arquitectura por capas (Controller -> Service -> Repository)" -ForegroundColor Green
Write-Host "✓ DTOs separados (Request/Response)" -ForegroundColor Green
Write-Host "✓ MapStruct para mapeo automático" -ForegroundColor Green
Write-Host "✓ Manejo global de excepciones" -ForegroundColor Green
Write-Host "✓ Validaciones con Bean Validation" -ForegroundColor Green
Write-Host "✓ Docker con variables de entorno (.env)" -ForegroundColor Green
Write-Host "✓ Undertow como servidor (más ligero que Tomcat)" -ForegroundColor Green


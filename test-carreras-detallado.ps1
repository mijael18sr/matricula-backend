# Script de Prueba - CRUD Carreras
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  PRUEBA DE ENDPOINTS - CARRERAS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$baseUrl = "http://localhost:8080/api/v1"

# 1. GET - Listar todas las carreras
Write-Host "`n[1] GET /carreras - Listar todas" -ForegroundColor Yellow
try {
    $carreras = Invoke-RestMethod -Uri "$baseUrl/carreras" -Method GET
    Write-Host "[OK] Total de carreras: $($carreras.Count)" -ForegroundColor Green

    if ($carreras.Count -gt 0) {
        Write-Host "`nPrimera carrera encontrada:" -ForegroundColor Cyan
        $carreras[0] | Format-List
    } else {
        Write-Host "No hay carreras en la base de datos" -ForegroundColor Yellow
    }
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
}

# 2. GET - Listar facultades para crear una carrera
Write-Host "`n[2] GET /facultades - Obtener facultades disponibles" -ForegroundColor Yellow
try {
    $facultades = Invoke-RestMethod -Uri "$baseUrl/facultades" -Method GET
    Write-Host "[OK] Total de facultades: $($facultades.Count)" -ForegroundColor Green

    if ($facultades.Count -gt 0) {
        $facultadId = $facultades[0].facultadId
        Write-Host "Usando Facultad ID: $facultadId - $($facultades[0].nombre)" -ForegroundColor Cyan
    }
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# 3. POST - Crear nueva carrera
Write-Host "`n[3] POST /carreras - Crear nueva carrera" -ForegroundColor Yellow
$nuevaCarrera = @{
    facultadId = $facultadId
    nombre = "Ingenieria de Sistemas PRUEBA"
    descripcion = "Carrera de prueba para verificar endpoints"
    duracionSemestres = 10
    tituloOtorgado = "Ingeniero de Sistemas"
    activo = $true
} | ConvertTo-Json

try {
    $carreraCreada = Invoke-RestMethod -Uri "$baseUrl/carreras" -Method POST -Body $nuevaCarrera -ContentType "application/json"
    Write-Host "[OK] Carrera creada exitosamente" -ForegroundColor Green
    Write-Host "`nDatos de la carrera creada:" -ForegroundColor Cyan
    $carreraCreada | Format-List
    $carreraId = $carreraCreada.carreraId
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Response: $($_.ErrorDetails.Message)" -ForegroundColor Red
}

# 4. GET - Obtener carrera por ID
Write-Host "`n[4] GET /carreras/{id} - Obtener por ID" -ForegroundColor Yellow
try {
    $carrera = Invoke-RestMethod -Uri "$baseUrl/carreras/$carreraId" -Method GET
    Write-Host "[OK] Carrera obtenida por ID: $carreraId" -ForegroundColor Green
    Write-Host "`nDatos completos:" -ForegroundColor Cyan
    $carrera | Format-List
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
}

# 5. GET - Filtrar por facultad
Write-Host "`n[5] GET /carreras?facultadId={id} - Filtrar por facultad" -ForegroundColor Yellow
try {
    $carrerasPorFacultad = Invoke-RestMethod -Uri "$baseUrl/carreras?facultadId=$facultadId" -Method GET
    Write-Host "[OK] Carreras de la facultad $facultadId : $($carrerasPorFacultad.Count)" -ForegroundColor Green

    if ($carrerasPorFacultad.Count -gt 0) {
        Write-Host "`nPrimera carrera:" -ForegroundColor Cyan
        $carrerasPorFacultad[0] | Format-List
    }
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
}

# 6. GET - Solo activas
Write-Host "`n[6] GET /carreras?soloActivos=true - Solo activas" -ForegroundColor Yellow
try {
    $carrerasActivas = Invoke-RestMethod -Uri "$baseUrl/carreras?soloActivos=true" -Method GET
    Write-Host "[OK] Carreras activas: $($carrerasActivas.Count)" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
}

# 7. PUT - Actualizar carrera
Write-Host "`n[7] PUT /carreras/{id} - Actualizar carrera" -ForegroundColor Yellow
$carreraActualizada = @{
    facultadId = $facultadId
    nombre = "Ingenieria de Sistemas ACTUALIZADA"
    descripcion = "Descripcion actualizada con DevOps"
    duracionSemestres = 10
    tituloOtorgado = "Ingeniero de Sistemas"
    activo = $true
} | ConvertTo-Json

try {
    $actualizada = Invoke-RestMethod -Uri "$baseUrl/carreras/$carreraId" -Method PUT -Body $carreraActualizada -ContentType "application/json"
    Write-Host "[OK] Carrera actualizada" -ForegroundColor Green
    Write-Host "`nDatos actualizados:" -ForegroundColor Cyan
    $actualizada | Format-List
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
}

# 8. PATCH - Desactivar carrera
Write-Host "`n[8] PATCH /carreras/{id}/desactivar - Desactivar" -ForegroundColor Yellow
try {
    Invoke-RestMethod -Uri "$baseUrl/carreras/$carreraId/desactivar" -Method PATCH
    Write-Host "[OK] Carrera desactivada" -ForegroundColor Green

    # Verificar
    $verificar = Invoke-RestMethod -Uri "$baseUrl/carreras/$carreraId" -Method GET
    Write-Host "Estado activo: $($verificar.activo)" -ForegroundColor White
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
}

# 9. DELETE - Eliminar carrera
Write-Host "`n[9] DELETE /carreras/{id} - Eliminar carrera" -ForegroundColor Yellow
try {
    Invoke-RestMethod -Uri "$baseUrl/carreras/$carreraId" -Method DELETE
    Write-Host "[OK] Carrera eliminada" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  PRUEBAS COMPLETADAS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan


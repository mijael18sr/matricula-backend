# ============================================
# PRUEBA COMPLETA DEL CRUD - POSTMAN STYLE
# ============================================

$baseUrl = "http://localhost:8080/api"
$resultados = @()

Write-Host "`n===============================================" -ForegroundColor Cyan
Write-Host "  PRUEBA COMPLETA DEL CRUD - SISTEMA MATRICULA" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan

# ====================
# 0. HEALTH CHECK
# ====================
Write-Host "`n[0] HEALTH CHECK" -ForegroundColor Yellow
try {
    $health = Invoke-RestMethod -Uri "$baseUrl/actuator/health" -Method GET -ErrorAction Stop
    Write-Host "[OK] Status: $($health.status)" -ForegroundColor Green
    $resultados += "[OK] Health Check"
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    $resultados += "[ERROR] Health Check"
    Write-Host "`nEl backend no esta respondiendo. Verifica que este ejecutandose." -ForegroundColor Red
    exit 1
}

# ====================
# FACULTADES - CRUD
# ====================
Write-Host "`n===============================================" -ForegroundColor Magenta
Write-Host "              CRUD FACULTADES" -ForegroundColor Magenta
Write-Host "===============================================" -ForegroundColor Magenta

# 1. GET - Listar todas las facultades
Write-Host "`n[1] GET /facultades (Listar todas)" -ForegroundColor Yellow
try {
    $facultades = Invoke-RestMethod -Uri "$baseUrl/v1/facultades" -Method GET -ErrorAction Stop
    Write-Host "[OK] Total de facultades: $($facultades.Count)" -ForegroundColor Green
    if ($facultades.Count -gt 0) {
        Write-Host "  Primera facultad:" -ForegroundColor Cyan
        Write-Host "  - ID: $($facultades[0].facultadId)" -ForegroundColor White
        Write-Host "  - Nombre: $($facultades[0].nombre)" -ForegroundColor White
        Write-Host "  - Decano: $($facultades[0].decano)" -ForegroundColor White
    }
    $resultados += "[OK] GET Facultades (Listar)"
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    $resultados += "[ERROR] GET Facultades (Listar)"
}

# 2. POST - Crear nueva facultad
Write-Host "`n[2] POST /facultades (Crear)" -ForegroundColor Yellow
$nuevaFacultad = @{
    nombre = "Facultad de Ingenieria y Arquitectura"
    descripcion = "Facultad dedicada a la formacion de ingenieros"
    ubicacion = "Edificio Central - Piso 3"
    decano = "Dr. Carlos Martinez Lopez"
    activo = $true
} | ConvertTo-Json

try {
    $facultadCreada = Invoke-RestMethod -Uri "$baseUrl/v1/facultades" -Method POST -Body $nuevaFacultad -ContentType "application/json" -ErrorAction Stop
    Write-Host "[OK] Facultad creada exitosamente" -ForegroundColor Green
    Write-Host "  - ID: $($facultadCreada.facultadId)" -ForegroundColor White
    Write-Host "  - Nombre: $($facultadCreada.nombre)" -ForegroundColor White
    Write-Host "  - Decano: $($facultadCreada.decano)" -ForegroundColor White
    Write-Host "  - Ubicacion: $($facultadCreada.ubicacion)" -ForegroundColor White
    $facultadId = $facultadCreada.facultadId
    $resultados += "[OK] POST Facultad (Crear)"
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    $resultados += "[ERROR] POST Facultad (Crear)"
}

# 3. GET - Obtener facultad por ID
Write-Host "`n[3] GET /facultades/{id} (Obtener por ID)" -ForegroundColor Yellow
try {
    $facultadById = Invoke-RestMethod -Uri "$baseUrl/v1/facultades/$facultadId" -Method GET -ErrorAction Stop
    Write-Host "[OK] Facultad obtenida por ID: $facultadId" -ForegroundColor Green
    Write-Host "  - Nombre: $($facultadById.nombre)" -ForegroundColor White
    Write-Host "  - Descripcion: $($facultadById.descripcion)" -ForegroundColor White
    Write-Host "  - Activo: $($facultadById.activo)" -ForegroundColor White
    $resultados += "[OK] GET Facultad por ID"
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    $resultados += "[ERROR] GET Facultad por ID"
}

# 4. PUT - Actualizar facultad
Write-Host "`n[4] PUT /facultades/{id} (Actualizar)" -ForegroundColor Yellow
$facultadActualizada = @{
    nombre = "Facultad de Ingenieria y Arquitectura ACTUALIZADA"
    descripcion = "Descripcion actualizada con nuevos programas"
    ubicacion = "Edificio Nuevo - Campus Norte"
    decano = "Dra. Maria Gonzalez Perez"
    activo = $true
} | ConvertTo-Json

try {
    $updated = Invoke-RestMethod -Uri "$baseUrl/v1/facultades/$facultadId" -Method PUT -Body $facultadActualizada -ContentType "application/json" -ErrorAction Stop
    Write-Host "[OK] Facultad actualizada exitosamente" -ForegroundColor Green
    Write-Host "  - Nuevo nombre: $($updated.nombre)" -ForegroundColor White
    Write-Host "  - Nueva ubicacion: $($updated.ubicacion)" -ForegroundColor White
    Write-Host "  - Nuevo decano: $($updated.decano)" -ForegroundColor White
    $resultados += "[OK] PUT Facultad (Actualizar)"
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    $resultados += "[ERROR] PUT Facultad (Actualizar)"
}

# ====================
# CARRERAS - CRUD
# ====================
Write-Host "`n===============================================" -ForegroundColor Magenta
Write-Host "               CRUD CARRERAS" -ForegroundColor Magenta
Write-Host "===============================================" -ForegroundColor Magenta

# 5. POST - Crear nueva carrera
Write-Host "`n[5] POST /carreras (Crear)" -ForegroundColor Yellow
$nuevaCarrera = @{
    facultadId = $facultadId
    nombre = "Ingenieria de Software"
    descripcion = "Carrera enfocada en desarrollo de software"
    duracionSemestres = 10
    tituloOtorgado = "Ingeniero de Software"
    activo = $true
} | ConvertTo-Json

try {
    $carreraCreada = Invoke-RestMethod -Uri "$baseUrl/v1/carreras" -Method POST -Body $nuevaCarrera -ContentType "application/json" -ErrorAction Stop
    Write-Host "[OK] Carrera creada exitosamente" -ForegroundColor Green
    Write-Host "  - ID: $($carreraCreada.carreraId)" -ForegroundColor White
    Write-Host "  - Nombre: $($carreraCreada.nombre)" -ForegroundColor White
    Write-Host "  - Duracion: $($carreraCreada.duracionSemestres) semestres" -ForegroundColor White
    Write-Host "  - Titulo: $($carreraCreada.tituloOtorgado)" -ForegroundColor White
    Write-Host "  - Facultad: $($carreraCreada.facultadNombre)" -ForegroundColor White
    $carreraId = $carreraCreada.carreraId
    $resultados += "[OK] POST Carrera (Crear)"
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    $resultados += "[ERROR] POST Carrera (Crear)"
}

# 6. GET - Listar todas las carreras
Write-Host "`n[6] GET /carreras (Listar todas)" -ForegroundColor Yellow
try {
    $carreras = Invoke-RestMethod -Uri "$baseUrl/v1/carreras" -Method GET -ErrorAction Stop
    Write-Host "[OK] Total de carreras: $($carreras.Count)" -ForegroundColor Green
    foreach ($c in $carreras | Select-Object -First 3) {
        Write-Host "  - $($c.nombre) (Facultad: $($c.facultadNombre))" -ForegroundColor Cyan
    }
    $resultados += "[OK] GET Carreras (Listar)"
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    $resultados += "[ERROR] GET Carreras (Listar)"
}

# 7. GET - Obtener carrera por ID
Write-Host "`n[7] GET /carreras/{id} (Obtener por ID)" -ForegroundColor Yellow
try {
    $carreraById = Invoke-RestMethod -Uri "$baseUrl/v1/carreras/$carreraId" -Method GET -ErrorAction Stop
    Write-Host "[OK] Carrera obtenida por ID: $carreraId" -ForegroundColor Green
    Write-Host "  - Nombre: $($carreraById.nombre)" -ForegroundColor White
    Write-Host "  - Descripcion: $($carreraById.descripcion)" -ForegroundColor White
    Write-Host "  - Activo: $($carreraById.activo)" -ForegroundColor White
    $resultados += "[OK] GET Carrera por ID"
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    $resultados += "[ERROR] GET Carrera por ID"
}

# 8. PUT - Actualizar carrera
Write-Host "`n[8] PUT /carreras/{id} (Actualizar)" -ForegroundColor Yellow
$carreraActualizada = @{
    facultadId = $facultadId
    nombre = "Ingenieria de Software ACTUALIZADA"
    descripcion = "Carrera con enfoque en Cloud Computing y DevOps"
    duracionSemestres = 10
    tituloOtorgado = "Ingeniero de Software"
    activo = $true
} | ConvertTo-Json

try {
    $carreraUpdated = Invoke-RestMethod -Uri "$baseUrl/v1/carreras/$carreraId" -Method PUT -Body $carreraActualizada -ContentType "application/json" -ErrorAction Stop
    Write-Host "[OK] Carrera actualizada exitosamente" -ForegroundColor Green
    Write-Host "  - Nuevo nombre: $($carreraUpdated.nombre)" -ForegroundColor White
    Write-Host "  - Nueva descripcion: $($carreraUpdated.descripcion)" -ForegroundColor White
    $resultados += "[OK] PUT Carrera (Actualizar)"
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    $resultados += "[ERROR] PUT Carrera (Actualizar)"
}

# 9. GET - Carreras por facultad
Write-Host "`n[9] GET /carreras?facultadId={id} (Por Facultad)" -ForegroundColor Yellow
try {
    $carrerasPorFacultad = Invoke-RestMethod -Uri "$baseUrl/v1/carreras?facultadId=$facultadId" -Method GET -ErrorAction Stop
    Write-Host "[OK] Carreras de la facultad ID $facultadId : $($carrerasPorFacultad.Count)" -ForegroundColor Green
    foreach ($c in $carrerasPorFacultad) {
        Write-Host "  - $($c.nombre)" -ForegroundColor Cyan
    }
    $resultados += "[OK] GET Carreras por Facultad"
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    $resultados += "[ERROR] GET Carreras por Facultad"
}

# 10. GET - Solo activos (Carreras)
Write-Host "`n[10] GET /carreras?soloActivos=true (Activas)" -ForegroundColor Yellow
try {
    $carrerasActivas = Invoke-RestMethod -Uri "$baseUrl/v1/carreras?soloActivos=true" -Method GET -ErrorAction Stop
    Write-Host "[OK] Total de carreras activas: $($carrerasActivas.Count)" -ForegroundColor Green
    $resultados += "[OK] GET Carreras Activas"
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    $resultados += "[ERROR] GET Carreras Activas"
}

# 11. PATCH - Desactivar carrera
Write-Host "`n[11] PATCH /carreras/{id}/desactivar (Desactivar)" -ForegroundColor Yellow
try {
    Invoke-RestMethod -Uri "$baseUrl/v1/carreras/$carreraId/desactivar" -Method PATCH -ErrorAction Stop
    Write-Host "[OK] Carrera desactivada exitosamente" -ForegroundColor Green

    # Verificar que se desactivo
    $verificar = Invoke-RestMethod -Uri "$baseUrl/v1/carreras/$carreraId" -Method GET
    Write-Host "  - Estado activo: $($verificar.activo)" -ForegroundColor White
    $resultados += "[OK] PATCH Carrera (Desactivar)"
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    $resultados += "[ERROR] PATCH Carrera (Desactivar)"
}

# 12. PATCH - Desactivar facultad
Write-Host "`n[12] PATCH /facultades/{id}/desactivar (Desactivar)" -ForegroundColor Yellow
try {
    Invoke-RestMethod -Uri "$baseUrl/v1/facultades/$facultadId/desactivar" -Method PATCH -ErrorAction Stop
    Write-Host "[OK] Facultad desactivada exitosamente" -ForegroundColor Green

    # Verificar que se desactivo
    $verificar = Invoke-RestMethod -Uri "$baseUrl/v1/facultades/$facultadId" -Method GET
    Write-Host "  - Estado activo: $($verificar.activo)" -ForegroundColor White
    $resultados += "[OK] PATCH Facultad (Desactivar)"
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    $resultados += "[ERROR] PATCH Facultad (Desactivar)"
}

# 13. DELETE - Eliminar carrera (solo si esta inactiva)
Write-Host "`n[13] DELETE /carreras/{id} (Eliminar)" -ForegroundColor Yellow
try {
    Invoke-RestMethod -Uri "$baseUrl/v1/carreras/$carreraId" -Method DELETE -ErrorAction Stop
    Write-Host "[OK] Carrera eliminada exitosamente" -ForegroundColor Green
    $resultados += "[OK] DELETE Carrera"
} catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    $resultados += "[ERROR] DELETE Carrera"
}

# ====================
# RESUMEN FINAL
# ====================
Write-Host "`n===============================================" -ForegroundColor Cyan
Write-Host "            RESUMEN DE PRUEBAS" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan

$exitosos = ($resultados | Where-Object { $_ -like "[OK]*" }).Count
$fallidos = ($resultados | Where-Object { $_ -like "[ERROR]*" }).Count
$total = $resultados.Count

Write-Host "`nResultados:" -ForegroundColor White
foreach ($resultado in $resultados) {
    if ($resultado -like "[OK]*") {
        Write-Host "  $resultado" -ForegroundColor Green
    } else {
        Write-Host "  $resultado" -ForegroundColor Red
    }
}

Write-Host "`n-----------------------------------------------" -ForegroundColor White
Write-Host "  Total de pruebas: $total" -ForegroundColor White
Write-Host "  Exitosas: $exitosos" -ForegroundColor Green
Write-Host "  Fallidas: $fallidos" -ForegroundColor $(if ($fallidos -eq 0) { "Green" } else { "Red" })
Write-Host "-----------------------------------------------" -ForegroundColor White

if ($fallidos -eq 0) {
    Write-Host "`n[EXITO] TODAS LAS PRUEBAS PASARON!" -ForegroundColor Green
    Write-Host "El CRUD esta funcionando perfectamente" -ForegroundColor Green
} else {
    Write-Host "`n[ADVERTENCIA] ALGUNAS PRUEBAS FALLARON" -ForegroundColor Yellow
    Write-Host "Revisa los errores anteriores" -ForegroundColor Yellow
}

Write-Host "`n===============================================`n" -ForegroundColor Cyan

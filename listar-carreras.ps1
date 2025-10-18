# Listar todas las carreras
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  LISTANDO TODAS LAS CARRERAS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$baseUrl = "http://localhost:8080/api/v1"

try {
    $carreras = Invoke-RestMethod -Uri "$baseUrl/carreras" -Method GET

    Write-Host "`nTotal de carreras encontradas: $($carreras.Count)" -ForegroundColor Green

    if ($carreras.Count -eq 0) {
        Write-Host "`nNo hay carreras registradas en la base de datos" -ForegroundColor Yellow
    } else {
        Write-Host "`n========================================" -ForegroundColor White

        foreach ($carrera in $carreras) {
            Write-Host "`nCarrera ID: $($carrera.carreraId)" -ForegroundColor Cyan
            Write-Host "  Nombre: $($carrera.nombre)" -ForegroundColor White
            Write-Host "  Descripcion: $($carrera.descripcion)" -ForegroundColor Gray
            Write-Host "  Facultad ID: $($carrera.facultadId)" -ForegroundColor White
            Write-Host "  Facultad Nombre: $($carrera.facultadNombre)" -ForegroundColor Yellow
            Write-Host "  Duracion: $($carrera.duracionSemestres) semestres" -ForegroundColor White
            Write-Host "  Titulo: $($carrera.tituloOtorgado)" -ForegroundColor White
            Write-Host "  Fecha Registro: $($carrera.fechaRegistro)" -ForegroundColor Gray
            Write-Host "  Activo: $($carrera.activo)" -ForegroundColor $(if ($carrera.activo) { "Green" } else { "Red" })
            Write-Host "  ----------------------------------------" -ForegroundColor DarkGray
        }
    }

    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "JSON Completo de todas las carreras:" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    $carreras | ConvertTo-Json -Depth 3

} catch {
    Write-Host "`n[ERROR] No se pudo listar las carreras" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Detalles: $($_.ErrorDetails.Message)" -ForegroundColor Red
}

Write-Host "`n========================================" -ForegroundColor Cyan


@echo off
echo ================================================
echo   Sistema de Matricula - Docker Setup
echo ================================================
echo.

echo [1/4] Verificando Docker...
docker --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Docker no esta instalado o no esta en el PATH
    pause
    exit /b 1
)
echo ✓ Docker encontrado

echo.
echo [2/4] Verificando Docker Compose...
docker-compose --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Docker Compose no esta instalado
    pause
    exit /b 1
)
echo ✓ Docker Compose encontrado

echo.
echo [3/4] Deteniendo contenedores existentes...
docker-compose down

echo.
echo [4/4] Construyendo e iniciando servicios...
docker-compose up --build -d

echo.
echo ================================================
echo   Servicios iniciados correctamente!
echo ================================================
echo.
echo Backend:   http://localhost:8080/api
echo Health:    http://localhost:8080/api/actuator/health
echo Database:  localhost:5432
echo.
echo Ver logs:  docker-compose logs -f
echo Detener:   docker-compose down
echo.
pause


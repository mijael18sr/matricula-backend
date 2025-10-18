@echo off
echo ================================================
echo   Verificando tamaño de imagen Docker
echo ================================================
echo.

echo Construyendo imagen optimizada...
docker-compose build backend

echo.
echo ================================================
echo   Tamaño de imagenes:
echo ================================================
docker images | findstr matricula

echo.
echo ================================================
echo   Detalles de la imagen:
echo ================================================
docker image inspect matricula-backend-backend --format="Tamaño: {{.Size}} bytes ({{ div .Size 1048576 }} MB)"

echo.
pause


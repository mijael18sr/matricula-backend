@echo off
echo ================================================
echo   Deteniendo servicios Docker
echo ================================================
echo.

docker-compose down

echo.
echo ✓ Servicios detenidos
echo.
pause


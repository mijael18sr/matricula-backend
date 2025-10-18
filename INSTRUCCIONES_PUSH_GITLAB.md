# INSTRUCCIONES PARA SUBIR EL PROYECTO A GITLAB

## Problema Actual
El repositorio de GitLab ya tiene un README.md inicial, por lo que necesitas hacer un push forzado.

## Solución: Ejecuta estos comandos en orden

### Paso 1: Verificar el estado del repositorio
```bash
git status
```

### Paso 2: Verificar el remoto configurado
```bash
git remote -v
```

Deberías ver:
```
origin  https://gitlab.com/matricula-universidad-capas/matricula-backend.git (fetch)
origin  https://gitlab.com/matricula-universidad-capas/matricula-backend.git (push)
```

### Paso 3: Hacer pull del README remoto y fusionarlo
```bash
git pull origin main --allow-unrelated-histories
```

Esto descargará el README que GitLab creó automáticamente.

### Paso 4: Si hay conflictos, resolverlos
Si hay conflicto con el README.md:
```bash
# Mantener tu versión del README
git checkout --ours README.md
git add README.md
git commit -m "Mantener README local"
```

### Paso 5: Subir todo el proyecto
```bash
git push origin main
```

---

## Alternativa: Push Forzado (Más Simple)

Si quieres sobrescribir completamente el repositorio remoto con tu versión local:

```bash
git push origin main --force
```

**Nota:** Esto eliminará el README que GitLab creó automáticamente y lo reemplazará con el tuyo.

---

## Alternativa 2: Desde Cero

Si nada funciona, prueba esto:

### 1. Eliminar el remoto actual
```bash
git remote remove origin
```

### 2. Volver a agregarlo
```bash
git remote add origin https://gitlab.com/matricula-universidad-capas/matricula-backend.git
```

### 3. Hacer pull con fusión
```bash
git pull origin main --allow-unrelated-histories --no-rebase
```

### 4. Resolver conflictos si existen
```bash
git add .
git commit -m "Merge inicial"
```

### 5. Push final
```bash
git push origin main
```

---

## ¿Por qué no funcionó el push automático?

GitLab requiere autenticación. Cuando ejecutes `git push`, GitLab te pedirá:
- **Usuario:** Tu usuario de GitLab
- **Contraseña:** Tu Personal Access Token (PAT) o contraseña

---

## Crear un Personal Access Token en GitLab

Si GitLab te pide autenticación:

1. Ve a GitLab → Settings → Access Tokens
2. Crea un nuevo token con permisos de `write_repository`
3. Copia el token
4. Úsalo como contraseña cuando hagas `git push`

---

## Comando Recomendado (EJECUTA ESTO)

```bash
# Opción 1: Pull + Merge + Push
git pull origin main --allow-unrelated-histories
git push origin main

# O si da error, forzar:
git push origin main --force
```

---

## Verificar que se subió correctamente

Después del push exitoso, ve a:
https://gitlab.com/matricula-universidad-capas/matricula-backend

Deberías ver todos tus archivos.

---

## Archivos que se subirán (75 archivos)

- Dockerfile
- docker-compose.yaml
- .env
- init.sql
- pom.xml
- README.md
- Todo el código fuente (src/)
- Scripts de pruebas (.ps1, .bat)
- Documentación completa

**¡Una vez que hagas el push, el proyecto estará listo para que tu compañero lo clone!**


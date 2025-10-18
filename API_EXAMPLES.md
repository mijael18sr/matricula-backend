# Colección de Postman para API de Matrícula

## Variables de Entorno
- base_url: http://localhost:8080/api

## Facultades

### Crear Facultad
```json
POST {{base_url}}/v1/facultades
Content-Type: application/json

{
    "nombre": "Facultad de Ingeniería",
    "descripcion": "Facultad de Ingeniería y Arquitectura",
    "ubicacion": "Edificio A",
    "decano": "Dr. Juan Pérez",
    "activo": true
}
```

### Obtener Todas las Facultades
```
GET {{base_url}}/v1/facultades
```

### Obtener Facultades Activas
```
GET {{base_url}}/v1/facultades?soloActivos=true
```

### Obtener Facultad por ID
```
GET {{base_url}}/v1/facultades/1
```

### Actualizar Facultad
```json
PUT {{base_url}}/v1/facultades/1
Content-Type: application/json

{
    "nombre": "Facultad de Ingeniería Actualizada",
    "descripcion": "Descripción actualizada",
    "ubicacion": "Edificio B",
    "decano": "Dra. María González",
    "activo": true
}
```

### Desactivar Facultad
```
PATCH {{base_url}}/v1/facultades/1/desactivar
```

### Eliminar Facultad
```
DELETE {{base_url}}/v1/facultades/1
```

## Carreras

### Crear Carrera
```json
POST {{base_url}}/v1/carreras
Content-Type: application/json

{
    "facultadId": 1,
    "nombre": "Ingeniería de Software",
    "descripcion": "Carrera de Ingeniería de Software",
    "duracionSemestres": 10,
    "tituloOtorgado": "Ingeniero de Software",
    "activo": true
}
```

### Obtener Todas las Carreras
```
GET {{base_url}}/v1/carreras
```

### Obtener Carreras Activas
```
GET {{base_url}}/v1/carreras?soloActivos=true
```

### Obtener Carreras por Facultad
```
GET {{base_url}}/v1/carreras?facultadId=1
```

### Obtener Carrera por ID
```
GET {{base_url}}/v1/carreras/1
```

### Actualizar Carrera
```json
PUT {{base_url}}/v1/carreras/1
Content-Type: application/json

{
    "facultadId": 1,
    "nombre": "Ingeniería de Software Actualizada",
    "descripcion": "Descripción actualizada",
    "duracionSemestres": 10,
    "tituloOtorgado": "Ingeniero de Software",
    "activo": true
}
```

### Desactivar Carrera
```
PATCH {{base_url}}/v1/carreras/1/desactivar
```

### Eliminar Carrera
```
DELETE {{base_url}}/v1/carreras/1
```


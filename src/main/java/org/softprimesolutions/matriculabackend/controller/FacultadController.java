package org.softprimesolutions.matriculabackend.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.softprimesolutions.matriculabackend.dto.request.FacultadRequestDTO;
import org.softprimesolutions.matriculabackend.dto.response.FacultadResponseDTO;
import org.softprimesolutions.matriculabackend.service.IFacultadService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/v1/facultades")
@RequiredArgsConstructor
public class FacultadController {

    private final IFacultadService facultadService;

    @PostMapping
    public ResponseEntity<FacultadResponseDTO> crear(@Valid @RequestBody FacultadRequestDTO requestDTO) {
        FacultadResponseDTO response = facultadService.crear(requestDTO);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<FacultadResponseDTO> obtenerPorId(@PathVariable Long id) {
        FacultadResponseDTO response = facultadService.obtenerPorId(id);
        return ResponseEntity.ok(response);
    }

    @GetMapping
    public ResponseEntity<List<FacultadResponseDTO>> obtenerTodos(
            @RequestParam(required = false, defaultValue = "false") boolean soloActivos) {

        List<FacultadResponseDTO> response = soloActivos
                ? facultadService.obtenerActivos()
                : facultadService.obtenerTodos();

        return ResponseEntity.ok(response);
    }

    @PutMapping("/{id}")
    public ResponseEntity<FacultadResponseDTO> actualizar(
            @PathVariable Long id,
            @Valid @RequestBody FacultadRequestDTO requestDTO) {

        FacultadResponseDTO response = facultadService.actualizar(id, requestDTO);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        facultadService.eliminar(id);
        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/{id}/desactivar")
    public ResponseEntity<Void> desactivar(@PathVariable Long id) {
        facultadService.eliminarLogico(id);
        return ResponseEntity.noContent().build();
    }
}


package org.softprimesolutions.matriculabackend.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.softprimesolutions.matriculabackend.dto.request.CarreraRequestDTO;
import org.softprimesolutions.matriculabackend.dto.response.CarreraResponseDTO;
import org.softprimesolutions.matriculabackend.service.ICarreraService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/v1/carreras")
@RequiredArgsConstructor
public class CarreraController {

    private final ICarreraService carreraService;

    @PostMapping
    public ResponseEntity<CarreraResponseDTO> crear(@Valid @RequestBody CarreraRequestDTO requestDTO) {
        CarreraResponseDTO response = carreraService.crear(requestDTO);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<CarreraResponseDTO> obtenerPorId(@PathVariable Long id) {
        CarreraResponseDTO response = carreraService.obtenerPorId(id);
        return ResponseEntity.ok(response);
    }

    @GetMapping
    public ResponseEntity<List<CarreraResponseDTO>> obtenerTodos(
            @RequestParam(required = false, defaultValue = "false") boolean soloActivos,
            @RequestParam(required = false) Long facultadId) {

        List<CarreraResponseDTO> response;

        if (facultadId != null) {
            response = carreraService.obtenerPorFacultad(facultadId);
        } else {
            response = soloActivos
                    ? carreraService.obtenerActivos()
                    : carreraService.obtenerTodos();
        }

        return ResponseEntity.ok(response);
    }

    @PutMapping("/{id}")
    public ResponseEntity<CarreraResponseDTO> actualizar(
            @PathVariable Long id,
            @Valid @RequestBody CarreraRequestDTO requestDTO) {

        CarreraResponseDTO response = carreraService.actualizar(id, requestDTO);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        carreraService.eliminar(id);
        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/{id}/desactivar")
    public ResponseEntity<Void> desactivar(@PathVariable Long id) {
        carreraService.eliminarLogico(id);
        return ResponseEntity.noContent().build();
    }
}


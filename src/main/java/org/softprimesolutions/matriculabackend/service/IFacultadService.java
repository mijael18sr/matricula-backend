package org.softprimesolutions.matriculabackend.service;

import org.softprimesolutions.matriculabackend.dto.request.FacultadRequestDTO;
import org.softprimesolutions.matriculabackend.dto.response.FacultadResponseDTO;

import java.util.List;

public interface IFacultadService {

    FacultadResponseDTO crear(FacultadRequestDTO requestDTO);

    FacultadResponseDTO obtenerPorId(Long id);

    List<FacultadResponseDTO> obtenerTodos();

    List<FacultadResponseDTO> obtenerActivos();

    FacultadResponseDTO actualizar(Long id, FacultadRequestDTO requestDTO);

    void eliminar(Long id);

    void eliminarLogico(Long id);
}


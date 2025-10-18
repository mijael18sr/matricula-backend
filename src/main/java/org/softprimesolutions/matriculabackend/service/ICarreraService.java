package org.softprimesolutions.matriculabackend.service;

import org.softprimesolutions.matriculabackend.dto.request.CarreraRequestDTO;
import org.softprimesolutions.matriculabackend.dto.response.CarreraResponseDTO;

import java.util.List;

public interface ICarreraService {

    CarreraResponseDTO crear(CarreraRequestDTO requestDTO);

    CarreraResponseDTO obtenerPorId(Long id);

    List<CarreraResponseDTO> obtenerTodos();

    List<CarreraResponseDTO> obtenerActivos();

    List<CarreraResponseDTO> obtenerPorFacultad(Long facultadId);

    CarreraResponseDTO actualizar(Long id, CarreraRequestDTO requestDTO);

    void eliminar(Long id);

    void eliminarLogico(Long id);
}


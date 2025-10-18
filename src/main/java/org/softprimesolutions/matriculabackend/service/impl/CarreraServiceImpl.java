package org.softprimesolutions.matriculabackend.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.softprimesolutions.matriculabackend.dto.request.CarreraRequestDTO;
import org.softprimesolutions.matriculabackend.dto.response.CarreraResponseDTO;
import org.softprimesolutions.matriculabackend.entity.Carrera;
import org.softprimesolutions.matriculabackend.entity.Facultad;
import org.softprimesolutions.matriculabackend.exception.BusinessException;
import org.softprimesolutions.matriculabackend.exception.ResourceNotFoundException;
import org.softprimesolutions.matriculabackend.mapper.CarreraMapper;
import org.softprimesolutions.matriculabackend.repository.CarreraRepository;
import org.softprimesolutions.matriculabackend.repository.FacultadRepository;
import org.softprimesolutions.matriculabackend.service.ICarreraService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class CarreraServiceImpl implements ICarreraService {

    private final CarreraRepository carreraRepository;
    private final FacultadRepository facultadRepository;
    private final CarreraMapper carreraMapper;

    @Override
    @Transactional
    public CarreraResponseDTO crear(CarreraRequestDTO requestDTO) {
        log.info("Creando nueva carrera: {}", requestDTO.getNombre());

        if (carreraRepository.existsByNombre(requestDTO.getNombre())) {
            throw new BusinessException("Ya existe una carrera con el nombre: " + requestDTO.getNombre());
        }

        Facultad facultad = facultadRepository.findById(requestDTO.getFacultadId())
                .orElseThrow(() -> new ResourceNotFoundException("Facultad no encontrada con ID: " + requestDTO.getFacultadId()));

        if (!facultad.getActivo()) {
            throw new BusinessException("No se puede crear una carrera en una facultad inactiva");
        }

        Carrera carrera = carreraMapper.toEntity(requestDTO);
        carrera.setFacultad(facultad);

        Carrera carreraGuardada = carreraRepository.save(carrera);

        log.info("Carrera creada exitosamente con ID: {}", carreraGuardada.getCarreraId());
        return carreraMapper.toResponseDTO(carreraGuardada);
    }

    @Override
    @Transactional(readOnly = true)
    public CarreraResponseDTO obtenerPorId(Long id) {
        log.info("Buscando carrera con ID: {}", id);

        Carrera carrera = carreraRepository.findByIdWithFacultad(id)
                .orElseThrow(() -> new ResourceNotFoundException("Carrera no encontrada con ID: " + id));

        return carreraMapper.toResponseDTO(carrera);
    }

    @Override
    @Transactional(readOnly = true)
    public List<CarreraResponseDTO> obtenerTodos() {
        log.info("Obteniendo todas las carreras");

        List<Carrera> carreras = carreraRepository.findAllWithFacultad();
        return carreraMapper.toResponseDTOList(carreras);
    }

    @Override
    @Transactional(readOnly = true)
    public List<CarreraResponseDTO> obtenerActivos() {
        log.info("Obteniendo carreras activas");

        List<Carrera> carreras = carreraRepository.findByActivoTrue();
        return carreraMapper.toResponseDTOList(carreras);
    }

    @Override
    @Transactional(readOnly = true)
    public List<CarreraResponseDTO> obtenerPorFacultad(Long facultadId) {
        log.info("Obteniendo carreras de la facultad con ID: {}", facultadId);

        if (!facultadRepository.existsById(facultadId)) {
            throw new ResourceNotFoundException("Facultad no encontrada con ID: " + facultadId);
        }

        List<Carrera> carreras = carreraRepository.findByFacultadFacultadId(facultadId);
        return carreraMapper.toResponseDTOList(carreras);
    }

    @Override
    @Transactional
    public CarreraResponseDTO actualizar(Long id, CarreraRequestDTO requestDTO) {
        log.info("Actualizando carrera con ID: {}", id);

        Carrera carrera = carreraRepository.findByIdWithFacultad(id)
                .orElseThrow(() -> new ResourceNotFoundException("Carrera no encontrada con ID: " + id));

        if (carreraRepository.existsByNombreAndCarreraIdNot(requestDTO.getNombre(), id)) {
            throw new BusinessException("Ya existe otra carrera con el nombre: " + requestDTO.getNombre());
        }

        // Si se cambia la facultad, validar que exista y esté activa
        if (!carrera.getFacultad().getFacultadId().equals(requestDTO.getFacultadId())) {
            Facultad nuevaFacultad = facultadRepository.findById(requestDTO.getFacultadId())
                    .orElseThrow(() -> new ResourceNotFoundException("Facultad no encontrada con ID: " + requestDTO.getFacultadId()));

            if (!nuevaFacultad.getActivo()) {
                throw new BusinessException("No se puede asignar una carrera a una facultad inactiva");
            }

            carrera.setFacultad(nuevaFacultad);
        }

        carreraMapper.updateEntityFromDTO(requestDTO, carrera);
        Carrera carreraActualizada = carreraRepository.save(carrera);

        log.info("Carrera actualizada exitosamente con ID: {}", id);
        return carreraMapper.toResponseDTO(carreraActualizada);
    }

    @Override
    @Transactional
    public void eliminar(Long id) {
        log.info("Eliminando carrera con ID: {}", id);

        if (!carreraRepository.existsById(id)) {
            throw new ResourceNotFoundException("Carrera no encontrada con ID: " + id);
        }

        carreraRepository.deleteById(id);
        log.info("Carrera eliminada exitosamente con ID: {}", id);
    }

    @Override
    @Transactional
    public void eliminarLogico(Long id) {
        log.info("Eliminando lógicamente carrera con ID: {}", id);

        Carrera carrera = carreraRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Carrera no encontrada con ID: " + id));

        carrera.setActivo(false);
        carreraRepository.save(carrera);

        log.info("Carrera desactivada exitosamente con ID: {}", id);
    }
}


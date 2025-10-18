package org.softprimesolutions.matriculabackend.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.softprimesolutions.matriculabackend.dto.request.FacultadRequestDTO;
import org.softprimesolutions.matriculabackend.dto.response.FacultadResponseDTO;
import org.softprimesolutions.matriculabackend.entity.Facultad;
import org.softprimesolutions.matriculabackend.exception.BusinessException;
import org.softprimesolutions.matriculabackend.exception.ResourceNotFoundException;
import org.softprimesolutions.matriculabackend.mapper.FacultadMapper;
import org.softprimesolutions.matriculabackend.repository.FacultadRepository;
import org.softprimesolutions.matriculabackend.service.IFacultadService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class FacultadServiceImpl implements IFacultadService {

    private final FacultadRepository facultadRepository;
    private final FacultadMapper facultadMapper;

    @Override
    @Transactional
    public FacultadResponseDTO crear(FacultadRequestDTO requestDTO) {
        log.info("Creando nueva facultad: {}", requestDTO.getNombre());

        if (facultadRepository.existsByNombre(requestDTO.getNombre())) {
            throw new BusinessException("Ya existe una facultad con el nombre: " + requestDTO.getNombre());
        }

        Facultad facultad = facultadMapper.toEntity(requestDTO);
        Facultad facultadGuardada = facultadRepository.save(facultad);

        log.info("Facultad creada exitosamente con ID: {}", facultadGuardada.getFacultadId());
        return facultadMapper.toResponseDTO(facultadGuardada);
    }

    @Override
    @Transactional(readOnly = true)
    public FacultadResponseDTO obtenerPorId(Long id) {
        log.info("Buscando facultad con ID: {}", id);

        Facultad facultad = facultadRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Facultad no encontrada con ID: " + id));

        return facultadMapper.toResponseDTO(facultad);
    }

    @Override
    @Transactional(readOnly = true)
    public List<FacultadResponseDTO> obtenerTodos() {
        log.info("Obteniendo todas las facultades");

        List<Facultad> facultades = facultadRepository.findAll();
        return facultadMapper.toResponseDTOList(facultades);
    }

    @Override
    @Transactional(readOnly = true)
    public List<FacultadResponseDTO> obtenerActivos() {
        log.info("Obteniendo facultades activas");

        List<Facultad> facultades = facultadRepository.findByActivoTrue();
        return facultadMapper.toResponseDTOList(facultades);
    }

    @Override
    @Transactional
    public FacultadResponseDTO actualizar(Long id, FacultadRequestDTO requestDTO) {
        log.info("Actualizando facultad con ID: {}", id);

        Facultad facultad = facultadRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Facultad no encontrada con ID: " + id));

        if (facultadRepository.existsByNombreAndFacultadIdNot(requestDTO.getNombre(), id)) {
            throw new BusinessException("Ya existe otra facultad con el nombre: " + requestDTO.getNombre());
        }

        facultadMapper.updateEntityFromDTO(requestDTO, facultad);
        Facultad facultadActualizada = facultadRepository.save(facultad);

        log.info("Facultad actualizada exitosamente con ID: {}", id);
        return facultadMapper.toResponseDTO(facultadActualizada);
    }

    @Override
    @Transactional
    public void eliminar(Long id) {
        log.info("Eliminando facultad con ID: {}", id);

        if (!facultadRepository.existsById(id)) {
            throw new ResourceNotFoundException("Facultad no encontrada con ID: " + id);
        }

        facultadRepository.deleteById(id);
        log.info("Facultad eliminada exitosamente con ID: {}", id);
    }

    @Override
    @Transactional
    public void eliminarLogico(Long id) {
        log.info("Eliminando lógicamente facultad con ID: {}", id);

        Facultad facultad = facultadRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Facultad no encontrada con ID: " + id));

        facultad.setActivo(false);
        facultadRepository.save(facultad);

        log.info("Facultad desactivada exitosamente con ID: {}", id);
    }
}


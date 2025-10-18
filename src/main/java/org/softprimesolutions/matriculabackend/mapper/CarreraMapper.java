package org.softprimesolutions.matriculabackend.mapper;

import org.mapstruct.*;
import org.softprimesolutions.matriculabackend.dto.request.CarreraRequestDTO;
import org.softprimesolutions.matriculabackend.dto.response.CarreraResponseDTO;
import org.softprimesolutions.matriculabackend.entity.Carrera;

import java.util.List;

@Mapper(
    componentModel = "spring",
    nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE
)
public interface CarreraMapper {

    @Mapping(source = "facultad.facultadId", target = "facultadId")
    @Mapping(source = "facultad.nombre", target = "facultadNombre")
    CarreraResponseDTO toResponseDTO(Carrera carrera);

    List<CarreraResponseDTO> toResponseDTOList(List<Carrera> carreras);

    @Mapping(target = "carreraId", ignore = true)
    @Mapping(target = "fechaRegistro", ignore = true)
    @Mapping(target = "facultad", ignore = true)
    Carrera toEntity(CarreraRequestDTO requestDTO);

    @Mapping(target = "carreraId", ignore = true)
    @Mapping(target = "fechaRegistro", ignore = true)
    @Mapping(target = "facultad", ignore = true)
    void updateEntityFromDTO(CarreraRequestDTO requestDTO, @MappingTarget Carrera carrera);
}


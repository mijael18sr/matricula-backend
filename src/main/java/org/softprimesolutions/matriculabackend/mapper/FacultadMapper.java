package org.softprimesolutions.matriculabackend.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValuePropertyMappingStrategy;
import org.softprimesolutions.matriculabackend.dto.request.FacultadRequestDTO;
import org.softprimesolutions.matriculabackend.dto.response.FacultadResponseDTO;
import org.softprimesolutions.matriculabackend.entity.Facultad;

import java.util.List;

@Mapper(
    componentModel = "spring",
    nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE
)
public interface FacultadMapper {

    FacultadResponseDTO toResponseDTO(Facultad facultad);

    List<FacultadResponseDTO> toResponseDTOList(List<Facultad> facultades);

    @Mapping(target = "facultadId", ignore = true)
    @Mapping(target = "fechaRegistro", ignore = true)
    @Mapping(target = "carreras", ignore = true)
    Facultad toEntity(FacultadRequestDTO requestDTO);

    @Mapping(target = "facultadId", ignore = true)
    @Mapping(target = "fechaRegistro", ignore = true)
    @Mapping(target = "carreras", ignore = true)
    void updateEntityFromDTO(FacultadRequestDTO requestDTO, @MappingTarget Facultad facultad);
}


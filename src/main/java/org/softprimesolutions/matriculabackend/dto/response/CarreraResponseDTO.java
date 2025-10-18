package org.softprimesolutions.matriculabackend.dto.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CarreraResponseDTO {

    private Long carreraId;
    private Long facultadId;
    private String facultadNombre;
    private String nombre;
    private String descripcion;
    private Integer duracionSemestres;
    private String tituloOtorgado;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime fechaRegistro;

    private Boolean activo;
}


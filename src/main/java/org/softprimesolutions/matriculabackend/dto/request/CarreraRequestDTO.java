package org.softprimesolutions.matriculabackend.dto.request;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CarreraRequestDTO {

    @NotNull(message = "El ID de la facultad es obligatorio")
    private Long facultadId;

    @NotBlank(message = "El nombre es obligatorio")
    @Size(max = 100, message = "El nombre no puede exceder 100 caracteres")
    private String nombre;

    private String descripcion;

    @NotNull(message = "La duración en semestres es obligatoria")
    @Min(value = 1, message = "La duración debe ser al menos 1 semestre")
    private Integer duracionSemestres;

    @Size(max = 100, message = "El título otorgado no puede exceder 100 caracteres")
    private String tituloOtorgado;

    private Boolean activo;
}


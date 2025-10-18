package org.softprimesolutions.matriculabackend.repository;

import org.softprimesolutions.matriculabackend.entity.Facultad;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FacultadRepository extends JpaRepository<Facultad, Long> {

    List<Facultad> findByActivoTrue();

    Optional<Facultad> findByNombre(String nombre);

    boolean existsByNombre(String nombre);

    boolean existsByNombreAndFacultadIdNot(String nombre, Long facultadId);
}


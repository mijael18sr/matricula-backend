package org.softprimesolutions.matriculabackend.repository;

import org.softprimesolutions.matriculabackend.entity.Carrera;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CarreraRepository extends JpaRepository<Carrera, Long> {

    List<Carrera> findByActivoTrue();

    List<Carrera> findByFacultadFacultadId(Long facultadId);

    @Query("SELECT c FROM Carrera c JOIN FETCH c.facultad WHERE c.carreraId = :id")
    Optional<Carrera> findByIdWithFacultad(@Param("id") Long id);

    @Query("SELECT c FROM Carrera c JOIN FETCH c.facultad")
    List<Carrera> findAllWithFacultad();

    boolean existsByNombre(String nombre);

    boolean existsByNombreAndCarreraIdNot(String nombre, Long carreraId);
}


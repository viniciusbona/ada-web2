package com.ada.web2.repository;

import com.ada.web2.model.Filme;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FilmeRepository extends JpaRepository<Filme, Long> {

    // Métodos de busca personalizados (opcionais)
    List<Filme> findByGenero(String genero);

    List<Filme> findByDiretor(String diretor);

    List<Filme> findByAnoLancamento(Integer anoLancamento);
}

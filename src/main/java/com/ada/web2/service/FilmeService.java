package com.ada.web2.service;

import com.ada.web2.model.Filme;
import com.ada.web2.repository.FilmeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class FilmeService {

    @Autowired
    private FilmeRepository filmeRepository;

    // GET - Buscar todos os filmes
    public List<Filme> buscarTodos() {
        return filmeRepository.findAll();
    }

    // GET - Buscar filme por ID
    public Optional<Filme> buscarPorId(Long id) {
        return filmeRepository.findById(id);
    }

    // POST - Criar novo filme
    public Filme criar(Filme filme) {
        return filmeRepository.save(filme);
    }

    // PUT - Atualizar filme completamente
    public Optional<Filme> atualizarCompleto(Long id, Filme filmeAtualizado) {
        return filmeRepository.findById(id)
                .map(filme -> {
                    filme.setTitulo(filmeAtualizado.getTitulo());
                    filme.setDiretor(filmeAtualizado.getDiretor());
                    filme.setAnoLancamento(filmeAtualizado.getAnoLancamento());
                    filme.setGenero(filmeAtualizado.getGenero());
                    filme.setSinopse(filmeAtualizado.getSinopse());
                    filme.setAvaliacao(filmeAtualizado.getAvaliacao());
                    filme.setDuracaoMinutos(filmeAtualizado.getDuracaoMinutos());
                    return filmeRepository.save(filme);
                });
    }

    // PATCH - Atualizar filme parcialmente
    public Optional<Filme> atualizarParcial(Long id, Filme filmeAtualizado) {
        return filmeRepository.findById(id)
                .map(filme -> {
                    if (filmeAtualizado.getTitulo() != null) {
                        filme.setTitulo(filmeAtualizado.getTitulo());
                    }
                    if (filmeAtualizado.getDiretor() != null) {
                        filme.setDiretor(filmeAtualizado.getDiretor());
                    }
                    if (filmeAtualizado.getAnoLancamento() != null) {
                        filme.setAnoLancamento(filmeAtualizado.getAnoLancamento());
                    }
                    if (filmeAtualizado.getGenero() != null) {
                        filme.setGenero(filmeAtualizado.getGenero());
                    }
                    if (filmeAtualizado.getSinopse() != null) {
                        filme.setSinopse(filmeAtualizado.getSinopse());
                    }
                    if (filmeAtualizado.getAvaliacao() != null) {
                        filme.setAvaliacao(filmeAtualizado.getAvaliacao());
                    }
                    if (filmeAtualizado.getDuracaoMinutos() != null) {
                        filme.setDuracaoMinutos(filmeAtualizado.getDuracaoMinutos());
                    }
                    return filmeRepository.save(filme);
                });
    }

    // DELETE - Deletar filme
    public boolean deletar(Long id) {
        if (filmeRepository.existsById(id)) {
            filmeRepository.deleteById(id);
            return true;
        }
        return false;
    }
}

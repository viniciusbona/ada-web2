package com.ada.web2.controller;

import com.ada.web2.model.Filme;
import com.ada.web2.service.FilmeService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/filmes")
public class FilmeController {

    @Autowired
    private FilmeService filmeService;

    /**
     * GET /filmes - Retorna todos os filmes
     */
    @GetMapping
    public ResponseEntity<List<Filme>> buscarTodos() {
        List<Filme> filmes = filmeService.buscarTodos();
        return ResponseEntity.ok(filmes);
    }

    /**
     * GET /filmes/{id} - Retorna um filme por ID
     */
    @GetMapping("/{id}")
    public ResponseEntity<Filme> buscarPorId(@PathVariable Long id) {
        return filmeService.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    /**
     * POST /filmes - Cria um novo filme
     */
    @PostMapping
    public ResponseEntity<Filme> criar(@Valid @RequestBody Filme filme) {
        Filme filmeCriado = filmeService.criar(filme);
        return ResponseEntity.status(HttpStatus.CREATED).body(filmeCriado);
    }

    /**
     * PUT /filmes/{id} - Atualiza completamente um filme
     */
    @PutMapping("/{id}")
    public ResponseEntity<Filme> atualizarCompleto(
            @PathVariable Long id,
            @Valid @RequestBody Filme filme) {
        return filmeService.atualizarCompleto(id, filme)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    /**
     * PATCH /filmes/{id} - Atualiza parcialmente um filme
     */
    @PatchMapping("/{id}")
    public ResponseEntity<Filme> atualizarParcial(
            @PathVariable Long id,
            @RequestBody Filme filme) {
        return filmeService.atualizarParcial(id, filme)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    /**
     * DELETE /filmes/{id} - Deleta um filme
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletar(@PathVariable Long id) {
        if (filmeService.deletar(id)) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}

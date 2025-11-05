# ada-web2 - Sistema de Gerenciamento de Filmes

Projeto Java programação web II ADA

## 📌 Tema do Projeto

Este projeto implementa uma **API REST para gerenciamento de filmes** utilizando Spring Boot, seguindo a arquitetura MVC e persistência em banco de dados H2.

A API permite realizar operações CRUD completas (Create, Read, Update, Delete) sobre uma base de dados de filmes, incluindo informações como título, diretor, ano de lançamento, gênero, sinopse, avaliação e duração.

## 👥 Integrantes do Grupo

- Vinícius Nunes de Bona
- Roberto Luiz de Andrade Barreto
- Pedro Luiz Vidal Athayde
- Matheus Gomes de Moura

---

## 🔗 Endpoints da API

A API contém os seguintes endpoints para gerenciamento de filmes:

| Método | Rota | Descrição |
|--------|---------------------------|-------------------------------------------|
| GET | `/filmes` | Retorna todos os filmes |
| GET | `/filmes/{id}` | Retorna um filme por ID |
| POST | `/filmes` | Cria um novo filme |
| PUT | `/filmes/{id}` | Atualiza completamente um filme |
| PATCH | `/filmes/{id}` | Atualiza parcialmente um filme |
| DELETE | `/filmes/{id}` | Deleta um filme |

### Modelo de Dados - Filme

```json
{
  "id": 1,
  "titulo": "Matrix",
  "diretor": "Lana Wachowski, Lilly Wachowski",
  "anoLancamento": 1999,
  "genero": "Ficção Científica",
  "sinopse": "Um hacker descobre a verdade sobre sua realidade...",
  "avaliacao": 8.7,
  "duracaoMinutos": 136
}
```

---

## 🚀 Como Executar o Projeto

### Pré-requisitos

- Java 17 ou superior
- Maven 3.6 ou superior

### Modo Rápido - Usando o script run.sh

A forma mais fácil de executar o projeto é usando o script `run.sh`:

```bash
./run.sh
```

O script irá:
- Verificar se Java e Maven estão instalados
- Compilar o projeto automaticamente
- Iniciar a aplicação
- Exibir informações úteis sobre os endpoints

### Modo Manual - Passos para execução

1. Clone o repositório:

```bash
git clone https://github.com/seu-usuario/ada-web2.git
cd ada-web2
```

2. Compile o projeto:

```bash
mvn clean install
```

3. Execute a aplicação:

```bash
mvn spring-boot:run
```

4. A aplicação estará disponível em: `http://localhost:8080`

5. Ao iniciar, a aplicação carrega automaticamente 10 filmes de exemplo no banco de dados

### Acessar o Console H2

O banco de dados H2 possui um console web disponível em:

- URL: `http://localhost:8080/h2-console`
- JDBC URL: `jdbc:h2:mem:filmesdb`
- Username: `sa`
- Password: (deixar em branco)

---

## 🧪 Testando a API

### Modo Rápido - Script de Testes Automatizado

Execute todos os testes da API de uma vez usando o script `test.sh`:

```bash
./test.sh
```

O script irá:
- Verificar se a API está rodando
- Executar 15 testes automatizados cobrindo todos os endpoints
- Testar operações: GET, POST, PUT, PATCH, DELETE
- Validar códigos de status HTTP
- Exibir resultados coloridos e formatados
- Gerar um resumo final com estatísticas

### Exemplos de requisições manuais usando curl:

**Criar um novo filme (POST):**

```bash
curl -X POST http://localhost:8080/filmes \
  -H "Content-Type: application/json" \
  -d '{
    "titulo": "Matrix",
    "diretor": "Lana Wachowski, Lilly Wachowski",
    "anoLancamento": 1999,
    "genero": "Ficção Científica",
    "sinopse": "Um hacker descobre a verdade sobre sua realidade...",
    "avaliacao": 8.7,
    "duracaoMinutos": 136
  }'
```

**Listar todos os filmes (GET):**

```bash
curl http://localhost:8080/filmes
```

**Buscar filme por ID (GET):**

```bash
curl http://localhost:8080/filmes/1
```

**Atualizar filme completamente (PUT):**

```bash
curl -X PUT http://localhost:8080/filmes/1 \
  -H "Content-Type: application/json" \
  -d '{
    "titulo": "Matrix Reloaded",
    "diretor": "Lana Wachowski, Lilly Wachowski",
    "anoLancamento": 2003,
    "genero": "Ficção Científica",
    "sinopse": "Neo continua sua luta...",
    "avaliacao": 7.2,
    "duracaoMinutos": 138
  }'
```

**Atualizar filme parcialmente (PATCH):**

```bash
curl -X PATCH http://localhost:8080/filmes/1 \
  -H "Content-Type: application/json" \
  -d '{
    "avaliacao": 9.0
  }'
```

**Deletar filme (DELETE):**

```bash
curl -X DELETE http://localhost:8080/filmes/1
```

### Dados de Exemplo

A aplicação carrega automaticamente 10 filmes ao iniciar:

1. Matrix (1999) - Ficção Científica
2. O Poderoso Chefão (1972) - Crime/Drama
3. Pulp Fiction (1994) - Crime/Drama
4. Forrest Gump (1994) - Drama/Romance
5. A Origem (2010) - Ficção Científica/Ação
6. Interestelar (2014) - Ficção Científica/Drama
7. Parasita (2019) - Thriller/Drama
8. O Senhor dos Anéis: A Sociedade do Anel (2001) - Fantasia/Aventura
9. Clube da Luta (1999) - Drama
10. Coringa (2019) - Crime/Drama/Thriller

Você pode visualizar todos esses filmes fazendo uma requisição GET em `/filmes` ou acessando o console H2.

---

## 🏗️ Arquitetura do Projeto

O projeto segue a arquitetura MVC (Model-View-Controller):

```text
ada-web2/
├── src/main/java/com/ada/web2/
│   ├── config/            # Configurações da aplicação
│   │   └── DataLoader.java
│   ├── controller/        # Camada de controle (endpoints REST)
│   │   └── FilmeController.java
│   ├── model/             # Camada de modelo (entidades)
│   │   └── Filme.java
│   ├── repository/        # Camada de persistência
│   │   └── FilmeRepository.java
│   ├── service/           # Camada de negócio
│   │   └── FilmeService.java
│   └── Application.java   # Classe principal
├── src/main/resources/
│   └── application.properties  # Configurações do Spring Boot e H2
├── run.sh                 # Script para executar a aplicação
├── test.sh                # Script para testar todos os endpoints
└── pom.xml                # Configuração do Maven
```

---

## 💾 Tecnologias Utilizadas

- **Java 17**
- **Spring Boot 3.2.0**
- **Spring Data JPA**
- **H2 Database** (em memória)
- **Maven**
- **Lombok**

---

## ✅ Checklist de Avaliação

- [x] Funcionalidade dos endpoints
- [x] Conexão com banco de dados H2
- [x] Código limpo e estruturado (arquitetura MVC)
- [x] Uso adequado de boas práticas REST
- [x] Validação de dados com Bean Validation

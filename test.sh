#!/bin/bash

# Script para testar todos os endpoints da API REST
# Sistema de Gerenciamento de Filmes - ADA Web2

API_URL="http://localhost:8080"
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "=========================================="
echo "  Testes da API - Sistema de Filmes"
echo "  ADA - Programação Web II"
echo "=========================================="
echo ""

# Verifica se a API está rodando
echo -n "Verificando se a API está rodando... "
if curl -s -o /dev/null -w "%{http_code}" ${API_URL}/filmes | grep -q "200"; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FALHOU${NC}"
    echo ""
    echo -e "${RED}A API não está rodando!${NC}"
    echo "Execute './run.sh' em outro terminal antes de rodar os testes."
    exit 1
fi

echo ""
echo "=========================================="
echo "  INICIANDO TESTES DOS ENDPOINTS"
echo "=========================================="
echo ""

# Variável para contar testes
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Função para executar teste
run_test() {
    local test_name=$1
    local method=$2
    local endpoint=$3
    local data=$4
    local expected_status=$5

    TOTAL_TESTS=$((TOTAL_TESTS + 1))

    echo -e "${BLUE}[TESTE $TOTAL_TESTS]${NC} $test_name"
    echo -e "${YELLOW}➜${NC} $method $endpoint"

    if [ -z "$data" ]; then
        response=$(curl -s -w "\n%{http_code}" -X $method "${API_URL}${endpoint}")
    else
        response=$(curl -s -w "\n%{http_code}" -X $method "${API_URL}${endpoint}" \
            -H "Content-Type: application/json" \
            -d "$data")
    fi

    # Separa o corpo da resposta do código de status
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | sed '$d')

    # Verifica o código de status
    if [ "$http_code" == "$expected_status" ]; then
        echo -e "${GREEN}✓ Status: $http_code (Esperado: $expected_status)${NC}"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        echo -e "${RED}✗ Status: $http_code (Esperado: $expected_status)${NC}"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi

    # Exibe o corpo da resposta formatado (se houver)
    if [ ! -z "$body" ]; then
        echo "Resposta:"
        echo "$body" | jq '.' 2>/dev/null || echo "$body"
    fi

    echo ""
}

# ==========================================
# TESTE 1: GET - Listar todos os filmes
# ==========================================
run_test "Listar todos os filmes" "GET" "/filmes" "" "200"

# ==========================================
# TESTE 2: GET - Buscar filme por ID (existente)
# ==========================================
run_test "Buscar filme por ID (ID=1)" "GET" "/filmes/1" "" "200"

# ==========================================
# TESTE 3: GET - Buscar filme por ID (inexistente)
# ==========================================
run_test "Buscar filme inexistente (ID=999)" "GET" "/filmes/999" "" "404"

# ==========================================
# TESTE 4: POST - Criar novo filme
# ==========================================
new_movie='{
  "titulo": "Gladiador",
  "diretor": "Ridley Scott",
  "anoLancamento": 2000,
  "genero": "Ação/Drama",
  "sinopse": "Um general romano é traído e sua família assassinada por um corrupto príncipe. Ele retorna como gladiador para buscar vingança.",
  "avaliacao": 8.5,
  "duracaoMinutos": 155
}'
run_test "Criar novo filme (POST)" "POST" "/filmes" "$new_movie" "201"

# ==========================================
# TESTE 5: POST - Criar filme com dados inválidos
# ==========================================
invalid_movie='{
  "titulo": "",
  "diretor": "",
  "genero": ""
}'
run_test "Criar filme com dados inválidos" "POST" "/filmes" "$invalid_movie" "400"

# ==========================================
# TESTE 6: PUT - Atualizar filme completamente
# ==========================================
updated_movie='{
  "titulo": "Matrix Reloaded",
  "diretor": "Lana Wachowski, Lilly Wachowski",
  "anoLancamento": 2003,
  "genero": "Ficção Científica/Ação",
  "sinopse": "Neo e seus aliados continuam sua batalha contra as máquinas.",
  "avaliacao": 7.2,
  "duracaoMinutos": 138
}'
run_test "Atualizar filme completamente (PUT ID=1)" "PUT" "/filmes/1" "$updated_movie" "200"

# ==========================================
# TESTE 7: PATCH - Atualizar filme parcialmente
# ==========================================
partial_update='{
  "avaliacao": 9.0,
  "sinopse": "Um hacker descobre a verdade sobre a Matrix e se torna o escolhido."
}'
run_test "Atualizar filme parcialmente (PATCH ID=1)" "PATCH" "/filmes/1" "$partial_update" "200"

# ==========================================
# TESTE 8: PUT - Atualizar filme inexistente
# ==========================================
run_test "Atualizar filme inexistente (PUT ID=999)" "PUT" "/filmes/999" "$updated_movie" "404"

# ==========================================
# TESTE 9: PATCH - Atualizar filme inexistente
# ==========================================
run_test "Atualizar filme inexistente (PATCH ID=999)" "PATCH" "/filmes/999" "$partial_update" "404"

# ==========================================
# TESTE 10: GET - Verificar filme após atualizações
# ==========================================
run_test "Verificar filme após atualizações (GET ID=1)" "GET" "/filmes/1" "" "200"

# ==========================================
# TESTE 11: DELETE - Deletar filme
# ==========================================
run_test "Deletar filme (DELETE ID=10)" "DELETE" "/filmes/10" "" "204"

# ==========================================
# TESTE 12: DELETE - Deletar filme inexistente
# ==========================================
run_test "Deletar filme inexistente (DELETE ID=999)" "DELETE" "/filmes/999" "" "404"

# ==========================================
# TESTE 13: GET - Verificar se filme foi deletado
# ==========================================
run_test "Verificar filme deletado (GET ID=10)" "GET" "/filmes/10" "" "404"

# ==========================================
# TESTE 14: POST - Criar múltiplos filmes
# ==========================================
new_movie2='{
  "titulo": "Duna",
  "diretor": "Denis Villeneuve",
  "anoLancamento": 2021,
  "genero": "Ficção Científica",
  "sinopse": "Paul Atreides viaja para o planeta mais perigoso do universo para garantir o futuro de sua família.",
  "avaliacao": 8.0,
  "duracaoMinutos": 155
}'
run_test "Criar segundo filme (POST)" "POST" "/filmes" "$new_movie2" "201"

# ==========================================
# TESTE 15: GET - Listar todos os filmes novamente
# ==========================================
run_test "Listar todos os filmes após modificações" "GET" "/filmes" "" "200"

# ==========================================
# RESUMO DOS TESTES
# ==========================================
echo "=========================================="
echo "  RESUMO DOS TESTES"
echo "=========================================="
echo ""
echo -e "Total de testes executados: ${BLUE}$TOTAL_TESTS${NC}"
echo -e "Testes bem-sucedidos: ${GREEN}$PASSED_TESTS${NC}"
echo -e "Testes falhados: ${RED}$FAILED_TESTS${NC}"
echo ""

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "${GREEN}✓ Todos os testes passaram com sucesso!${NC}"
    exit 0
else
    echo -e "${RED}✗ Alguns testes falharam. Verifique os logs acima.${NC}"
    exit 1
fi

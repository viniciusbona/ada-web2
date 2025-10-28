#!/bin/bash

# Script para executar o projeto Spring Boot
# Sistema de Gerenciamento de Filmes - ADA Web2

echo "=========================================="
echo "  Sistema de Gerenciamento de Filmes"
echo "  ADA - Programação Web II"
echo "=========================================="
echo ""

# Verifica se Java está instalado
if ! command -v java &> /dev/null; then
    echo "❌ Java não encontrado!"
    echo "Por favor, instale o Java 17 ou superior."
    exit 1
fi

# Verifica versão do Java
JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1)
echo "✓ Java encontrado: versão $JAVA_VERSION"

if [ "$JAVA_VERSION" -lt 17 ]; then
    echo "⚠️  Aviso: Este projeto requer Java 17 ou superior."
    echo "   Você está usando Java $JAVA_VERSION"
fi

# Verifica se Maven está instalado
if ! command -v mvn &> /dev/null; then
    echo "❌ Maven não encontrado!"
    echo "Por favor, instale o Maven 3.6 ou superior."
    exit 1
fi

MAVEN_VERSION=$(mvn -version | head -n 1 | awk '{print $3}')
echo "✓ Maven encontrado: versão $MAVEN_VERSION"
echo ""

# Compilar o projeto
echo "📦 Compilando o projeto..."
mvn clean install -DskipTests

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Erro ao compilar o projeto!"
    exit 1
fi

echo ""
echo "✅ Compilação concluída com sucesso!"
echo ""
echo "=========================================="
echo "🚀 Iniciando a aplicação..."
echo "=========================================="
echo ""
echo "📍 A aplicação estará disponível em:"
echo "   http://localhost:8080"
echo ""
echo "📍 Console H2 disponível em:"
echo "   http://localhost:8080/h2-console"
echo "   JDBC URL: jdbc:h2:mem:filmesdb"
echo "   Username: sa"
echo "   Password: (deixar em branco)"
echo ""
echo "📋 Endpoints disponíveis:"
echo "   GET    /filmes       - Lista todos os filmes"
echo "   GET    /filmes/{id}  - Busca filme por ID"
echo "   POST   /filmes       - Cria novo filme"
echo "   PUT    /filmes/{id}  - Atualiza filme completo"
echo "   PATCH  /filmes/{id}  - Atualiza filme parcial"
echo "   DELETE /filmes/{id}  - Deleta filme"
echo ""
echo "💡 Pressione Ctrl+C para parar a aplicação"
echo "=========================================="
echo ""

# Executar a aplicação
mvn spring-boot:run

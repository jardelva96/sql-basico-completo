-- ============================================================
-- SQL: Do Básico ao Avançado — Capítulo 1
-- Arquivo: 03_create_produtos.sql
-- Descrição: Criação da tabela de produtos
-- ============================================================

CREATE TABLE IF NOT EXISTS produtos (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    categoria_id   INTEGER NOT NULL,
    nome           TEXT NOT NULL,
    descricao      TEXT,
    preco          DECIMAL(10, 2) NOT NULL CHECK (preco >= 0),
    estoque        INTEGER NOT NULL DEFAULT 0,
    ativo          INTEGER DEFAULT 1,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

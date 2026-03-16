-- ============================================================
-- SQL: Do Básico ao Avançado — Capítulo 1
-- Arquivo: 01_create_categorias.sql
-- Descrição: Criação da tabela de categorias de produtos
-- ============================================================

CREATE TABLE IF NOT EXISTS categorias (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    nome        TEXT NOT NULL UNIQUE,
    descricao   TEXT
);

-- ============================================================
-- SQL: Do Básico ao Avançado — Capítulo 1
-- Arquivo: 02_create_clientes.sql
-- Descrição: Criação da tabela de clientes
-- ============================================================

CREATE TABLE IF NOT EXISTS clientes (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    nome           TEXT NOT NULL,
    email          TEXT UNIQUE NOT NULL,
    telefone       TEXT,
    cidade         TEXT,
    estado         TEXT,
    data_cadastro  DATE DEFAULT CURRENT_DATE
);

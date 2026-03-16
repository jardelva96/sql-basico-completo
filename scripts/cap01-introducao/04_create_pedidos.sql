-- ============================================================
-- SQL: Do Básico ao Avançado — Capítulo 1
-- Arquivo: 04_create_pedidos.sql
-- Descrição: Criação da tabela de pedidos
-- ============================================================

CREATE TABLE IF NOT EXISTS pedidos (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id     INTEGER NOT NULL,
    data_pedido    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_total    DECIMAL(10, 2) NOT NULL,
    status         TEXT DEFAULT 'pendente',
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

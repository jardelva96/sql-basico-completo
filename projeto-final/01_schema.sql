-- ============================================================
-- Projeto Final: Sistema de Loja — Schema
-- ============================================================

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS categorias (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    nome        TEXT NOT NULL UNIQUE,
    descricao   TEXT
);

CREATE TABLE IF NOT EXISTS clientes (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    nome           TEXT NOT NULL,
    email          TEXT UNIQUE NOT NULL,
    telefone       TEXT,
    cidade         TEXT,
    estado         TEXT,
    data_cadastro  DATE DEFAULT CURRENT_DATE
);

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

CREATE TABLE IF NOT EXISTS pedidos (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id     INTEGER NOT NULL,
    data_pedido    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_total    DECIMAL(10, 2) NOT NULL,
    status         TEXT DEFAULT 'pendente',
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE IF NOT EXISTS itens_pedido (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    pedido_id       INTEGER NOT NULL,
    produto_id      INTEGER NOT NULL,
    quantidade      INTEGER NOT NULL CHECK (quantidade > 0),
    preco_unitario  DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

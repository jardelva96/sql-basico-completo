-- ============================================================
-- SQL: Do Básico ao Avançado
-- Arquivo: 00_setup_completo.sql
-- Descrição: Script completo — cria todas as tabelas e insere
--            todos os dados de uma vez. Execute este arquivo
--            para configurar o banco rapidamente.
--
-- Uso: sqlite3 loja.db < scripts/cap01-introducao/00_setup_completo.sql
-- ============================================================

-- Ativar foreign keys no SQLite
PRAGMA foreign_keys = ON;

-- ============================================================
-- CRIAÇÃO DAS TABELAS
-- ============================================================

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

-- ============================================================
-- INSERÇÃO DE DADOS
-- ============================================================

-- Categorias (8 registros)
INSERT INTO categorias (nome, descricao) VALUES
    ('Eletrônicos',    'Smartphones, notebooks, tablets e acessórios'),
    ('Roupas',         'Moda masculina, feminina e infantil'),
    ('Livros',         'Livros físicos e digitais'),
    ('Casa e Jardim',  'Móveis, decoração e jardinagem'),
    ('Esportes',       'Equipamentos e roupas esportivas'),
    ('Alimentos',      'Alimentos, bebidas e suplementos'),
    ('Brinquedos',     'Brinquedos e jogos para todas as idades'),
    ('Informática',    'Componentes, periféricos e software');

-- Clientes (15 registros)
INSERT INTO clientes (nome, email, telefone, cidade, estado) VALUES
    ('Ana Silva',       'ana.silva@email.com',     '(11) 98765-4321', 'São Paulo',       'SP'),
    ('Carlos Santos',   'carlos.s@email.com',      '(21) 91234-5678', 'Rio de Janeiro',  'RJ'),
    ('Maria Oliveira',  'maria.oli@email.com',     '(31) 99876-1234', 'Belo Horizonte',  'MG'),
    ('João Pereira',    'joao.p@email.com',        '(48) 98765-9999', 'Florianópolis',   'SC'),
    ('Fernanda Lima',   'fer.lima@email.com',      '(41) 91111-2222', 'Curitiba',        'PR'),
    ('Roberto Costa',   'roberto.c@email.com',     '(51) 93333-4444', 'Porto Alegre',    'RS'),
    ('Juliana Souza',   'ju.souza@email.com',      '(61) 95555-6666', 'Brasília',        'DF'),
    ('Pedro Almeida',   'pedro.a@email.com',       '(71) 97777-8888', 'Salvador',        'BA'),
    ('Luciana Rocha',   'lu.rocha@email.com',      '(85) 92222-3333', 'Fortaleza',       'CE'),
    ('Marcos Ferreira', 'marcos.f@email.com',      '(62) 94444-5555', 'Goiânia',         'GO'),
    ('Patrícia Dias',   'pat.dias@email.com',      '(27) 96666-7777', 'Vitória',         'ES'),
    ('Rafael Mendes',   'rafa.m@email.com',        '(92) 98888-9999', 'Manaus',          'AM'),
    ('Camila Barbosa',  'camila.b@email.com',      NULL,              'São Paulo',       'SP'),
    ('Thiago Nunes',    'thiago.n@email.com',      '(11) 91010-2020', 'São Paulo',       'SP'),
    ('Beatriz Araujo',  'bia.araujo@email.com',    '(21) 93030-4040', 'Rio de Janeiro',  'RJ');

-- Produtos (20 registros)
INSERT INTO produtos (categoria_id, nome, descricao, preco, estoque, ativo) VALUES
    (1, 'Smartphone Galaxy S24',   'Samsung 256GB 8RAM',              4299.99, 25, 1),
    (1, 'Notebook Dell Inspiron',   'Intel i7 16GB 512SSD',           5499.00, 12, 1),
    (1, 'Tablet iPad Air',          'Apple M2 64GB WiFi',             6299.00,  8, 1),
    (1, 'Fone Bluetooth JBL',       'JBL Tune 520BT',                 249.90, 50, 1),
    (2, 'Camiseta Polo',            'Algodão premium M/G/GG',          89.90, 100, 1),
    (2, 'Calça Jeans Slim',         'Jeans escuro 38 a 46',           159.90, 60, 1),
    (3, 'SQL para Iniciantes',      'Ebook - Guia Completo',           49.90, 999, 1),
    (3, 'Clean Code',               'Robert C. Martin',                79.90, 30, 1),
    (4, 'Mesa de Escritório',       'MDF 120x60cm branca',            459.00, 15, 1),
    (4, 'Luminária LED',            'Articulada USB 3 tons',           89.00, 40, 1),
    (5, 'Tênis de Corrida Nike',    'Air Zoom Pegasus 41',            699.90, 20, 1),
    (5, 'Haltere Emborrachado 10kg','Par - revestimento emborrachado', 189.90, 35, 1),
    (6, 'Whey Protein 1kg',         'Concentrado sabor chocolate',    129.90, 45, 1),
    (7, 'LEGO Technic',             '1580 peças - Kit Avançado',      599.90, 10, 1),
    (8, 'Mouse Gamer Logitech',     'G502 HERO 25600 DPI',           299.90, 30, 1),
    (8, 'Teclado Mecânico',         'Redragon Kumara RGB',            249.90, 25, 1),
    (8, 'Monitor 27 pol',           'LG UltraGear 144Hz IPS',       1899.00,  8, 1),
    (1, 'Carregador Portátil',      'Power Bank 20000mAh',            149.90, 60, 1),
    (2, 'Jaqueta Corta-Vento',      'Impermeável unissex',            229.90, 30, 0),
    (3, 'Python Fluente',           'Luciano Ramalho - 2a ed.',       119.90, 20, 1);

-- Pedidos (15 registros)
INSERT INTO pedidos (cliente_id, data_pedido, valor_total, status) VALUES
    (1,  '2025-01-15 10:30:00', 4549.89, 'entregue'),
    (2,  '2025-01-20 14:15:00', 249.90,  'entregue'),
    (3,  '2025-02-05 09:00:00', 5658.90, 'entregue'),
    (1,  '2025-02-14 16:45:00', 89.90,   'entregue'),
    (4,  '2025-03-01 11:20:00', 1399.80, 'enviado'),
    (5,  '2025-03-10 08:30:00', 459.00,  'enviado'),
    (6,  '2025-03-15 17:00:00', 829.80,  'pendente'),
    (7,  '2025-03-20 13:10:00', 129.90,  'pendente'),
    (2,  '2025-04-01 10:00:00', 6598.90, 'entregue'),
    (8,  '2025-04-05 15:30:00', 599.90,  'cancelado'),
    (3,  '2025-04-10 09:45:00', 249.90,  'entregue'),
    (9,  '2025-04-15 12:00:00', 1899.00, 'enviado'),
    (10, '2025-05-01 14:20:00', 339.80,  'pendente'),
    (1,  '2025-05-10 11:00:00', 699.90,  'enviado'),
    (4,  '2025-05-20 16:30:00', 79.90,   'entregue');

-- Itens de Pedido (20 registros)
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
    (1,  1,  1, 4299.99),
    (1,  4,  1,  249.90),
    (2,  4,  1,  249.90),
    (3,  2,  1, 5499.00),
    (3,  6,  1,  159.90),
    (4,  5,  1,   89.90),
    (5, 11,  2,  699.90),
    (6,  9,  1,  459.00),
    (7,  8,  1,   79.90),
    (7, 15,  1,  299.90),
    (8, 13,  1,  129.90),
    (9,  3,  1, 6299.00),
    (9, 15,  1,  299.90),
    (10, 14, 1,  599.90),
    (11,  4, 1,  249.90),
    (12, 17, 1, 1899.00),
    (13, 12, 1,  189.90),
    (13, 18, 1,  149.90),
    (14, 11, 1,  699.90),
    (15,  8, 1,   79.90);

-- ============================================================
-- VERIFICAÇÃO
-- ============================================================
SELECT '✅ Categorias:    ' || COUNT(*) FROM categorias;
SELECT '✅ Clientes:      ' || COUNT(*) FROM clientes;
SELECT '✅ Produtos:      ' || COUNT(*) FROM produtos;
SELECT '✅ Pedidos:       ' || COUNT(*) FROM pedidos;
SELECT '✅ Itens Pedido:  ' || COUNT(*) FROM itens_pedido;
SELECT '🎉 Banco de dados configurado com sucesso!';

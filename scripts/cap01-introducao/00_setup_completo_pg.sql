-- ============================================================
-- SQL: Do Básico ao Avançado — Versão PostgreSQL
-- Uso: psql loja < scripts/cap01-introducao/00_setup_completo_pg.sql
-- ============================================================

DROP TABLE IF EXISTS itens_pedido CASCADE;
DROP TABLE IF EXISTS pedidos CASCADE;
DROP TABLE IF EXISTS produtos CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;
DROP TABLE IF EXISTS categorias CASCADE;

CREATE TABLE categorias (
    id          SERIAL PRIMARY KEY,
    nome        VARCHAR(100) NOT NULL UNIQUE,
    descricao   TEXT
);

CREATE TABLE clientes (
    id             SERIAL PRIMARY KEY,
    nome           VARCHAR(200) NOT NULL,
    email          VARCHAR(200) UNIQUE NOT NULL,
    telefone       VARCHAR(20),
    cidade         VARCHAR(100),
    estado         VARCHAR(2),
    data_cadastro  DATE DEFAULT CURRENT_DATE
);

CREATE TABLE produtos (
    id             SERIAL PRIMARY KEY,
    categoria_id   INTEGER NOT NULL REFERENCES categorias(id),
    nome           VARCHAR(200) NOT NULL,
    descricao      TEXT,
    preco          NUMERIC(10, 2) NOT NULL CHECK (preco >= 0),
    estoque        INTEGER NOT NULL DEFAULT 0,
    ativo          BOOLEAN DEFAULT TRUE
);

CREATE TABLE pedidos (
    id             SERIAL PRIMARY KEY,
    cliente_id     INTEGER NOT NULL REFERENCES clientes(id),
    data_pedido    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_total    NUMERIC(10, 2) NOT NULL,
    status         VARCHAR(20) DEFAULT 'pendente'
);

CREATE TABLE itens_pedido (
    id              SERIAL PRIMARY KEY,
    pedido_id       INTEGER NOT NULL REFERENCES pedidos(id),
    produto_id      INTEGER NOT NULL REFERENCES produtos(id),
    quantidade      INTEGER NOT NULL CHECK (quantidade > 0),
    preco_unitario  NUMERIC(10, 2) NOT NULL
);

INSERT INTO categorias (nome, descricao) VALUES
    ('Eletrônicos', 'Smartphones, notebooks, tablets e acessórios'),
    ('Roupas', 'Moda masculina, feminina e infantil'),
    ('Livros', 'Livros físicos e digitais'),
    ('Casa e Jardim', 'Móveis, decoração e jardinagem'),
    ('Esportes', 'Equipamentos e roupas esportivas'),
    ('Alimentos', 'Alimentos, bebidas e suplementos'),
    ('Brinquedos', 'Brinquedos e jogos para todas as idades'),
    ('Informática', 'Componentes, periféricos e software');

INSERT INTO clientes (nome, email, telefone, cidade, estado) VALUES
    ('Ana Silva','ana.silva@email.com','(11) 98765-4321','São Paulo','SP'),
    ('Carlos Santos','carlos.s@email.com','(21) 91234-5678','Rio de Janeiro','RJ'),
    ('Maria Oliveira','maria.oli@email.com','(31) 99876-1234','Belo Horizonte','MG'),
    ('João Pereira','joao.p@email.com','(48) 98765-9999','Florianópolis','SC'),
    ('Fernanda Lima','fer.lima@email.com','(41) 91111-2222','Curitiba','PR'),
    ('Roberto Costa','roberto.c@email.com','(51) 93333-4444','Porto Alegre','RS'),
    ('Juliana Souza','ju.souza@email.com','(61) 95555-6666','Brasília','DF'),
    ('Pedro Almeida','pedro.a@email.com','(71) 97777-8888','Salvador','BA'),
    ('Luciana Rocha','lu.rocha@email.com','(85) 92222-3333','Fortaleza','CE'),
    ('Marcos Ferreira','marcos.f@email.com','(62) 94444-5555','Goiânia','GO'),
    ('Patrícia Dias','pat.dias@email.com','(27) 96666-7777','Vitória','ES'),
    ('Rafael Mendes','rafa.m@email.com','(92) 98888-9999','Manaus','AM'),
    ('Camila Barbosa','camila.b@email.com',NULL,'São Paulo','SP'),
    ('Thiago Nunes','thiago.n@email.com','(11) 91010-2020','São Paulo','SP'),
    ('Beatriz Araujo','bia.araujo@email.com','(21) 93030-4040','Rio de Janeiro','RJ');

INSERT INTO produtos (categoria_id, nome, descricao, preco, estoque, ativo) VALUES
    (1,'Smartphone Galaxy S24','Samsung 256GB 8RAM',4299.99,25,TRUE),
    (1,'Notebook Dell Inspiron','Intel i7 16GB 512SSD',5499.00,12,TRUE),
    (1,'Tablet iPad Air','Apple M2 64GB WiFi',6299.00,8,TRUE),
    (1,'Fone Bluetooth JBL','JBL Tune 520BT',249.90,50,TRUE),
    (2,'Camiseta Polo','Algodão premium M/G/GG',89.90,100,TRUE),
    (2,'Calça Jeans Slim','Jeans escuro 38 a 46',159.90,60,TRUE),
    (3,'SQL para Iniciantes','Ebook - Guia Completo',49.90,999,TRUE),
    (3,'Clean Code','Robert C. Martin',79.90,30,TRUE),
    (4,'Mesa de Escritório','MDF 120x60cm branca',459.00,15,TRUE),
    (4,'Luminária LED','Articulada USB 3 tons',89.00,40,TRUE),
    (5,'Tênis de Corrida Nike','Air Zoom Pegasus 41',699.90,20,TRUE),
    (5,'Haltere Emborrachado 10kg','Par - revestimento emborrachado',189.90,35,TRUE),
    (6,'Whey Protein 1kg','Concentrado sabor chocolate',129.90,45,TRUE),
    (7,'LEGO Technic','1580 peças - Kit Avançado',599.90,10,TRUE),
    (8,'Mouse Gamer Logitech','G502 HERO 25600 DPI',299.90,30,TRUE),
    (8,'Teclado Mecânico','Redragon Kumara RGB',249.90,25,TRUE),
    (8,'Monitor 27 pol','LG UltraGear 144Hz IPS',1899.00,8,TRUE),
    (1,'Carregador Portátil','Power Bank 20000mAh',149.90,60,TRUE),
    (2,'Jaqueta Corta-Vento','Impermeável unissex',229.90,30,FALSE),
    (3,'Python Fluente','Luciano Ramalho - 2a ed.',119.90,20,TRUE);

INSERT INTO pedidos (cliente_id, data_pedido, valor_total, status) VALUES
    (1,'2025-01-15 10:30:00',4549.89,'entregue'),(2,'2025-01-20 14:15:00',249.90,'entregue'),
    (3,'2025-02-05 09:00:00',5658.90,'entregue'),(1,'2025-02-14 16:45:00',89.90,'entregue'),
    (4,'2025-03-01 11:20:00',1399.80,'enviado'),(5,'2025-03-10 08:30:00',459.00,'enviado'),
    (6,'2025-03-15 17:00:00',829.80,'pendente'),(7,'2025-03-20 13:10:00',129.90,'pendente'),
    (2,'2025-04-01 10:00:00',6598.90,'entregue'),(8,'2025-04-05 15:30:00',599.90,'cancelado'),
    (3,'2025-04-10 09:45:00',249.90,'entregue'),(9,'2025-04-15 12:00:00',1899.00,'enviado'),
    (10,'2025-05-01 14:20:00',339.80,'pendente'),(1,'2025-05-10 11:00:00',699.90,'enviado'),
    (4,'2025-05-20 16:30:00',79.90,'entregue');

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
    (1,1,1,4299.99),(1,4,1,249.90),(2,4,1,249.90),(3,2,1,5499.00),(3,6,1,159.90),
    (4,5,1,89.90),(5,11,2,699.90),(6,9,1,459.00),(7,8,1,79.90),(7,15,1,299.90),
    (8,13,1,129.90),(9,3,1,6299.00),(9,15,1,299.90),(10,14,1,599.90),(11,4,1,249.90),
    (12,17,1,1899.00),(13,12,1,189.90),(13,18,1,149.90),(14,11,1,699.90),(15,8,1,79.90);

SELECT 'Banco PostgreSQL configurado com sucesso!' AS status;

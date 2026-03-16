-- ============================================================
-- SQL: Do Básico ao Avançado — Capítulo 1
-- Arquivo: 08_insert_produtos.sql
-- Descrição: Inserção de dados na tabela produtos
-- ============================================================

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

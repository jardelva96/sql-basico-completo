-- ============================================================
-- SQL: Do Básico ao Avançado — Capítulo 1
-- Arquivo: 10_insert_itens_pedido.sql
-- Descrição: Inserção de dados na tabela itens_pedido
-- ============================================================

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
    (1,  1,  1, 4299.99),  -- Pedido 1: Smartphone Galaxy S24
    (1,  4,  1,  249.90),  -- Pedido 1: Fone Bluetooth JBL
    (2,  4,  1,  249.90),  -- Pedido 2: Fone Bluetooth JBL
    (3,  2,  1, 5499.00),  -- Pedido 3: Notebook Dell Inspiron
    (3,  6,  1,  159.90),  -- Pedido 3: Calça Jeans Slim
    (4,  5,  1,   89.90),  -- Pedido 4: Camiseta Polo
    (5, 11,  2,  699.90),  -- Pedido 5: 2x Tênis de Corrida Nike
    (6,  9,  1,  459.00),  -- Pedido 6: Mesa de Escritório
    (7,  8,  1,   79.90),  -- Pedido 7: Clean Code
    (7, 15,  1,  299.90),  -- Pedido 7: Mouse Gamer Logitech
    (8, 13,  1,  129.90),  -- Pedido 8: Whey Protein
    (9,  3,  1, 6299.00),  -- Pedido 9: Tablet iPad Air
    (9, 15,  1,  299.90),  -- Pedido 9: Mouse Gamer Logitech
    (10, 14, 1,  599.90),  -- Pedido 10: LEGO Technic
    (11,  4, 1,  249.90),  -- Pedido 11: Fone Bluetooth JBL
    (12, 17, 1, 1899.00),  -- Pedido 12: Monitor 27 pol
    (13, 12, 1,  189.90),  -- Pedido 13: Haltere Emborrachado
    (13, 18, 1,  149.90),  -- Pedido 13: Carregador Portátil
    (14, 11, 1,  699.90),  -- Pedido 14: Tênis de Corrida Nike
    (15,  8, 1,   79.90);  -- Pedido 15: Clean Code

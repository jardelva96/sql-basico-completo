-- ============================================================
-- Capítulo 11: Índices e Performance
-- ============================================================

-- Criar índices nas FKs
CREATE INDEX IF NOT EXISTS idx_produtos_categoria ON produtos(categoria_id);
CREATE INDEX IF NOT EXISTS idx_pedidos_cliente ON pedidos(cliente_id);
CREATE INDEX IF NOT EXISTS idx_pedidos_data ON pedidos(data_pedido);
CREATE INDEX IF NOT EXISTS idx_itens_pedido ON itens_pedido(pedido_id);
CREATE INDEX IF NOT EXISTS idx_itens_produto ON itens_pedido(produto_id);

-- Índice composto
CREATE INDEX IF NOT EXISTS idx_pedidos_status_data ON pedidos(status, data_pedido);

-- Índice para buscas por email
CREATE INDEX IF NOT EXISTS idx_clientes_email ON clientes(email);
CREATE INDEX IF NOT EXISTS idx_clientes_cidade ON clientes(cidade);

-- EXPLAIN QUERY PLAN — comparar com e sem índice
EXPLAIN QUERY PLAN SELECT * FROM clientes WHERE email = 'ana.silva@email.com';
EXPLAIN QUERY PLAN SELECT * FROM pedidos WHERE cliente_id = 1;
EXPLAIN QUERY PLAN SELECT * FROM pedidos WHERE status = 'entregue' AND data_pedido > '2025-03-01';

-- Atualizar estatísticas
ANALYZE;

-- Listar índices existentes
SELECT name, tbl_name FROM sqlite_master WHERE type = 'index' ORDER BY tbl_name;

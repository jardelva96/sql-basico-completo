-- ============================================================
-- Exercícios Resolvidos — Capítulo 11: Índices e Performance
-- ============================================================
-- Execute 00_setup_completo.sql antes de resolver os exercícios.
-- Tente resolver antes de olhar as respostas!
-- ============================================================

-- Exercício 1: Criar índices nas colunas de FK
CREATE INDEX IF NOT EXISTS idx_pedidos_cliente_id
    ON pedidos(cliente_id);

CREATE INDEX IF NOT EXISTS idx_itens_pedido_id
    ON itens_pedido(pedido_id);

CREATE INDEX IF NOT EXISTS idx_itens_produto_id
    ON itens_pedido(produto_id);

CREATE INDEX IF NOT EXISTS idx_produtos_categoria_id
    ON produtos(categoria_id);

-- Exercício 2: EXPLAIN QUERY PLAN comparando busca por email com/sem índice
-- Sem índice (veja o SCAN):
EXPLAIN QUERY PLAN
SELECT * FROM clientes WHERE email = 'ana.silva@email.com';

-- Criar índice:
CREATE INDEX IF NOT EXISTS idx_clientes_email ON clientes(email);

-- Com índice (veja o SEARCH USING INDEX):
EXPLAIN QUERY PLAN
SELECT * FROM clientes WHERE email = 'ana.silva@email.com';

-- Exercício 3: Índice composto em pedidos(status, data_pedido) + EXPLAIN
CREATE INDEX IF NOT EXISTS idx_pedidos_status_data
    ON pedidos(status, data_pedido);

EXPLAIN QUERY PLAN
SELECT * FROM pedidos
WHERE status = 'entregue'
  AND data_pedido >= '2025-03-01';

-- Exercício 4: Consultas dos capítulos anteriores que se beneficiam de índices
-- Esta consulta do cap07 usa JOIN em cliente_id -> já coberta pelo índice criado
EXPLAIN QUERY PLAN
SELECT p.id, c.nome, p.valor_total
FROM pedidos p
INNER JOIN clientes c ON c.id = p.cliente_id
WHERE p.status = 'entregue';

-- Exercício 5: ANALYZE para atualizar estatísticas do otimizador
ANALYZE;

-- Re-verificar plano após ANALYZE:
EXPLAIN QUERY PLAN
SELECT * FROM pedidos WHERE status = 'entregue' AND data_pedido >= '2025-01-01';

-- Exercício 6: (Pesquisa teórica)
-- B-Tree: estrutura em árvore balanceada. Suporta range queries (>, <, BETWEEN, LIKE 'x%').
--         É o tipo padrão em SQLite, PostgreSQL e MySQL.
-- Hash:   Tabela hash. Muito rápido para igualdade (=) mas NÃO suporta ranges.
--         Disponível no PostgreSQL com CREATE INDEX USING HASH.
--         Não existe em SQLite.

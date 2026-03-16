-- ============================================================
-- Capítulo 12: Transações e ACID
-- ============================================================

-- Transação básica: criar pedido completo
BEGIN TRANSACTION;

INSERT INTO pedidos (cliente_id, valor_total, status)
VALUES (1, 4549.89, 'pendente');

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario)
VALUES
    (last_insert_rowid(), 1, 1, 4299.99),
    (last_insert_rowid(), 4, 1, 249.90);

UPDATE produtos SET estoque = estoque - 1 WHERE id = 1;
UPDATE produtos SET estoque = estoque - 1 WHERE id = 4;

COMMIT;

-- SAVEPOINT exemplo
BEGIN TRANSACTION;

INSERT INTO clientes (nome, email, cidade, estado)
VALUES ('Teste 1', 'teste1@email.com', 'SP', 'SP');

SAVEPOINT antes_teste2;

INSERT INTO clientes (nome, email, cidade, estado)
VALUES ('Teste 2', 'teste2@email.com', 'RJ', 'RJ');

ROLLBACK TO antes_teste2;  -- Desfaz Teste 2, mantém Teste 1

COMMIT;

-- Performance: INSERT em lote com transação
BEGIN TRANSACTION;
-- Múltiplos INSERTs aqui são muito mais rápidos dentro de uma transação
COMMIT;

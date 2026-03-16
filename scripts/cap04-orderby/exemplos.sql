-- ============================================================
-- Capítulo 4: ORDER BY — Ordenação
-- ============================================================

-- 4.1 Ordenação Simples
SELECT nome, preco FROM produtos ORDER BY preco;
SELECT nome, preco FROM produtos ORDER BY preco DESC;
SELECT nome, cidade FROM clientes ORDER BY nome ASC;
SELECT id, data_pedido, valor_total FROM pedidos ORDER BY data_pedido DESC;

-- 4.2 Múltiplas Colunas
SELECT nome, cidade, estado FROM clientes ORDER BY estado ASC, nome ASC;
SELECT categoria_id, nome, preco FROM produtos WHERE ativo = 1 ORDER BY categoria_id ASC, preco DESC;

-- 4.3 Ordenação por Expressão
SELECT nome, preco, estoque, preco * estoque AS valor_em_estoque
FROM produtos WHERE ativo = 1 ORDER BY preco * estoque DESC;

SELECT nome, LENGTH(nome) AS tam FROM clientes ORDER BY LENGTH(nome) DESC;

-- 4.4 Top N
SELECT nome, preco FROM produtos WHERE ativo = 1 ORDER BY preco DESC LIMIT 5;
SELECT id, cliente_id, data_pedido, valor_total FROM pedidos ORDER BY data_pedido DESC LIMIT 3;
SELECT nome, preco FROM produtos WHERE categoria_id = 1 AND ativo = 1 ORDER BY preco ASC LIMIT 1;

-- ============================================================
-- Exercícios Resolvidos — Capítulo 3: WHERE
-- ============================================================
-- Execute 00_setup_completo.sql antes de resolver os exercícios.
-- Tente resolver antes de olhar as respostas!
-- ============================================================

-- Exercício 1: Busque todos os clientes da cidade de São Paulo
SELECT nome, email, cidade FROM clientes WHERE cidade = 'São Paulo';

-- Exercício 2: Liste produtos com preço entre R$ 50 e R$ 200
SELECT nome, preco FROM produtos WHERE preco BETWEEN 50 AND 200 ORDER BY preco;

-- Exercício 3: Encontre clientes cujo nome começa com a letra 'J'
SELECT nome, email FROM clientes WHERE nome LIKE 'J%';

-- Exercício 4: Liste todos os pedidos de 2025 com status 'entregue'
SELECT id, cliente_id, data_pedido, valor_total
FROM pedidos
WHERE data_pedido BETWEEN '2025-01-01' AND '2025-12-31'
  AND status = 'entregue';

-- Exercício 5: Quais produtos estão sem estoque (estoque = 0)?
SELECT nome, preco, estoque FROM produtos WHERE estoque = 0;

-- Exercício 6: Busque clientes sem telefone cadastrado (NULL)
SELECT nome, email FROM clientes WHERE telefone IS NULL;

-- Exercício 7: Produtos das categorias 1, 3 ou 8 com preço abaixo de R$ 300
SELECT nome, preco, categoria_id
FROM produtos
WHERE categoria_id IN (1, 3, 8)
  AND preco < 300
  AND ativo = 1
ORDER BY preco;

-- Exercício 8: Pedidos com valor entre R$ 100 e R$ 1000 não cancelados
SELECT id, cliente_id, valor_total, status
FROM pedidos
WHERE valor_total BETWEEN 100 AND 1000
  AND status != 'cancelado'
ORDER BY valor_total;

-- Exercício 9: Produtos com 'Bluetooth' ou 'Gamer' no nome
SELECT nome, preco
FROM produtos
WHERE nome LIKE '%Bluetooth%' OR nome LIKE '%Gamer%';

-- Exercício 10: Clientes que NÃO são de SP nem de RJ, ordenados por nome
SELECT nome, cidade, estado
FROM clientes
WHERE estado NOT IN ('SP', 'RJ')
ORDER BY nome;

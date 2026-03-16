-- ============================================================
-- Capítulo 3: WHERE — Filtrando Dados
-- ============================================================

-- 3.1 Operadores de Comparação
SELECT nome, preco FROM produtos WHERE preco > 500;
SELECT nome, email, cidade FROM clientes WHERE cidade = 'São Paulo';
SELECT nome, estoque, preco FROM produtos WHERE estoque < 15;

-- 3.2 Operadores Lógicos: AND, OR, NOT
SELECT nome, preco, estoque FROM produtos WHERE preco > 100 AND estoque > 20;
SELECT nome, cidade FROM clientes WHERE cidade = 'São Paulo' OR cidade = 'Rio de Janeiro';
SELECT nome, preco FROM produtos WHERE NOT categoria_id = 1;

-- Combinando (use parênteses!)
SELECT nome, preco, estoque
FROM produtos
WHERE (categoria_id = 1 OR categoria_id = 8)
  AND preco < 500
  AND ativo = 1;

-- 3.3 IN — Lista de Valores
SELECT nome, cidade, estado FROM clientes
WHERE cidade IN ('São Paulo', 'Rio de Janeiro', 'Belo Horizonte');

SELECT id, cliente_id, valor_total, status FROM pedidos
WHERE status IN ('pendente', 'enviado');

SELECT nome, preco FROM produtos WHERE categoria_id NOT IN (1, 8);

-- 3.4 BETWEEN — Faixa de Valores
SELECT nome, preco FROM produtos WHERE preco BETWEEN 50 AND 300;

SELECT id, cliente_id, data_pedido, valor_total FROM pedidos
WHERE data_pedido BETWEEN '2025-01-01' AND '2025-03-31';

-- 3.5 LIKE — Busca por Padrões
SELECT nome, email FROM clientes WHERE nome LIKE 'M%';
SELECT nome, email FROM clientes WHERE email LIKE '%@email.com';
SELECT nome, preco FROM produtos WHERE nome LIKE '%Gamer%';

-- 3.6 IS NULL / IS NOT NULL
SELECT nome, email FROM clientes WHERE telefone IS NULL;
SELECT nome, telefone FROM clientes WHERE telefone IS NOT NULL;

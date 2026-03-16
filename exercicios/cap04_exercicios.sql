-- ============================================================
-- Exercícios Resolvidos — Capítulo 4: ORDER BY
-- ============================================================
-- Execute 00_setup_completo.sql antes de resolver os exercícios.
-- Tente resolver antes de olhar as respostas!
-- ============================================================

-- Exercício 1: Liste todos os produtos ordenados por preço (crescente)
SELECT nome, preco FROM produtos ORDER BY preco ASC;

-- Exercício 2: Mostre os 5 clientes mais recentes (por data_cadastro DESC)
SELECT nome, cidade, data_cadastro FROM clientes ORDER BY data_cadastro DESC LIMIT 5;

-- Exercício 3: Produtos por categoria_id e depois por nome dentro de cada categoria
SELECT categoria_id, nome, preco
FROM produtos
WHERE ativo = 1
ORDER BY categoria_id ASC, nome ASC;

-- Exercício 4: Encontre o pedido com maior valor_total
SELECT id, cliente_id, valor_total, status
FROM pedidos
ORDER BY valor_total DESC
LIMIT 1;

-- Exercício 5: Os 3 produtos com menor estoque que ainda estão ativos
SELECT nome, estoque, preco
FROM produtos
WHERE ativo = 1
ORDER BY estoque ASC
LIMIT 3;

-- Exercício 6: Clientes por estado e dentro de cada estado por cidade
SELECT nome, estado, cidade
FROM clientes
ORDER BY estado ASC, cidade ASC;

-- Exercício 7: Calcule valor em estoque (preco * estoque) e mostre Top 5
SELECT
    nome,
    preco,
    estoque,
    ROUND(preco * estoque, 2) AS valor_em_estoque
FROM produtos
WHERE ativo = 1
ORDER BY preco * estoque DESC
LIMIT 5;

-- Exercício 8: Pedidos por status (A-Z) e depois por data (mais recente primeiro)
SELECT id, status, data_pedido, valor_total
FROM pedidos
ORDER BY status ASC, data_pedido DESC;

-- ============================================================
-- Exercícios Resolvidos — Capítulo 10: Window Functions
-- ============================================================
-- Execute 00_setup_completo.sql antes de resolver os exercícios.
-- Tente resolver antes de olhar as respostas!
-- ============================================================

-- Exercício 1: Ranking de produtos por preço (mais caro = posição 1)
SELECT
    nome,
    preco,
    ROW_NUMBER() OVER (ORDER BY preco DESC) AS posicao
FROM produtos
WHERE ativo = 1
ORDER BY posicao;

-- Exercício 2: Produto mais caro de cada categoria (ROW_NUMBER + CTE)
WITH ranking AS (
    SELECT
        pr.nome,
        cat.nome AS categoria,
        pr.preco,
        ROW_NUMBER() OVER (PARTITION BY pr.categoria_id ORDER BY pr.preco DESC) AS rn
    FROM produtos pr
    INNER JOIN categorias cat ON cat.id = pr.categoria_id
    WHERE pr.ativo = 1
)
SELECT nome, categoria, preco
FROM ranking
WHERE rn = 1
ORDER BY preco DESC;

-- Exercício 3: Total acumulado de receita ordenado por data do pedido
SELECT
    data_pedido,
    valor_total,
    ROUND(SUM(valor_total) OVER (
        ORDER BY data_pedido
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 2) AS receita_acumulada
FROM pedidos
WHERE status != 'cancelado'
ORDER BY data_pedido;

-- Exercício 4: Variação de valor entre pedidos consecutivos de Ana Silva
SELECT
    c.nome,
    p.data_pedido,
    p.valor_total,
    LAG(p.valor_total) OVER (ORDER BY p.data_pedido)   AS pedido_anterior,
    ROUND(p.valor_total - LAG(p.valor_total) OVER (ORDER BY p.data_pedido), 2) AS variacao
FROM pedidos p
INNER JOIN clientes c ON c.id = p.cliente_id
WHERE c.nome = 'Ana Silva'
ORDER BY p.data_pedido;

-- Exercício 5: Percentual de cada produto sobre o preco total em estoque
SELECT
    nome,
    preco,
    estoque,
    ROUND(preco * estoque, 2) AS valor_estoque,
    ROUND(100.0 * (preco * estoque) / SUM(preco * estoque) OVER (), 2) AS percentual
FROM produtos
WHERE ativo = 1
ORDER BY valor_estoque DESC;

-- Exercício 6: Média móvel de 3 pedidos para valor_total
SELECT
    data_pedido,
    valor_total,
    ROUND(AVG(valor_total) OVER (
        ORDER BY data_pedido
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS media_movel_3
FROM pedidos
WHERE status != 'cancelado'
ORDER BY data_pedido;

-- Exercício 7: DENSE_RANK para rankear clientes por gasto total
WITH gastos AS (
    SELECT c.nome, ROUND(SUM(p.valor_total),2) AS gasto_total
    FROM clientes c
    INNER JOIN pedidos p ON p.cliente_id = c.id
    WHERE p.status != 'cancelado'
    GROUP BY c.id, c.nome
)
SELECT
    nome,
    gasto_total,
    DENSE_RANK() OVER (ORDER BY gasto_total DESC) AS posicao
FROM gastos
ORDER BY posicao;

-- Exercício 8: Pedido anterior e próximo de cada cliente (LAG + LEAD)
SELECT
    c.nome,
    p.data_pedido,
    p.valor_total,
    LAG(p.valor_total)  OVER (PARTITION BY p.cliente_id ORDER BY p.data_pedido) AS pedido_anterior,
    LEAD(p.valor_total) OVER (PARTITION BY p.cliente_id ORDER BY p.data_pedido) AS proximo_pedido
FROM pedidos p
INNER JOIN clientes c ON c.id = p.cliente_id
ORDER BY c.nome, p.data_pedido;

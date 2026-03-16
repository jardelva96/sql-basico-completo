-- ============================================================
-- Capítulo 10: Window Functions
-- ============================================================

-- 10.1 Window vs GROUP BY
SELECT nome, cidade, COUNT(*) OVER (PARTITION BY cidade) AS total_na_cidade
FROM clientes ORDER BY cidade, nome;

-- 10.2 ROW_NUMBER, RANK, DENSE_RANK
SELECT nome, categoria_id, preco,
    ROW_NUMBER() OVER (PARTITION BY categoria_id ORDER BY preco DESC) AS posicao,
    RANK()       OVER (PARTITION BY categoria_id ORDER BY preco DESC) AS rank,
    DENSE_RANK() OVER (PARTITION BY categoria_id ORDER BY preco DESC) AS dense_rank
FROM produtos WHERE ativo = 1 ORDER BY categoria_id, preco DESC;

-- Top 1 produto mais caro de cada categoria
WITH ranking AS (
    SELECT pr.nome, cat.nome AS categoria, pr.preco,
        ROW_NUMBER() OVER (PARTITION BY pr.categoria_id ORDER BY pr.preco DESC) AS rn
    FROM produtos pr INNER JOIN categorias cat ON cat.id = pr.categoria_id WHERE pr.ativo = 1
)
SELECT nome, categoria, preco FROM ranking WHERE rn = 1 ORDER BY preco DESC;

-- 10.3 LAG e LEAD
SELECT c.nome, p.data_pedido, p.valor_total,
    LAG(p.valor_total) OVER (PARTITION BY p.cliente_id ORDER BY p.data_pedido) AS pedido_anterior,
    p.valor_total - LAG(p.valor_total) OVER (PARTITION BY p.cliente_id ORDER BY p.data_pedido) AS diferenca
FROM pedidos p INNER JOIN clientes c ON c.id = p.cliente_id
WHERE p.status != 'cancelado' ORDER BY c.nome, p.data_pedido;

-- 10.4 Total acumulado e média móvel
SELECT data_pedido, valor_total,
    SUM(valor_total) OVER (ORDER BY data_pedido ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS receita_acumulada,
    ROUND(AVG(valor_total) OVER (ORDER BY data_pedido ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS media_movel_3
FROM pedidos WHERE status != 'cancelado' ORDER BY data_pedido;

-- Porcentagem sobre o total
SELECT id, valor_total, SUM(valor_total) OVER () AS total_geral,
    ROUND(100.0 * valor_total / SUM(valor_total) OVER (), 2) AS percentual
FROM pedidos WHERE status != 'cancelado' ORDER BY valor_total DESC;

-- ============================================================
-- Projeto Final: Consultas e Relatórios
-- ============================================================

-- 1. Dashboard geral
SELECT
    (SELECT COUNT(*) FROM clientes) AS total_clientes,
    (SELECT COUNT(*) FROM produtos WHERE ativo = 1) AS produtos_ativos,
    (SELECT COUNT(*) FROM pedidos) AS total_pedidos,
    (SELECT ROUND(SUM(valor_total), 2) FROM pedidos WHERE status != 'cancelado') AS receita_total;

-- 2. Top 5 clientes por receita
SELECT * FROM vw_clientes_ativos WHERE total_pedidos > 0 ORDER BY gasto_total DESC LIMIT 5;

-- 3. Vendas por categoria
SELECT * FROM vw_vendas_categoria ORDER BY receita DESC;

-- 4. Receita mensal
SELECT SUBSTR(data_pedido, 1, 7) AS mes,
    COUNT(*) AS pedidos, ROUND(SUM(valor_total), 2) AS receita,
    ROUND(AVG(valor_total), 2) AS ticket_medio
FROM pedidos WHERE status != 'cancelado'
GROUP BY SUBSTR(data_pedido, 1, 7) ORDER BY mes;

-- 5. Produtos mais vendidos
SELECT pr.nome, cat.nome AS categoria, SUM(ip.quantidade) AS qtd_vendida,
    ROUND(SUM(ip.quantidade * ip.preco_unitario), 2) AS receita
FROM itens_pedido ip
INNER JOIN produtos pr ON pr.id = ip.produto_id
INNER JOIN categorias cat ON cat.id = pr.categoria_id
GROUP BY pr.id ORDER BY qtd_vendida DESC LIMIT 10;

-- 6. Produtos nunca vendidos
SELECT pr.nome, cat.nome AS categoria, pr.preco, pr.estoque
FROM produtos pr
INNER JOIN categorias cat ON cat.id = pr.categoria_id
LEFT JOIN itens_pedido ip ON ip.produto_id = pr.id
WHERE ip.id IS NULL AND pr.ativo = 1;

-- 7. Classificação de clientes (CTE + CASE)
WITH resumo AS (
    SELECT c.nome, c.cidade, COUNT(p.id) AS pedidos, COALESCE(SUM(p.valor_total), 0) AS gasto
    FROM clientes c LEFT JOIN pedidos p ON p.cliente_id = c.id AND p.status != 'cancelado'
    GROUP BY c.id
)
SELECT nome, cidade, pedidos, ROUND(gasto, 2) AS gasto_total,
    CASE WHEN gasto > 5000 THEN 'VIP' WHEN gasto > 1000 THEN 'Regular' WHEN gasto > 0 THEN 'Novo' ELSE 'Inativo' END AS classificacao
FROM resumo ORDER BY gasto DESC;

-- 8. Ranking de produtos por categoria (Window Function)
WITH ranking AS (
    SELECT pr.nome, cat.nome AS categoria, pr.preco,
        ROW_NUMBER() OVER (PARTITION BY pr.categoria_id ORDER BY pr.preco DESC) AS posicao
    FROM produtos pr INNER JOIN categorias cat ON cat.id = pr.categoria_id WHERE pr.ativo = 1
)
SELECT * FROM ranking WHERE posicao <= 3 ORDER BY categoria, posicao;

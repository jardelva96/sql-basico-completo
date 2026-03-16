-- ============================================================
-- Capítulo 8: Subconsultas e CTEs
-- ============================================================

-- 8.1 Subconsultas no WHERE
SELECT nome, email FROM clientes WHERE id IN (SELECT cliente_id FROM pedidos WHERE valor_total > 1000);
SELECT nome, preco FROM produtos WHERE preco > (SELECT AVG(preco) FROM produtos WHERE ativo = 1) ORDER BY preco DESC;
SELECT nome, email FROM clientes WHERE id NOT IN (SELECT DISTINCT cliente_id FROM pedidos);

-- 8.2 Subconsultas no SELECT
SELECT nome, preco,
    ROUND((SELECT AVG(preco) FROM produtos WHERE ativo = 1), 2) AS media_geral,
    ROUND(preco - (SELECT AVG(preco) FROM produtos WHERE ativo = 1), 2) AS diferenca_media
FROM produtos WHERE ativo = 1 ORDER BY diferenca_media DESC;

-- 8.3 Tabela Derivada (FROM)
SELECT resumo.nome, resumo.total_pedidos, resumo.gasto_total,
    CASE
        WHEN resumo.gasto_total > 5000 THEN 'VIP'
        WHEN resumo.gasto_total > 1000 THEN 'Regular'
        WHEN resumo.gasto_total > 0    THEN 'Novo'
        ELSE 'Inativo'
    END AS classificacao
FROM (
    SELECT c.nome, COUNT(p.id) AS total_pedidos, COALESCE(SUM(p.valor_total), 0) AS gasto_total
    FROM clientes c LEFT JOIN pedidos p ON p.cliente_id = c.id GROUP BY c.id, c.nome
) AS resumo ORDER BY resumo.gasto_total DESC;

-- 8.4 EXISTS
SELECT nome, email FROM clientes c
WHERE EXISTS (SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id AND p.status = 'entregue');

SELECT nome FROM categorias cat
WHERE NOT EXISTS (SELECT 1 FROM produtos pr WHERE pr.categoria_id = cat.id);

-- 8.5 CTEs
WITH vendas_cliente AS (
    SELECT cliente_id, COUNT(*) AS total_pedidos, SUM(valor_total) AS gasto_total, AVG(valor_total) AS ticket_medio
    FROM pedidos WHERE status != 'cancelado' GROUP BY cliente_id
)
SELECT c.nome, c.cidade, vc.total_pedidos, ROUND(vc.gasto_total, 2) AS gasto_total, ROUND(vc.ticket_medio, 2) AS ticket_medio
FROM vendas_cliente vc INNER JOIN clientes c ON c.id = vc.cliente_id ORDER BY vc.gasto_total DESC;

-- Múltiplas CTEs
WITH
vendas_produto AS (
    SELECT produto_id, SUM(quantidade) AS qtd_vendida, SUM(quantidade * preco_unitario) AS receita_produto
    FROM itens_pedido GROUP BY produto_id
),
produtos_completos AS (
    SELECT pr.nome, cat.nome AS categoria, pr.preco, pr.estoque,
        COALESCE(vp.qtd_vendida, 0) AS vendidos, COALESCE(vp.receita_produto, 0) AS receita
    FROM produtos pr
    LEFT JOIN vendas_produto vp ON vp.produto_id = pr.id
    INNER JOIN categorias cat ON cat.id = pr.categoria_id WHERE pr.ativo = 1
)
SELECT * FROM produtos_completos ORDER BY receita DESC;

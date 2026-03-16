-- ============================================================
-- Capítulo 6: GROUP BY e HAVING
-- ============================================================

-- 6.1 GROUP BY Básico
SELECT cidade, COUNT(*) AS total_clientes FROM clientes GROUP BY cidade ORDER BY total_clientes DESC;

SELECT categoria_id, COUNT(*) AS qtd_produtos, ROUND(AVG(preco), 2) AS preco_medio
FROM produtos WHERE ativo = 1 GROUP BY categoria_id ORDER BY qtd_produtos DESC;

SELECT status, COUNT(*) AS total_pedidos, SUM(valor_total) AS receita, ROUND(AVG(valor_total), 2) AS ticket_medio
FROM pedidos GROUP BY status ORDER BY receita DESC;

-- 6.2 Múltiplas Colunas
SELECT estado, cidade, COUNT(*) AS total FROM clientes GROUP BY estado, cidade ORDER BY estado, total DESC;

SELECT SUBSTR(data_pedido, 1, 7) AS mes, status, COUNT(*) AS qtd, SUM(valor_total) AS receita
FROM pedidos GROUP BY SUBSTR(data_pedido, 1, 7), status ORDER BY mes, status;

-- 6.3 HAVING
SELECT cidade, COUNT(*) AS total FROM clientes GROUP BY cidade HAVING COUNT(*) > 1;

SELECT categoria_id, COUNT(*) AS qtd_produtos, ROUND(AVG(preco), 2) AS preco_medio
FROM produtos WHERE ativo = 1 GROUP BY categoria_id HAVING AVG(preco) > 500 ORDER BY preco_medio DESC;

SELECT cliente_id, COUNT(*) AS total_pedidos, SUM(valor_total) AS gasto_total
FROM pedidos GROUP BY cliente_id HAVING COUNT(*) > 1 ORDER BY gasto_total DESC;

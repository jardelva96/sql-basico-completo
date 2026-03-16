-- ============================================================
-- Exercícios Resolvidos — Capítulo 6: GROUP BY e HAVING
-- ============================================================
-- Execute 00_setup_completo.sql antes de resolver os exercícios.
-- Tente resolver antes de olhar as respostas!
-- ============================================================

-- Exercício 1: Quantos produtos existem em cada categoria? (DESC)
SELECT categoria_id, COUNT(*) AS qtd_produtos
FROM produtos
GROUP BY categoria_id
ORDER BY qtd_produtos DESC;

-- Exercício 2: Receita total por mês (ano-mês com SUBSTR)
SELECT
    SUBSTR(data_pedido, 1, 7) AS mes,
    COUNT(*)                  AS qtd_pedidos,
    ROUND(SUM(valor_total), 2) AS receita_mes
FROM pedidos
WHERE status != 'cancelado'
GROUP BY SUBSTR(data_pedido, 1, 7)
ORDER BY mes;

-- Exercício 3: Categorias com mais de 2 produtos
SELECT categoria_id, COUNT(*) AS qtd_produtos
FROM produtos
GROUP BY categoria_id
HAVING COUNT(*) > 2
ORDER BY qtd_produtos DESC;

-- Exercício 4: Ticket médio (valor médio) por status de pedido
SELECT
    status,
    COUNT(*)                       AS total_pedidos,
    ROUND(AVG(valor_total), 2)     AS ticket_medio
FROM pedidos
GROUP BY status
ORDER BY ticket_medio DESC;

-- Exercício 5: Quais estados têm mais de 1 cliente?
SELECT estado, COUNT(*) AS total_clientes
FROM clientes
GROUP BY estado
HAVING COUNT(*) > 1
ORDER BY total_clientes DESC;

-- Exercício 6: Clientes com gasto total acima de R$ 3.000
SELECT
    cliente_id,
    COUNT(*)                       AS total_pedidos,
    ROUND(SUM(valor_total), 2)     AS gasto_total
FROM pedidos
WHERE status != 'cancelado'
GROUP BY cliente_id
HAVING SUM(valor_total) > 3000
ORDER BY gasto_total DESC;

-- Exercício 7: Soma de estoque por categoria, apenas com estoque > 30
SELECT
    categoria_id,
    SUM(estoque) AS estoque_total
FROM produtos
WHERE ativo = 1
GROUP BY categoria_id
HAVING SUM(estoque) > 30
ORDER BY estoque_total DESC;

-- Exercício 8: Pedidos por mês; quais meses tiveram mais de 2 pedidos?
SELECT
    SUBSTR(data_pedido, 1, 7) AS mes,
    COUNT(*) AS qtd_pedidos
FROM pedidos
GROUP BY SUBSTR(data_pedido, 1, 7)
HAVING COUNT(*) > 2
ORDER BY mes;

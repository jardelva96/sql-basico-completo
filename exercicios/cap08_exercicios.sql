-- ============================================================
-- Exercícios Resolvidos — Capítulo 8: Subconsultas e CTEs
-- ============================================================
-- Execute 00_setup_completo.sql antes de resolver os exercícios.
-- Tente resolver antes de olhar as respostas!
-- ============================================================

-- Exercício 1: Produtos com preço acima da média (subconsulta)
SELECT nome, preco
FROM produtos
WHERE preco > (SELECT AVG(preco) FROM produtos WHERE ativo = 1)
  AND ativo = 1
ORDER BY preco DESC;

-- Exercício 2: Clientes que NUNCA fizeram pedido (NOT IN)
SELECT nome, email, cidade
FROM clientes
WHERE id NOT IN (SELECT DISTINCT cliente_id FROM pedidos);

-- Exercício 2b: Mesma consulta com NOT EXISTS
SELECT nome, email, cidade
FROM clientes c
WHERE NOT EXISTS (
    SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id
);

-- Exercício 3: Cada cliente com total gasto (subconsulta no SELECT)
SELECT
    nome,
    cidade,
    (SELECT COUNT(*)
     FROM pedidos p WHERE p.cliente_id = c.id) AS total_pedidos,
    (SELECT COALESCE(ROUND(SUM(valor_total),2), 0)
     FROM pedidos p WHERE p.cliente_id = c.id) AS gasto_total
FROM clientes c
ORDER BY gasto_total DESC;

-- Exercício 4: Classificação de clientes usando tabela derivada (FROM)
SELECT
    resumo.nome,
    resumo.total_pedidos,
    resumo.gasto_total,
    CASE
        WHEN resumo.gasto_total > 5000 THEN 'VIP'
        WHEN resumo.gasto_total > 1000 THEN 'Regular'
        WHEN resumo.gasto_total > 0    THEN 'Novo'
        ELSE 'Inativo'
    END AS classificacao
FROM (
    SELECT c.nome, COUNT(p.id) AS total_pedidos,
           COALESCE(SUM(p.valor_total), 0) AS gasto_total
    FROM clientes c
    LEFT JOIN pedidos p ON p.cliente_id = c.id
    GROUP BY c.id, c.nome
) AS resumo
ORDER BY resumo.gasto_total DESC;

-- Exercício 5: Mesma classificação usando CTE
WITH resumo AS (
    SELECT c.nome, COUNT(p.id) AS total_pedidos,
           COALESCE(SUM(p.valor_total), 0) AS gasto_total
    FROM clientes c
    LEFT JOIN pedidos p ON p.cliente_id = c.id
    GROUP BY c.id, c.nome
)
SELECT
    nome, total_pedidos, ROUND(gasto_total, 2) AS gasto_total,
    CASE
        WHEN gasto_total > 5000 THEN 'VIP'
        WHEN gasto_total > 1000 THEN 'Regular'
        WHEN gasto_total > 0    THEN 'Novo'
        ELSE 'Inativo'
    END AS classificacao
FROM resumo
ORDER BY gasto_total DESC;

-- Exercício 6: CTE com vendas por categoria, apenas receita > R$ 1.000
WITH vendas_cat AS (
    SELECT
        cat.nome AS categoria,
        ROUND(SUM(ip.quantidade * ip.preco_unitario), 2) AS receita
    FROM categorias cat
    LEFT JOIN produtos pr    ON pr.categoria_id = cat.id
    LEFT JOIN itens_pedido ip ON ip.produto_id  = pr.id
    GROUP BY cat.id, cat.nome
)
SELECT categoria, receita
FROM vendas_cat
WHERE receita > 1000
ORDER BY receita DESC;

-- Exercício 7: EXISTS para categorias com pelo menos 3 produtos
SELECT cat.nome AS categoria
FROM categorias cat
WHERE (
    SELECT COUNT(*) FROM produtos pr
    WHERE pr.categoria_id = cat.id AND pr.ativo = 1
) >= 3;

-- Exercício 8: Múltiplas CTEs: vendas por mês classificadas
WITH
vendas_mes AS (
    SELECT
        SUBSTR(data_pedido, 1, 7) AS mes,
        COUNT(*)                   AS qtd,
        ROUND(SUM(valor_total), 2) AS receita
    FROM pedidos
    WHERE status != 'cancelado'
    GROUP BY SUBSTR(data_pedido, 1, 7)
),
meses_classificados AS (
    SELECT mes, qtd, receita,
        CASE WHEN receita > 3000 THEN 'Forte' ELSE 'Fraco' END AS desempenho
    FROM vendas_mes
)
SELECT * FROM meses_classificados ORDER BY mes;

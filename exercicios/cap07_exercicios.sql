-- ============================================================
-- Exercícios Resolvidos — Capítulo 7: JOINs
-- ============================================================
-- Execute 00_setup_completo.sql antes de resolver os exercícios.
-- Tente resolver antes de olhar as respostas!
-- ============================================================

-- Exercício 1: Todos os pedidos com o nome do cliente (INNER JOIN)
SELECT
    p.id        AS pedido_id,
    c.nome      AS cliente,
    p.data_pedido,
    p.valor_total,
    p.status
FROM pedidos p
INNER JOIN clientes c ON c.id = p.cliente_id
ORDER BY p.data_pedido DESC;

-- Exercício 2: Todos os produtos com o nome da sua categoria
SELECT
    pr.nome     AS produto,
    cat.nome    AS categoria,
    pr.preco,
    pr.estoque
FROM produtos pr
INNER JOIN categorias cat ON cat.id = pr.categoria_id
ORDER BY cat.nome, pr.nome;

-- Exercício 3: TODOS os clientes e quantos pedidos cada um fez (LEFT JOIN)
SELECT
    c.nome,
    c.cidade,
    COUNT(p.id)                        AS total_pedidos,
    COALESCE(ROUND(SUM(p.valor_total),2), 0) AS gasto_total
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nome, c.cidade
ORDER BY gasto_total DESC;

-- Exercício 4: Clientes que NUNCA fizeram um pedido (LEFT JOIN + IS NULL)
SELECT c.nome, c.email, c.cidade
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.id
WHERE p.id IS NULL;

-- Exercício 5: Relatório: pedido_id, cliente, produto, quantidade, subtotal
SELECT
    p.id                                          AS pedido_id,
    c.nome                                        AS cliente,
    pr.nome                                       AS produto,
    ip.quantidade,
    ip.preco_unitario,
    ROUND(ip.quantidade * ip.preco_unitario, 2)   AS subtotal
FROM itens_pedido ip
INNER JOIN pedidos p   ON p.id   = ip.pedido_id
INNER JOIN clientes c  ON c.id   = p.cliente_id
INNER JOIN produtos pr ON pr.id  = ip.produto_id
ORDER BY p.id, pr.nome;

-- Exercício 6: Receita total por categoria de produto
SELECT
    cat.nome                                      AS categoria,
    COUNT(DISTINCT p.id)                          AS total_pedidos,
    SUM(ip.quantidade)                            AS itens_vendidos,
    ROUND(SUM(ip.quantidade * ip.preco_unitario), 2) AS receita
FROM categorias cat
LEFT JOIN produtos pr    ON pr.categoria_id = cat.id
LEFT JOIN itens_pedido ip ON ip.produto_id  = pr.id
LEFT JOIN pedidos p       ON p.id           = ip.pedido_id
GROUP BY cat.id, cat.nome
ORDER BY receita DESC;

-- Exercício 7: Top 3 clientes que mais gastaram (excluindo cancelados)
SELECT
    c.nome,
    c.cidade,
    COUNT(p.id)                    AS total_pedidos,
    ROUND(SUM(p.valor_total), 2)   AS receita_total
FROM clientes c
INNER JOIN pedidos p ON p.cliente_id = c.id
WHERE p.status != 'cancelado'
GROUP BY c.id, c.nome, c.cidade
ORDER BY receita_total DESC
LIMIT 3;

-- Exercício 8: Produtos que NUNCA foram vendidos
SELECT pr.nome, cat.nome AS categoria, pr.preco, pr.estoque
FROM produtos pr
INNER JOIN categorias cat ON cat.id = pr.categoria_id
LEFT JOIN itens_pedido ip  ON ip.produto_id = pr.id
WHERE ip.id IS NULL AND pr.ativo = 1;

-- Exercício 9: Clientes que moram na mesma cidade (Self JOIN)
SELECT
    c1.nome AS cliente_1,
    c2.nome AS cliente_2,
    c1.cidade
FROM clientes c1
INNER JOIN clientes c2 ON c1.cidade = c2.cidade AND c1.id < c2.id
ORDER BY c1.cidade;

-- Exercício 10: Relatório mensal: mês, total de pedidos, receita, ticket médio
SELECT
    SUBSTR(p.data_pedido, 1, 7)    AS mes,
    COUNT(*)                       AS total_pedidos,
    ROUND(SUM(p.valor_total), 2)   AS receita,
    ROUND(AVG(p.valor_total), 2)   AS ticket_medio
FROM pedidos p
WHERE p.status != 'cancelado'
GROUP BY SUBSTR(p.data_pedido, 1, 7)
ORDER BY mes;

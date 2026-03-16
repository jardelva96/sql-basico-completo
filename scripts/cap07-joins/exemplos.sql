-- ============================================================
-- Capítulo 7: JOINs — Cruzando Tabelas
-- ============================================================

-- 7.1 INNER JOIN
SELECT p.id AS pedido_id, c.nome AS cliente, p.data_pedido, p.valor_total, p.status
FROM pedidos p INNER JOIN clientes c ON c.id = p.cliente_id ORDER BY p.data_pedido DESC;

-- JOIN com 4 tabelas
SELECT p.id AS pedido, c.nome AS cliente, pr.nome AS produto, ip.quantidade,
    ip.preco_unitario, ip.quantidade * ip.preco_unitario AS subtotal
FROM itens_pedido ip
INNER JOIN pedidos p ON p.id = ip.pedido_id
INNER JOIN clientes c ON c.id = p.cliente_id
INNER JOIN produtos pr ON pr.id = ip.produto_id
ORDER BY p.id, pr.nome;

-- 7.2 LEFT JOIN — Todos os clientes
SELECT c.nome, c.cidade, COUNT(p.id) AS total_pedidos, COALESCE(SUM(p.valor_total), 0) AS gasto_total
FROM clientes c LEFT JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nome, c.cidade ORDER BY gasto_total DESC;

-- Clientes sem pedido
SELECT c.nome, c.email, c.cidade
FROM clientes c LEFT JOIN pedidos p ON p.cliente_id = c.id WHERE p.id IS NULL;

-- 7.4 CROSS JOIN
SELECT cat.nome AS categoria, s.status
FROM categorias cat CROSS JOIN (SELECT DISTINCT status FROM pedidos) s
ORDER BY cat.nome, s.status;

-- 7.5 Self JOIN — Clientes da mesma cidade
SELECT c1.nome AS cliente_1, c2.nome AS cliente_2, c1.cidade
FROM clientes c1 INNER JOIN clientes c2 ON c1.cidade = c2.cidade AND c1.id < c2.id
ORDER BY c1.cidade;

-- 7.6 Relatórios com JOIN + Agregação
SELECT cat.nome AS categoria, COUNT(DISTINCT p.id) AS total_pedidos,
    SUM(ip.quantidade) AS itens_vendidos, ROUND(SUM(ip.quantidade * ip.preco_unitario), 2) AS receita
FROM categorias cat
LEFT JOIN produtos pr ON pr.categoria_id = cat.id
LEFT JOIN itens_pedido ip ON ip.produto_id = pr.id
LEFT JOIN pedidos p ON p.id = ip.pedido_id
GROUP BY cat.id, cat.nome ORDER BY receita DESC;

-- Top 5 clientes por receita
SELECT c.nome, c.cidade, COUNT(p.id) AS total_pedidos,
    ROUND(SUM(p.valor_total), 2) AS receita_total, ROUND(AVG(p.valor_total), 2) AS ticket_medio
FROM clientes c INNER JOIN pedidos p ON p.cliente_id = c.id
WHERE p.status != 'cancelado'
GROUP BY c.id, c.nome, c.cidade ORDER BY receita_total DESC LIMIT 5;

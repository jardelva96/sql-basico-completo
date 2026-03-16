-- ============================================================
-- Projeto Final: Views
-- ============================================================

-- View: Clientes ativos (que fizeram pedidos)
CREATE VIEW IF NOT EXISTS vw_clientes_ativos AS
SELECT c.id, c.nome, c.email, c.cidade, c.estado,
    COUNT(p.id) AS total_pedidos,
    COALESCE(SUM(p.valor_total), 0) AS gasto_total
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.id AND p.status != 'cancelado'
GROUP BY c.id;

-- View: Relatório de vendas por categoria
CREATE VIEW IF NOT EXISTS vw_vendas_categoria AS
SELECT cat.id, cat.nome AS categoria,
    COUNT(DISTINCT p.id) AS total_pedidos,
    COALESCE(SUM(ip.quantidade), 0) AS itens_vendidos,
    COALESCE(ROUND(SUM(ip.quantidade * ip.preco_unitario), 2), 0) AS receita
FROM categorias cat
LEFT JOIN produtos pr ON pr.categoria_id = cat.id
LEFT JOIN itens_pedido ip ON ip.produto_id = pr.id
LEFT JOIN pedidos p ON p.id = ip.pedido_id
GROUP BY cat.id, cat.nome;

-- View: Pedidos completos
CREATE VIEW IF NOT EXISTS vw_pedidos_completos AS
SELECT p.id AS pedido_id, c.nome AS cliente, c.cidade,
    p.data_pedido, p.valor_total, p.status,
    COUNT(ip.id) AS total_itens
FROM pedidos p
INNER JOIN clientes c ON c.id = p.cliente_id
LEFT JOIN itens_pedido ip ON ip.pedido_id = p.id
GROUP BY p.id;

-- View: Produtos com detalhes
CREATE VIEW IF NOT EXISTS vw_produtos_detalhes AS
SELECT pr.id, pr.nome, cat.nome AS categoria, pr.preco, pr.estoque, pr.ativo,
    pr.preco * pr.estoque AS valor_em_estoque
FROM produtos pr
INNER JOIN categorias cat ON cat.id = pr.categoria_id;

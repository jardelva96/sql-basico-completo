-- ============================================================
-- Exercícios Resolvidos — Capítulo 5: Funções de Agregação
-- ============================================================
-- Execute 00_setup_completo.sql antes de resolver os exercícios.
-- Tente resolver antes de olhar as respostas!
-- ============================================================

-- Exercício 1: Quantos pedidos existem no total?
SELECT COUNT(*) AS total_pedidos FROM pedidos;

-- Exercício 2: Soma dos valores dos pedidos com status 'entregue'
SELECT
    COUNT(*)                 AS qtd_entregues,
    ROUND(SUM(valor_total),2) AS receita_entregue
FROM pedidos
WHERE status = 'entregue';

-- Exercício 3: Preço médio dos produtos da categoria 'Livros' (categoria_id = 3)
SELECT ROUND(AVG(preco), 2) AS preco_medio_livros
FROM produtos
WHERE categoria_id = 3 AND ativo = 1;

-- Exercício 4: Produto mais caro e mais barato (nome e preço)
SELECT
    (SELECT nome FROM produtos ORDER BY preco DESC LIMIT 1) AS produto_mais_caro,
    MAX(preco) AS maior_preco,
    (SELECT nome FROM produtos ORDER BY preco ASC  LIMIT 1) AS produto_mais_barato,
    MIN(preco) AS menor_preco
FROM produtos WHERE ativo = 1;

-- Exercício 5: Quantos clientes distintos fizeram pelo menos um pedido?
SELECT COUNT(DISTINCT cliente_id) AS clientes_ativos FROM pedidos;

-- Exercício 6: Valor total em estoque (SUM de preco * estoque) produtos ativos
SELECT ROUND(SUM(preco * estoque), 2) AS valor_total_estoque
FROM produtos WHERE ativo = 1;

-- Exercício 7: Quantos produtos estão inativos (ativo = 0)?
SELECT COUNT(*) AS total_inativos FROM produtos WHERE ativo = 0;

-- Exercício 8: Diferença entre o pedido mais caro e o mais barato
SELECT
    MAX(valor_total) AS maior_pedido,
    MIN(valor_total) AS menor_pedido,
    ROUND(MAX(valor_total) - MIN(valor_total), 2) AS diferenca
FROM pedidos;

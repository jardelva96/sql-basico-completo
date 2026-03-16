-- ============================================================
-- Capítulo 5: Funções de Agregação
-- ============================================================

-- 5.1 Funções Principais
SELECT COUNT(*) AS total_clientes FROM clientes;
SELECT COUNT(telefone) AS com_telefone FROM clientes;
SELECT SUM(valor_total) AS receita_total FROM pedidos;
SELECT ROUND(AVG(preco), 2) AS preco_medio FROM produtos;
SELECT MAX(preco) AS mais_caro, MIN(preco) AS mais_barato, MAX(preco) - MIN(preco) AS diferenca
FROM produtos WHERE ativo = 1;

-- 5.2 COUNT em Detalhes
SELECT COUNT(*) FROM clientes;
SELECT COUNT(telefone) FROM clientes;
SELECT COUNT(DISTINCT cidade) FROM clientes;
SELECT COUNT(DISTINCT estado) FROM clientes;

SELECT
    COUNT(*) AS total_linhas,
    COUNT(telefone) AS com_telefone,
    COUNT(DISTINCT cidade) AS cidades_unicas
FROM clientes;

-- 5.3 Agregações com WHERE
SELECT SUM(valor_total) AS receita_entregue, COUNT(*) AS qtd_entregues
FROM pedidos WHERE status = 'entregue';

SELECT ROUND(AVG(preco), 2) AS media_eletronicos
FROM produtos WHERE categoria_id = 1 AND ativo = 1;

SELECT
    COUNT(*) AS total_produtos,
    ROUND(AVG(preco), 2) AS preco_medio,
    ROUND(MIN(preco), 2) AS menor_preco,
    ROUND(MAX(preco), 2) AS maior_preco,
    SUM(estoque) AS estoque_total
FROM produtos WHERE ativo = 1;

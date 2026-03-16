-- ============================================================
-- Exercícios Resolvidos — Capítulo 2: SELECT
-- ============================================================
-- Execute 00_setup_completo.sql antes de resolver os exercícios.
-- Tente resolver antes de olhar as respostas!
-- ============================================================

-- Exercício 1: Selecione todas as colunas da tabela produtos
SELECT * FROM produtos;

-- Exercício 2: Selecione apenas nome e preco dos produtos ativos
SELECT nome, preco FROM produtos WHERE ativo = 1;

-- Exercício 3: Liste todas as cidades únicas dos clientes
SELECT DISTINCT cidade FROM clientes ORDER BY cidade;

-- Exercício 4: Liste os 5 primeiros pedidos cadastrados
SELECT * FROM pedidos LIMIT 5;

-- Exercício 5: Crie alias legíveis para nome e preco
SELECT
    nome        AS 'Nome do Produto',
    preco       AS 'Preço (R$)'
FROM produtos WHERE ativo = 1;

-- Exercício 6: Use UPPER() para mostrar emails em maiúscula
SELECT nome, UPPER(email) AS email_maiusculo FROM clientes;

-- Exercício 7: Concatene cidade + ' - ' + estado como 'Localização'
SELECT nome, cidade || ' - ' || estado AS Localizacao FROM clientes;

-- Exercício 8: Implemente paginação com 5 produtos por página
SELECT nome, preco FROM produtos LIMIT 5 OFFSET 0;  -- Página 1
SELECT nome, preco FROM produtos LIMIT 5 OFFSET 5;  -- Página 2
SELECT nome, preco FROM produtos LIMIT 5 OFFSET 10; -- Página 3
SELECT nome, preco FROM produtos LIMIT 5 OFFSET 15; -- Página 4

-- Exercício 9: Quantas categorias distintas existem na tabela produtos?
SELECT COUNT(DISTINCT categoria_id) AS total_categorias FROM produtos;

-- Exercício 10: Mostre os 3 produtos mais baratos com nome, preco e categoria_id
SELECT nome, preco, categoria_id
FROM produtos
WHERE ativo = 1
ORDER BY preco ASC
LIMIT 3;

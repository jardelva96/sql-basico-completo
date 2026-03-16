-- ============================================================
-- Capítulo 2: SELECT — Consultando Dados
-- ============================================================

-- 2.1 SELECT Básico
SELECT * FROM clientes;
SELECT nome, email, cidade FROM clientes;

-- 2.2 Alias e Expressões
SELECT
    nome       AS cliente_nome,
    email      AS contato_email,
    cidade     AS localidade
FROM clientes;

SELECT
    nome,
    UPPER(email)        AS email_maiusculo,
    LOWER(cidade)       AS cidade_minuscula,
    LENGTH(nome)        AS tamanho_nome
FROM clientes;

SELECT
    'Cliente: ' || nome          AS descricao,
    cidade || ' - ' || estado    AS localizacao
FROM clientes;

SELECT
    nome,
    preco,
    preco * 1.10 AS preco_com_10pct
FROM produtos;

-- 2.3 DISTINCT — Valores Únicos
SELECT DISTINCT cidade FROM clientes;
SELECT DISTINCT estado FROM clientes ORDER BY estado;
SELECT DISTINCT cidade, estado FROM clientes;
SELECT COUNT(DISTINCT cidade) AS total_cidades FROM clientes;

-- 2.4 LIMIT e OFFSET — Paginação
SELECT nome, email FROM clientes LIMIT 5;
SELECT * FROM produtos LIMIT 10 OFFSET 0;   -- Página 1
SELECT * FROM produtos LIMIT 10 OFFSET 10;  -- Página 2

-- Top 3 produtos mais caros
SELECT nome, preco
FROM produtos
WHERE ativo = 1
ORDER BY preco DESC
LIMIT 3;

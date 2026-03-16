-- ============================================================
-- Exercícios Resolvidos — Capítulo 9: INSERT, UPDATE, DELETE
-- ============================================================
-- Execute 00_setup_completo.sql antes de resolver os exercícios.
-- ATENÇÃO: Alguns exercícios modificam dados. Use ROLLBACK se necessário.
-- ============================================================

-- Exercício 1: Inserir 3 novos clientes de estados diferentes
INSERT INTO clientes (nome, email, cidade, estado) VALUES
    ('Lucas Martins',  'lucas.m@email.com',  'Recife',    'PE'),
    ('Daniela Cruz',   'dani.c@email.com',   'Natal',     'RN'),
    ('Felipe Ramos',   'felipe.r@email.com', 'Belém',     'PA');

-- Confirmar
SELECT * FROM clientes ORDER BY id DESC LIMIT 5;

-- Exercício 2: Inserir novo produto na categoria 'Livros' (categoria_id = 3)
INSERT INTO produtos (categoria_id, nome, descricao, preco, estoque, ativo)
VALUES (3, 'Design Patterns', 'Gang of Four - Padrões de Projeto', 99.90, 25, 1);

-- Exercício 3: Atualizar o email de um cliente especifico
UPDATE clientes
SET email = 'ana.silva.novo@email.com'
WHERE id = 1;

-- Confirmar
SELECT id, nome, email FROM clientes WHERE id = 1;

-- Exercício 4: Desconto de 15% em todos os produtos de Esportes (categoria_id = 5)
-- Primeiro confirme quais serão afetados:
SELECT id, nome, preco FROM produtos WHERE categoria_id = 5;

UPDATE produtos
SET preco = ROUND(preco * 0.85, 2)
WHERE categoria_id = 5;

-- Confirmar
SELECT id, nome, preco FROM produtos WHERE categoria_id = 5;

-- Exercício 5: Mudar pedidos 'pendente' criados antes de abril para 'enviado'
SELECT id, status, data_pedido FROM pedidos
WHERE status = 'pendente' AND data_pedido < '2025-04-01';

UPDATE pedidos
SET status = 'enviado'
WHERE status = 'pendente' AND data_pedido < '2025-04-01';

-- Exercício 6: Deletar pedido cancelado (primeiro os itens, depois o pedido)
-- Ver pedidos cancelados:
SELECT id FROM pedidos WHERE status = 'cancelado';

DELETE FROM itens_pedido WHERE pedido_id = 10;
DELETE FROM pedidos WHERE id = 10;

-- Exercício 7: CASE para criar coluna 'faixa_preco' nos produtos
SELECT
    nome,
    preco,
    CASE
        WHEN preco > 1000  THEN 'Premium'
        WHEN preco > 200   THEN 'Intermediário'
        WHEN preco > 50    THEN 'Acessível'
        ELSE 'Econômico'
    END AS faixa_preco
FROM produtos
WHERE ativo = 1
ORDER BY preco DESC;

-- Exercício 8: Relatório pivô CASE mostrando vendas por mês e status
SELECT
    SUBSTR(data_pedido, 1, 7) AS mes,
    COUNT(CASE WHEN status = 'entregue'  THEN 1 END) AS entregues,
    COUNT(CASE WHEN status = 'enviado'   THEN 1 END) AS enviados,
    COUNT(CASE WHEN status = 'pendente'  THEN 1 END) AS pendentes,
    COUNT(CASE WHEN status = 'cancelado' THEN 1 END) AS cancelados
FROM pedidos
GROUP BY SUBSTR(data_pedido, 1, 7)
ORDER BY mes;

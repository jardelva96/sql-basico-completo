-- ============================================================
-- Capítulo 9: INSERT, UPDATE, DELETE
-- ============================================================
-- ⚠️ ATENÇÃO: Estes exemplos MODIFICAM dados!
-- Execute em um banco de TESTES. Faça backup antes.

-- 9.1 INSERT
INSERT INTO clientes (nome, email, cidade, estado)
VALUES ('Lucas Martins', 'lucas.m@email.com', 'Recife', 'PE');

INSERT INTO clientes (nome, email, cidade, estado) VALUES
    ('Daniela Cruz', 'dani.c@email.com', 'Natal', 'RN'),
    ('Felipe Ramos', 'felipe.r@email.com', 'Belém', 'PA'),
    ('Gabriela Pinto', 'gabi.p@email.com', 'Campinas', 'SP');

-- INSERT com ON CONFLICT (SQLite 3.24+)
INSERT INTO clientes (email, nome, cidade, estado)
VALUES ('ana.silva@email.com', 'Ana Silva', 'São Paulo', 'SP')
ON CONFLICT(email) DO UPDATE SET nome = excluded.nome, cidade = excluded.cidade;

-- 9.2 UPDATE
-- ⚠️ SEMPRE faça SELECT antes para verificar!
SELECT id, nome, preco FROM produtos WHERE categoria_id = 1;

UPDATE produtos SET preco = ROUND(preco * 1.10, 2) WHERE categoria_id = 1;

UPDATE pedidos SET status = 'entregue'
WHERE id IN (SELECT id FROM pedidos WHERE status = 'enviado' AND data_pedido < '2025-03-15');

-- 9.3 DELETE
-- Primeiro os itens, depois o pedido (respeitar FK)
DELETE FROM itens_pedido WHERE pedido_id = 10;
DELETE FROM pedidos WHERE id = 10;

-- 9.4 CASE
SELECT nome, preco,
    CASE
        WHEN preco > 1000 THEN 'Premium'
        WHEN preco > 200  THEN 'Intermediário'
        WHEN preco > 50   THEN 'Acessível'
        ELSE 'Econômico'
    END AS faixa_preco
FROM produtos WHERE ativo = 1 ORDER BY preco DESC;

-- Pivô com CASE
SELECT SUBSTR(data_pedido, 1, 7) AS mes,
    COUNT(CASE WHEN status = 'entregue' THEN 1 END) AS entregues,
    COUNT(CASE WHEN status = 'enviado' THEN 1 END) AS enviados,
    COUNT(CASE WHEN status = 'pendente' THEN 1 END) AS pendentes,
    COUNT(CASE WHEN status = 'cancelado' THEN 1 END) AS cancelados
FROM pedidos GROUP BY SUBSTR(data_pedido, 1, 7) ORDER BY mes;

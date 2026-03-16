-- ============================================================
-- Exercícios Resolvidos — Capítulo 12: Transações e ACID
-- ============================================================
-- Execute 00_setup_completo.sql antes de resolver os exercícios.
-- ATENÇÃO: Exemplos que modificam dados. Use ROLLBACK para desfazer.
-- ============================================================

-- Exercício 1: Transação que insere pedido com 3 itens e atualiza estoque
BEGIN TRANSACTION;

-- 1. Criar o pedido
INSERT INTO pedidos (cliente_id, valor_total, status)
VALUES (5, 539.70, 'pendente');

-- 2. Adicionar os 3 itens (assume que o novo pedido recebeu id próximo)
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario)
VALUES
    (last_insert_rowid(), 13, 1, 129.90),  -- Whey Protein
    (last_insert_rowid(), 12, 1, 189.90),  -- Haltere
    (last_insert_rowid(), 18, 1, 149.90);  -- Carregador Portátil

-- 3. Atualizar estoque
UPDATE produtos SET estoque = estoque - 1 WHERE id = 13;
UPDATE produtos SET estoque = estoque - 1 WHERE id = 12;
UPDATE produtos SET estoque = estoque - 1 WHERE id = 18;

COMMIT;

-- Confirmar
SELECT id, nome, estoque FROM produtos WHERE id IN (12, 13, 18);

-- Exercício 2: Simular falha com ROLLBACK
BEGIN TRANSACTION;

INSERT INTO clientes (nome, email, cidade, estado)
VALUES ('Teste Rollback', 'rollback@test.com', 'SP', 'SP');

-- Verificar antes de desfazer:
SELECT id, nome FROM clientes ORDER BY id DESC LIMIT 3;

-- Ops, não era pra inserir:
ROLLBACK;

-- Confirmar que sumiu:
SELECT id, nome FROM clientes ORDER BY id DESC LIMIT 3;

-- Exercício 3: SAVEPOINT dentro de uma transação
BEGIN TRANSACTION;

INSERT INTO clientes (nome, email, cidade, estado)
VALUES ('Teste 1', 'teste1@email.com', 'SP', 'SP');

SAVEPOINT antes_teste2;

INSERT INTO clientes (nome, email, cidade, estado)
VALUES ('Teste 2', 'teste2@email.com', 'RJ', 'RJ');

-- Desfazer somente o Teste 2:
ROLLBACK TO antes_teste2;

-- Teste 1 ainda existe! Confirmar:
COMMIT;

SELECT id, nome FROM clientes WHERE email LIKE 'teste%';

-- Exercício 4: (Pesquisa teórica)
-- SQLite usa SERIALIZABLE por padrão (o mais seguro).
-- PostgreSQL usa READ COMMITTED por padrão.
-- MySQL usa REPEATABLE READ por padrão.

-- Exercício 5: Comparar velocidade INSERT sem e com transação explícita
-- Sem transação (autocommit = cada INSERT é uma transação): muito mais lento!
-- INSERT INTO produtos ... (1000x)

-- Com transação explícita: muito mais rápido (só 1 commit)
BEGIN TRANSACTION;
-- Exemplo com 5 registros (simule 1000 para o teste de velocidade):
INSERT INTO categorias (nome, descricao) VALUES ('Teste A', 'descr a');
INSERT INTO categorias (nome, descricao) VALUES ('Teste B', 'descr b');
INSERT INTO categorias (nome, descricao) VALUES ('Teste C', 'descr c');
ROLLBACK; -- desfaz os testes

-- Exercício 6: (Teórico) ACID com exemplo de transferência bancária:
-- Atomicidade: Débito e crédito são unitários. Se o sistema cair no meio, ROLLBACK automático.
-- Consistência: O saldo total do sistema não muda (o que saiu de A entrou em B).
-- Isolamento: Outro usuário consultando as contas não vê estado intermediário.
-- Durabilidade: Após COMMIT, mesmo com queda de energia, os dados persistem no disco.

-- ============================================================
-- SQL: Do Básico ao Avançado — Capítulo 1
-- Arquivo: 07_insert_clientes.sql
-- Descrição: Inserção de dados na tabela clientes
-- ============================================================

INSERT INTO clientes (nome, email, telefone, cidade, estado) VALUES
    ('Ana Silva',       'ana.silva@email.com',     '(11) 98765-4321', 'São Paulo',       'SP'),
    ('Carlos Santos',   'carlos.s@email.com',      '(21) 91234-5678', 'Rio de Janeiro',  'RJ'),
    ('Maria Oliveira',  'maria.oli@email.com',     '(31) 99876-1234', 'Belo Horizonte',  'MG'),
    ('João Pereira',    'joao.p@email.com',        '(48) 98765-9999', 'Florianópolis',   'SC'),
    ('Fernanda Lima',   'fer.lima@email.com',      '(41) 91111-2222', 'Curitiba',        'PR'),
    ('Roberto Costa',   'roberto.c@email.com',     '(51) 93333-4444', 'Porto Alegre',    'RS'),
    ('Juliana Souza',   'ju.souza@email.com',      '(61) 95555-6666', 'Brasília',        'DF'),
    ('Pedro Almeida',   'pedro.a@email.com',       '(71) 97777-8888', 'Salvador',        'BA'),
    ('Luciana Rocha',   'lu.rocha@email.com',      '(85) 92222-3333', 'Fortaleza',       'CE'),
    ('Marcos Ferreira', 'marcos.f@email.com',      '(62) 94444-5555', 'Goiânia',         'GO'),
    ('Patrícia Dias',   'pat.dias@email.com',      '(27) 96666-7777', 'Vitória',         'ES'),
    ('Rafael Mendes',   'rafa.m@email.com',        '(92) 98888-9999', 'Manaus',          'AM'),
    ('Camila Barbosa',  'camila.b@email.com',      NULL,              'São Paulo',       'SP'),
    ('Thiago Nunes',    'thiago.n@email.com',      '(11) 91010-2020', 'São Paulo',       'SP'),
    ('Beatriz Araujo',  'bia.araujo@email.com',    '(21) 93030-4040', 'Rio de Janeiro',  'RJ');

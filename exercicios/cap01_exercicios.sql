-- ============================================================
-- Exercícios Resolvidos — Capítulo 1
-- ============================================================

-- 1. Verificar quantos registros em cada tabela
SELECT 'categorias' AS tabela, COUNT(*) AS registros FROM categorias
UNION ALL SELECT 'clientes', COUNT(*) FROM clientes
UNION ALL SELECT 'produtos', COUNT(*) FROM produtos
UNION ALL SELECT 'pedidos', COUNT(*) FROM pedidos
UNION ALL SELECT 'itens_pedido', COUNT(*) FROM itens_pedido;

-- 2. Banco escola
CREATE TABLE IF NOT EXISTS alunos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    data_nascimento DATE
);

CREATE TABLE IF NOT EXISTS cursos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    carga_horaria INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS matriculas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    aluno_id INTEGER NOT NULL,
    curso_id INTEGER NOT NULL,
    data_matricula DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

INSERT INTO alunos (nome, email, data_nascimento) VALUES
    ('Pedro Silva', 'pedro@escola.com', '2000-05-15'),
    ('Ana Costa', 'ana@escola.com', '2001-03-22'),
    ('Lucas Souza', 'lucas@escola.com', '1999-11-08'),
    ('Maria Santos', 'maria@escola.com', '2002-07-30'),
    ('João Lima', 'joao@escola.com', '2000-01-12');

INSERT INTO cursos (nome, carga_horaria) VALUES
    ('SQL Básico', 40), ('Python', 60), ('Java', 80), ('Web', 50), ('Data Science', 100);

INSERT INTO matriculas (aluno_id, curso_id) VALUES
    (1, 1), (1, 2), (2, 1), (2, 3), (3, 4), (4, 5), (5, 1), (5, 2), (5, 3);

<p align="center">
  <h1 align="center">📊 SQL: Do Básico ao Avançado</h1>
  <p align="center">
    <strong>Repositório oficial do livro — Scripts, exercícios e projeto completo</strong>
  </p>
  <p align="center">
    <a href="#-início-rápido">Início Rápido</a> •
    <a href="#-estrutura-do-repositório">Estrutura</a> •
    <a href="#-capítulos">Capítulos</a> •
    <a href="#-como-usar">Como Usar</a> •
    <a href="#-sobre-o-autor">Autor</a>
  </p>
</p>

---

## 📖 Sobre

Este repositório contém **todos os scripts SQL** do livro **"SQL: Do Básico ao Avançado — Guia Completo de Bancos de Dados Relacionais"** (2ª Edição, 2026) por **Jardel Alves**.

Aqui você encontra:

- ✅ Scripts de criação de tabelas (`CREATE TABLE`)
- ✅ Scripts de inserção de dados (`INSERT`) completos e prontos para uso
- ✅ Exemplos de cada capítulo organizados por pasta
- ✅ Exercícios resolvidos
- ✅ Projeto final completo (Sistema de Loja)

> **Compatível com:** SQLite (recomendado para iniciantes), PostgreSQL e MySQL

---

## 🚀 Início Rápido

### Opção 1: SQLite (Recomendado)

```bash
# 1. Clone o repositório
git clone https://github.com/jardelalves/sql-basico-avancado.git
cd sql-basico-avancado

# 2. Crie o banco de dados e popule com dados
sqlite3 loja.db < scripts/cap01-introducao/00_setup_completo.sql

# 3. Pronto! Comece a praticar
sqlite3 loja.db
```

### Opção 2: PostgreSQL

```bash
# 1. Crie o banco
createdb loja

# 2. Execute o setup (versão PostgreSQL)
psql loja < scripts/cap01-introducao/00_setup_completo_pg.sql
```

### Opção 3: Online (sem instalar nada)

Acesse [sqliteonline.com](https://sqliteonline.com/) e cole o conteúdo do arquivo `scripts/cap01-introducao/00_setup_completo.sql`.

---

## 📁 Estrutura do Repositório

```
sql-basico-avancado/
│
├── README.md                          # Este arquivo
├── LICENSE                            # Licença MIT
├── .gitignore                         # Arquivos ignorados
│
├── scripts/                           # Scripts organizados por capítulo
│   ├── cap01-introducao/              # Criação de tabelas + INSERTs
│   │   ├── 00_setup_completo.sql      # ⭐ Execute este primeiro!
│   │   ├── 01_create_categorias.sql
│   │   ├── 02_create_clientes.sql
│   │   ├── 03_create_produtos.sql
│   │   ├── 04_create_pedidos.sql
│   │   ├── 05_create_itens_pedido.sql
│   │   ├── 06_insert_categorias.sql
│   │   ├── 07_insert_clientes.sql
│   │   ├── 08_insert_produtos.sql
│   │   ├── 09_insert_pedidos.sql
│   │   └── 10_insert_itens_pedido.sql
│   │
│   ├── cap02-select/                  # SELECT, alias, DISTINCT, LIMIT
│   ├── cap03-where/                   # WHERE, IN, BETWEEN, LIKE, NULL
│   ├── cap04-orderby/                 # ORDER BY, Top N
│   ├── cap05-agregacao/               # COUNT, SUM, AVG, MAX, MIN
│   ├── cap06-groupby/                 # GROUP BY, HAVING
│   ├── cap07-joins/                   # INNER, LEFT, RIGHT, CROSS, Self JOIN
│   ├── cap08-subconsultas/            # Subqueries, EXISTS, CTEs
│   ├── cap09-dml/                     # INSERT, UPDATE, DELETE, CASE
│   ├── cap10-window-functions/        # ROW_NUMBER, RANK, LAG, LEAD
│   ├── cap11-indices/                 # CREATE INDEX, EXPLAIN
│   └── cap12-transacoes/             # BEGIN, COMMIT, ROLLBACK, SAVEPOINT
│
├── exercicios/                        # Exercícios resolvidos por capítulo
│   ├── cap01_exercicios.sql
│   ├── cap02_exercicios.sql
│   ├── ...
│   └── cap12_exercicios.sql
│
└── projeto-final/                     # Projeto completo do Apêndice A
    ├── 01_schema.sql
    ├── 02_dados.sql
    ├── 03_indices.sql
    ├── 04_views.sql
    └── 05_consultas_relatorios.sql
```

---

## 📚 Capítulos

### PARTE I — Fundamentos

| # | Capítulo | Pasta | Tópicos |
|---|----------|-------|---------|
| 1 | Introdução ao SQL | `cap01-introducao/` | CREATE TABLE, INSERT, tipos de comandos |
| 2 | SELECT | `cap02-select/` | SELECT, alias, DISTINCT, LIMIT, OFFSET |
| 3 | WHERE | `cap03-where/` | Comparações, AND/OR, IN, BETWEEN, LIKE, NULL |
| 4 | ORDER BY | `cap04-orderby/` | ASC, DESC, múltiplas colunas, Top N |
| 5 | Agregação | `cap05-agregacao/` | COUNT, SUM, AVG, MAX, MIN |
| 6 | GROUP BY | `cap06-groupby/` | GROUP BY, HAVING, ordem de execução |
| 7 | JOINs | `cap07-joins/` | INNER, LEFT, RIGHT, CROSS, Self JOIN |
| 8 | Subconsultas | `cap08-subconsultas/` | Subqueries, EXISTS, CTEs |
| 9 | DML | `cap09-dml/` | INSERT, UPDATE, DELETE, CASE |

### PARTE II — Avançado

| # | Capítulo | Pasta | Tópicos |
|---|----------|-------|---------|
| 10 | Window Functions | `cap10-window-functions/` | ROW_NUMBER, RANK, LAG, LEAD, SUM OVER |
| 11 | Índices | `cap11-indices/` | CREATE INDEX, EXPLAIN, otimização |
| 12 | Transações | `cap12-transacoes/` | BEGIN, COMMIT, ROLLBACK, ACID, SAVEPOINT |

---

## 💻 Como Usar

### Pré-requisitos

Você precisa de **apenas um** dos seguintes:

- **SQLite** (recomendado) — [Download](https://www.sqlite.org/download.html)
- **PostgreSQL** — [Download](https://www.postgresql.org/download/)
- **MySQL** — [Download](https://dev.mysql.com/downloads/)
- **DB Browser for SQLite** (interface gráfica) — [Download](https://sqlitebrowser.org/)

### Passo a Passo

```bash
# 1. Clone o repositório
git clone https://github.com/jardelalves/sql-basico-avancado.git
cd sql-basico-avancado

# 2. Crie o banco com todos os dados
sqlite3 loja.db < scripts/cap01-introducao/00_setup_completo.sql

# 3. Abra o banco
sqlite3 loja.db

# 4. Teste: veja os dados
SELECT * FROM clientes;
SELECT * FROM produtos;

# 5. Siga os scripts de cada capítulo na ordem
# Exemplo: executar exemplos do capítulo 3
.read scripts/cap03-where/exemplos.sql
```

### Dicas do SQLite

```sql
-- Ativar modo tabela (saída formatada)
.mode column
.headers on

-- Ver tabelas existentes
.tables

-- Ver estrutura de uma tabela
.schema clientes

-- Executar um arquivo SQL
.read scripts/cap02-select/exemplos.sql

-- Sair
.quit
```

---

## 🗄️ Banco de Dados da Loja

O banco usado ao longo do livro simula uma loja online com as seguintes tabelas:

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  categorias  │     │   clientes   │     │   produtos   │
├──────────────┤     ├──────────────┤     ├──────────────┤
│ id (PK)      │     │ id (PK)      │     │ id (PK)      │
│ nome         │◄────│ nome         │     │ categoria_id (FK)──►│
│ descricao    │     │ email        │     │ nome         │
└──────────────┘     │ telefone     │     │ descricao    │
                     │ cidade       │     │ preco        │
                     │ estado       │     │ estoque      │
                     │ data_cadastro│     │ ativo        │
                     └──────┬───────┘     └──────────────┘
                            │
                     ┌──────┴───────┐     ┌──────────────┐
                     │   pedidos    │     │ itens_pedido │
                     ├──────────────┤     ├──────────────┤
                     │ id (PK)      │◄────│ id (PK)      │
                     │ cliente_id(FK)│     │ pedido_id(FK)│
                     │ data_pedido  │     │ produto_id(FK)──►│
                     │ valor_total  │     │ quantidade   │
                     │ status       │     │ preco_unitario│
                     └──────────────┘     └──────────────┘
```

**Volume de dados:** 8 categorias, 15 clientes, 20 produtos, 15 pedidos, 21 itens de pedido.

---

## 👨‍💻 Sobre o Autor

**Jardel Alves** — Desenvolvedor Full Stack e autor de livros técnicos.

- 📧 jardel.va96@gmail.com
- 📚 [Amazon KDP](https://www.amazon.com.br/s?k=Jardel+Alves) — Mais livros do autor
- 💼 Florianópolis, SC — Brasil

---

## 📄 Licença

Este repositório é material complementar do livro "SQL: Do Básico ao Avançado".
Os scripts são disponibilizados sob licença MIT para fins educacionais.

Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

<p align="center">
  <strong>⭐ Se este repositório te ajudou, deixe uma estrela!</strong>
</p>
<p align="center">
  <code>SELECT 'Obrigado!' AS mensagem FROM leitores WHERE dedicacao = 'total';</code>
</p>

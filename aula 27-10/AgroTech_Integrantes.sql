/* =====================================================================
   AgroTech Solutions — Auditoria de Dados e Indicadores Gerenciais
   Arquivo: AgroTech_Integrantes.sql   |   SGBD: MySQL 8
   Ordem de execução: Preparação da base -> Parte 1 -> Parte 2 -> Parte 3
   ===================================================================== */


/* =====================================================================
   PREPARAÇÃO DA BASE
   ===================================================================== */
DROP DATABASE IF EXISTS agropecuaria_db;
CREATE DATABASE agropecuaria_db;
USE agropecuaria_db;

CREATE TABLE tb_vendas_agro(
    id INT PRIMARY KEY,
    produto VARCHAR(100),
    categoria VARCHAR(50),
    fornecedor VARCHAR(100),
    estado VARCHAR(50),
    quantidade INT,
    valor_unitario DECIMAL(10,2),
    data_venda DATE,
    estoque BOOLEAN
);

INSERT INTO tb_vendas_agro
(id, produto, categoria, fornecedor, estado, quantidade, valor_unitario, data_venda, estoque)
VALUES
(1, 'Milho Safrinha', 'Grãos', 'AgroSul', 'PR', 120, 89.90, '2025-01-10', true),
(2, 'Soja Premium', 'Grãos', 'Campo Verde', 'MT', 200, 145.50, '2025-01-15', true),
(3, 'Ração Bovina 25kg', 'Rações', 'NutriCampo', 'SC', 80, 110.00, '2025-01-18', true),
(4, 'Fertilizante NPK', 'Fertilizantes', 'AgroMax', 'GO', 50, 320.75, '2025-01-22', false),
(5, 'Herbicida ForteMax', 'Defensivos', 'BioPlant', 'MS', 30, 450.00, '2025-01-25', true),
(6, 'Calcário Agrícola', 'Minerais', 'Solo Forte', 'PR', 300, 45.90, '2025-01-27', true),
(7, 'Semente de Trigo', 'Sementes', 'AgroSul', 'RS', 90, 99.99, '2025-02-01', false),
(8, 'Inseticida Power', 'Defensivos', 'Campo Verde', 'MT', 25, 599.00, '2025-02-03', true),
(9, 'Farelo de Soja', 'Rações', 'NutriCampo', 'SC', 110, 76.50, '2025-02-05', true),
(10, 'Adubo Orgânico', 'Fertilizantes', 'BioPlant', 'SP', 60, 180.00, '2025-02-08', true),
(11, 'Milheto', 'Sementes', 'AgroSul', 'GO', 70, 88.80, '2025-02-10', false),
(12, 'Sal Mineral Bovino', 'Minerais', 'NutriCampo', 'MG', 95, 67.40, '2025-02-12', true),
(13, 'Soja Convencional', 'Grãos', 'Campo Verde', 'MT', 180, 139.00, '2025-02-15', true),
(14, 'Ração Suína 20kg', 'Rações', 'NutriCampo', 'SC', 55, 98.00, '2025-02-17', false),
(15, 'Fungicida Max', 'Defensivos', 'AgroMax', 'PR', 22, 799.90, '2025-02-20', true),
(16, 'Semente de Aveia', 'Sementes', 'AgroSul', 'RS', 65, 72.30, '2025-02-22', true),
(17, 'Ureia Agrícola', 'Fertilizantes', 'Solo Forte', 'GO', 140, 210.00, '2025-02-25', true),
(18, 'Milho Híbrido', 'Grãos', 'Campo Verde', 'MS', 210, 155.90, '2025-03-01', false),
(19, 'Ração Equina', 'Rações', 'NutriCampo', 'SP', 40, 132.75, '2025-03-04', true),
(20, 'Herbicida Select', 'Defensivos', 'BioPlant', 'MT', 28, 499.90, '2025-03-06', true),
(21, 'Calcário Premium', 'Minerais', 'Solo Forte', 'PR', 310, 55.50, '2025-03-08', true),
(22, 'Semente de Pastagem', 'Sementes', 'AgroSul', 'GO', 85, 120.00, '2025-03-10', false),
(23, 'Soja Exportação', 'Grãos', 'Campo Verde', 'MT', 260, 160.00, '2025-03-12', true),
(24, 'Fertilizante Potássico', 'Fertilizantes', 'AgroMax', 'MS', 48, 420.00, '2025-03-14', true),
(25, 'Inseticida Ultra', 'Defensivos', 'BioPlant', 'SP', 18, 890.00, '2025-03-16', false),
(26, 'Ração Avícola', 'Rações', 'NutriCampo', 'SC', 130, 89.50, '2025-03-18', true),
(27, 'Milho Orgânico', 'Grãos', 'AgroSul', 'PR', 95, 110.00, '2025-03-20', true),
(28, 'Adubo Nitrogenado', 'Fertilizantes', 'Solo Forte', 'GO', 75, 275.00, '2025-03-22', true),
(29, 'Semente de Arroz', 'Sementes', 'Campo Verde', 'RS', 60, 140.00, '2025-03-24', false),
(30, 'Fungicida Premium', 'Defensivos', 'AgroMax', 'MT', 15, 950.00, '2025-03-26', true),
(31, 'Farelo Bovino', 'Rações', 'NutriCampo', 'MG', 120, 82.30, '2025-03-28', true),
(32, 'Soja Safra 2025', 'Grãos', 'Campo Verde', 'MS', 230, 150.00, '2025-03-30', false),
(33, 'Calcário Fino', 'Minerais', 'Solo Forte', 'PR', 340, 42.00, '2025-04-01', true),
(34, 'Herbicida AgroPlus', 'Defensivos', 'BioPlant', 'GO', 26, 620.00, '2025-04-03', true),
(35, 'Ração Premium Bovina', 'Rações', 'NutriCampo', 'SC', 88, 145.00, '2025-04-05', false),
(36, 'Semente de Feijão', 'Sementes', 'AgroSul', 'PR', 77, 115.90, '2025-04-07', true),
(37, 'Milho Tradicional', 'Grãos', 'Campo Verde', 'MT', 170, 100.00, '2025-04-10', true),
(38, 'Fertilizante Especial', 'Fertilizantes', 'AgroMax', 'SP', 54, 380.00, '2025-04-12', true),
(39, 'Inseticida Verde', 'Defensivos', 'BioPlant', 'MS', 19, 720.00, '2025-04-15', false),
(40, 'Sal Mineral Premium', 'Minerais', 'Solo Forte', 'MG', 105, 92.00, '2025-04-18', true),
(41, 'Ração Ovina', 'Rações', 'NutriCampo', 'RS', 66, 118.00, '2025-04-20', true),
(42, 'Soja Natural', 'Grãos', 'Campo Verde', 'GO', 190, 148.00, '2025-04-22', false),
(43, 'Semente Especial', 'Sementes', 'AgroSul', 'PR', 59, 132.50, '2025-04-24', true),
(44, 'Fungicida Rural', 'Defensivos', 'AgroMax', 'MT', 24, 845.00, '2025-04-26', true),
(45, 'Adubo Premium', 'Fertilizantes', 'Solo Forte', 'SC', 81, 299.90, '2025-04-28', false),
(46, 'Milho Exportação', 'Grãos', 'Campo Verde', 'MS', 250, 170.00, '2025-05-01', true),
(47, 'Ração Campo Forte', 'Rações', 'NutriCampo', 'GO', 74, 136.40, '2025-05-03', true),
(48, 'Calcário Rural', 'Minerais', 'Solo Forte', 'PR', 330, 48.90, '2025-05-05', false),
(49, 'Herbicida Platinum', 'Defensivos', 'BioPlant', 'SP', 17, 980.00, '2025-05-07', true),
(50, 'Semente Premium', 'Sementes', 'AgroSul', 'RS', 68, 155.00, '2025-05-10', true),

-- REGISTROS COM PROBLEMAS PARA LIMPEZA E TRATAMENTO DE DADOS

-- PRODUTOS DUPLICADOS
(51, 'Milho Safrinha', 'Grãos', 'AgroSul', 'PR', 120, 89.90, '2025-05-12', true),
(52, 'Soja Premium', 'Grãos', 'Campo Verde', 'MT', 200, 145.50, '2025-05-12', true),
(53, 'Ração Bovina 25kg', 'Rações', 'NutriCampo', 'SC', 80, 110.00, '2025-05-12', true),

-- NOMES INCORRETOS DE PRODUTOS
(54, 'Milhho Safrinha', 'Grãos', 'AgroSul', 'PR', 95, 88.00, '2025-05-13', true),
(55, 'Sojjja Premium', 'Grãos', 'Campo Verde', 'MT', 180, 140.00, '2025-05-13', true),
(56, 'Racão Bovina 25kg', 'Rações', 'NutriCampo', 'SC', 70, 105.00, '2025-05-13', true),
(57, 'Fertilizanti NPK', 'Fertilizantes', 'AgroMax', 'GO', 45, 310.00, '2025-05-13', false),
(58, 'Insetcida Power', 'Defensivos', 'Campo Verde', 'MT', 20, 580.00, '2025-05-13', true),

-- FORNECEDORES ESCRITOS ERRADOS
(59, 'Milho Híbrido', 'Grãos', 'Campo Vrede', 'MS', 190, 150.00, '2025-05-14', true),
(60, 'Ração Equina', 'Rações', 'NutriCamp', 'SP', 38, 130.00, '2025-05-14', true),
(61, 'Herbicida Select', 'Defensivos', 'Bio Planti', 'MT', 27, 495.00, '2025-05-14', true),

-- PREÇOS INCORRETOS / SUSPEITOS
(62, 'Soja Exportação', 'Grãos', 'Campo Verde', 'MT', 250, 1.99, '2025-05-15', true),
(63, 'Fungicida Premium', 'Defensivos', 'AgroMax', 'MT', 12, 99999.99, '2025-05-15', true),
(64, 'Calcário Premium', 'Minerais', 'Solo Forte', 'PR', 300, -45.00, '2025-05-15', true),
(65, 'Adubo Nitrogenado', 'Fertilizantes', 'Solo Forte', 'GO', 70, 0.00, '2025-05-15', true),

-- QUANTIDADES INCORRETAS
(66, 'Milho Tradicional', 'Grãos', 'Campo Verde', 'MT', -10, 100.00, '2025-05-16', true),
(67, 'Ração Ovina', 'Rações', 'NutriCampo', 'RS', 0, 118.00, '2025-05-16', true),

-- ESTADOS INCORRETOS
(68, 'Semente Especial', 'Sementes', 'AgroSul', 'PARANA', 59, 132.50, '2025-05-16', true),
(69, 'Herbicida Platinum', 'Defensivos', 'BioPlant', 'SÃO PAULO', 17, 980.00, '2025-05-16', true),

-- CATEGORIAS INCORRETAS
(70, 'Milho Exportação', 'Graos', 'Campo Verde', 'MS', 250, 170.00, '2025-05-17', true),
(71, 'Ração Campo Forte', 'Racao', 'NutriCampo', 'GO', 74, 136.40, '2025-05-17', true),

-- DATAS INCONSISTENTES
(72, 'Calcário Rural', 'Minerais', 'Solo Forte', 'PR', 330, 48.90, '2035-01-01', false),
(73, 'Semente Premium', 'Sementes', 'AgroSul', 'RS', 68, 155.00, '2028-12-30', true),

-- REGISTROS COMPLETAMENTE INCONSISTENTES
(74, 'XXXXX', 'ERRO', 'DESCONHECIDO', 'XX', -999, -500.00, '2040-01-01', false),
(75, 'TESTE PRODUTO', 'TESTE', 'TESTE', 'TT', 99999, 999999.99, '2099-01-01', true);

-- Conferência inicial da carga (esperado: 75 registros)
SELECT COUNT(*) AS total_registros_carregados FROM tb_vendas_agro;

-- Desativa o modo seguro do MySQL Workbench (permite UPDATE/DELETE filtrando por colunas que não são a chave)
SET SQL_SAFE_UPDATES = 0;


/* =====================================================================
   PARTE 1 — LIMPEZA E TRATAMENTO DE DADOS
   ===================================================================== */

/* ---------------------------------------------------------------------
   P1 - Questão 01: Remoção de registros duplicados
   Regra: para Milho Safrinha, Soja Premium e Ração Bovina 25kg, manter o
   registro de menor ID e remover os inseridos depois (ID maior).
   A grafia errada (ex.: 'Racão Bovina 25kg') não é igual ao nome exato,
   portanto esses registros são preservados.
   ATENÇÃO: o MySQL compara texto sem diferenciar acentos por padrão
   (collation *_ai_ci), então 'Racão' = 'Ração'. Por isso os filtros que
   dependem de acento usam COLLATE utf8mb4_bin (comparação exata).
   --------------------------------------------------------------------- */
-- Conferência (SELECT com o mesmo filtro do DELETE) — esperado: IDs 51, 52 e 53
SELECT d.id, d.produto, d.data_venda
FROM tb_vendas_agro d
WHERE d.produto COLLATE utf8mb4_bin IN ('Milho Safrinha', 'Soja Premium', 'Ração Bovina 25kg')
  AND d.id > (SELECT MIN(o.id) FROM tb_vendas_agro o WHERE o.produto COLLATE utf8mb4_bin = d.produto COLLATE utf8mb4_bin)
ORDER BY d.id;

-- Exclusão (a subquery é encapsulada em tabela derivada, exigência do MySQL
-- para consultar a mesma tabela que está sendo alterada)
DELETE FROM tb_vendas_agro
WHERE id IN (
    SELECT id FROM (
        SELECT d.id
        FROM tb_vendas_agro d
        WHERE d.produto COLLATE utf8mb4_bin IN ('Milho Safrinha', 'Soja Premium', 'Ração Bovina 25kg')
          AND d.id > (SELECT MIN(o.id) FROM tb_vendas_agro o WHERE o.produto COLLATE utf8mb4_bin = d.produto COLLATE utf8mb4_bin)
    ) AS duplicados
);

/* ---------------------------------------------------------------------
   P1 - Questão 02: Padronização dos nomes dos produtos
   --------------------------------------------------------------------- */
-- Conferência — esperado: IDs 54, 55, 56, 57 e 58
SELECT id, produto FROM tb_vendas_agro
WHERE produto COLLATE utf8mb4_bin IN ('Milhho Safrinha', 'Sojjja Premium', 'Racão Bovina 25kg', 'Fertilizanti NPK', 'Insetcida Power');

UPDATE tb_vendas_agro SET produto = 'Milho Safrinha'     WHERE produto COLLATE utf8mb4_bin = 'Milhho Safrinha';
UPDATE tb_vendas_agro SET produto = 'Soja Premium'       WHERE produto COLLATE utf8mb4_bin = 'Sojjja Premium';
UPDATE tb_vendas_agro SET produto = 'Ração Bovina 25kg'  WHERE produto COLLATE utf8mb4_bin = 'Racão Bovina 25kg';
UPDATE tb_vendas_agro SET produto = 'Fertilizante NPK'   WHERE produto COLLATE utf8mb4_bin = 'Fertilizanti NPK';
UPDATE tb_vendas_agro SET produto = 'Inseticida Power'   WHERE produto COLLATE utf8mb4_bin = 'Insetcida Power';

/* ---------------------------------------------------------------------
   P1 - Questão 03: Padronização dos fornecedores
   --------------------------------------------------------------------- */
-- Conferência — esperado: IDs 59, 60 e 61
SELECT id, produto, fornecedor FROM tb_vendas_agro
WHERE fornecedor IN ('Campo Vrede', 'NutriCamp', 'Bio Planti');

UPDATE tb_vendas_agro SET fornecedor = 'Campo Verde' WHERE fornecedor = 'Campo Vrede';
UPDATE tb_vendas_agro SET fornecedor = 'NutriCampo'  WHERE fornecedor = 'NutriCamp';
UPDATE tb_vendas_agro SET fornecedor = 'BioPlant'    WHERE fornecedor = 'Bio Planti';

/* ---------------------------------------------------------------------
   P1 - Questão 04: Correção dos valores unitários
   Filtros por produto + condição do valor inconsistente, para não tocar
   nos registros originais corretos (ex.: Soja Exportação de R$ 160,00).
   --------------------------------------------------------------------- */
-- Conferência — esperado: IDs 62, 63, 64 e 65
SELECT id, produto, valor_unitario FROM tb_vendas_agro
WHERE (produto = 'Soja Exportação'   AND valor_unitario < 10)
   OR (produto = 'Fungicida Premium' AND valor_unitario > 950)
   OR (produto = 'Calcário Premium'  AND valor_unitario < 0)
   OR (produto = 'Adubo Nitrogenado' AND valor_unitario = 0);

UPDATE tb_vendas_agro SET valor_unitario = 160.00 WHERE produto = 'Soja Exportação'   AND valor_unitario < 10;
UPDATE tb_vendas_agro SET valor_unitario = 950.00 WHERE produto = 'Fungicida Premium' AND valor_unitario > 950;
UPDATE tb_vendas_agro SET valor_unitario = 55.50  WHERE produto = 'Calcário Premium'  AND valor_unitario < 0;
UPDATE tb_vendas_agro SET valor_unitario = 275.00 WHERE produto = 'Adubo Nitrogenado' AND valor_unitario = 0;

/* ---------------------------------------------------------------------
   P1 - Questão 05: Correção das quantidades
   --------------------------------------------------------------------- */
-- Conferência — esperado: IDs 66 e 67
SELECT id, produto, quantidade FROM tb_vendas_agro
WHERE (produto = 'Milho Tradicional' AND quantidade = -10)
   OR (produto = 'Ração Ovina'       AND quantidade = 0);

UPDATE tb_vendas_agro SET quantidade = 170 WHERE produto = 'Milho Tradicional' AND quantidade = -10;
UPDATE tb_vendas_agro SET quantidade = 66  WHERE produto = 'Ração Ovina'       AND quantidade = 0;

/* ---------------------------------------------------------------------
   P1 - Questão 06: Padronização dos estados
   --------------------------------------------------------------------- */
-- Conferência — esperado: IDs 68 e 69
SELECT id, produto, estado FROM tb_vendas_agro WHERE estado IN ('PARANA', 'SÃO PAULO');

UPDATE tb_vendas_agro SET estado = 'PR' WHERE estado = 'PARANA';
UPDATE tb_vendas_agro SET estado = 'SP' WHERE estado = 'SÃO PAULO';

/* ---------------------------------------------------------------------
   P1 - Questão 07: Padronização das categorias
   (COLLATE utf8mb4_bin: sem isso 'Graos' também casaria com 'Grãos')
   --------------------------------------------------------------------- */
-- Conferência — esperado: IDs 70 e 71
SELECT id, produto, categoria FROM tb_vendas_agro WHERE categoria COLLATE utf8mb4_bin IN ('Graos', 'Racao');

UPDATE tb_vendas_agro SET categoria = 'Grãos'  WHERE categoria COLLATE utf8mb4_bin = 'Graos';
UPDATE tb_vendas_agro SET categoria = 'Rações' WHERE categoria COLLATE utf8mb4_bin = 'Racao';

/* ---------------------------------------------------------------------
   P1 - Questão 08: Exclusão de datas incompatíveis
   Limite do período operacional: 31/12/2025
   --------------------------------------------------------------------- */
-- Conferência — esperado: IDs 72, 73, 74 e 75
SELECT id, produto, data_venda FROM tb_vendas_agro WHERE data_venda > '2025-12-31';

DELETE FROM tb_vendas_agro WHERE data_venda > '2025-12-31';

/* ---------------------------------------------------------------------
   P1 - Questão 09: Exclusão de registros de teste
   Como os registros de teste (IDs 74 e 75) já foram removidos na Questão 08
   por terem datas inválidas, espera-se 0 linhas afetadas.
   --------------------------------------------------------------------- */
-- Conferência — esperado: nenhum registro
SELECT id, produto, categoria, fornecedor FROM tb_vendas_agro
WHERE produto IN ('XXXXX', 'TESTE PRODUTO')
   OR categoria IN ('ERRO', 'TESTE')
   OR fornecedor IN ('DESCONHECIDO', 'TESTE');

DELETE FROM tb_vendas_agro
WHERE produto IN ('XXXXX', 'TESTE PRODUTO')
   OR categoria IN ('ERRO', 'TESTE')
   OR fornecedor IN ('DESCONHECIDO', 'TESTE');

/* ---------------------------------------------------------------------
   P1 - Questão 10: Bloqueio comercial de defensivos
   Defensivos com valor_unitario > 800,00 passam a estoque = false.
   --------------------------------------------------------------------- */
-- Conferência — esperado: IDs 25, 30, 44, 49, 63 e 69 (o 25 já estava indisponível)
SELECT id, produto, categoria, valor_unitario, estoque FROM tb_vendas_agro
WHERE categoria = 'Defensivos' AND valor_unitario > 800.00;

UPDATE tb_vendas_agro SET estoque = false
WHERE categoria = 'Defensivos' AND valor_unitario > 800.00;

-- Conferência final da base tratada
SELECT COUNT(*) AS total_registros_base_tratada FROM tb_vendas_agro;


/* =====================================================================
   PARTE 2 — RELATÓRIO GERENCIAL (base tratada)
   ===================================================================== */

/* P2 - Questão 01: Produtos disponíveis (estoque = true) */
SELECT COUNT(*) AS total_registros_disponiveis
FROM tb_vendas_agro
WHERE estoque = true;

/* P2 - Questão 02: Participação dos fornecedores */
SELECT fornecedor, COUNT(*) AS quantidade_registros
FROM tb_vendas_agro
GROUP BY fornecedor
ORDER BY quantidade_registros DESC, fornecedor;

/* P2 - Questão 03: 10 registros de maior valor unitário */
SELECT produto AS nome_produto, categoria, valor_unitario, estado
FROM tb_vendas_agro
ORDER BY valor_unitario DESC, produto
LIMIT 10;

/* P2 - Questão 04: Valor unitário médio por categoria */
SELECT categoria, ROUND(AVG(valor_unitario), 2) AS valor_unitario_medio
FROM tb_vendas_agro
GROUP BY categoria
ORDER BY categoria;

/* P2 - Questão 05: Distribuição por estado */
SELECT estado, COUNT(*) AS quantidade_registros
FROM tb_vendas_agro
GROUP BY estado
ORDER BY quantidade_registros DESC, estado;

/* P2 - Questão 06: Sementes e Grãos disponíveis */
SELECT produto, categoria, quantidade, valor_unitario, estado
FROM tb_vendas_agro
WHERE categoria IN ('Sementes', 'Grãos')
  AND estoque = true
ORDER BY categoria, produto;

/* P2 - Questão 07: Registros com mais de 200 unidades */
SELECT produto, quantidade, estado
FROM tb_vendas_agro
WHERE quantidade > 200
ORDER BY quantidade DESC, produto;

/* P2 - Questão 08: Valor potencial do estoque disponível (quantidade x valor unitário) */
SELECT ROUND(SUM(quantidade * valor_unitario), 2) AS valor_potencial_estoque_disponivel
FROM tb_vendas_agro
WHERE estoque = true;

/* P2 - Questão 09: Categorias com produtos indisponíveis */
SELECT categoria, COUNT(*) AS registros_indisponiveis
FROM tb_vendas_agro
WHERE estoque = false
GROUP BY categoria
HAVING COUNT(*) >= 1
ORDER BY registros_indisponiveis DESC, categoria;

/* P2 - Questão 10: Vendas entre 01/03/2025 e 31/05/2025 (inclusive) */
SELECT produto, categoria, data_venda, valor_unitario, estado
FROM tb_vendas_agro
WHERE data_venda BETWEEN '2025-03-01' AND '2025-05-31'
ORDER BY data_venda, id;


/* =====================================================================
   PARTE 3 — KPIs DA AGROTECH SOLUTIONS (base tratada)
   Observações: "valor potencial" = quantidade x valor_unitario; NÃO é
   faturamento nem lucro. Divisões protegidas com NULLIF (evita divisão
   por zero). Percentuais e valores em R$ com 2 casas decimais.
   ===================================================================== */

/* ---------------------------------------------------------------------
   KPI 01 — Taxa de Disponibilidade
   Tema: Disponibilidade
   Objetivo: medir que parcela do portfólio cadastrado está liberada para
             venda.
   Regra: (registros com estoque = true / total de registros) x 100.
          Numerador: registros disponíveis. Denominador: TODOS os registros.
   --------------------------------------------------------------------- */
SELECT
    SUM(CASE WHEN estoque = true THEN 1 ELSE 0 END) AS registros_disponiveis,
    COUNT(*) AS total_registros,
    ROUND(100.0 * SUM(CASE WHEN estoque = true THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS taxa_disponibilidade_pct
FROM tb_vendas_agro;

/* ---------------------------------------------------------------------
   KPI 02 — Taxa de Indisponibilidade por Categoria
   Tema: Disponibilidade / Categorias
   Objetivo: identificar quais categorias concentram mais itens fora de
             venda, comparando segmentos.
   Regra: por categoria, (registros com estoque = false / registros da
          categoria) x 100. Considera TODOS os registros.
   --------------------------------------------------------------------- */
SELECT
    categoria,
    SUM(CASE WHEN estoque = false THEN 1 ELSE 0 END) AS registros_indisponiveis,
    COUNT(*) AS total_registros_categoria,
    ROUND(100.0 * SUM(CASE WHEN estoque = false THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS taxa_indisponibilidade_pct
FROM tb_vendas_agro
GROUP BY categoria
ORDER BY taxa_indisponibilidade_pct DESC, categoria;

/* ---------------------------------------------------------------------
   KPI 03 — Unidades Armazenadas Disponíveis
   Tema: Estoque e logística
   Objetivo: dimensionar o volume físico (em unidades) pronto para venda,
             diferenciando unidades de registros.
   Regra: SUM(quantidade) onde estoque = true. Considera APENAS os
          disponíveis. Registros disponíveis informados como referência.
   --------------------------------------------------------------------- */
SELECT
    COALESCE(SUM(quantidade), 0) AS unidades_disponiveis,
    COUNT(*) AS registros_disponiveis,
    ROUND(COALESCE(SUM(quantidade), 0) / NULLIF(COUNT(*), 0), 2) AS media_unidades_por_registro
FROM tb_vendas_agro
WHERE estoque = true;

/* ---------------------------------------------------------------------
   KPI 04 — Concentração de Unidades em Lotes Grandes (> 200 unidades)
   Tema: Estoque e logística
   Objetivo: medir quanto do volume armazenado está concentrado em poucos
             registros de grande quantidade (necessidade de espaço/giro).
   Regra: (soma de quantidade dos registros com quantidade > 200 / soma de
          quantidade de TODOS os registros) x 100. Usa subquery no
          denominador. Considera TODOS os registros.
   --------------------------------------------------------------------- */
SELECT
    SUM(quantidade) AS unidades_em_lotes_grandes,
    (SELECT SUM(quantidade) FROM tb_vendas_agro) AS unidades_totais,
    ROUND(100.0 * SUM(quantidade) / NULLIF((SELECT SUM(quantidade) FROM tb_vendas_agro), 0), 2) AS concentracao_lotes_grandes_pct
FROM tb_vendas_agro
WHERE quantidade > 200;

/* ---------------------------------------------------------------------
   KPI 05 — Valor Potencial do Estoque Disponível (R$)
   Tema: Valor financeiro do estoque
   Objetivo: estimar o valor potencial, a preços de tabela, do que está
             liberado para comercialização (não é faturamento nem lucro).
   Regra: SUM(quantidade x valor_unitario) onde estoque = true.
          Considera APENAS os disponíveis.
   --------------------------------------------------------------------- */
SELECT ROUND(COALESCE(SUM(quantidade * valor_unitario), 0), 2) AS valor_potencial_disponivel_rs
FROM tb_vendas_agro
WHERE estoque = true;

/* ---------------------------------------------------------------------
   KPI 06 — Valor Potencial Parado em Registros Indisponíveis (R$ e %)
   Tema: Valor financeiro do estoque / Disponibilidade
   Objetivo: mostrar quanto do valor potencial total está em itens
             bloqueados ou sem disponibilidade.
   Regra: valor indisponível = SUM(quantidade x valor_unitario) com
          estoque = false; % = valor indisponível / valor potencial de
          TODOS os registros x 100. Considera TODOS os registros.
   --------------------------------------------------------------------- */
SELECT
    ROUND(COALESCE(SUM(CASE WHEN estoque = false THEN quantidade * valor_unitario ELSE 0 END), 0), 2) AS valor_potencial_indisponivel_rs,
    ROUND(COALESCE(SUM(quantidade * valor_unitario), 0), 2) AS valor_potencial_total_rs,
    ROUND(100.0 * SUM(CASE WHEN estoque = false THEN quantidade * valor_unitario ELSE 0 END)
          / NULLIF(SUM(quantidade * valor_unitario), 0), 2) AS participacao_indisponivel_pct
FROM tb_vendas_agro;

/* ---------------------------------------------------------------------
   KPI 07 — Participação das Categorias no Valor Potencial Disponível
   Tema: Categorias / Valor financeiro do estoque
   Objetivo: comparar quais categorias sustentam o valor potencial do
             estoque disponível.
   Regra: por categoria, SUM(quantidade x valor_unitario) com
          estoque = true; % = valor da categoria / valor potencial total
          dos disponíveis (subquery) x 100. Considera APENAS os disponíveis.
   --------------------------------------------------------------------- */
SELECT
    categoria,
    ROUND(SUM(quantidade * valor_unitario), 2) AS valor_potencial_rs,
    ROUND(100.0 * SUM(quantidade * valor_unitario)
          / NULLIF((SELECT SUM(quantidade * valor_unitario) FROM tb_vendas_agro WHERE estoque = true), 0), 2) AS participacao_pct
FROM tb_vendas_agro
WHERE estoque = true
GROUP BY categoria
ORDER BY valor_potencial_rs DESC, categoria;

/* ---------------------------------------------------------------------
   KPI 08 — Participação e Concentração por Fornecedor
   Tema: Fornecedores
   Objetivo: medir a dependência do portfólio em relação a cada
             fornecedor (risco de concentração).
   Regra: por fornecedor, (registros do fornecedor / total de registros)
          x 100, com total obtido por subquery. Considera TODOS os registros.
   --------------------------------------------------------------------- */
SELECT
    fornecedor,
    COUNT(*) AS registros_fornecedor,
    (SELECT COUNT(*) FROM tb_vendas_agro) AS total_registros,
    ROUND(100.0 * COUNT(*) / NULLIF((SELECT COUNT(*) FROM tb_vendas_agro), 0), 2) AS participacao_pct
FROM tb_vendas_agro
GROUP BY fornecedor
ORDER BY registros_fornecedor DESC, fornecedor;

/* ---------------------------------------------------------------------
   KPI 09 — Participação dos Estados nas Unidades Armazenadas
   Tema: Categorias e estados / Estoque e logística
   Objetivo: comparar regiões quanto ao volume físico armazenado, para
             apoiar a logística e a distribuição.
   Regra: por estado, SUM(quantidade) e (unidades do estado / unidades
          totais) x 100, com total por subquery. Considera TODOS os
          registros.
   --------------------------------------------------------------------- */
SELECT
    estado,
    SUM(quantidade) AS unidades_estado,
    ROUND(100.0 * SUM(quantidade) / NULLIF((SELECT SUM(quantidade) FROM tb_vendas_agro), 0), 2) AS participacao_unidades_pct
FROM tb_vendas_agro
GROUP BY estado
ORDER BY unidades_estado DESC, estado;

/* ---------------------------------------------------------------------
   KPI 10 — Valor Unitário Médio: Defensivos x Demais Categorias (R$)
   Tema: Categorias / Valor financeiro
   Objetivo: comparar o posicionamento de preço dos Defensivos (alvo do
             bloqueio comercial) com o restante do portfólio.
   Regra: AVG(valor_unitario) do grupo 'Defensivos' e do grupo 'Demais
          categorias'. Considera TODOS os registros.
   --------------------------------------------------------------------- */
SELECT
    CASE WHEN categoria = 'Defensivos' THEN 'Defensivos' ELSE 'Demais categorias' END AS grupo,
    COUNT(*) AS registros,
    ROUND(AVG(valor_unitario), 2) AS valor_unitario_medio_rs
FROM tb_vendas_agro
GROUP BY CASE WHEN categoria = 'Defensivos' THEN 'Defensivos' ELSE 'Demais categorias' END
ORDER BY valor_unitario_medio_rs DESC;

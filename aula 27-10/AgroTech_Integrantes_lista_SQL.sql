-- ======================================================================
-- AgroTech Solutions — Auditoria de Dados e Indicadores Gerenciais
-- Arquivo único: Preparação da base + Parte 1 + Parte 2 + Parte 3 (KPIs)
-- Usa somente comandos da lista de comandos SQL da aula. Executar na ordem, em ambiente sem o banco agropecuaria_db.
-- ======================================================================


-- ======================================================================
-- PREPARAÇÃO DA BASE
-- ======================================================================

-- Criação do banco
CREATE DATABASE agropecuaria_db;

-- Seleção do banco
USE agropecuaria_db;

-- Criação da tabela
CREATE TABLE tb_vendas_agro (
  id             INT PRIMARY KEY,
  produto        VARCHAR(100),
  categoria      VARCHAR(50),
  fornecedor     VARCHAR(100),
  estado         VARCHAR(50),
  quantidade     INT,
  valor_unitario DECIMAL(10,2),
  data_venda     DATE,
  estoque        BOOLEAN
);

-- Carga dos dados fornecidos
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
(75, 'TESTE PRODUTO', 'TESTE', 'TESTE', 'TT', 99999, 999999.99, '2099-01-01', true);;

-- Conferência da carga
SELECT COUNT(*) AS total_registros FROM tb_vendas_agro;


-- ======================================================================
-- PARTE 1 — LIMPEZA E TRATAMENTO DE DADOS
-- ======================================================================

-- --------------------------------------------------------------------
-- QUESTÃO 01. Remoção de registros duplicados
-- Duplicado = mesmo produto, categoria, fornecedor, estado, quantidade e valor, com id maior (cópia inserida depois). O agrupamento por todas essas colunas evita confundir "Racão Bovina 25kg" (id 56, nome incorreto, com quantidade e valor diferentes) com "Ração Bovina 25kg": o MySQL ignora acentos na comparação de texto.
-- --------------------------------------------------------------------
-- Armadilha de acentos: o id 56 (nome incorreto) aparece junto, pois a comparação ignora acentos
SELECT id, produto, data_venda FROM tb_vendas_agro
WHERE produto = 'Ração Bovina 25kg'
ORDER BY id;

-- Localização das duplicatas: o menor id é o original
SELECT produto, quantidade, valor_unitario, COUNT(*) AS ocorrencias,
       MIN(id) AS id_original, MAX(id) AS id_copia
FROM tb_vendas_agro
WHERE produto IN ('Milho Safrinha', 'Soja Premium', 'Ração Bovina 25kg')
GROUP BY produto, categoria, fornecedor, estado, quantidade, valor_unitario
HAVING COUNT(*) > 1;

-- Conferência (SELECT) com o mesmo filtro do DELETE
SELECT id, produto, data_venda FROM tb_vendas_agro
WHERE id IN (51, 52, 53);

-- Comando (DELETE)
DELETE FROM tb_vendas_agro WHERE id IN (51, 52, 53);

-- Validação: originais (1, 2, 3) e nomes incorretos (54, 55, 56) preservados
SELECT id, produto, data_venda FROM tb_vendas_agro
WHERE produto IN ('Milho Safrinha', 'Soja Premium', 'Ração Bovina 25kg',
                  'Milhho Safrinha', 'Sojjja Premium', 'Racão Bovina 25kg')
ORDER BY id;

-- --------------------------------------------------------------------
-- QUESTÃO 02. Padronização dos nomes dos produtos
-- A lista de comandos não inclui UPDATE. Cada registro incorreto é removido com DELETE e reinserido com INSERT INTO, mantendo o mesmo id e todos os demais dados; só o nome muda. A remoção é feita por id porque a busca por "Racão Bovina 25kg" também alcançaria o id 3, que está correto.
-- --------------------------------------------------------------------
-- Localização: o id 3 aparece por ignorar acento, mas está correto e será preservado
SELECT id, produto FROM tb_vendas_agro
WHERE produto IN ('Milhho Safrinha', 'Sojjja Premium', 'Racão Bovina 25kg',
                  'Fertilizanti NPK', 'Insetcida Power')
ORDER BY id;

-- Conferência (SELECT) com o mesmo filtro do DELETE
SELECT id, produto FROM tb_vendas_agro
WHERE id IN (54, 55, 56, 57, 58);

-- Comando 1/2 (DELETE dos 5 registros incorretos)
DELETE FROM tb_vendas_agro WHERE id IN (54, 55, 56, 57, 58);

-- Comando 2/2 (INSERT INTO com os nomes corretos)
INSERT INTO tb_vendas_agro VALUES
(54, 'Milho Safrinha', 'Grãos', 'AgroSul', 'PR', 95, 88.00, '2025-05-13', true),
(55, 'Soja Premium', 'Grãos', 'Campo Verde', 'MT', 180, 140.00, '2025-05-13', true),
(56, 'Ração Bovina 25kg', 'Rações', 'NutriCampo', 'SC', 70, 105.00, '2025-05-13', true),
(57, 'Fertilizante NPK', 'Fertilizantes', 'AgroMax', 'GO', 45, 310.00, '2025-05-13', false),
(58, 'Inseticida Power', 'Defensivos', 'Campo Verde', 'MT', 20, 580.00, '2025-05-13', true);

-- Validação (id 3 permanece intacto)
SELECT id, produto, fornecedor, quantidade, valor_unitario, estoque
FROM tb_vendas_agro
WHERE id IN (3, 54, 55, 56, 57, 58)
ORDER BY id;

-- --------------------------------------------------------------------
-- QUESTÃO 03. Padronização dos fornecedores
-- Mesma técnica (DELETE + INSERT INTO), agora filtrando pela grafia incorreta do fornecedor.
-- --------------------------------------------------------------------
-- Conferência (SELECT)
SELECT id, produto, fornecedor FROM tb_vendas_agro
WHERE fornecedor IN ('Campo Vrede', 'NutriCamp', 'Bio Planti')
ORDER BY id;

-- Comando 1/2 (DELETE)
DELETE FROM tb_vendas_agro
WHERE fornecedor IN ('Campo Vrede', 'NutriCamp', 'Bio Planti');

-- Comando 2/2 (INSERT INTO com os fornecedores corretos)
INSERT INTO tb_vendas_agro VALUES
(59, 'Milho Híbrido', 'Grãos', 'Campo Verde', 'MS', 190, 150.00, '2025-05-14', true),
(60, 'Ração Equina', 'Rações', 'NutriCampo', 'SP', 38, 130.00, '2025-05-14', true),
(61, 'Herbicida Select', 'Defensivos', 'BioPlant', 'MT', 27, 495.00, '2025-05-14', true);

-- Validação: grafias incorretas eliminadas (DESCONHECIDO e TESTE são registros de teste, removidos nas Questões 08/09)
SELECT fornecedor, COUNT(*) AS qtd_registros
FROM tb_vendas_agro
GROUP BY fornecedor
ORDER BY fornecedor;

-- --------------------------------------------------------------------
-- QUESTÃO 04. Correção dos valores unitários
-- O diagnóstico lista todos os valores fora do padrão. O filtro combina produto e condição do valor errado, preservando as linhas corretas dos mesmos produtos (ids 21, 23, 28 e 30). Correção por DELETE + INSERT INTO.
-- --------------------------------------------------------------------
-- Diagnóstico geral de valores suspeitos (ids 74 e 75 são registros de teste, tratados na Questão 08)
SELECT id, produto, valor_unitario FROM tb_vendas_agro
WHERE valor_unitario <= 5 OR valor_unitario >= 5000
ORDER BY id;

-- Conferência (SELECT) com o filtro do DELETE
SELECT id, produto, valor_unitario FROM tb_vendas_agro
WHERE (produto = 'Soja Exportação'   AND valor_unitario < 10)
   OR (produto = 'Fungicida Premium' AND valor_unitario > 10000)
   OR (produto = 'Calcário Premium'  AND valor_unitario < 0)
   OR (produto = 'Adubo Nitrogenado' AND valor_unitario = 0)
ORDER BY id;

-- Comando 1/2 (DELETE)
DELETE FROM tb_vendas_agro
WHERE (produto = 'Soja Exportação'   AND valor_unitario < 10)
   OR (produto = 'Fungicida Premium' AND valor_unitario > 10000)
   OR (produto = 'Calcário Premium'  AND valor_unitario < 0)
   OR (produto = 'Adubo Nitrogenado' AND valor_unitario = 0);

-- Comando 2/2 (INSERT INTO com os valores corretos)
INSERT INTO tb_vendas_agro VALUES
(62, 'Soja Exportação', 'Grãos', 'Campo Verde', 'MT', 250, 160.00, '2025-05-15', true),
(63, 'Fungicida Premium', 'Defensivos', 'AgroMax', 'MT', 12, 950.00, '2025-05-15', true),
(64, 'Calcário Premium', 'Minerais', 'Solo Forte', 'PR', 300, 55.50, '2025-05-15', true),
(65, 'Adubo Nitrogenado', 'Fertilizantes', 'Solo Forte', 'GO', 70, 275.00, '2025-05-15', true);

-- Validação
SELECT id, produto, valor_unitario FROM tb_vendas_agro
WHERE produto IN ('Soja Exportação', 'Fungicida Premium',
                  'Calcário Premium', 'Adubo Nitrogenado')
ORDER BY produto, id;

-- --------------------------------------------------------------------
-- QUESTÃO 05. Correção das quantidades
-- Corrige as quantidades negativa e zerada, filtrando por produto e pelo valor incorreto (DELETE + INSERT INTO).
-- --------------------------------------------------------------------
-- Diagnóstico geral (o id 74 é registro de teste, tratado na Questão 08)
SELECT id, produto, quantidade FROM tb_vendas_agro
WHERE quantidade <= 0
ORDER BY id;

-- Conferência (SELECT) com o filtro do DELETE
SELECT id, produto, quantidade FROM tb_vendas_agro
WHERE (produto = 'Milho Tradicional' AND quantidade = -10)
   OR (produto = 'Ração Ovina'       AND quantidade = 0)
ORDER BY id;

-- Comando 1/2 (DELETE)
DELETE FROM tb_vendas_agro
WHERE (produto = 'Milho Tradicional' AND quantidade = -10)
   OR (produto = 'Ração Ovina'       AND quantidade = 0);

-- Comando 2/2 (INSERT INTO com as quantidades corretas)
INSERT INTO tb_vendas_agro VALUES
(66, 'Milho Tradicional', 'Grãos', 'Campo Verde', 'MT', 170, 100.00, '2025-05-16', true),
(67, 'Ração Ovina', 'Rações', 'NutriCampo', 'RS', 66, 118.00, '2025-05-16', true);

-- Validação
SELECT id, produto, quantidade FROM tb_vendas_agro
WHERE produto IN ('Milho Tradicional', 'Ração Ovina')
ORDER BY produto, id;

-- --------------------------------------------------------------------
-- QUESTÃO 06. Padronização dos estados
-- Troca os estados por extenso pela sigla padrão (DELETE + INSERT INTO).
-- --------------------------------------------------------------------
-- Conferência (SELECT)
SELECT id, produto, estado FROM tb_vendas_agro
WHERE estado IN ('PARANA', 'SÃO PAULO')
ORDER BY id;

-- Comando 1/2 (DELETE)
DELETE FROM tb_vendas_agro WHERE estado IN ('PARANA', 'SÃO PAULO');

-- Comando 2/2 (INSERT INTO com as siglas corretas)
INSERT INTO tb_vendas_agro VALUES
(68, 'Semente Especial', 'Sementes', 'AgroSul', 'PR', 59, 132.50, '2025-05-16', true),
(69, 'Herbicida Platinum', 'Defensivos', 'BioPlant', 'SP', 17, 980.00, '2025-05-16', true);

-- Validação
SELECT id, produto, estado FROM tb_vendas_agro
WHERE id IN (68, 69)
ORDER BY id;

-- --------------------------------------------------------------------
-- QUESTÃO 07. Padronização das categorias
-- O MySQL ignora acentos na comparação de texto, então "Graos" seria igual a "Grãos" e um filtro por categoria alcançaria todos os Grãos. Por isso os registros incorretos são localizados pelos produtos e removidos por id (70 e 71). DELETE + INSERT INTO.
-- --------------------------------------------------------------------
-- Localização: ids 70 e 71 estão com a grafia incorreta
SELECT id, produto, categoria FROM tb_vendas_agro
WHERE produto IN ('Milho Exportação', 'Ração Campo Forte')
ORDER BY id;

-- Conferência (SELECT) com o mesmo filtro do DELETE
SELECT id, produto, categoria FROM tb_vendas_agro
WHERE id IN (70, 71);

-- Comando 1/2 (DELETE)
DELETE FROM tb_vendas_agro WHERE id IN (70, 71);

-- Comando 2/2 (INSERT INTO com as categorias corretas)
INSERT INTO tb_vendas_agro VALUES
(70, 'Milho Exportação', 'Grãos', 'Campo Verde', 'MS', 250, 170.00, '2025-05-17', true),
(71, 'Ração Campo Forte', 'Rações', 'NutriCampo', 'GO', 74, 136.40, '2025-05-17', true);

-- Validação
SELECT id, produto, categoria FROM tb_vendas_agro
WHERE produto IN ('Milho Exportação', 'Ração Campo Forte')
ORDER BY id;

-- --------------------------------------------------------------------
-- QUESTÃO 08. Exclusão de datas incompatíveis
-- Remove todos os registros com data_venda posterior a 31/12/2025, independentemente do produto ou do estoque.
-- --------------------------------------------------------------------
-- Conferência (SELECT)
SELECT id, produto, data_venda, estoque FROM tb_vendas_agro
WHERE data_venda > '2025-12-31'
ORDER BY id;

-- Comando (DELETE)
DELETE FROM tb_vendas_agro WHERE data_venda > '2025-12-31';

-- Validação
SELECT COUNT(*) AS total_registros,
       MAX(data_venda) AS maior_data_venda
FROM tb_vendas_agro;

-- --------------------------------------------------------------------
-- QUESTÃO 09. Exclusão de registros de teste
-- O comando é apresentado conforme solicitado. Como os ids 74 e 75 já foram removidos na Questão 08 (datas 2040 e 2099), a expectativa é 0 linhas afetadas.
-- --------------------------------------------------------------------
-- Conferência (SELECT)
SELECT id, produto, categoria, fornecedor FROM tb_vendas_agro
WHERE produto IN ('XXXXX', 'TESTE PRODUTO')
   OR categoria IN ('ERRO', 'TESTE')
   OR fornecedor IN ('DESCONHECIDO', 'TESTE');

-- Comando (DELETE)
DELETE FROM tb_vendas_agro
WHERE produto IN ('XXXXX', 'TESTE PRODUTO')
   OR categoria IN ('ERRO', 'TESTE')
   OR fornecedor IN ('DESCONHECIDO', 'TESTE');

-- --------------------------------------------------------------------
-- QUESTÃO 10. Bloqueio comercial de defensivos
-- Defensivos com valor_unitario superior a R$ 800,00 passam a estoque = false (DELETE + INSERT INTO, mantendo os registros cadastrados). O Fungicida Max (R$ 799,90) fica de fora por não ser superior a 800, e o id 25 já estava com estoque = false.
-- --------------------------------------------------------------------
-- Diagnóstico: Defensivos acima de R$ 800,00 (o id 25 já está indisponível)
SELECT id, produto, valor_unitario, estoque FROM tb_vendas_agro
WHERE categoria = 'Defensivos' AND valor_unitario > 800
ORDER BY id;

-- Conferência (SELECT) com o filtro do DELETE
SELECT id, produto, valor_unitario, estoque FROM tb_vendas_agro
WHERE categoria = 'Defensivos' AND valor_unitario > 800 AND estoque = TRUE
ORDER BY id;

-- Comando 1/2 (DELETE)
DELETE FROM tb_vendas_agro
WHERE categoria = 'Defensivos' AND valor_unitario > 800 AND estoque = TRUE;

-- Comando 2/2 (INSERT INTO com estoque = false)
INSERT INTO tb_vendas_agro VALUES
(30, 'Fungicida Premium', 'Defensivos', 'AgroMax', 'MT', 15, 950.00, '2025-03-26', false),
(44, 'Fungicida Rural', 'Defensivos', 'AgroMax', 'MT', 24, 845.00, '2025-04-26', false),
(49, 'Herbicida Platinum', 'Defensivos', 'BioPlant', 'SP', 17, 980.00, '2025-05-07', false),
(63, 'Fungicida Premium', 'Defensivos', 'AgroMax', 'MT', 12, 950.00, '2025-05-15', false),
(69, 'Herbicida Platinum', 'Defensivos', 'BioPlant', 'SP', 17, 980.00, '2025-05-16', false);

-- Validação: todos os Defensivos, ordenados por valor
SELECT id, produto, valor_unitario, estoque FROM tb_vendas_agro
WHERE categoria = 'Defensivos'
ORDER BY valor_unitario DESC, id;

-- Fechamento da Parte 1: tamanho da base tratada
SELECT COUNT(*) AS total_registros_base_tratada FROM tb_vendas_agro;


-- ======================================================================
-- PARTE 2 — RELATÓRIO GERENCIAL
-- ======================================================================

-- --------------------------------------------------------------------
-- QUESTÃO 01. Produtos disponíveis
-- Contagem de registros com estoque = true.
-- --------------------------------------------------------------------
-- Consulta
SELECT COUNT(*) AS total_registros_disponiveis
FROM tb_vendas_agro
WHERE estoque = TRUE;

-- --------------------------------------------------------------------
-- QUESTÃO 02. Participação dos fornecedores
-- Registros por fornecedor, do maior para o menor (desempate em ordem alfabética).
-- --------------------------------------------------------------------
-- Consulta
SELECT fornecedor, COUNT(*) AS qtd_registros
FROM tb_vendas_agro
GROUP BY fornecedor
ORDER BY qtd_registros DESC, fornecedor ASC;

-- --------------------------------------------------------------------
-- QUESTÃO 03. Produtos de maior valor unitário
-- LIMIT não consta na lista de comandos. O top 10 usa uma subquery que conta quantos registros têm valor maior que o da linha: só entram os registros com menos de 10 valores acima.
-- --------------------------------------------------------------------
-- Consulta
SELECT t.produto, t.categoria, t.valor_unitario, t.estado
FROM tb_vendas_agro AS t
WHERE (SELECT COUNT(*) FROM tb_vendas_agro AS o
       WHERE o.valor_unitario > t.valor_unitario) < 10
ORDER BY t.valor_unitario DESC, t.produto ASC;

-- --------------------------------------------------------------------
-- QUESTÃO 04. Valor médio por categoria
-- ROUND não consta na lista. O arredondamento para 2 casas é feito com FLOOR: FLOOR(média × 100 + 0,5) × 0,01.
-- --------------------------------------------------------------------
-- Consulta
SELECT categoria,
       FLOOR(AVG(valor_unitario) * 100 + 0.5) * 0.01 AS valor_unitario_medio
FROM tb_vendas_agro
GROUP BY categoria
ORDER BY valor_unitario_medio DESC;

-- --------------------------------------------------------------------
-- QUESTÃO 05. Distribuição por estado
-- Registros por estado, do maior para o menor.
-- --------------------------------------------------------------------
-- Consulta
SELECT estado, COUNT(*) AS qtd_registros
FROM tb_vendas_agro
GROUP BY estado
ORDER BY qtd_registros DESC, estado ASC;

-- --------------------------------------------------------------------
-- QUESTÃO 06. Sementes e grãos disponíveis
-- Registros das categorias Sementes e Grãos com estoque = true.
-- --------------------------------------------------------------------
-- Consulta
SELECT produto, categoria, quantidade, valor_unitario, estado
FROM tb_vendas_agro
WHERE categoria IN ('Sementes', 'Grãos')
  AND estoque = TRUE
ORDER BY categoria, produto;

-- --------------------------------------------------------------------
-- QUESTÃO 07. Produtos com grande quantidade armazenada
-- Registros com mais de 200 unidades, da maior para a menor quantidade.
-- --------------------------------------------------------------------
-- Consulta
SELECT produto, quantidade, estado
FROM tb_vendas_agro
WHERE quantidade > 200
ORDER BY quantidade DESC, produto ASC;

-- --------------------------------------------------------------------
-- QUESTÃO 08. Valor potencial do estoque disponível
-- Valor potencial = quantidade × valor_unitario, somado apenas para estoque = true. O resultado já sai com 2 casas decimais (quantidade inteira × valor com 2 casas).
-- --------------------------------------------------------------------
-- Consulta
SELECT SUM(quantidade * valor_unitario) AS valor_potencial_estoque_disponivel
FROM tb_vendas_agro
WHERE estoque = TRUE;

-- --------------------------------------------------------------------
-- QUESTÃO 09. Produtos indisponíveis por categoria
-- Categorias com pelo menos um registro com estoque = false.
-- --------------------------------------------------------------------
-- Consulta
SELECT categoria, COUNT(*) AS qtd_indisponiveis
FROM tb_vendas_agro
WHERE estoque = FALSE
GROUP BY categoria
HAVING COUNT(*) >= 1
ORDER BY qtd_indisponiveis DESC, categoria ASC;

-- --------------------------------------------------------------------
-- QUESTÃO 10. Vendas entre março e maio de 2025
-- data_venda de 01/03/2025 a 31/05/2025 (BETWEEN inclui as duas pontas).
-- --------------------------------------------------------------------
-- Consulta
SELECT produto, categoria, data_venda, valor_unitario, estado
FROM tb_vendas_agro
WHERE data_venda BETWEEN '2025-03-01' AND '2025-05-31'
ORDER BY data_venda ASC, id ASC;


-- ======================================================================
-- PARTE 3 — CRIAÇÃO DE KPIs
-- ======================================================================

-- --------------------------------------------------------------------
-- KPI 01 — Taxa de Disponibilidade de Produtos
-- Tema: Disponibilidade
-- Objetivo: Medir que parcela dos registros cadastrados está liberada para comercialização.
-- Regra de cálculo: Registros com estoque = true ÷ total de registros × 100.
-- Base: Todos os registros (numerador: apenas disponíveis; denominador: todos).
-- --------------------------------------------------------------------
SELECT SUM(CASE WHEN estoque = TRUE THEN 1 ELSE 0 END) AS registros_disponiveis,
       COUNT(*) AS total_registros,
       CASE WHEN COUNT(*) = 0 THEN 0
            ELSE FLOOR(SUM(CASE WHEN estoque = TRUE THEN 1 ELSE 0 END) * 10000
                       / COUNT(*) + 0.5) * 0.01
       END AS taxa_disponibilidade_pct
FROM tb_vendas_agro;

-- --------------------------------------------------------------------
-- KPI 02 — Taxa de Indisponibilidade por Categoria
-- Tema: Disponibilidade / Categorias
-- Objetivo: Comparar as categorias quanto à proporção de registros sem estoque, apontando onde há mais ruptura.
-- Regra de cálculo: Registros da categoria com estoque = false ÷ total de registros da categoria × 100.
-- Base: Todos os registros, agrupados por categoria.
-- --------------------------------------------------------------------
SELECT categoria,
       SUM(CASE WHEN estoque = FALSE THEN 1 ELSE 0 END) AS registros_indisponiveis,
       COUNT(*) AS total_registros_categoria,
       CASE WHEN COUNT(*) = 0 THEN 0
            ELSE FLOOR(SUM(CASE WHEN estoque = FALSE THEN 1 ELSE 0 END) * 10000
                       / COUNT(*) + 0.5) * 0.01
       END AS taxa_indisponibilidade_pct
FROM tb_vendas_agro
GROUP BY categoria
ORDER BY taxa_indisponibilidade_pct DESC, categoria;

-- --------------------------------------------------------------------
-- KPI 03 — Participação das Unidades Disponíveis no Volume Total
-- Tema: Estoque e logística
-- Objetivo: Medir, em unidades (e não em registros), quanto do volume armazenado está disponível para venda.
-- Regra de cálculo: SUM(quantidade) dos registros com estoque = true ÷ SUM(quantidade) de todos os registros × 100.
-- Base: Numerador: apenas disponíveis; denominador: todos os registros (subquery).
-- --------------------------------------------------------------------
SELECT SUM(quantidade) AS unidades_disponiveis,
       (SELECT SUM(quantidade) FROM tb_vendas_agro) AS unidades_totais,
       CASE WHEN (SELECT SUM(quantidade) FROM tb_vendas_agro) = 0 THEN 0
            ELSE FLOOR(SUM(quantidade) * 10000
                       / (SELECT SUM(quantidade) FROM tb_vendas_agro) + 0.5) * 0.01
       END AS pct_unidades_disponiveis
FROM tb_vendas_agro
WHERE estoque = TRUE;

-- --------------------------------------------------------------------
-- KPI 04 — Distribuição das Unidades Disponíveis por Estado
-- Tema: Estoque e logística / Estados
-- Objetivo: Identificar onde o volume disponível está concentrado, apoiando decisões de logística e abastecimento regional.
-- Regra de cálculo: SUM(quantidade) do estado ÷ SUM(quantidade) total disponível × 100.
-- Base: Apenas registros disponíveis (estoque = true), agrupados por estado.
-- --------------------------------------------------------------------
SELECT estado,
       SUM(quantidade) AS unidades_estado,
       (SELECT SUM(quantidade) FROM tb_vendas_agro WHERE estoque = TRUE) AS unidades_disp_total,
       CASE WHEN (SELECT SUM(quantidade) FROM tb_vendas_agro WHERE estoque = TRUE) = 0 THEN 0
            ELSE FLOOR(SUM(quantidade) * 10000
                       / (SELECT SUM(quantidade) FROM tb_vendas_agro WHERE estoque = TRUE)
                       + 0.5) * 0.01
       END AS pct_unidades_disponiveis
FROM tb_vendas_agro
WHERE estoque = TRUE
GROUP BY estado
ORDER BY unidades_estado DESC, estado;

-- --------------------------------------------------------------------
-- KPI 05 — Valor Potencial do Estoque Disponível (R$)
-- Tema: Valor financeiro do estoque
-- Objetivo: Dimensionar o valor potencial representado pelos produtos liberados para venda. Não é faturamento nem lucro.
-- Regra de cálculo: SUM(quantidade × valor_unitario) dos registros com estoque = true.
-- Base: Apenas registros disponíveis.
-- --------------------------------------------------------------------
SELECT COUNT(*) AS registros_considerados,
       SUM(quantidade * valor_unitario) AS valor_potencial_disponivel_rs
FROM tb_vendas_agro
WHERE estoque = TRUE;

-- --------------------------------------------------------------------
-- KPI 06 — Concentração do Valor Potencial por Categoria (R$ e %)
-- Tema: Valor financeiro / Categorias
-- Objetivo: Mostrar quais categorias concentram o valor potencial dos produtos cadastrados.
-- Regra de cálculo: SUM(quantidade × valor_unitario) da categoria ÷ SUM(quantidade × valor_unitario) total × 100.
-- Base: Todos os registros cadastrados, agrupados por categoria.
-- --------------------------------------------------------------------
SELECT categoria,
       SUM(quantidade * valor_unitario) AS valor_potencial_rs,
       (SELECT SUM(quantidade * valor_unitario) FROM tb_vendas_agro) AS valor_potencial_total_rs,
       CASE WHEN (SELECT SUM(quantidade * valor_unitario) FROM tb_vendas_agro) = 0 THEN 0
            ELSE FLOOR(SUM(quantidade * valor_unitario) * 10000
                       / (SELECT SUM(quantidade * valor_unitario) FROM tb_vendas_agro)
                       + 0.5) * 0.01
       END AS pct_do_total
FROM tb_vendas_agro
GROUP BY categoria
ORDER BY valor_potencial_rs DESC;

-- --------------------------------------------------------------------
-- KPI 07 — Concentração dos 3 Maiores Fornecedores
-- Tema: Fornecedores
-- Objetivo: Avaliar a dependência da base em relação aos principais fornecedores.
-- Regra de cálculo: Registros dos 3 fornecedores com mais registros ÷ total de registros × 100.
-- Base: Todos os registros. Sem LIMIT: entram os fornecedores com menos de 3 fornecedores acima deles em registros.
-- --------------------------------------------------------------------
SELECT SUM(f.qtd) AS registros_top3,
       (SELECT COUNT(*) FROM tb_vendas_agro) AS total_registros,
       CASE WHEN (SELECT COUNT(*) FROM tb_vendas_agro) = 0 THEN 0
            ELSE FLOOR(SUM(f.qtd) * 10000 / (SELECT COUNT(*) FROM tb_vendas_agro) + 0.5) * 0.01
       END AS pct_concentracao_top3
FROM (SELECT fornecedor, COUNT(*) AS qtd
      FROM tb_vendas_agro
      GROUP BY fornecedor) AS f
WHERE (SELECT COUNT(*)
       FROM (SELECT fornecedor, COUNT(*) AS qtd
             FROM tb_vendas_agro
             GROUP BY fornecedor) AS g
       WHERE g.qtd > f.qtd) < 3;

-- --------------------------------------------------------------------
-- KPI 08 — Índice de Preço Médio por Fornecedor (base 100 = média geral)
-- Tema: Fornecedores / Financeiro
-- Objetivo: Comparar o valor unitário médio de cada fornecedor com a média geral da base, indicando o posicionamento do portfólio de cada um.
-- Regra de cálculo: AVG(valor_unitario) do fornecedor ÷ AVG(valor_unitario) geral × 100.
-- Base: Todos os registros, agrupados por fornecedor (subquery para a média geral).
-- --------------------------------------------------------------------
SELECT fornecedor,
       FLOOR(AVG(valor_unitario) * 100 + 0.5) * 0.01 AS preco_medio_fornecedor_rs,
       (SELECT FLOOR(AVG(valor_unitario) * 100 + 0.5) * 0.01 FROM tb_vendas_agro)
       AS preco_medio_geral_rs,
       CASE WHEN (SELECT AVG(valor_unitario) FROM tb_vendas_agro) = 0 THEN 0
            ELSE FLOOR(AVG(valor_unitario) * 10000
                       / (SELECT AVG(valor_unitario) FROM tb_vendas_agro) + 0.5) * 0.01
       END AS indice_preco
FROM tb_vendas_agro
GROUP BY fornecedor
ORDER BY indice_preco DESC;

-- --------------------------------------------------------------------
-- KPI 09 — Peso dos Registros de Alto Volume (> 200 unidades)
-- Tema: Estoque e logística
-- Objetivo: Medir quanto do volume armazenado está concentrado em poucos registros de grande quantidade.
-- Regra de cálculo: Registros com quantidade > 200 ÷ total de registros × 100; e unidades desses registros ÷ unidades totais × 100. O limite de 200 unidades é o da Parte 2, Q07 (sugestão do grupo).
-- Base: Todos os registros.
-- --------------------------------------------------------------------
SELECT SUM(CASE WHEN quantidade > 200 THEN 1 ELSE 0 END) AS reg_alto_volume,
       COUNT(*) AS total_registros,
       CASE WHEN COUNT(*) = 0 THEN 0
            ELSE FLOOR(SUM(CASE WHEN quantidade > 200 THEN 1 ELSE 0 END) * 10000
                       / COUNT(*) + 0.5) * 0.01
       END AS pct_registros,
       SUM(CASE WHEN quantidade > 200 THEN quantidade ELSE 0 END) AS un_alto_volume,
       SUM(quantidade) AS unidades_totais,
       CASE WHEN SUM(quantidade) = 0 THEN 0
            ELSE FLOOR(SUM(CASE WHEN quantidade > 200 THEN quantidade ELSE 0 END) * 10000
                       / SUM(quantidade) + 0.5) * 0.01
       END AS pct_unidades
FROM tb_vendas_agro;

-- --------------------------------------------------------------------
-- KPI 10 — Cobertura Geográfica por Categoria
-- Tema: Categorias e estados
-- Objetivo: Verificar em quantos estados cada categoria está presente, em relação ao total de estados da base.
-- Regra de cálculo: Estados distintos da categoria ÷ estados distintos de toda a base × 100. (DISTINCT é intencional: conta estados, não produtos.)
-- Base: Todos os registros, agrupados por categoria (subquery com DISTINCT para o total de estados).
-- --------------------------------------------------------------------
SELECT c.categoria,
       COUNT(*) AS estados_atendidos,
       (SELECT COUNT(*) FROM (SELECT DISTINCT estado FROM tb_vendas_agro) AS e) AS total_estados,
       CASE WHEN (SELECT COUNT(*) FROM (SELECT DISTINCT estado FROM tb_vendas_agro)
       AS e) = 0 THEN 0
            ELSE FLOOR(COUNT(*) * 10000
                       / (SELECT COUNT(*) FROM (SELECT DISTINCT estado FROM tb_vendas_agro)
       AS e) + 0.5) * 0.01
       END AS cobertura_pct
FROM (SELECT DISTINCT categoria, estado FROM tb_vendas_agro) AS c
GROUP BY c.categoria
ORDER BY cobertura_pct DESC, c.categoria;


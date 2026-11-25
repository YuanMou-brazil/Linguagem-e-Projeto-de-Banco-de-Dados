# Análise de Dados AgroTech Solutions

Auditoria de dados e indicadores gerenciais (KPIs) sobre a base consolidada de vendas agrícolas das filiais da AgroTech Solutions, desenvolvida em SQL (MySQL).

## Sumário

1. [Visão geral](#1-visão-geral)
2. [Como executar](#2-como-executar)
3. [Dicionário de dados](#3-dicionário-de-dados)
4. [Resultados do tratamento e do relatório gerencial](#4-resultados-do-tratamento-e-do-relatório-gerencial)
5. [Catálogo e resultados dos 10 KPIs](#5-catálogo-e-resultados-dos-10-kpis)
6. [Conclusão gerencial](#6-conclusão-gerencial)

---

## 1. Visão geral

**Objetivo.** A AgroTech Solutions consolidou os dados de suas filiais em uma única base, e a integração trouxe registros duplicados, erros de digitação, valores incorretos, datas incompatíveis e dados de teste. Este trabalho trata esses problemas, produz um relatório gerencial e cria 10 indicadores (KPIs) para apoiar as decisões da diretoria. A documentação permite que outra equipe entenda a base, execute o script e confira os resultados.

**Integrantes:** Yuan J. Mou

**Disciplina:** Linguagem e Projeto de Banco de Dados

**O que foi feito em cada parte**

| Parte                       | O que foi feito                                                                                                                                                                                                                                                                                                                                               |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1. Limpeza e tratamento** | Remoção de 3 duplicados e de 4 registros com data posterior a 31/12/2025 (2 deles de teste), padronização de nomes de produtos, fornecedores, estados e categorias, correção de 4 valores unitários e 2 quantidades, e bloqueio comercial de defensivos acima de R$ 800,00. Antes de cada `UPDATE`/`DELETE` há um `SELECT` de conferência com o mesmo filtro. |
| **2. Relatório gerencial**  | 10 consultas sobre a base tratada: disponibilidade, fornecedores, maiores valores unitários, valor médio por categoria, distribuição por estado, sementes e grãos disponíveis, grandes quantidades, valor potencial do estoque, indisponíveis por categoria e vendas entre março e maio de 2025.                                                              |
| **3. KPIs**                 | 10 indicadores de disponibilidade, estoque e logística, valor financeiro do estoque, fornecedores, categorias e estados, cada um com objetivo, regra de cálculo, consulta, resultado e interpretação.                                                                                                                                                         |
| **4. Documentação**         | Este README, o repositório e os slides com a apresentação dos KPIs.                                                                                                                                                                                                                                                                                           |

**Estrutura do repositório**

```
analise_de_dados_agrotech/
├── README.md                              # esta documentação
├── sql/
│   └── AgroTech_Integrantes.sql           # criação do banco, carga, Partes 1, 2 e 3
└── slides/
    └── AgroTech_KPIs_Integrantes.pptx     # apresentação dos 10 KPIs
```

---

## 2. Como executar

**Requisitos**

- MySQL 8.0 ou superior (o script também foi executado com sucesso no MariaDB 10.11).
- Um cliente SQL, como MySQL Workbench ou a linha de comando `mysql`.
- Um usuário com permissão para criar bancos de dados.

**Arquivo a executar:** [`sql/AgroTech_Integrantes.sql`](sql/AgroTech_Integrantes.sql). Um único arquivo cria o banco, carrega a base, aplica o tratamento e executa as consultas.

**Passo a passo**

_MySQL Workbench:_ abra o arquivo (File > Open SQL Script) e execute o script inteiro (ícone do raio, sem selecionar trechos).

_Linha de comando:_

```bash
mysql -u root -p --default-character-set=utf8mb4 --table < sql/AgroTech_Integrantes.sql
```

**Ordem do script**

| Seção              | Conteúdo                                                                                                |
| ------------------ | ------------------------------------------------------------------------------------------------------- |
| Preparação da base | `CREATE DATABASE agropecuaria_db`, `CREATE TABLE tb_vendas_agro` e `INSERT` dos 75 registros fornecidos |
| Parte 1            | 10 questões de limpeza, cada uma com `SELECT` de conferência antes do `UPDATE`/`DELETE`                 |
| Parte 2            | 10 consultas do relatório gerencial                                                                     |
| Parte 3            | 10 consultas de KPI, identificadas de `KPI 01` a `KPI 10` nos comentários                               |

**Pontos de atenção**

- O script começa com `DROP DATABASE IF EXISTS agropecuaria_db;` para poder ser executado mais de uma vez. **Não use esse nome de banco se ele já guarda outros dados.**
- Execute o script **do início ao fim e na ordem**. A Parte 1 depende dos dados originais e as Partes 2 e 3 dependem da base já tratada.
- O script usa `SET SQL_SAFE_UPDATES = 0;` (somente na sessão) para permitir `UPDATE`/`DELETE` filtrando por colunas que não são a chave.
- O MySQL compara textos sem diferenciar acentos por padrão (`'Racão'` = `'Ração'`). Por isso os filtros que dependem de acento usam `COLLATE utf8mb4_bin` (comparação exata). Sem isso, a questão 01 apagaria também o registro 56, que deve ser preservado.
- Um erro `1146` (tabela não existe) indica que a execução ocorreu fora do banco `agropecuaria_db` ou sem a criação da tabela. Execute o script completo.

**Conferência rápida.** Depois da execução, `total_registros_carregados` deve ser **75** e `total_registros_base_tratada` deve ser **68**.

---

## 3. Dicionário de dados

**Tabela `tb_vendas_agro`.** Consolida os registros de produtos agrícolas enviados pelas filiais da AgroTech. **Cada linha representa um registro de produto cadastrado por uma filial**, com a quantidade armazenada, o valor unitário, o estado, o fornecedor, a data da venda e a disponibilidade para comercialização. Um mesmo nome de produto pode aparecer em mais de uma linha, com `id` diferente.

| Coluna           | Tipo            | Descrição                            | Restrições e regras (base tratada)                                                                           | Exemplo          |
| ---------------- | --------------- | ------------------------------------ | ------------------------------------------------------------------------------------------------------------ | ---------------- |
| `id`             | `INT`           | Identificador do registro            | `PRIMARY KEY`, único. Na base tratada vai de 1 a 71 (68 registros; os IDs 51 a 53 e 72 a 75 foram removidos) | `1`              |
| `produto`        | `VARCHAR(100)`  | Nome oficial do produto              | Grafia padronizada (ex.: `Milho Safrinha`, `Ração Bovina 25kg`); 50 nomes distintos                          | `Milho Safrinha` |
| `categoria`      | `VARCHAR(50)`   | Categoria do produto                 | 6 valores: `Defensivos`, `Fertilizantes`, `Grãos`, `Minerais`, `Rações`, `Sementes`                          | `Grãos`          |
| `fornecedor`     | `VARCHAR(100)`  | Fornecedor do produto                | 6 valores: `AgroMax`, `AgroSul`, `BioPlant`, `Campo Verde`, `NutriCampo`, `Solo Forte`                       | `AgroSul`        |
| `estado`         | `VARCHAR(50)`   | Estado (UF) do registro              | Sigla de 2 letras; 8 valores: `GO`, `MG`, `MS`, `MT`, `PR`, `RS`, `SC`, `SP`                                 | `PR`             |
| `quantidade`     | `INT`           | Unidades armazenadas no registro     | Inteiro positivo (de 12 a 340 na base tratada)                                                               | `120`            |
| `valor_unitario` | `DECIMAL(10,2)` | Preço de uma unidade, em reais       | Maior que zero (de R$ 42,00 a R$ 980,00 na base tratada)                                                     | `89.90`          |
| `data_venda`     | `DATE`          | Data da venda do registro            | No máximo `2025-12-31`; na base tratada vai de `2025-01-10` a `2025-05-17`                                   | `2025-01-10`     |
| `estoque`        | `BOOLEAN`       | Disponibilidade para comercialização | `TRUE`/`1` = disponível, `FALSE`/`0` = indisponível                                                          | `TRUE` (`1`)     |

A definição da tabela (`CREATE TABLE`) só declara `id` como chave primária. As regras das demais colunas são as aplicadas pela limpeza da Parte 1.

**Como interpretar as colunas principais**

- **`quantidade`** é a quantidade de **unidades** armazenadas no registro, e não o número de registros. Para contar registros usa-se `COUNT(*)`; para contar unidades, `SUM(quantidade)`. Exemplo: o estoque disponível tem 48 registros, que somam 5.681 unidades.
- **`estoque`** indica se o registro está liberado para venda (`TRUE`) ou não (`FALSE`). Não significa que a quantidade seja zero. Na base tratada, os defensivos com valor unitário acima de R$ 800,00 foram marcados como `FALSE` por decisão da diretoria (bloqueio comercial temporário).
- **`data_venda`** é a data da venda do registro. O período operacional válido termina em **31/12/2025**; registros com data posterior foram excluídos.
- **Valor potencial do estoque** = `quantidade × valor_unitario`, conforme os filtros de cada consulta. **Não é faturamento nem lucro**, pois a base não informa custos nem a quantidade efetivamente vendida em cada operação.

---

## 4. Resultados do tratamento e do relatório gerencial

### 4.1 Parte 1: principais correções

A base passou de **75 para 68 registros**: 7 foram excluídos e 18 tiveram o conteúdo corrigido.

| Questão | Ação                                                                                                                                          | Registros afetados                                                |
| ------- | --------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| 01      | Excluídos os duplicados de Milho Safrinha, Soja Premium e Ração Bovina 25kg (mantidos os de menor ID)                                         | 3 (IDs 51, 52 e 53)                                               |
| 02      | Nomes de produtos padronizados (ex.: `Milhho Safrinha` para `Milho Safrinha`)                                                                 | 5 (IDs 54 a 58)                                                   |
| 03      | Fornecedores padronizados (`Campo Vrede`, `NutriCamp`, `Bio Planti`)                                                                          | 3 (IDs 59 a 61)                                                   |
| 04      | Valores unitários corrigidos (Soja Exportação R$ 160,00; Fungicida Premium R$ 950,00; Calcário Premium R$ 55,50; Adubo Nitrogenado R$ 275,00) | 4 (IDs 62 a 65)                                                   |
| 05      | Quantidades corrigidas (Milho Tradicional de -10 para 170; Ração Ovina de 0 para 66)                                                          | 2 (IDs 66 e 67)                                                   |
| 06      | Estados padronizados (`PARANA` para `PR`, `SÃO PAULO` para `SP`)                                                                              | 2 (IDs 68 e 69)                                                   |
| 07      | Categorias padronizadas (`Graos` para `Grãos`, `Racao` para `Rações`)                                                                         | 2 (IDs 70 e 71)                                                   |
| 08      | Excluídos registros com `data_venda` posterior a 31/12/2025                                                                                   | 4 (IDs 72 a 75)                                                   |
| 09      | Exclusão de registros de teste                                                                                                                | 0 (já removidos na questão 08)                                    |
| 10      | Defensivos com valor unitário acima de R$ 800,00 passam a `estoque = false`                                                                   | 6 no filtro; 5 mudaram de status (o ID 25 já estava indisponível) |

| Indicador de qualidade                                 | Antes | Depois |
| ------------------------------------------------------ | ----- | ------ |
| Registros                                              | 75    | 68     |
| Valores unitários negativos, zerados ou fora do padrão | 4     | 0      |
| Quantidades negativas ou zeradas                       | 2     | 0      |
| Registros com data posterior a 31/12/2025              | 4     | 0      |

Os registros de ID 54 a 71 repetem nomes de produtos já existentes (por exemplo, `Milho Safrinha` nos IDs 1 e 54, com quantidade e valor diferentes). Eles foram mantidos porque o enunciado só pede a remoção das duplicidades listadas. Por isso a base tratada tem 68 registros para 50 nomes de produtos distintos. As contagens "de produtos" a seguir são **contagens de registros**, sem `DISTINCT`.

### 4.2 Parte 2: principais resultados

**Q01. Produtos disponíveis.** 48 dos 68 registros estão com `estoque = true` (70,59%); 20 estão indisponíveis.

**Q02. Participação dos fornecedores (registros)**

| Fornecedor  | Registros |
| ----------- | --------- |
| Campo Verde | 16        |
| NutriCampo  | 14        |
| AgroSul     | 11        |
| Solo Forte  | 10        |
| BioPlant    | 9         |
| AgroMax     | 8         |

Campo Verde e NutriCampo reúnem 30 dos 68 registros (44,12%).

**Q03. 10 registros de maior valor unitário**

| Produto            | Categoria  | Valor unitário | Estado |
| ------------------ | ---------- | -------------- | ------ |
| Herbicida Platinum | Defensivos | R$ 980,00      | SP     |
| Herbicida Platinum | Defensivos | R$ 980,00      | SP     |
| Fungicida Premium  | Defensivos | R$ 950,00      | MT     |
| Fungicida Premium  | Defensivos | R$ 950,00      | MT     |
| Inseticida Ultra   | Defensivos | R$ 890,00      | SP     |
| Fungicida Rural    | Defensivos | R$ 845,00      | MT     |
| Fungicida Max      | Defensivos | R$ 799,90      | PR     |
| Inseticida Verde   | Defensivos | R$ 720,00      | MS     |
| Herbicida AgroPlus | Defensivos | R$ 620,00      | GO     |
| Inseticida Power   | Defensivos | R$ 599,00      | MT     |

Os 10 maiores valores unitários são todos de Defensivos.

**Q04. Valor unitário médio por categoria**

| Categoria     | Valor unitário médio |
| ------------- | -------------------- |
| Defensivos    | R$ 739,91            |
| Fertilizantes | R$ 296,74            |
| Grãos         | R$ 136,02            |
| Sementes      | R$ 117,44            |
| Rações        | R$ 113,68            |
| Minerais      | R$ 58,17             |

**Q05. Distribuição por estado (registros)**

| Estado | Registros |
| ------ | --------- |
| MT     | 14        |
| PR     | 12        |
| GO     | 11        |
| MS     | 8         |
| SC     | 7         |
| SP     | 7         |
| RS     | 6         |
| MG     | 3         |

MT e PR concentram 26 dos 68 registros (38,24%). Em **unidades**, porém, o líder é o PR (2.107), seguido por MT (1.561), como mostra o KPI 09.

**Q06. Sementes e Grãos disponíveis.** 18 registros: 13 de Grãos e 5 de Sementes.

**Q07. Registros com mais de 200 unidades.** 11 registros; o maior é Calcário Fino, com 340 unidades (PR).

**Q08. Valor potencial do estoque disponível.** R$ 769.784,00 (soma de `quantidade × valor_unitario` com `estoque = true`).

**Q09. Categorias com produtos indisponíveis**

| Categoria     | Registros com `estoque = false` |
| ------------- | ------------------------------- |
| Defensivos    | 7                               |
| Sementes      | 4                               |
| Fertilizantes | 3                               |
| Grãos         | 3                               |
| Rações        | 2                               |
| Minerais      | 1                               |

**Q10. Vendas entre 01/03/2025 e 31/05/2025.** 51 registros, ordenados da data mais antiga (01/03/2025) para a mais recente (17/05/2025).

---

## 5. Catálogo e resultados dos 10 KPIs

Todos os KPIs usam a tabela `tb_vendas_agro` na base tratada. A identificação (`KPI 01` a `KPI 10`) é a mesma dos comentários do arquivo SQL. Nos slides, os nomes aparecem de forma abreviada, mas com o mesmo código.

**Tratamento de divisão por zero.** Em todos os cálculos com divisão, o denominador está dentro de `NULLIF(denominador, 0)`. Se o denominador for zero, a consulta retorna `NULL` em vez de gerar erro. Somas usadas como resultado têm `COALESCE(..., 0)`.

**Resumo**

| Código | Nome                                                       | Resultado              | Base               |
| ------ | ---------------------------------------------------------- | ---------------------- | ------------------ |
| KPI 01 | Taxa de Disponibilidade                                    | 70,59%                 | Todos os registros |
| KPI 02 | Taxa de Indisponibilidade por Categoria                    | Defensivos 50,00%      | Todos os registros |
| KPI 03 | Unidades Armazenadas Disponíveis                           | 5.681 unidades         | Apenas disponíveis |
| KPI 04 | Concentração de Unidades em Lotes Grandes (> 200 unidades) | 41,02%                 | Todos os registros |
| KPI 05 | Valor Potencial do Estoque Disponível (R$)                 | R$ 769.784,00          | Apenas disponíveis |
| KPI 06 | Valor Potencial Parado em Registros Indisponíveis (R$ e %) | R$ 326.690,50 (29,79%) | Todos os registros |
| KPI 07 | Participação das Categorias no Valor Potencial Disponível  | Grãos 43,91%           | Apenas disponíveis |
| KPI 08 | Participação e Concentração por Fornecedor                 | Campo Verde 23,53%     | Todos os registros |
| KPI 09 | Participação dos Estados nas Unidades Armazenadas          | PR 28,52%              | Todos os registros |
| KPI 10 | Valor Unitário Médio: Defensivos x Demais Categorias (R$)  | R$ 739,91 x R$ 144,24  | Todos os registros |

### KPI 01 — Taxa de Disponibilidade

| Item                    | Descrição                                                                                                                                                                                                                          |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Objetivo                | Medir a parcela do portfólio liberada para venda.                                                                                                                                                                                  |
| Tabela e colunas        | `tb_vendas_agro`: `estoque`                                                                                                                                                                                                        |
| Regra de cálculo        | (registros com `estoque = true` ÷ total de registros) × 100                                                                                                                                                                        |
| Filtros / base          | Nenhum filtro; todos os registros                                                                                                                                                                                                  |
| Unidade                 | Percentual (%)                                                                                                                                                                                                                     |
| Numerador / denominador | 48 registros disponíveis / 68 registros                                                                                                                                                                                            |
| Divisão por zero        | `NULLIF(COUNT(*), 0)`                                                                                                                                                                                                              |
| **Resultado**           | **70,59%**                                                                                                                                                                                                                         |
| Interpretação           | Cerca de 7 em cada 10 registros estão liberados; 20 dos 68 estão fora de venda. Decisão: investigar os motivos dos 20 indisponíveis. Como sugestão do grupo (não fornecida pela empresa), acompanhar a taxa com referência de 80%. |

### KPI 02 — Taxa de Indisponibilidade por Categoria

| Item                    | Descrição                                                                                                                                                                           |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Objetivo                | Comparar categorias quanto à parcela de itens fora de venda.                                                                                                                        |
| Tabela e colunas        | `tb_vendas_agro`: `categoria`, `estoque`                                                                                                                                            |
| Regra de cálculo        | Por categoria: (registros com `estoque = false` ÷ registros da categoria) × 100                                                                                                     |
| Filtros / base          | Nenhum filtro; todos os registros. Média geral de referência: 29,41% (20 de 68)                                                                                                     |
| Unidade                 | Percentual (%)                                                                                                                                                                      |
| Numerador / denominador | Registros indisponíveis da categoria / registros da categoria (tabela abaixo)                                                                                                       |
| Divisão por zero        | `NULLIF(COUNT(*), 0)`                                                                                                                                                               |
| Interpretação           | Considera-se alta a taxa acima da média geral (29,41%): Defensivos, Sementes e Fertilizantes superam esse nível. Decisão: priorizar reposição e liberação em Defensivos e Sementes. |

| Categoria     | Numerador | Denominador | **Resultado** |
| ------------- | --------- | ----------- | ------------- |
| Defensivos    | 7         | 14          | **50,00%**    |
| Sementes      | 4         | 9           | **44,44%**    |
| Fertilizantes | 3         | 9           | **33,33%**    |
| Grãos         | 3         | 16          | **18,75%**    |
| Rações        | 2         | 13          | **15,38%**    |
| Minerais      | 1         | 7           | **14,29%**    |

### KPI 03 — Unidades Armazenadas Disponíveis

| Item             | Descrição                                                                                                                                                                     |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Objetivo         | Dimensionar o volume físico pronto para venda, separando unidades de registros.                                                                                               |
| Tabela e colunas | `tb_vendas_agro`: `quantidade`, `estoque`                                                                                                                                     |
| Regra de cálculo | `SUM(quantidade)` com `estoque = true`; média = unidades ÷ registros disponíveis                                                                                              |
| Filtros / base   | `estoque = true` (apenas disponíveis)                                                                                                                                         |
| Unidade          | Unidades (média em unidades por registro)                                                                                                                                     |
| Divisão por zero | A média usa `NULLIF(COUNT(*), 0)`                                                                                                                                             |
| **Resultado**    | **5.681 unidades** em **48 registros**; média de **118,35 unidades por registro**                                                                                             |
| Interpretação    | O estoque disponível soma 5.681 unidades. Decisão: usar o volume como base para planejar armazenagem e transporte, lembrando que unidades e registros são medidas diferentes. |

### KPI 04 — Concentração de Unidades em Lotes Grandes (> 200 unidades)

| Item                    | Descrição                                                                                                                                                                                                          |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Objetivo                | Medir quanto do volume está concentrado em poucos registros de grande quantidade.                                                                                                                                  |
| Tabela e colunas        | `tb_vendas_agro`: `quantidade`                                                                                                                                                                                     |
| Regra de cálculo        | (soma de `quantidade` dos registros com `quantidade > 200` ÷ soma de `quantidade` de todos os registros) × 100                                                                                                     |
| Filtros / base          | Numerador: `quantidade > 200`; denominador: todos os registros (subquery)                                                                                                                                          |
| Unidade                 | Percentual (%)                                                                                                                                                                                                     |
| Numerador / denominador | 3.030 unidades / 7.387 unidades                                                                                                                                                                                    |
| Divisão por zero        | `NULLIF((SELECT SUM(quantidade) ...), 0)`                                                                                                                                                                          |
| **Resultado**           | **41,02%**                                                                                                                                                                                                         |
| Interpretação           | 11 registros (16,18% dos 68) guardam 41,02% das unidades. Calcário (5 registros, 1.580 unidades, todos no PR) é o maior bloco. Decisão: reforçar o controle desses lotes e avaliar sua distribuição entre estados. |

### KPI 05 — Valor Potencial do Estoque Disponível (R$)

| Item             | Descrição                                                                                                                                                               |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Objetivo         | Estimar o valor potencial, a preços de tabela, do que está liberado para venda.                                                                                         |
| Tabela e colunas | `tb_vendas_agro`: `quantidade`, `valor_unitario`, `estoque`                                                                                                             |
| Regra de cálculo | `SUM(quantidade × valor_unitario)` com `estoque = true`                                                                                                                 |
| Filtros / base   | `estoque = true` (apenas disponíveis)                                                                                                                                   |
| Unidade          | Reais (R$)                                                                                                                                                              |
| Divisão por zero | Não há divisão; a soma usa `COALESCE(..., 0)`                                                                                                                           |
| **Resultado**    | **R$ 769.784,00** (70,21% do valor potencial total de R$ 1.096.474,50)                                                                                                  |
| Interpretação    | É o valor potencial do estoque disponível; **não é faturamento nem lucro**. Decisão: concentrar esforços comerciais nas categorias que mais pesam nesse valor (KPI 07). |

### KPI 06 — Valor Potencial Parado em Registros Indisponíveis (R$ e %)

| Item                    | Descrição                                                                                                                                                                                                                                   |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Objetivo                | Mostrar quanto do valor potencial do estoque está em itens fora de venda.                                                                                                                                                                   |
| Tabela e colunas        | `tb_vendas_agro`: `quantidade`, `valor_unitario`, `estoque`                                                                                                                                                                                 |
| Regra de cálculo        | (Σ `quantidade × valor_unitario` com `estoque = false` ÷ Σ `quantidade × valor_unitario` de todos) × 100                                                                                                                                    |
| Filtros / base          | Numerador: `estoque = false`; denominador: todos os registros                                                                                                                                                                               |
| Unidade                 | Reais (R$) e percentual (%)                                                                                                                                                                                                                 |
| Numerador / denominador | R$ 326.690,50 / R$ 1.096.474,50                                                                                                                                                                                                             |
| Divisão por zero        | `NULLIF(SUM(quantidade * valor_unitario), 0)`                                                                                                                                                                                               |
| **Resultado**           | **R$ 326.690,50, ou 29,79%** do valor potencial total                                                                                                                                                                                       |
| Interpretação           | Quase 30% do valor potencial do estoque está parado em registros indisponíveis, parcela ligeiramente maior que a de registros (29,41%). Decisão: revisar primeiro os indisponíveis de maior valor para liberar, repor ou manter o bloqueio. |

### KPI 07 — Participação das Categorias no Valor Potencial Disponível

| Item                    | Descrição                                                                                                                                                               |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Objetivo                | Comparar quais categorias sustentam o valor potencial do estoque disponível.                                                                                            |
| Tabela e colunas        | `tb_vendas_agro`: `categoria`, `quantidade`, `valor_unitario`, `estoque`                                                                                                |
| Regra de cálculo        | Por categoria: (valor potencial da categoria com `estoque = true` ÷ valor potencial total dos disponíveis) × 100                                                        |
| Filtros / base          | `estoque = true` (apenas disponíveis); denominador por subquery                                                                                                         |
| Unidade                 | Reais (R$) e percentual (%)                                                                                                                                             |
| Numerador / denominador | Valor potencial da categoria / R$ 769.784,00                                                                                                                            |
| Divisão por zero        | `NULLIF((SELECT SUM(quantidade * valor_unitario) ...), 0)`                                                                                                              |
| Interpretação           | Grãos respondem por 43,91% (R$ 338.018,00), quase o triplo de Fertilizantes (15,69%). Decisão: dar atenção especial à disponibilidade de Grãos, que pesa mais no valor. |

| Categoria     | Valor potencial (numerador) | **Participação** |
| ------------- | --------------------------- | ---------------- |
| Grãos         | R$ 338.018,00               | **43,91%**       |
| Fertilizantes | R$ 120.755,00               | **15,69%**       |
| Defensivos    | R$ 101.155,00               | **13,14%**       |
| Rações        | R$ 92.089,20                | **11,96%**       |
| Minerais      | R$ 77.968,00                | **10,13%**       |
| Sementes      | R$ 39.798,80                | **5,17%**        |

### KPI 08 — Participação e Concentração por Fornecedor

| Item                    | Descrição                                                                                                                                                                                                                                                   |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Objetivo                | Medir a dependência do portfólio em relação a cada fornecedor (risco de concentração).                                                                                                                                                                      |
| Tabela e colunas        | `tb_vendas_agro`: `fornecedor`                                                                                                                                                                                                                              |
| Regra de cálculo        | Por fornecedor: (registros do fornecedor ÷ total de registros) × 100                                                                                                                                                                                        |
| Filtros / base          | Nenhum filtro; todos os registros; total por subquery                                                                                                                                                                                                       |
| Unidade                 | Percentual (%)                                                                                                                                                                                                                                              |
| Numerador / denominador | Registros do fornecedor / 68 registros                                                                                                                                                                                                                      |
| Divisão por zero        | `NULLIF((SELECT COUNT(*) ...), 0)`                                                                                                                                                                                                                          |
| Interpretação           | Referência: divisão igual entre 6 fornecedores = 16,67%. Campo Verde está 6,86 pontos percentuais acima; com NutriCampo, soma 44,12% dos registros. Nenhum fornecedor passa de 25%. Decisão: monitorar a dependência e manter alternativas de fornecimento. |

| Fornecedor  | Numerador | **Participação** |
| ----------- | --------- | ---------------- |
| Campo Verde | 16        | **23,53%**       |
| NutriCampo  | 14        | **20,59%**       |
| AgroSul     | 11        | **16,18%**       |
| Solo Forte  | 10        | **14,71%**       |
| BioPlant    | 9         | **13,24%**       |
| AgroMax     | 8         | **11,76%**       |

### KPI 09 — Participação dos Estados nas Unidades Armazenadas

| Item                    | Descrição                                                                                                                                                                                             |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Objetivo                | Comparar regiões quanto ao volume físico armazenado, para apoiar a logística.                                                                                                                         |
| Tabela e colunas        | `tb_vendas_agro`: `estado`, `quantidade`                                                                                                                                                              |
| Regra de cálculo        | Por estado: (`SUM(quantidade)` do estado ÷ `SUM(quantidade)` total) × 100                                                                                                                             |
| Filtros / base          | Nenhum filtro; todos os registros; total por subquery                                                                                                                                                 |
| Unidade                 | Unidades e percentual (%)                                                                                                                                                                             |
| Numerador / denominador | Unidades do estado / 7.387 unidades                                                                                                                                                                   |
| Divisão por zero        | `NULLIF((SELECT SUM(quantidade) ...), 0)`                                                                                                                                                             |
| Interpretação           | PR, MT e MS reúnem cerca de 66% das unidades; SP tem o menor volume (244 unidades, 3,30%). Decisão: avaliar se o estoque está bem posicionado frente à demanda e se há necessidade de redistribuição. |

| Estado | Unidades (numerador) | **Participação** |
| ------ | -------------------- | ---------------- |
| PR     | 2.107                | **28,52%**       |
| MT     | 1.561                | **21,13%**       |
| MS     | 1.227                | **16,61%**       |
| GO     | 899                  | **12,17%**       |
| SC     | 614                  | **8,31%**        |
| RS     | 415                  | **5,62%**        |
| MG     | 320                  | **4,33%**        |
| SP     | 244                  | **3,30%**        |

### KPI 10 — Valor Unitário Médio: Defensivos x Demais Categorias (R$)

| Item             | Descrição                                                                                                                                                  |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Objetivo         | Comparar o preço médio dos Defensivos (alvo do bloqueio comercial) com o restante do portfólio.                                                            |
| Tabela e colunas | `tb_vendas_agro`: `categoria`, `valor_unitario`                                                                                                            |
| Regra de cálculo | `AVG(valor_unitario)` do grupo `Defensivos` e do grupo `Demais categorias`                                                                                 |
| Filtros / base   | Nenhum filtro; todos os registros (14 Defensivos e 54 demais)                                                                                              |
| Unidade          | Reais (R$) por unidade                                                                                                                                     |
| Divisão por zero | Não há divisão explícita; `AVG` ignora grupos vazios                                                                                                       |
| **Resultado**    | **Defensivos: R$ 739,91; demais categorias: R$ 144,24**                                                                                                    |
| Interpretação    | Os Defensivos custam cerca de 5,1 vezes mais por unidade. Decisão: reavaliar os Defensivos de maior valor tem peso financeiro; acompanhar os KPIs 02 e 06. |

---

## 6. Conclusão gerencial

Os três KPIs mais relevantes para a diretoria são o **KPI 06**, o **KPI 02** e o **KPI 07**. Juntos mostram quanto valor está parado, em quais categorias e onde um problema de disponibilidade custaria mais.

| KPI                                                                    | Resultado                                                              | Por que é relevante                                                                                                              | Decisões que apoia                                                                                     |
| ---------------------------------------------------------------------- | ---------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| **KPI 06** — Valor Potencial Parado em Registros Indisponíveis         | R$ 326.690,50 (29,79% do valor potencial total)                        | Quantifica em reais o que os 20 registros indisponíveis representam. Quase 30% do valor potencial do estoque está fora de venda. | Definir quais itens indisponíveis liberar, repor ou manter bloqueados, começando pelos de maior valor. |
| **KPI 02** — Taxa de Indisponibilidade por Categoria                   | Defensivos 50,00% e Sementes 44,44%, contra média geral de 29,41%      | Mostra onde está o problema: metade dos registros de Defensivos e quase metade dos de Sementes estão fora de venda.              | Priorizar reposição, liberação e revisão do bloqueio comercial em Defensivos e Sementes.               |
| **KPI 07** — Participação das Categorias no Valor Potencial Disponível | Grãos 43,91% (R$ 338.018,00), quase o triplo de Fertilizantes (15,69%) | Indica onde uma falha de disponibilidade custaria mais, pois Grãos sustentam quase metade do valor disponível.                   | Proteger a disponibilidade de Grãos e direcionar esforços comerciais e logísticos para a categoria.    |

**Recomendações**

1. Reavaliar os itens indisponíveis de Defensivos e Sementes e definir critérios claros para liberar ou manter o bloqueio.
2. Começar pelos indisponíveis que mais pesam no valor potencial de R$ 326.690,50.
3. Acompanhar a taxa de disponibilidade de Grãos, categoria que concentra 43,91% do valor potencial disponível.
4. Monitorar a dependência de Campo Verde (23,53% dos registros) e a concentração de unidades em PR, MT e MS (cerca de 66%).

**Limitações**

- O valor potencial (`quantidade × valor_unitario`) **não representa faturamento nem lucro**: a base não informa custos nem a quantidade efetivamente vendida em cada operação.
- A base não tem dados de margem, satisfação de clientes ou prazo de entrega, e por isso nenhum KPI depende deles.
- Os termos "alto" e "baixo" usam como critério a comparação com a média geral ou com uma divisão igual entre os grupos, sempre indicada no KPI.
- A referência de 80% de disponibilidade (KPI 01) é uma sugestão do grupo, não uma meta fornecida pela empresa.

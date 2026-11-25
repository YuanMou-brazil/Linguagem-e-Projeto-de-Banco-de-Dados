-- =====================================================================
-- AULA 11 - INSERT, SELECT, UPDATE, DELETE e TRUNCATE
-- Banco: aula10 | Tabela: tb_livros
-- =====================================================================

-- Seleciona o banco de dados que será usado nos comandos seguintes
USE aula10;

-- Estado inicial: conta quantos registros existem na tabela (esperado: 71)
SELECT COUNT(*) AS total_registros FROM tb_livros;

-- Mostra a estrutura da tabela (colunas, tipos, chave primária e valor padrão)
DESCRIBE tb_livros;


-- =====================================================================
-- ETAPA 1 - EXCLUSÃO, LIMPEZA E RECARGA INICIAL
-- =====================================================================

-- ---------- 01. Remover só o id = 71 (duplicado de "O Cortiço") ----------

-- Confere os dois cadastros de "O Cortiço" antes de apagar
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE titulo = 'O Cortiço';

-- Apaga somente o registro de id 71 (filtro pela chave primária, preserva o id 3)
DELETE FROM tb_livros
WHERE id = 71;

-- Confere se restou apenas o cadastro de id 3
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE titulo = 'O Cortiço';

-- ---------- 02. TRUNCATE: limpar a tabela inteira ----------

-- Conta os registros antes da limpeza (esperado: 70)
SELECT COUNT(*) AS total_antes FROM tb_livros;

-- Apaga TODOS os registros de uma vez, mantendo a estrutura da tabela
-- (não aceita WHERE, não dispara triggers e não pode ser desfeito com ROLLBACK)
TRUNCATE TABLE tb_livros;

-- Conta os registros depois da limpeza (esperado: 0)
SELECT COUNT(*) AS total_depois FROM tb_livros;

-- Confirma que a estrutura da tabela continua existindo
DESCRIBE tb_livros;

-- ---------- 03. Recarga dos 71 registros ----------

-- Insere vários livros de uma vez (carga original fornecida pelo professor)
INSERT INTO tb_livros (id, titulo, autor, ano_publicacao, disponivel)
VALUES
    (1, 'Dom Casmurro', 'Machado de Assis', 1899, TRUE),
    (2, 'Memórias Póstumas de Brás Cubas', 'Machado de Assis', 1881, TRUE),
    (3, 'O Cortiço', 'Aluísio Azevedo', 1890, FALSE),
    (4, 'Iracema', 'José de Alencar', 1865, TRUE),
    (5, 'Grande Sertão: Veredas', 'João Guimarães Rosa', 1956, TRUE);
    -- ... demais registros exatamente como no arquivo insert_dados_tb_livros.sql (até o id 71)
  

-- Confirma a carga: deve retornar 71 registros
SELECT COUNT(*) AS total_registros FROM tb_livros;


-- =====================================================================
-- ETAPA 2 - INSERÇÃO DE NOVOS LIVROS
-- =====================================================================

-- ---------- 04. "A Montanha Mágica" (id 72, disponível) ----------

-- Insere um novo livro informando todas as colunas (o id é manual, sem AUTO_INCREMENT)
INSERT INTO tb_livros (id, titulo, autor, ano_publicacao, disponivel)
VALUES (72, 'A Montanha Mágica', 'Thomas Mann', 1924, TRUE);

-- Consulta o registro inserido para conferir
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE id = 72;

-- ---------- 05. "O Lobo da Estepe" (id 73, indisponível) ----------

-- Insere o livro com disponivel = FALSE (grava 0)
INSERT INTO tb_livros (id, titulo, autor, ano_publicacao, disponivel)
VALUES (73, 'O Lobo da Estepe', 'Hermann Hesse', 1927, FALSE);

-- Consulta o registro inserido para conferir
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE id = 73;

-- ---------- 06. "Solaris" (id 74, omitindo a coluna disponivel) ----------

-- Insere sem informar "disponivel": o banco aplica o valor padrão (TRUE = 1)
INSERT INTO tb_livros (id, titulo, autor, ano_publicacao)
VALUES (74, 'Solaris', 'Stanisław Lem', 1961);

-- Consulta o registro para ver que disponivel ficou com 1 (valor padrão)
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE id = 74;

-- ---------- 07. "O Som e a Fúria" (id 75, disponível) ----------

-- Inserção completa com todas as colunas
INSERT INTO tb_livros (id, titulo, autor, ano_publicacao, disponivel)
VALUES (75, 'O Som e a Fúria', 'William Faulkner', 1929, TRUE);

-- Consulta o registro inserido para conferir
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE id = 75;

-- ---------- 08. Livro fictício de Albert Camus (id 76, indisponível) ----------

-- Insere o livro fictício; Camus passa a ter dois registros
INSERT INTO tb_livros (id, titulo, autor, ano_publicacao, disponivel)
VALUES (76, 'Horizontes do Amanhã', 'Albert Camus', 2020, FALSE);

-- Consulta o registro inserido para conferir
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE id = 76;


-- =====================================================================
-- ETAPA 3 - CONSULTAS E ANÁLISE DO CATÁLOGO
-- =====================================================================

-- ---------- 09. Quantidade de livros disponíveis ----------

-- Conta quantos livros estão disponíveis para empréstimo (disponivel = TRUE)
SELECT COUNT(*) AS livros_disponiveis
FROM tb_livros
WHERE disponivel = TRUE;

-- ---------- 10. Autores e quantidade de registros ----------

-- Agrupa por autor e conta os registros; ordena da maior quantidade para a menor
-- e, em caso de empate, pelo nome do autor (A-Z)
SELECT autor, COUNT(*) AS qtd_registros
FROM tb_livros
GROUP BY autor
ORDER BY qtd_registros DESC, autor ASC;

-- ---------- 11. Livro(s) mais antigo(s) (subquery com MIN) ----------

-- A subquery encontra o menor ano; a consulta externa traz o(s) livro(s) desse ano
SELECT id, titulo, autor, ano_publicacao
FROM tb_livros
WHERE ano_publicacao = (SELECT MIN(ano_publicacao) FROM tb_livros);

-- ---------- 12. Autores com mais de dois registros ----------

-- Agrupa por autor e usa HAVING para filtrar os grupos com mais de 2 registros
-- (HAVING filtra depois da contagem; WHERE filtra antes)
SELECT autor, COUNT(*) AS qtd_registros
FROM tb_livros
GROUP BY autor
HAVING COUNT(*) > 2;


-- =====================================================================
-- ETAPA 4 - ATUALIZAÇÕES BÁSICAS
-- =====================================================================

-- ---------- 13. "Dom Casmurro" como indisponível ----------

-- Confere o registro antes de alterar
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE titulo = 'Dom Casmurro';

-- Marca o livro como indisponível (FALSE grava 0)
UPDATE tb_livros
SET disponivel = FALSE
WHERE titulo = 'Dom Casmurro';

-- Confere o resultado da alteração
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE titulo = 'Dom Casmurro';

-- ---------- 14. Corrigir o ano de "O Cortiço" para 1891 ----------

-- Confere os registros antes de alterar (inclui o duplicado, id 71)
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE titulo = 'O Cortiço';

-- Atualiza o ano de todos os registros com esse título (ids 3 e 71)
UPDATE tb_livros
SET ano_publicacao = 1891
WHERE titulo = 'O Cortiço';

-- Confere o resultado da alteração
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE titulo = 'O Cortiço';

-- ---------- 15. "Vidas Secas" (id 6) como disponível ----------

-- Confere o registro antes de alterar
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE id = 6;

-- Marca o livro como disponível (filtro pela chave primária)
UPDATE tb_livros
SET disponivel = TRUE
WHERE id = 6;

-- Confere o resultado da alteração
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE id = 6;

-- ---------- 16. Autor "George Orwell" -> "George Orwell (Verificado)" ----------

-- Confere os livros do autor antes de alterar
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor = 'George Orwell';

-- Troca o nome do autor em todas as suas obras
UPDATE tb_livros
SET autor = 'George Orwell (Verificado)'
WHERE autor = 'George Orwell';

-- Confere o resultado usando LIKE (o nome agora tem texto a mais no final)
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor LIKE 'George Orwell%';

-- ---------- 17. Livros de Dostoiévski como disponíveis ----------

-- Confere os livros do autor antes de alterar
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor = 'Fiódor Dostoiévski';

-- Marca todas as obras do autor como disponíveis de uma vez
UPDATE tb_livros
SET disponivel = TRUE
WHERE autor = 'Fiódor Dostoiévski';

-- Confere o resultado da alteração
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor = 'Fiódor Dostoiévski';

-- ---------- 18. Título do id 18 -> "O Senhor dos Anéis: A Sociedade do Anel" ----------

-- Confere o registro antes de alterar
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE id = 18;

-- Altera o título do livro (filtro pela chave primária)
UPDATE tb_livros
SET titulo = 'O Senhor dos Anéis: A Sociedade do Anel'
WHERE id = 18;

-- Confere o resultado da alteração
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE id = 18;


-- =====================================================================
-- ETAPA 5 - ATUALIZAÇÕES COM FILTROS E SUBQUERIES
-- =====================================================================

-- ---------- 19. J.K. Rowling antes de 1999 como indisponíveis ----------

-- Confere os registros que atendem às duas condições (AND)
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor = 'J.K. Rowling' AND ano_publicacao < 1999;

-- Marca como indisponíveis os livros da autora publicados antes de 1999
UPDATE tb_livros
SET disponivel = FALSE
WHERE autor = 'J.K. Rowling' AND ano_publicacao < 1999;

-- Confere todos os livros da autora após a alteração
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor = 'J.K. Rowling';

-- ---------- 20. Indisponíveis entre 1950 e 2000 passam a disponíveis ----------

-- Confere os registros antes de alterar (BETWEEN inclui os dois limites)
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE disponivel = FALSE AND ano_publicacao BETWEEN 1950 AND 2000;

-- Torna disponíveis os livros indisponíveis desse período
UPDATE tb_livros
SET disponivel = TRUE
WHERE disponivel = FALSE AND ano_publicacao BETWEEN 1950 AND 2000;

-- Confere por contagens (total, disponíveis e indisponíveis) para não listar tudo
SELECT COUNT(*) AS livros_no_filtro, SUM(disponivel) AS disponiveis,
       SUM(disponivel = FALSE) AS indisponiveis
FROM tb_livros
WHERE ano_publicacao BETWEEN 1950 AND 2000;

-- ---------- 21. Livros de Victor Hugo indisponíveis (subquery no WHERE) ----------

-- Confere os livros do autor antes de alterar
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor = 'Victor Hugo';

-- Atualiza usando subquery para selecionar os IDs; a subquery fica dentro de uma
-- tabela derivada (alias sub) para evitar o erro 1093 do MySQL
-- (não permite ler e alterar a mesma tabela diretamente na subquery)
UPDATE tb_livros
SET disponivel = FALSE
WHERE id IN (
        SELECT id FROM (
            SELECT id FROM tb_livros WHERE autor = 'Victor Hugo'
        ) AS sub);

-- Confere o resultado da alteração
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor = 'Victor Hugo';

-- ---------- 22. Indisponíveis entre 1930 e 1950 passam a disponíveis (subquery) ----------

-- Confere os registros antes de alterar
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE disponivel = FALSE AND ano_publicacao BETWEEN 1930 AND 1950;

-- Torna disponíveis os IDs encontrados pela subquery (tabela derivada evita o erro 1093)
UPDATE tb_livros
SET disponivel = TRUE
WHERE id IN (
        SELECT id FROM (
            SELECT id FROM tb_livros
            WHERE disponivel = FALSE AND ano_publicacao BETWEEN 1930 AND 1950
        ) AS sub);

-- Confere todos os livros do período após a alteração
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE ano_publicacao BETWEEN 1930 AND 1950;

-- ---------- 23. Autores com "Kafka" no nome como disponíveis (LIKE) ----------

-- Confere os registros antes de alterar (% aceita qualquer texto antes/depois)
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor LIKE '%Kafka%';

-- Marca como disponíveis os livros de autores que contenham "Kafka"
UPDATE tb_livros
SET disponivel = TRUE
WHERE autor LIKE '%Kafka%';

-- Confere o resultado da alteração
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor LIKE '%Kafka%';

-- ---------- 24. Dan Brown, George Orwell (Verificado) e H.G. Wells indisponíveis (IN) ----------

-- Confere os registros antes de alterar (IN testa se o valor está na lista)
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor IN ('Dan Brown', 'George Orwell (Verificado)', 'H.G. Wells');

-- Marca como indisponíveis os livros desses três autores
UPDATE tb_livros
SET disponivel = FALSE
WHERE autor IN ('Dan Brown', 'George Orwell (Verificado)', 'H.G. Wells');

-- Confere o resultado da alteração
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor IN ('Dan Brown', 'George Orwell (Verificado)', 'H.G. Wells');

-- ---------- 25. Obras de 1930 a 1969 disponíveis (independente do status atual) ----------

-- Confere os registros antes de alterar
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE ano_publicacao BETWEEN 1930 AND 1969;

-- Torna disponíveis todas as obras do período, sem filtrar pela disponibilidade
UPDATE tb_livros
SET disponivel = TRUE
WHERE ano_publicacao BETWEEN 1930 AND 1969;

-- Confere por contagens (total, disponíveis e indisponíveis)
SELECT COUNT(*) AS livros_no_filtro, SUM(disponivel) AS disponiveis,
       SUM(disponivel = FALSE) AS indisponiveis
FROM tb_livros
WHERE ano_publicacao BETWEEN 1930 AND 1969;

-- ---------- 26. Autor com "Tolstói" -> "Autor Revisado" (LIKE) ----------

-- Confere os registros antes de alterar
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor LIKE '%Tolstói%';

-- Troca o nome do autor em todas as obras cujo autor contenha "Tolstói"
UPDATE tb_livros
SET autor = 'Autor Revisado'
WHERE autor LIKE '%Tolstói%';

-- Confere o resultado da alteração
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor = 'Autor Revisado';

-- ---------- 27. Publicados antes de 1950 OU com "Mundo" no título (OR) ----------

-- Confere os registros antes de alterar (basta uma das condições ser verdadeira)
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE ano_publicacao < 1950 OR titulo LIKE '%Mundo%';

-- Marca como indisponíveis os livros que atendem a qualquer uma das condições
UPDATE tb_livros
SET disponivel = FALSE
WHERE ano_publicacao < 1950 OR titulo LIKE '%Mundo%';

-- Confere por contagens (total, disponíveis e indisponíveis)
SELECT COUNT(*) AS livros_no_filtro, SUM(disponivel) AS disponiveis,
       SUM(disponivel = FALSE) AS indisponiveis
FROM tb_livros
WHERE ano_publicacao < 1950 OR titulo LIKE '%Mundo%';

-- ---------- 28. Garantir disponíveis os IDs 3, 6, 11, 18 e 45 (IN) ----------

-- Confere os registros antes de alterar
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE id IN (3, 6, 11, 18, 45);

-- Marca como disponíveis os livros com esses IDs
UPDATE tb_livros
SET disponivel = TRUE
WHERE id IN (3, 6, 11, 18, 45);

-- Confere o resultado da alteração
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE id IN (3, 6, 11, 18, 45);

-- ---------- 29. Acrescentar " (Coleção Especial)" ao título (LIKE, OR e CONCAT) ----------

-- Confere os registros antes de alterar
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE titulo LIKE '%Senhor%' OR titulo LIKE '%Nárnia%';

-- CONCAT junta o título original com o texto novo, preservando o que já existia
UPDATE tb_livros
SET titulo = CONCAT(titulo, ' (Coleção Especial)')
WHERE titulo LIKE '%Senhor%' OR titulo LIKE '%Nárnia%';

-- Confere o resultado da alteração
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE titulo LIKE '%Senhor%' OR titulo LIKE '%Nárnia%';


-- =====================================================================
-- ETAPA 6 - EXCLUSÕES ESPECÍFICAS E COM MÚLTIPLAS CONDIÇÕES
-- =====================================================================

-- ---------- 30. Excluir "O Código Da Vinci" ----------

-- Confere o registro antes de excluir
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE titulo = 'O Código Da Vinci';

-- Exclui o livro pelo título
DELETE FROM tb_livros
WHERE titulo = 'O Código Da Vinci';

-- Confere se foi removido (deve retornar "Empty set")
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE titulo = 'O Código Da Vinci';

-- Conta o total de livros restantes
SELECT COUNT(*) AS total_livros FROM tb_livros;

-- ---------- 31. Excluir livros indisponíveis de H.G. Wells ----------

-- Confere os registros antes de excluir
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor = 'H.G. Wells' AND disponivel = FALSE;

-- Exclui apenas os livros do autor que estão indisponíveis
DELETE FROM tb_livros
WHERE autor = 'H.G. Wells' AND disponivel = FALSE;

-- Confere se foram removidos (deve retornar "Empty set")
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor = 'H.G. Wells' AND disponivel = FALSE;

-- Conta o total de livros restantes
SELECT COUNT(*) AS total_livros FROM tb_livros;

-- ---------- 32. Remover todos os livros de Eça de Queirós ----------

-- Confere os registros antes de excluir
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor = 'Eça de Queirós';

-- Exclui todas as obras do autor
DELETE FROM tb_livros
WHERE autor = 'Eça de Queirós';

-- Confere se foram removidos (deve retornar "Empty set")
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor = 'Eça de Queirós';

-- Conta o total de livros restantes
SELECT COUNT(*) AS total_livros FROM tb_livros;

-- ---------- 33. Excluir livros com ano de publicação menor que zero (a.C.) ----------

-- Confere os registros antes de excluir
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE ano_publicacao < 0;

-- Exclui as obras anteriores ao ano 0
DELETE FROM tb_livros
WHERE ano_publicacao < 0;

-- Confere se foram removidos (deve retornar "Empty set")
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE ano_publicacao < 0;

-- Conta o total de livros restantes
SELECT COUNT(*) AS total_livros FROM tb_livros;

-- ---------- 34. Remover livros disponíveis de José de Alencar ----------

-- Confere os registros antes de excluir (nenhum atende ao filtro neste ponto)
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor = 'José de Alencar' AND disponivel = TRUE;

-- Exclui apenas os livros do autor que estão disponíveis (afeta 0 linhas aqui)
DELETE FROM tb_livros
WHERE autor = 'José de Alencar' AND disponivel = TRUE;

-- Confere novamente o filtro (deve retornar "Empty set")
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor = 'José de Alencar' AND disponivel = TRUE;

-- Conta o total de livros (não mudou, pois nada foi excluído)
SELECT COUNT(*) AS total_livros FROM tb_livros;

-- ---------- 35. Remover indisponíveis de Victor Hugo e Franz Kafka (IN + AND) ----------

-- Confere os registros antes de excluir
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor IN ('Victor Hugo', 'Franz Kafka') AND disponivel = FALSE;

-- IN escolhe os autores e AND restringe aos livros indisponíveis
DELETE FROM tb_livros
WHERE autor IN ('Victor Hugo', 'Franz Kafka') AND disponivel = FALSE;

-- Confere se foram removidos (deve retornar "Empty set")
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor IN ('Victor Hugo', 'Franz Kafka') AND disponivel = FALSE;

-- Conta o total de livros restantes
SELECT COUNT(*) AS total_livros FROM tb_livros;

-- ---------- 36. Remover indisponíveis publicados entre 1800 e 1900 ----------

-- Confere os registros antes de excluir (BETWEEN inclui 1800 e 1900)
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE disponivel = FALSE AND ano_publicacao BETWEEN 1800 AND 1900;

-- Exclui os livros indisponíveis desse período
DELETE FROM tb_livros
WHERE disponivel = FALSE AND ano_publicacao BETWEEN 1800 AND 1900;

-- Confere se foram removidos (deve retornar "Empty set")
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE disponivel = FALSE AND ano_publicacao BETWEEN 1800 AND 1900;

-- Conta o total de livros restantes
SELECT COUNT(*) AS total_livros FROM tb_livros;

-- ---------- 37. Excluir indisponíveis publicados antes de 1900 ----------

-- Confere os registros antes de excluir
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE disponivel = FALSE AND ano_publicacao < 1900;

-- Exclui os livros indisponíveis anteriores a 1900
DELETE FROM tb_livros
WHERE disponivel = FALSE AND ano_publicacao < 1900;

-- Confere se foram removidos (deve retornar "Empty set")
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE disponivel = FALSE AND ano_publicacao < 1900;

-- Conta o total de livros restantes
SELECT COUNT(*) AS total_livros FROM tb_livros;

-- ---------- 38. Excluir indisponíveis publicados a partir de 2000 ----------

-- Confere os registros antes de excluir (>= inclui o próprio ano 2000)
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE disponivel = FALSE AND ano_publicacao >= 2000;

-- Exclui os livros indisponíveis publicados de 2000 em diante
DELETE FROM tb_livros
WHERE disponivel = FALSE AND ano_publicacao >= 2000;

-- Confere se foram removidos (deve retornar "Empty set")
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE disponivel = FALSE AND ano_publicacao >= 2000;

-- Conta o total de livros restantes
SELECT COUNT(*) AS total_livros FROM tb_livros;


-- =====================================================================
-- ETAPA 7 - EXCLUSÃO COM SUBQUERY E COLEÇÃO TEMÁTICA
-- =====================================================================

-- ---------- 39. Excluir livros de autores com mais de dois registros (subquery) ----------

-- Lista os autores que, neste momento, têm mais de 2 registros
SELECT autor, COUNT(*) AS qtd_registros
FROM tb_livros
GROUP BY autor
HAVING COUNT(*) > 2;

-- Confere os livros que serão excluídos (subquery dentro de tabela derivada "sub"
-- para evitar o erro 1093 do MySQL)
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor IN (
        SELECT autor FROM (
            SELECT autor FROM tb_livros GROUP BY autor HAVING COUNT(*) > 2
        ) AS sub);

-- Exclui todos os livros dos autores que têm mais de 2 registros
DELETE FROM tb_livros
WHERE autor IN (
        SELECT autor FROM (
            SELECT autor FROM tb_livros GROUP BY autor HAVING COUNT(*) > 2
        ) AS sub);

-- Confere se ainda há autores com mais de 2 registros (deve retornar "Empty set")
SELECT autor, COUNT(*) AS qtd_registros
FROM tb_livros
GROUP BY autor
HAVING COUNT(*) > 2;

-- Conta o total de livros restantes
SELECT COUNT(*) AS total_livros FROM tb_livros;

-- ---------- 40. Manter só obras de J.K. Rowling (NOT LIKE) ----------

-- Confere os registros que serão excluídos (autores que NÃO contêm "J.K. Rowling")
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros
WHERE autor NOT LIKE '%J.K. Rowling%';

-- Exclui tudo que não for da autora, sobrando só os livros dela
DELETE FROM tb_livros
WHERE autor NOT LIKE '%J.K. Rowling%';

-- Mostra a tabela inteira para conferir o que sobrou (só os 2 livros da autora)
SELECT id, titulo, autor, ano_publicacao, disponivel
FROM tb_livros;

-- Conta o total final de livros (esperado: 2)
SELECT COUNT(*) AS total_livros FROM tb_livros;

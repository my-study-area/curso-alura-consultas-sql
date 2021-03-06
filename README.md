# curso-alura-consultas-sql
<p>
    <img alt="GitHub top language" src="https://img.shields.io/github/languages/top/my-study-area/curso-alura-consultas-sql">
    <a href="https://github.com/my-study-area">
        <img alt="Made by" src="https://img.shields.io/badge/made%20by-adriano%20avelino-gree">
    </a>
    <img alt="Repository size" src="https://img.shields.io/github/repo-size/my-study-area/curso-alura-consultas-sql">
    <a href="https://github.com/EliasGcf/readme-template/commits/master">
    <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/my-study-area/curso-alura-consultas-sql">
    </a>
</p>
Curso de Introdução ao SQL com MySQL: Manipule e consulte dados

## Configurando container Mysql
```bash
#constrói o container
docker-compose build

#inicia o container
docker-compose up -d

#carrega os registro iniciais
docker exec -i db sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < ./sucos_vendas_database.sql
```

## Anotações
**01 - Instalando e configurando o MYSQL**
- As pequenas diferenças entre os SQL de diferentes bancos de dados relacionais estão nas diferentes funções


**02 - Filtrando as consultas de dados**
- consultas realizadas usando WHERE e campo com índices são mais rápidas em relação a campos sem indice
- para consultar tabelas por coluna do tipo flutuante devemos usar `BETWEEN`. Ex: `SELECT * FROM tabela_de_produtos WHERE PRECO_DE_LISTA BETWEEN 19.50 AND 19.52;`

Comandos utilizados na aula **2.03 - Revisando consultas**:
```sql
USE sucos_vendas;

SELECT CPF, NOME, ENDERECO_1, ENDERECO_2, BAIRRO, CIDADE, ESTADO, 
CEP, DATA_DE_NASCIMENTO,
IDADE, SEXO, LIMITE_DE_CREDITO, VOLUME_DE_COMPRA, PRIMEIRA_COMPRA 
FROM tabela_de_clientes;

SELECT * FROM tabela_de_clientes;

SELECT CPF, NOME FROM tabela_de_clientes;

SELECT CPF as INDENTIFICADOR, NOME AS CLIENTE FROM tabela_de_clientes;

SELECT * FROM tabela_de_produtos;

SELECT * FROM tabela_de_produtos WHERE CODIGO_DO_PRODUTO = '1000889';

SELECT * FROM tabela_de_produtos WHERE SABOR = 'Uva';

SELECT * FROM tabela_de_produtos WHERE SABOR = 'Laranja';

SELECT * FROM tabela_de_produtos WHERE EMBALAGEM = 'PET';

SELECT * FROM tabela_de_produtos WHERE EMBALAGEM = 'pet';

SELECT * FROM tabela_de_produtos WHERE PRECO_DE_LISTA > 19.50;

SELECT * FROM tabela_de_produtos WHERE PRECO_DE_LISTA BETWEEN 19.50 AND 19.52;
```

Comandos utilizados na aula **2.07 Aplicando consultas condicionais**:
```sql
SELECT * FROM tabela_de_produtos WHERE SABOR = 'Manga'
OR TAMANHO = '470 ml';

SELECT * FROM tabela_de_produtos WHERE SABOR = 'Manga'
AND TAMANHO = '470 ml';

SELECT * FROM tabela_de_produtos WHERE NOT (SABOR = 'Manga'
AND TAMANHO = '470 ml');

SELECT * FROM tabela_de_produtos WHERE NOT (SABOR = 'Manga'
OR TAMANHO = '470 ml');

SELECT * FROM tabela_de_produtos WHERE SABOR = 'Manga'
AND NOT ( TAMANHO = '470 ml');

SELECT * FROM tabela_de_produtos WHERE SABOR IN ('Laranja', 'Manga');

SELECT * FROM tabela_de_produtos WHERE SABOR = 'Laranja' OR SABOR = 'Manga';

SELECT * FROM tabela_de_clientes WHERE CIDADE IN ('Rio de Janeiro','São Paulo')
AND IDADE >= 20;

SELECT * FROM tabela_de_clientes WHERE CIDADE IN ('Rio de Janeiro','São Paulo')
AND (IDADE >= 20 AND IDADE <= 22);
```

**Comandos utilizados na aula 2.09 Usando o LIKE**
```sql
SELECT * FROM tabela_de_produtos WHERE SABOR LIKE '%Maça%';

SELECT * FROM tabela_de_produtos WHERE SABOR LIKE '%Maça%'
AND EMBALAGEM = 'PET';
```

**03 - Apresentação dos dados de uma consulta**
- o comando `DISTINCT` é utilizado para exibir, numa consulta, os registros sem repetição
Comandos utilizados na aula 3.01 Usando DISTINCT para visualizar a tabela:
```sql
SELECT EMBALAGEM, TAMANHO FROM tabela_de_produtos;

SELECT DISTINCT EMBALAGEM, TAMANHO FROM tabela_de_produtos;

SELECT DISTINCT EMBALAGEM, TAMANHO FROM tabela_de_produtos
WHERE SABOR = 'Laranja';

SELECT DISTINCT EMBALAGEM, TAMANHO, SABOR FROM tabela_de_produtos;
```

- utilizamos `LIMIT` no SQL para limitar a quantidade de registro na consulta ou o intervalo de valores. Ex:
```sql
-- limita a consulta nos 5 primeiros registros
SELECT * FROM tabela_de_produtos LIMIT 5;

-- limita a consulta, iniciando na linha zero, nos 2 primeiros registros
-- incluindo a linha zero
SELECT * FROM tabela_de_produtos LIMIT 0,2;
```
Comandos utilizados na aula 03.03 Limitando a saída da consulta:
```sql
SELECT * FROM tabela_de_produtos;

SELECT * FROM tabela_de_produtos LIMIT 5;

SELECT * FROM tabela_de_produtos LIMIT 2,3;

SELECT * FROM tabela_de_produtos LIMIT 0,2;
```

- `ORDER BY` é utilizado para selecionar os registros ordenando por pela coluna(s), podendo ser ascendente (`ASC`) ou descendente (`DESC`)

Comandos utilizados na aula 03.05 Ordenando a saída da consulta:
```sql
SELECT * FROM tabela_de_produtos;

SELECT * FROM tabela_de_produtos ORDER BY PRECO_DE_LISTA;

SELECT * FROM tabela_de_produtos ORDER BY PRECO_DE_LISTA DESC;

SELECT * FROM tabela_de_produtos ORDER BY NOME_DO_PRODUTO;

SELECT * FROM tabela_de_produtos ORDER BY NOME_DO_PRODUTO DESC;

SELECT * FROM tabela_de_produtos ORDER BY EMBALAGEM DESC, NOME_DO_PRODUTO ASC;
```
- `GROUP BY` agrupaa linhas por um conjunto de campos e aplicando um critério de agrupamento sobre os campos numéricos (SOMA, MIN, MAX, MÉDIA, etc)
Comando utilizados na aula 03.07 Agrupando os resultados:
```sql
SELECT * FROM tabela_de_clientes;

SELECT ESTADO, LIMITE_DE_CREDITO FROM tabela_de_clientes;

SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS LIMITE_TOTAL FROM tabela_de_clientes GROUP BY ESTADO;

SELECT EMBALAGEM, PRECO_DE_LISTA FROM tabela_de_produtos;

SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO FROM tabela_de_Produtos GROUP BY EMBALAGEM;

SELECT EMBALAGEM, COUNT(*) AS CONTADOR FROM tabela_de_produtos GROUP BY EMBALAGEM;

SELECT BAIRRO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabela_de_clientes GROUP BY BAIRRO;

SELECT BAIRRO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabela_de_clientes 
WHERE CIDADE = 'Rio de Janeiro' GROUP BY BAIRRO;

SELECT ESTADO, BAIRRO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabela_de_clientes 
GROUP BY ESTADO, BAIRRO;

SELECT ESTADO, BAIRRO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabela_de_clientes 
WHERE CIDADE = 'Rio de Janeiro' GROUP BY ESTADO, BAIRRO;

SELECT ESTADO, BAIRRO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabela_de_clientes 
WHERE CIDADE = 'Rio de Janeiro' 
GROUP BY ESTADO, BAIRRO
ORDER BY BAIRRO;
```
- HAVING é um filtro, mas que se aplica sobre o resultado de um SELECT que é agrupado.

Anotações da aula 03.09 Usando a condição HAVING:
```sql
SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS SOMA_LIMITE FROM TABELA_DE_CLIENTES
GROUP BY ESTADO;

-- Erro: ERROR 1054 (42S22): Unknown column 'SOMA_LIMITE' in 'where clause'
-- a coluna SOMA_LIMITE somente é criada após ao realizar o agrupamento
SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS SOMA_LIMITE FROM TABELA_DE_CLIENTES
WHERE SOMA_LIMITE > 900000
GROUP BY ESTADO;

SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS SOMA_LIMITE FROM TABELA_DE_CLIENTES
GROUP BY ESTADO HAVING SUM(LIMITE_DE_CREDITO) > 900000;

SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO, 
MIN(PRECO_DE_LISTA) AS MENOR_PRECO FROM TABELA_DE_PRODUTOS
GROUP BY EMBALAGEM;

SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO, 
MIN(PRECO_DE_LISTA) AS MENOR_PRECO FROM TABELA_DE_PRODUTOS
GROUP BY EMBALAGEM HAVING SUM(PRECO_DE_LISTA) <= 80;

SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO, 
MIN(PRECO_DE_LISTA) AS MENOR_PRECO FROM TABELA_DE_PRODUTOS
GROUP BY EMBALAGEM HAVING SUM(PRECO_DE_LISTA) <= 80 AND MAX(PRECO_DE_LISTA) >= 5;
```
- `CASE`, como o próprio nome diz, o CASE é o seguinte: se acontece uma determinada condição, eu faço uma coisa; senão, eu faço outra.

Anotações da aula 03.11 Classificar resultados:
```sql
SELECT * FROM TABELA_DE_PRODUTOS;

SELECT NOME_DO_PRODUTO, PRECO_DE_LISTA,
CASE 
   WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
   WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
   ELSE 'PRODUTO BARATO' 
END AS STATUS_PRECO 
FROM TABELA_DE_PRODUTOS;

SELECT EMBALAGEM,
CASE 
   WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
   WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
   ELSE 'PRODUTO BARATO' 
END AS STATUS_PRECO, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO
FROM TABELA_DE_PRODUTOS
WHERE sabor = 'Manga'
GROUP BY EMBALAGEM, 
CASE 
   WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
   WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
   ELSE 'PRODUTO BARATO' 
END 
ORDER BY EMBALAGEM;
```

**04 - Juntando tabelas e consultas**
- `INNER JOIN` une duas tabelas relacionando a informação de uma coluna em comum nas duas tabelas, normalmente, uma chave estrangeira

Anotações da aula 04.01 Usando JOINS:
```sql
SELECT * FROM TABELA_DE_VENDEDORES;
SELECT * FROM NOTAS_FISCAIS;

SELECT * FROM TABELA_DE_VENDEDORES A
INNER JOIN NOTAS_FISCAIS B
ON A.MATRICULA = B.MATRICULA;

SELECT A.MATRICULA, A.NOME, COUNT(*) FROM
TABELA_DE_VENDEDORES A
INNER JOIN NOTAS_FISCAIS B
ON A.MATRICULA = B.MATRICULA
GROUP BY A.MATRICULA, A.NOME;

-- INNER JOIN DA FORMA ANTIGA
SELECT A.MATRICULA, A.NOME, COUNT(*) FROM
TABELA_DE_VENDEDORES A, NOTAS_FISCAIS B
WHERE A.MATRICULA = B.MATRICULA
GROUP BY A.MATRICULA, A.NOME;
```
- Atividade 4.02 Obtendo o faturamento anual:

  Obtenha o faturamento anual da empresa. Leve em consideração que o valor financeiro das vendas consiste em multiplicar a quantidade pelo preço.

  ```sql
  SELECT 
    YEAR(DATA_VENDA),
    SUM(QUANTIDADE * PRECO) AS FATURAMENTO
  FROM NOTAS_FISCAIS NF 
  INNER JOIN ITENS_NOTAS_FISCAIS INF ON NF.NUMERO = INF.NUMERO
  GROUP BY YEAR(DATA_VENDA);

  +------------------+--------------------+
  | YEAR(DATA_VENDA) | FATURAMENTO        |
  +------------------+--------------------+
  |             2015 | 39848262.062838554 |
  |             2016 |   42362118.2579875 |
  |             2017 |  44359017.49654484 |
  |             2018 | 11022277.617453337 |
  +------------------+--------------------+
  ```
- `LEFT JOIN` une duas tabelas relacionando a informação de uma coluna em comum nas duas tabelas, normalmente, uma chave estrangeira. E também adiciona os registros da tabela da esquerda
- `RIGHT JOIN` une duas tabelas relacionando a informação de uma coluna em comum nas duas tabelas, normalmente, uma chave estrangeira. E também adiciona os registros da tabela da direita

Anotações da aula 04.03 Exemplos de LEFT e RIGHT JOIN:
```sql
SELECT COUNT(*) FROM TABELA_DE_CLIENTES;

SELECT CPF, COUNT(*) FROM NOTAS_FISCAIS GROUP BY CPF;

SELECT DISTINCT CLI.CPF, CLI.NOME, NF.CPF FROM TABELA_DE_CLIENTES CLI
INNER JOIN NOTAS_FISCAIS NF ON CLI.CPF = NF.CPF;

SELECT DISTINCT CLI.CPF, CLI.NOME, NF.CPF FROM TABELA_DE_CLIENTES CLI
LEFT JOIN NOTAS_FISCAIS NF ON CLI.CPF = NF.CPF
WHERE NF.CPF IS NULL;

SELECT DISTINCT CLI.CPF, CLI.NOME, NF.CPF FROM NOTAS_FISCAIS NF
RIGHT JOIN TABELA_DE_CLIENTES CLI ON CLI.CPF = NF.CPF
WHERE NF.CPF IS NULL;
```
- `FULL JOIN` traz todo mundo da tabela da esquerda e todo mundo da tabela da direita
- `CROSS JOIN` junta os registro da primeira tabela com todos os registros da segunda tabela

Anotações da Aula 04.05 Exemplos de FULL e CROSS JOIN
```sql
SELECT * FROM TABELA_DE_VENDEDORES;

SELECT count(*) FROM TABELA_DE_CLIENTES;

SELECT * FROM TABELA_DE_VENDEDORES INNER JOIN TABELA_DE_CLIENTES
ON TABELA_DE_VENDEDORES.BAIRRO = TABELA_DE_CLIENTES.BAIRRO;

SELECT TABELA_DE_VENDEDORES.BAIRRO,
TABELA_DE_VENDEDORES.NOME, DE_FERIAS,
TABELA_DE_CLIENTES.BAIRRO,
TABELA_DE_CLIENTES.NOME  FROM TABELA_DE_VENDEDORES INNER JOIN TABELA_DE_CLIENTES
ON TABELA_DE_VENDEDORES.BAIRRO = TABELA_DE_CLIENTES.BAIRRO;

SELECT TABELA_DE_VENDEDORES.BAIRRO,
TABELA_DE_VENDEDORES.NOME, DE_FERIAS,
TABELA_DE_CLIENTES.BAIRRO,
TABELA_DE_CLIENTES.NOME  FROM TABELA_DE_VENDEDORES LEFT JOIN TABELA_DE_CLIENTES
ON TABELA_DE_VENDEDORES.BAIRRO = TABELA_DE_CLIENTES.BAIRRO;

SELECT TABELA_DE_VENDEDORES.BAIRRO,
TABELA_DE_VENDEDORES.NOME, DE_FERIAS,
TABELA_DE_CLIENTES.BAIRRO,
TABELA_DE_CLIENTES.NOME  FROM TABELA_DE_VENDEDORES RIGHT JOIN TABELA_DE_CLIENTES
ON TABELA_DE_VENDEDORES.BAIRRO = TABELA_DE_CLIENTES.BAIRRO;

-- mysql não implementa FULL JOIN 
SELECT TABELA_DE_VENDEDORES.BAIRRO,
TABELA_DE_VENDEDORES.NOME, DE_FERIAS,
TABELA_DE_CLIENTES.BAIRRO,
TABELA_DE_CLIENTES.NOME  FROM TABELA_DE_VENDEDORES FULL JOIN TABELA_DE_CLIENTES
ON TABELA_DE_VENDEDORES.BAIRRO = TABELA_DE_CLIENTES.BAIRRO;

SELECT TABELA_DE_VENDEDORES.BAIRRO,
TABELA_DE_VENDEDORES.NOME, DE_FERIAS,
TABELA_DE_CLIENTES.BAIRRO,
TABELA_DE_CLIENTES.NOME  FROM TABELA_DE_VENDEDORES , TABELA_DE_CLIENTES;
```
- `UNION` é o comando que junta duas consultas, mas não mostra valores repetidos. Semelhante ao DISTINCT.
- `UNION ALL` é o comando que junta duas consultas e mostra os registros repetidos

Anotações da Aula 04.07 Juntando consultas:
```sql
SELECT DISTINCT BAIRRO FROM TABELA_DE_CLIENTES;

SELECT DISTINCT BAIRRO FROM TABELA_DE_VENDEDORES;

SELECT DISTINCT BAIRRO FROM TABELA_DE_CLIENTES
UNION
SELECT DISTINCT BAIRRO FROM TABELA_DE_VENDEDORES;

SELECT DISTINCT BAIRRO FROM TABELA_DE_CLIENTES
UNION ALL
SELECT DISTINCT BAIRRO FROM TABELA_DE_VENDEDORES;

SELECT DISTINCT BAIRRO, NOME, 'CLIENTE' as TIPO FROM TABELA_DE_CLIENTES
UNION
SELECT DISTINCT BAIRRO, NOME, 'VENDEDOR' as TIPO FROM TABELA_DE_VENDEDORES;

SELECT DISTINCT BAIRRO, NOME, 'CLIENTE' as TIPO_CLIENTE FROM TABELA_DE_CLIENTES
UNION
SELECT DISTINCT BAIRRO, NOME, 'VENDEDOR' as TIPO_VENDEDOR FROM TABELA_DE_VENDEDORES;

SELECT DISTINCT BAIRRO, NOME, 'CLIENTE' as TIPO_CLIENTE, CPF  FROM TABELA_DE_CLIENTES
UNION
SELECT DISTINCT BAIRRO, NOME, 'VENDEDOR' as TIPO_VENDEDOR, MATRICULA FROM TABELA_DE_VENDEDORES;

SELECT TABELA_DE_VENDEDORES.BAIRRO,
TABELA_DE_VENDEDORES.NOME, DE_FERIAS,
TABELA_DE_CLIENTES.BAIRRO,
TABELA_DE_CLIENTES.NOME  FROM TABELA_DE_VENDEDORES LEFT JOIN TABELA_DE_CLIENTES
ON TABELA_DE_VENDEDORES.BAIRRO = TABELA_DE_CLIENTES.BAIRRO
UNION
SELECT TABELA_DE_VENDEDORES.BAIRRO,
TABELA_DE_VENDEDORES.NOME, DE_FERIAS,
TABELA_DE_CLIENTES.BAIRRO,
TABELA_DE_CLIENTES.NOME  FROM TABELA_DE_VENDEDORES RIGHT JOIN TABELA_DE_CLIENTES
ON TABELA_DE_VENDEDORES.BAIRRO = TABELA_DE_CLIENTES.BAIRRO;
```

Anotações da aula 04.09 Sub consultas
```sql
SELECT DISTINCT BAIRRO FROM TABELA_DE_VENDEDORES;

SELECT * FROM TABELA_DE_CLIENTES WHERE BAIRRO 
IN ('Tijuca','Jardins','Copacabana','Santo Amaro');

SELECT * FROM TABELA_DE_CLIENTES WHERE BAIRRO 
IN (SELECT DISTINCT BAIRRO FROM TABELA_DE_VENDEDORES);

SELECT X.EMBALAGEM, X.PRECO_MAXIMO FROM 
(SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS PRECO_MAXIMO FROM TABELA_DE_PRODUTOS
GROUP BY EMBALAGEM) X WHERE X.PRECO_MAXIMO >= 10;
```

Atividade 04.10 Relação entre HAVING e sub consulta

Qual seria a consulta usando subconsulta que seria equivalente a:

```sql
SELECT CPF, COUNT(*) FROM NOTAS_FISCAIS
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY CPF
HAVING COUNT(*) > 2000;
```
Resposta:
```sql
--OPÇÃO 01
SELECT T.CPF, T.TOTAL 
FROM (SELECT CPF, COUNT(*) AS TOTAL 
      FROM NOTAS_FISCAIS
      WHERE YEAR(DATA_VENDA) = 2016
      GROUP BY CPF
      HAVING COUNT(*) > 2000
) AS T;

--OPÇÃO 02
SELECT T.CPF, T.TOTAL 
FROM (SELECT CPF, COUNT(*) AS TOTAL, YEAR(DATA_VENDA) AS ANO
      FROM NOTAS_FISCAIS
      WHERE YEAR(DATA_VENDA) = 2016
      GROUP BY CPF, YEAR(DATA_VENDA)
      HAVING COUNT(*) > 2000
) AS T;

--OPÇÃO 03
SELECT T.CPF, T.TOTAL 
FROM (SELECT CPF, COUNT(*) AS TOTAL, YEAR(DATA_VENDA) AS ANO
      FROM NOTAS_FISCAIS
      GROUP BY CPF, YEAR(DATA_VENDA)
      HAVING COUNT(*) > 2000
) AS T
WHERE ANO = 2016 ;

--OPÇÃO 04
SELECT T.CPF, T.TOTAL_NF, T.ANO 
FROM (SELECT CPF, COUNT(*) AS TOTAL_NF, YEAR(DATA_VENDA) AS ANO
      FROM NOTAS_FISCAIS
      GROUP BY CPF, YEAR(DATA_VENDA)
) AS T
WHERE ANO = 2016 AND TOTAL_NF > 2000;
```
- `VIEW` é uma tabela lógica, resultado de uma consulta, que pode ser usada depois em qualquer outa consulta

Anotações da aula 04.11 Visão:
```sql
SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO 
FROM TABELA_DE_PRODUTOS
GROUP BY EMBALAGEM;

SELECT X.EMBALAGEM, X.MAIOR_PRECO FROM
(SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO 
FROM TABELA_DE_PRODUTOS
GROUP BY EMBALAGEM) X WHERE X.MAIOR_PRECO >= 10;

-- EXEMPLO DE CRIAÇÃO DE VIEW
CREATE VIEW `VW_MAIORES_EMBALAGENS` AS 
SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO 
FROM TABELA_DE_PRODUTOS 
GROUP BY EMBALAGEM;

SELECT X.EMBALAGEM, X.MAIOR_PRECO FROM
VW_MAIORES_EMBALAGENS X WHERE X.MAIOR_PRECO >= 10;

SELECT A.NOME_DO_PRODUTO, A.EMBALAGEM, A.PRECO_DE_LISTA, X.MAIOR_PRECO,
((A.PRECO_DE_LISTA / X.MAIOR_PRECO) -1) * 100 AS PERCENTUAL
FROM TABELA_DE_PRODUTOS A INNER JOIN VW_MAIORES_EMBALAGENS X
ON A.EMBALAGEM = X.EMBALAGEM;
```

**05 - Funções de string**

Anotações da aula 05.01 Funções de String
```sql
SELECT LTRIM('    OLÁ') AS RESULTADO;

SELECT RTRIM('OLÁ     ') AS RESULTADO;

SELECT TRIM('    OLÁ    ') AS RESULTADO;

SELECT CONCAT('OLÁ', ' ', 'TUDO BEM','?') AS RESULTADO;

SELECT UPPER('olá, tudo bem?') AS RESULTADO;

SELECT LOWER('OLÁ, TUDO BEM?') AS RESULTADO;

SELECT SUBSTRING('OLÁ, TUDO BEM?', 6) AS RESULTADO;

SELECT SUBSTRING('OLÁ, TUDO BEM?', 6, 4) AS RESULTADO;

SELECT CONCAT(NOME, ' (', CPF, ') ') AS RESULTADO FROM TABELA_DE_CLIENTES;
```

Atividade 05.02 Listando o endereço completo

Faça uma consulta listando o nome do cliente e o endereço completo (Com rua, bairro, cidade e estado).

Resposta:
```sql
SELECT 
    CONCAT('Nome: ', NOME) AS NOME,
    CONCAT('Rua: ', ENDERECO_1, ', Bairro: ', BAIRRO, ', Cidade:', CIDADE, ', Estado:', ESTADO) AS ENDERECO_COMPLETO
FROM TABELA_DE_CLIENTES;
```

Aula 05.03 Funções de datas
```sql
SELECT CURDATE();

SELECT CURRENT_TIME();

SELECT CURRENT_TIMESTAMP();

SELECT YEAR(CURRENT_TIMESTAMP());

SELECT DAY(CURRENT_TIMESTAMP());

SELECT MONTH(CURRENT_TIMESTAMP());

SELECT MONTHNAME(CURRENT_TIMESTAMP());

SELECT DATEDIFF(CURRENT_TIMESTAMP(), '2021-01-01') AS RESULTADO;

SELECT DATEDIFF(CURRENT_TIMESTAMP(), '1984-03-09') AS RESULTADO;

SELECT 
    CURRENT_TIMESTAMP() AS DIA_HOJE,
    DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL 5 DAY) AS RESULTADO;

SELECT DISTINCT DATA_VENDA,
DAYNAME(DATA_VENDA) AS DIA, MONTHNAME(DATA_VENDA) AS MES
, YEAR(DATA_VENDA) AS ANO FROM NOTAS_FISCAIS;
```

Atividade 05.04 Idade dos clientes

Crie uma consulta que mostre o nome e a idade atual dos clientes.

```sql
SELECT NOME, TIMESTAMPDIFF(YEAR, DATA_DE_NASCIMENTO, CURDATE()) AS IDADE
FROM  TABELA_DE_CLIENTES;
```
Anotações da Aula 05.05 Funções matemáticas:

```sql
SELECT (23+((25-2)/2)*45) AS RESULTADO;

SELECT CEILING(12.33333232323) AS RESULTADO;

SELECT ROUND(12.7777232323) AS RESULTADO;

SELECT FLOOR(12.7777232323) AS RESULTADO;

SELECT RAND() AS RESULTADO; 

SELECT NUMERO, QUANTIDADE, PRECO, QUANTIDADE * PRECO AS FATURAMENTO
FROM ITENS_NOTAS_FISCAIS;

SELECT NUMERO, QUANTIDADE, PRECO, ROUND(QUANTIDADE * PRECO, 2) AS FATURAMENTO
FROM ITENS_NOTAS_FISCAIS;
```

Atividade 05.06 Formato do faturamento

Na tabela de notas fiscais temos o valor do imposto. Já na tabela de itens temos a quantidade e o faturamento. Calcule o valor do imposto pago no ano de 2016 arredondando para o menor inteiro.

```sql
SELECT YEAR(DATA_VENDA), FLOOR(SUM(IMPOSTO * (QUANTIDADE * PRECO))) 
FROM notas_fiscais NF
INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY YEAR(DATA_VENDA)
```

Anotações da Aula 05.07 Conversão de dados:
```sql
SELECT CURRENT_TIMESTAMP() AS RESULTADO;

SELECT CONCAT('O dia de hoje é : ', CURRENT_TIMESTAMP()) AS RESULTADO;

SELECT CONCAT('O dia de hoje é : ', 
DATE_FORMAT(CURRENT_TIMESTAMP(),'%W, %d/%m/%Y - %U') ) AS RESULTADO;

SELECT SUBSTRING(CONVERT(23.3, CHAR),1,1) AS RESULTADO;
```

Atividade da aula 05.08 Listando expressão natural
Queremos construir um SQL cujo resultado seja, para cada cliente:

`“O cliente João da Silva faturou 120000 no ano de 2016”.`

Somente para o ano de 2016.

Resposta:
```sql
SELECT 
    CONCAT('O cliente ',C.NOME, ' faturou ', FLOOR(SUM(I.QUANTIDADE * I.PRECO)), ' no ano de ', YEAR(NF.DATA_VENDA)) AS FRASE
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS I ON I.NUMERO = NF.NUMERO
INNER JOIN TABELA_DE_CLIENTES C ON C.CPF = NF.CPF
WHERE YEAR(NF.DATA_VENDA) = '2016'
GROUP BY NF.CPF, YEAR(DATA_VENDA);
```

**06 - Exemplos de relatórios**

Anotações da aula 06.01 Relatório de vendas válidas
```sql
SELECT * FROM ITENS_NOTAS_FISCAIS;

SELECT * FROM NOTAS_FISCAIS;

SELECT * 
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF ON NF.NUMERO = INF.NUMERO;

SELECT NF.CPF, NF.DATA_VENDA, INF.QUANTIDADE 
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF ON NF.NUMERO = INF.NUMERO;

SELECT 
    NF.CPF,
    DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO,
    INF.QUANTIDADE 
FROM NOTAS_FISCAIS NF
    INNER JOIN ITENS_NOTAS_FISCAIS INF ON NF.NUMERO = INF.NUMERO;

/* CONSULTA COM VENDAS DE CLIENTES POR MES */
SELECT
    NF.CPF,
    DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO,
    SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDAS 
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF ON NF.NUMERO = INF.NUMERO
GROUP BY NF.CPF, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m');

/* LIMITE DE COMPRA POR CLIENTE */
SELECT * FROM TABELA_DE_CLIENTES TC;

SELECT TC.CPF, TC.NOME, TC.VOLUME_DE_COMPRA AS QUANTIDADE_LIMITE
FROM TABELA_DE_CLIENTES TC;

SELECT
    NF.CPF,
    TC.NOME,
    DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO,
    SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDAS,
    TC.VOLUME_DE_COMPRA AS QUANTIDADE_LIMITE 
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF ON NF.NUMERO = INF.NUMERO
INNER JOIN TABELA_DE_CLIENTES TC ON TC.CPF = NF.CPF
GROUP BY NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m');

SELECT
    NF.CPF,
    TC.NOME,
    DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO,
    (INF.QUANTIDADE) AS QUANTIDADE_VENDAS,
    TC.VOLUME_DE_COMPRA AS QUANTIDADE_LIMITE
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF ON NF.NUMERO = INF.NUMERO
INNER JOIN TABELA_DE_CLIENTES TC ON TC.CPF = NF.CPF;

SELECT
    NF.CPF,
    TC.NOME,
    DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO,
    SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDAS ,
    MAX(TC.VOLUME_DE_COMPRA) AS QUANTIDADE_LIMITE FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF ON NF.NUMERO = INF.NUMERO
INNER JOIN TABELA_DE_CLIENTES TC ON TC.CPF = NF.CPF
GROUP BY NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m');

SELECT 
    X.CPF,
    X.NOME,
    X.MES_ANO,
    X.QUANTIDADE_VENDAS,
    X.QUANTIDADE_LIMITE,
    X.QUANTIDADE_LIMITE - X.QUANTIDADE_VENDAS AS DIFERENCA
FROM (
    SELECT NF.CPF,
        TC.NOME,
        DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO,
        SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDAS,
        MAX(TC.VOLUME_DE_COMPRA) AS QUANTIDADE_LIMITE
    FROM NOTAS_FISCAIS NF
    INNER JOIN ITENS_NOTAS_FISCAIS INF ON NF.NUMERO = INF.NUMERO
    INNER JOIN TABELA_DE_CLIENTES TC ON TC.CPF = NF.CPF
    GROUP BY NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m')
) X;


SELECT
    X.CPF,
    X.NOME,
    X.MES_ANO,
    X.QUANTIDADE_VENDAS,
    X.QUANTIDADE_LIMITE,
CASE WHEN (X.QUANTIDADE_LIMITE - X.QUANTIDADE_VENDAS) < 0 THEN 'INVÁLIDA'
ELSE 'VÁLIDA' END AS STATUS_VENDA
FROM (
    SELECT 
        NF.CPF,
        TC.NOME,
        DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO,
        SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDAS ,
        MAX(TC.VOLUME_DE_COMPRA) AS QUANTIDADE_LIMITE FROM NOTAS_FISCAIS NF
    INNER JOIN ITENS_NOTAS_FISCAIS INF ON NF.NUMERO = INF.NUMERO
    INNER JOIN TABELA_DE_CLIENTES TC ON TC.CPF = NF.CPF
    GROUP BY NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m')
) X;
```

Atividade 06.02 A consulta do relatório

Nesta aula construímos um relatório que apresentou os clientes que tiveram vendas inválidas. Complemente este relatório listando somente os que tiveram vendas inválidas e calculando a diferença entre o limite de venda máximo e o realizado, em percentuais.

Dica:

Capture a SQL final da aula.

Filtre somente as linhas onde

(X.QUANTIDADE_LIMITE - X.QUANTIDADE_VENDAS) < 0

Liste a coluna de X.QUANTIDADE_LIMITE

Crie uma nova coluna fazendo a fórmula:

(1 - (X.QUANTIDADE_LIMITE/X.QUANTIDADE_VENDAS)) * 100

```sql
SELECT
    X.CPF,
    X.NOME,
    X.MES_ANO,
    X.QUANTIDADE_VENDAS,
    X.QUANTIDADE_LIMITE,
    CASE WHEN (X.QUANTIDADE_LIMITE - X.QUANTIDADE_VENDAS) < 0 THEN 'INVÁLIDA'
    ELSE 'VÁLIDA' END AS STATUS_VENDA,
    CONCAT(FLOOR((1 - (X.QUANTIDADE_LIMITE/X.QUANTIDADE_VENDAS)) * 100), '%') AS PERCENT
FROM (
    SELECT 
        NF.CPF,
        TC.NOME,
        DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO,
        SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDAS ,
        MAX(TC.VOLUME_DE_COMPRA) AS QUANTIDADE_LIMITE FROM NOTAS_FISCAIS NF
    INNER JOIN ITENS_NOTAS_FISCAIS INF ON NF.NUMERO = INF.NUMERO
    INNER JOIN TABELA_DE_CLIENTES TC ON TC.CPF = NF.CPF
    GROUP BY NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m')
) X WHERE (X.QUANTIDADE_LIMITE - X.QUANTIDADE_VENDAS) < 0;


```

Anotações da aula 06.03 Relatório de vendas por sabor
```sql
SELECT * 
FROM TABELA_DE_PRODUTOS P
INNER JOIN ITENS_NOTAS_FISCAIS I ON P.CODIGO_DO_PRODUTO = I.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF ON NF.NUMERO = I.NUMERO;

-- QUANTIDADE DE VENDA DE SABORES NO ANO DE 2016
SELECT
    P.SABOR,
    SUM(I.QUANTIDADE) AS QUANTIDADE,
    YEAR(DATA_VENDA) AS ANO
FROM TABELA_DE_PRODUTOS P
INNER JOIN ITENS_NOTAS_FISCAIS I ON P.CODIGO_DO_PRODUTO = I.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF ON NF.NUMERO = I.NUMERO
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY P.SABOR, ANO
ORDER BY QUANTIDADE DESC;


-- QUANTIDADE DE VENDA TOTAL NO ANO DE 2016
SELECT
    SUM(I.QUANTIDADE) AS QUANTIDADE,
    YEAR(DATA_VENDA) AS ANO
FROM TABELA_DE_PRODUTOS P
INNER JOIN ITENS_NOTAS_FISCAIS I ON P.CODIGO_DO_PRODUTO = I.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF ON NF.NUMERO = I.NUMERO
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY ANO;

SELECT
    VENDAS_SABOR.SABOR,
    VENDAS_SABOR.ANO,
    VENDAS_SABOR.QUANTIDADE,
    ROUND((VENDAS_SABOR.QUANTIDADE/VENDAS_TOTAL.QUANTIDADE) * 100, 2) AS PARTICIPACAO
FROM (
      SELECT
          P.SABOR,
          SUM(I.QUANTIDADE) AS QUANTIDADE,
          YEAR(DATA_VENDA) AS ANO
      FROM TABELA_DE_PRODUTOS P
      INNER JOIN ITENS_NOTAS_FISCAIS I ON P.CODIGO_DO_PRODUTO = I.CODIGO_DO_PRODUTO
      INNER JOIN NOTAS_FISCAIS NF ON NF.NUMERO = I.NUMERO
      WHERE YEAR(DATA_VENDA) = 2016
      GROUP BY P.SABOR, ANO
      ) VENDAS_SABOR
INNER JOIN (
      SELECT
          SUM(I.QUANTIDADE) AS QUANTIDADE,
          YEAR(DATA_VENDA) AS ANO
      FROM TABELA_DE_PRODUTOS P
      INNER JOIN ITENS_NOTAS_FISCAIS I ON P.CODIGO_DO_PRODUTO = I.CODIGO_DO_PRODUTO
      INNER JOIN NOTAS_FISCAIS NF ON NF.NUMERO = I.NUMERO
      WHERE YEAR(DATA_VENDA) = 2016
      GROUP BY ANO
) VENDAS_TOTAL ON VENDAS_SABOR.ANO = VENDAS_TOTAL.ANO
ORDER BY VENDAS_SABOR.QUANTIDADE DESC;
```

Atividade 06.04 Vendas percentuais por tamanho

Modifique o relatório mas agora para ver o ranking das vendas por tamanho.

Dica: Pode parecer difícil mas este é o exercício mais fácil de resolver.

```sql
SELECT
    VENDAS_SABOR.TAMANHO,
    VENDAS_SABOR.ANO,
    VENDAS_SABOR.QUANTIDADE,
    ROUND((VENDAS_SABOR.QUANTIDADE/VENDAS_TOTAL.QUANTIDADE) * 100, 2) AS PARTICIPACAO
FROM (
    SELECT
        P.SABOR,
        P.TAMANHO,
        SUM(I.QUANTIDADE) AS QUANTIDADE,
        YEAR(DATA_VENDA) AS ANO
    FROM TABELA_DE_PRODUTOS P
    INNER JOIN ITENS_NOTAS_FISCAIS I ON P.CODIGO_DO_PRODUTO = I.CODIGO_DO_PRODUTO
    INNER JOIN NOTAS_FISCAIS NF ON NF.NUMERO = I.NUMERO
    WHERE YEAR(DATA_VENDA) = 2016
    GROUP BY P.TAMANHO, ANO
      ) VENDAS_SABOR
INNER JOIN (
      SELECT
          SUM(I.QUANTIDADE) AS QUANTIDADE,
          YEAR(DATA_VENDA) AS ANO
      FROM TABELA_DE_PRODUTOS P
      INNER JOIN ITENS_NOTAS_FISCAIS I ON P.CODIGO_DO_PRODUTO = I.CODIGO_DO_PRODUTO
      INNER JOIN NOTAS_FISCAIS NF ON NF.NUMERO = I.NUMERO
      WHERE YEAR(DATA_VENDA) = 2016
      GROUP BY ANO
) VENDAS_TOTAL ON VENDAS_SABOR.ANO = VENDAS_TOTAL.ANO
ORDER BY VENDAS_SABOR.QUANTIDADE DESC;
```

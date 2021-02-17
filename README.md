# curso-alura-consultas-sql
Curso de Introdução ao SQL com MySQL: Manipule e consulte dados

## Configurando container Mysql
```bash
#constrói o container
docker-compose build

#inicia o container
docker-compose up -d

#carrega os registro iniciais
docker exec -i db sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < ./backup.sql
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

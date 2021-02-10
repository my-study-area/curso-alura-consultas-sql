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

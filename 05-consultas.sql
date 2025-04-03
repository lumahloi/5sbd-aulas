--1. Exiba os nomes dos clientes com todas as letras em maiúsculas:
SELECT UPPER(nome) AS nome_maiusculo FROM clientes;
--2. Exiba os nomes dos clientes formatados com apenas a primeira letra maiúscula:
SELECT INITCAP(nome) AS nome_primeira_maiuscula FROM clientes;
--3. Mostre as três primeiras letras do nome de cada cliente:
SELECT SUBSTRING(nome, 1, 3) AS primeiras_tres_letras FROM clientes;
--4. Exiba o número de caracteres do nome de cada cliente:
SELECT LENGTH(nome) AS numero_de_caracteres FROM clientes;
--5. Apresente o saldo de todas as contas, arredondado para o inteiro mais próximo:
SELECT ROUND(saldo) AS saldo_arredondado FROM contas;
--6. Exiba o saldo truncado, sem casas decimais:
SELECT TRUNCATE(saldo, 0) AS saldo_truncado FROM contas;
--7. Mostre o resto da divisão do saldo da conta por 1000:
SELECT MOD(saldo, 1000) AS resto_divisao_1000 FROM contas;
--8. Exiba a data atual do servidor do banco:
SELECT CURRENT_DATE AS data_atual;
--9. Adicione 30 dias à data atual e exiba como "Data de vencimento simulada":
SELECT DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY) AS data_vencimento_simulada;
--10. Exiba o número de dias entre a data de abertura da conta e a data atual:
SELECT DATEDIFF(CURRENT_DATE, data_abertura) AS dias_desde_abertura FROM contas;
--11. Apresente o saldo de cada conta formatado como moeda local:
SELECT FORMAT(saldo, 2, 'de_DE') AS saldo_moeda_local FROM contas;
--12. Converta a data de abertura da conta para o formato 'dd/mm/yyyy':
SELECT DATE_FORMAT(data_abertura, '%d/%m/%Y') AS data_abertura_formatada FROM contas;
--13. Exiba o saldo da conta e substitua valores nulos por 0:
SELECT IFNULL(saldo, 0) AS saldo_com_substituicao_nulo FROM contas;
--14. Exiba os nomes dos clientes e substitua valores nulos na cidade por 'Sem cidade':
SELECT nome, IFNULL(cidade, 'Sem cidade') AS cidade_com_substituicao FROM clientes;
--15. Classifique os clientes em grupos com base em sua cidade:
SELECT nome, CASE WHEN cidade = 'Niterói' THEN 'Região Metropolitana' WHEN cidade = 'Resende' THEN 'Interior' ELSE 'Outra Região' END AS grupo_regiao FROM clientes;
--16. Exiba o nome de cada cliente, o número da conta e o saldo correspondente:
SELECT clientes.nome, contas.numero_conta, contas.saldo FROM clientes JOIN contas ON clientes.codigo = contas.codigo_cliente;
--17. Liste os nomes dos clientes e os nomes das agências onde mantêm conta:
SELECT clientes.nome, agencias.nome_agencia FROM clientes JOIN contas ON clientes.codigo = contas.codigo_cliente JOIN agencias ON contas.codigo_agencia = agencias.codigo_agencia;
--18. Mostre todas as agências, mesmo aquelas que não possuem clientes vinculados (junção externa esquerda):
SELECT agencias.nome_agencia, clientes.nome FROM agencias LEFT JOIN contas ON agencias.codigo_agencia = contas.codigo_agencia LEFT JOIN clientes ON contas.codigo_cliente = clientes.codigo;

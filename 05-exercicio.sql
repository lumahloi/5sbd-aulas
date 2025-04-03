--1. Exibir o nome de cada cliente junto com o número de sua conta:
SELECT c.nome_cliente, co.numero_conta FROM cliente c JOIN conta co ON c.id_cliente = co.id_cliente;
--2. Mostrar todas as combinações possíveis de clientes e agências (produto cartesiano):
SELECT c.nome_cliente, a.nome_agencia FROM cliente c, agencia a;
--3. Exibir o nome dos clientes e a cidade da agência onde mantêm conta, usando aliases:
SELECT c.nome_cliente, a.cidade FROM cliente c JOIN conta co ON c.id_cliente = co.id_cliente JOIN agencia a ON co.id_agencia = a.id_agencia;
--4. Exibir o saldo total de todas as contas cadastradas:
SELECT SUM(co.saldo) AS saldo_total FROM conta co;
--5. Mostrar o maior saldo e a média de saldo entre todas as contas:
SELECT MAX(co.saldo) AS maior_saldo, AVG(co.saldo) AS media_saldo FROM conta co;
--6. Apresentar a quantidade total de contas cadastradas:
SELECT COUNT(co.numero_conta) AS total_contas FROM conta co;
--7. Listar o número de cidades distintas onde os clientes residem:
SELECT COUNT(DISTINCT c.cidade) AS numero_cidades FROM cliente c;
--8. Exibir o número da conta e o saldo, substituindo valores nulos por zero:
SELECT co.numero_conta, NVL(co.saldo, 0) AS saldo FROM conta co;
--9. Exibir a média de saldo por cidade dos clientes:
SELECT c.cidade, AVG(co.saldo) AS media_saldo FROM cliente c JOIN conta co ON c.id_cliente = co.id_cliente GROUP BY c.cidade;
--10. Listar apenas as cidades com mais de 3 contas associadas a seus moradores:
SELECT c.cidade, COUNT(co.numero_conta) AS total_contas FROM cliente c JOIN conta co ON c.id_cliente = co.id_cliente GROUP BY c.cidade HAVING COUNT(co.numero_conta) > 3;
--11. Usar a cláusula ROLLUP para exibir o total de saldos por cidade da agência e o total geral:
SELECT a.cidade, SUM(co.saldo) AS total_saldo FROM agencia a JOIN conta co ON a.id_agencia = co.id_agencia GROUP BY ROLLUP(a.cidade);
--12. Fazer uma consulta com UNION que combine os nomes de cidades dos clientes e das agências, sem repetições:
SELECT DISTINCT c.cidade FROM cliente c UNION SELECT DISTINCT a.cidade FROM agencia a;
--1. Liste os nomes dos clientes cujas contas possuem saldo acima da média geral de todas as contas registradas:
SELECT c.nome_cliente FROM cliente c JOIN conta co ON c.id_cliente = co.id_cliente WHERE co.saldo > (SELECT AVG(saldo) FROM conta);
--2. Exiba os nomes dos clientes cujos saldos são iguais ao maior saldo encontrado no banco:
SELECT c.nome_cliente FROM cliente c JOIN conta co ON c.id_cliente = co.id_cliente WHERE co.saldo = (SELECT MAX(saldo) FROM conta);
--3. Liste as cidades onde a quantidade de clientes é maior que a quantidade média de clientes por cidade:
SELECT c.cidade FROM cliente c GROUP BY c.cidade HAVING COUNT(c.id_cliente) > (SELECT AVG(qtd) FROM (SELECT COUNT(id_cliente) AS qtd FROM cliente GROUP BY cidade));
--4. Liste os nomes dos clientes com saldo igual a qualquer um dos dez maiores saldos registrados:
SELECT c.nome_cliente FROM cliente c JOIN conta co ON c.id_cliente = co.id_cliente WHERE co.saldo IN (SELECT saldo FROM (SELECT saldo FROM conta ORDER BY saldo DESC) WHERE ROWNUM <= 10);
--5. Liste os clientes que possuem saldo menor que todos os saldos dos clientes da cidade de Niterói:
SELECT c.nome_cliente FROM cliente c JOIN conta co ON c.id_cliente = co.id_cliente WHERE co.saldo < ALL (SELECT co.saldo FROM cliente c2 JOIN conta co ON c2.id_cliente = co.id_cliente WHERE c2.cidade = 'Niterói');
--6. Liste os clientes cujos saldos estão entre os saldos de clientes de Volta Redonda:
SELECT c.nome_cliente FROM cliente c JOIN conta co ON c.id_cliente = co.id_cliente WHERE co.saldo BETWEEN (SELECT MIN(co.saldo) FROM cliente c2 JOIN conta co ON c2.id_cliente = co.id_cliente WHERE c2.cidade = 'Volta Redonda') AND (SELECT MAX(co.saldo) FROM cliente c2 JOIN conta co ON c2.id_cliente = co.id_cliente WHERE c2.cidade = 'Volta Redonda');
--7. Exiba os nomes dos clientes cujos saldos são maiores que a média de saldo das contas da mesma agência:
SELECT c.nome_cliente FROM cliente c JOIN conta co ON c.id_cliente = co.id_cliente WHERE co.saldo > (SELECT AVG(co2.saldo) FROM conta co2 WHERE co2.id_agencia = co.id_agencia);
--8. Liste os nomes e cidades dos clientes que têm saldo inferior à média de sua própria cidade:
SELECT c.nome_cliente, c.cidade FROM cliente c JOIN conta co ON c.id_cliente = co.id_cliente WHERE co.saldo < (SELECT AVG(co2.saldo) FROM conta co2 JOIN cliente c2 ON co2.id_cliente = c2.id_cliente WHERE c2.cidade = c.cidade);
--9. Liste os nomes dos clientes que possuem pelo menos uma conta registrada no banco:
SELECT c.nome_cliente FROM cliente c WHERE EXISTS (SELECT 1 FROM conta co WHERE co.id_cliente = c.id_cliente);
--10. Liste os nomes dos clientes que ainda não possuem conta registrada no banco:
SELECT c.nome_clienteFROM cliente c WHERE NOT EXISTS (SELECT 1 FROM conta co WHERE co.id_cliente = c.id_cliente);
--11. Usando a cláusula WITH, calcule a média de saldo por cidade e exiba os clientes que possuem saldo acima da média de sua cidade:
WITH media_saldo_por_cidade AS (SELECT c.cidade, AVG(co.saldo) AS media_saldo FROM cliente c JOIN conta co ON c.id_cliente = co.id_cliente GROUP BY c.cidade) SELECT c.nome_cliente, c.cidade, co.saldo FROM cliente c JOIN conta co ON c.id_cliente = co.id_cliente JOIN media_saldo_por_cidade m ON c.cidade = m.cidade WHERE co.saldo > m.media_saldo;

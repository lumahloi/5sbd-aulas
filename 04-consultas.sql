-- 1. Exibir todos os dados cadastrados na tabela de clientes:
SELECT * FROM clientes;
--2. Exibir apenas os nomes e as cidades dos clientes:
SELECT nome, cidade FROM clientes;
--3. Listar todas as contas registradas, exibindo o número da conta e o saldo:
SELECT numero_conta, saldo FROM contas;
--4. Liste os nomes dos clientes da cidade de Macaé:
SELECT nome FROM clientes WHERE cidade = 'Macaé';
--5. Exiba o código e o nome de todos os clientes com código entre 5 e 15:
SELECT codigo, nome FROM clientes WHERE codigo BETWEEN 5 AND 15;
--6. Exiba os clientes que moram em Niterói, Volta Redonda ou Itaboraí:
SELECT nome FROM clientes WHERE cidade IN ('Niterói', 'Volta Redonda', 'Itaboraí');
--7. Exiba os nomes dos clientes que começam com a letra "F":
SELECT nome FROM clientes WHERE nome LIKE 'F%';
--8. Exiba uma frase com a seguinte estrutura para todos os clientes:
SELECT CONCAT(nome, ' mora em ', cidade) AS Frase FROM clientes;
--9. Exiba os dados de todas as contas com saldo superior a R$ 9.000, ordenados do maior para o menor saldo:
SELECT * FROM contas WHERE saldo > 9000 ORDER BY saldo DESC;
--10. Liste os clientes que moram em Nova Iguaçu ou que tenham "Silva" no nome:
SELECT nome FROM clientes WHERE cidade = 'Nova Iguaçu' OR nome LIKE '%Silva%';
--11. Exiba o saldo das contas com arredondamento para o inteiro mais próximo:
SELECT ROUND(saldo) AS saldo_arredondado FROM contas;
--12. Exiba o nome de todos os clientes em letras maiúsculas:
SELECT UPPER(nome) AS nome_maiusculo FROM clientes;
--13. Exiba os nomes dos clientes que não são das cidades de Teresópolis nem Campos dos Goytacazes:
SELECT nome FROM clientes WHERE cidade NOT IN ('Teresópolis', 'Campos dos Goytacazes');

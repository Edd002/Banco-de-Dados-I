SELECT nom_empregado FROM empregado WHERE sig_uf='MG';

SELECT nom_empregado, dat_nascimento FROM empregado ORDER BY dat_nascimento ASC;

SELECT nom_projeto, nom_local FROM projeto;

SELECT DISTINCT nom_cidade, sig_uf FROM empregado;

SELECT * FROM departamento WHERE dat_inicio_gerente > '2007-01-01';

SELECT nom_empregado, val_salario FROM empregado ORDER BY val_salario DESC;

SELECT nom_dependente, dsc_parentesco FROM dependente WHERE sex_dependente='M';

SELECT * FROM empregado WHERE num_matricula_supervisor IS NULL AND sig_uf='MG';

SELECT * FROM departamento WHERE num_matricula_gerente IS NULL;

SELECT * FROM empregado WHERE sex_empregado='F' AND val_salario>1500.00;

SELECT nom_projeto FROM projeto WHERE cod_depto=2;

SELECT cod_projeto, nom_projeto FROM projeto WHERE nom_local IN('BH','RJ','SP');

SELECT DISTINCT nom_local FROM projeto WHERE nom_projeto LIKE '%novo%' OR nom_projeto LIKE '%nova%';

SELECT nom_projeto FROM projeto WHERE nom_projeto LIKE 'criar%' OR nom_projeto LIKE '%2005';

SELECT TOP 1 nom_empregado, val_salario FROM empregado WHERE sig_uf='MG' ORDER BY val_salario DESC;
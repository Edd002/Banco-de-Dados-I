/* 1. Listar o nome dos empregados que estão alocados em projetos (OBS: resolver com IN,
EXISTS e JOIN) */

-- JOIN
select distinct e.nom_empregado
from empregado as e
INNER JOIN alocacao as a on e.num_matricula = a.num_matricula
INNER JOIN projeto as p on a.cod_projeto = p.cod_projeto
--order by e.nom_empregado desc

-- IN
select e.nom_empregado
from empregado as e 
where e.num_matricula IN(
	select a.num_matricula from alocacao as a where a.cod_projeto IN(
		select p.cod_projeto from projeto as p));

-- EXISTS
select e.nom_empregado
from empregado as e
where EXISTS(
	select * from alocacao as a where a.num_matricula = e.num_matricula);


/* 2. Listar o nome dos departamentos que controlam projetos (OBS: resolver com IN, EXISTS e
JOIN) */

-- JOIN
select distinct d.nom_depto
from departamento as d
INNER JOIN projeto as p on d.cod_depto = p.cod_depto;

-- IN
select d.nom_depto
from departamento as d
where d.cod_depto IN(
	select p.cod_depto from projeto as p);

-- EXISTS
select d.nom_depto
from departamento as d
where EXISTS(
	select * from projeto as p where p.cod_depto = d.cod_depto);


/* 3. Listar o nome dos supervisores (OBS: resolver com IN, EXISTS e JOIN) */

-- JOIN
select distinct sup.nom_empregado
from empregado as e
INNER JOIN empregado as sup on e.num_matricula_supervisor = sup.num_matricula;

-- IN
select sup.nom_empregado
from empregado as sup
where sup.num_matricula IN(
	select e.num_matricula_supervisor from empregado as e);

-- EXISTS
select sup.nom_empregado
from empregado as sup
where EXISTS(
	select * from empregado as e where e.num_matricula_supervisor = sup.num_matricula);


/* 4. Listar o nome dos dependentes dos empregados que são gerentes (OBS: resolver com IN,
EXISTS e JOIN) */

-- JOIN
select d.nom_dependente
from dependente as d
INNER JOIN empregado as g on d.num_matricula = g.num_matricula
INNER JOIN departamento as depto on g.num_matricula = depto.num_matricula_gerente;

-- IN
select d.nom_dependente
from dependente as d
where d.num_matricula IN(
	select g.num_matricula from empregado as g where g.num_matricula IN(
	select depto.num_matricula_gerente from departamento as depto));

-- EXISTS
select d.nom_dependente
from dependente as d
where EXISTS(
	select * from empregado as g where d.num_matricula = g.num_matricula AND EXISTS(
	select * from departamento as depto where g.num_matricula = depto.num_matricula_gerente));


/* 5. Listar todos os departamentos que não têm local cadastrado (OBS: resolver com IN, EXISTS
e JOIN) */

-- JOIN
select d.nom_depto
from departamento as d
LEFT JOIN departamento_local as dl on d.cod_depto = dl.cod_depto
where dl.cod_depto IS NULL;

-- IN
select d.nom_depto
from departamento as d
where d.cod_depto NOT IN(
	select dl.cod_depto from departamento_local as dl);

-- EXISTS
select d.nom_depto
from departamento as d
where NOT EXISTS(
	select * from departamento_local as dl where dl.cod_depto = d.cod_depto);


/* 6. Listar o nome do empregado e o nome do respectivo departamento para todos os
empregados que não estão alocados em projetos */
select e.nom_empregado, d.nom_depto
from empregado as e
INNER JOIN departamento as d on e.cod_depto = d.cod_depto
LEFT JOIN alocacao as a on e.num_matricula = a.num_matricula
where a.cod_projeto IS NULL;


/* 7. Listar os projetos nos quais cada alocação de funcionário em projeto é maior do que 5
horas */
select distinct nom_projeto
from projeto as p 
INNER JOIN alocacao as a on p.cod_projeto = a.cod_projeto
where a.num_horas > 5;


/* 8. Listar o nome e a matrícula dos empregados que não têm dependentes e que são
supervisores */
select e.num_matricula, e.nom_empregado
from empregado as e
LEFT JOIN dependente as d on e.num_matricula = d.num_matricula
INNER JOIN empregado as sup on e.num_matricula = sup.num_matricula_supervisor
where d.num_matricula IS NULL;


/* 9. Listar o nome dos departamentos que tem empregados e que controlam projetos */
select distinct nom_depto
from departamento as d
LEFT JOIN empregado as e on d.cod_depto = e.cod_depto
LEFT JOIN alocacao as a on e.num_matricula = a.num_matricula
LEFT JOIN projeto as p on a.cod_projeto = p.cod_projeto
where e.cod_depto IS NOT NULL AND p.cod_projeto IS NOT NULL;


/* 10. Listar o nome, o salário e a UF dos empregados que possuem o salário maior ou
igual do que todos os empregados cuja UF é 'MG' */
select e.nom_empregado, e.val_salario, e.sig_uf from empregado as e
where val_salario >=
	( select MAX(e2.val_salario) from empregado as e2 where e2.sig_uf = 'MG' );


/* 11. Listar o nome, o salário e a UF dos empregados que não são de 'MG' e que possuem o
salário maior ou igual do que todos os empregados cuja UF é 'MG' */
select e.nom_empregado, e.val_salario, e.sig_uf from empregado as e
where e.sig_uf != 'MG' AND val_salario >= 
	( select MAX(e2.val_salario) from empregado as e2 where e2.sig_uf != 'MG' );


/* 12. Listar o nome do empregado, o nome do projeto e o número de horas alocadas, cujas
horas de um empregao alocado em um projeto seja maior do que todas as horas alocadas
de empregados no projeto 2 */
select e.nom_empregado, p.nom_projeto, a.num_horas
from empregado as e
INNER JOIN alocacao as a on e.num_matricula = a.num_matricula
INNER JOIN projeto as p on a.cod_projeto = p.cod_projeto
where a.num_horas >=
	( select SUM(a2.num_horas) from alocacao as a2 where a2.cod_projeto = 2 );


/* 13. Listar o nome, o salário e a UF dos empregados do sexo masculino que possuem o salário
maior do que todos os empregados do sexo feminino */
select e.nom_empregado, e.val_salario, e.sig_uf from empregado as e
where e.sex_empregado = 'M' AND val_salario >= 
	( select MAX(e2.val_salario) from empregado as e2 where e2.sex_empregado = 'F' );


/* 14. Listar os empregados que são supervisores ou que possuem dependentes (utilizar UNION) */
select distinct e.nom_empregado
from empregado as e INNER JOIN empregado as sup
on e.num_matricula = sup.num_matricula_supervisor
UNION
select e.nom_empregado from empregado as e
INNER JOIN dependente as d
on e.num_matricula = d.num_matricula;
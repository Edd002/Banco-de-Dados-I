select p.nom_projeto, d.nom_depto from projeto as p INNER JOIN departamento as d on p.cod_depto = d.cod_depto;

select e.num_matricula, e.nom_empregado, d.nom_depto from empregado as e INNER JOIN departamento as d on e.cod_depto = d.cod_depto;

select e.nom_empregado, d.nom_depto from empregado as e INNER JOIN departamento as d on e.num_matricula = d.num_matricula_gerente;

select e.nom_empregado, d.nom_dependente from empregado as e INNER JOIN dependente as d on e.num_matricula = d.num_matricula;

select e.nom_empregado, sup.nom_empregado as supervisor from empregado as e INNER JOIN empregado as sup on e.num_matricula = sup.num_matricula_supervisor;

select e.num_matricula, e.nom_empregado, d.nom_depto, d.num_matricula_gerente from empregado as e INNER JOIN departamento as d on e.cod_depto = d.cod_depto;

select distinct e.num_matricula_supervisor, sup.nom_empregado from empregado as e INNER JOIN empregado as sup on sup.num_matricula = e.num_matricula_supervisor;

select e.nom_empregado, sup.nom_empregado as supervisor
from empregado as e LEFT JOIN empregado as sup
on sup.num_matricula = e.num_matricula_supervisor;

select e.nom_empregado, COALESCE(CONVERT(varchar, d.nom_depto), '(nao encontrado)') as departamento_que_gerencia
from empregado as e LEFT JOIN departamento as d
on e.num_matricula = d.num_matricula_gerente;

select e.nom_empregado, d.nom_dependente
from empregado as e LEFT JOIN dependente as d on e.num_matricula = d.num_matricula
--where d.num_matricula IS NOT NULL
order by e.nom_empregado asc;

select d.nom_depto, e.nom_empregado
from departamento as d LEFT JOIN empregado as e on d.cod_depto = e.cod_depto;

select p.cod_projeto, p.nom_projeto
from projeto as p LEFT JOIN alocacao as a on p.cod_projeto = a.cod_projeto
where a.cod_projeto IS NULL;

select e.num_matricula, e.nom_empregado
from empregado as e LEFT JOIN departamento as d on e.cod_depto = d.cod_depto
where e.num_matricula <> d.num_matricula_gerente or d.num_matricula_gerente IS NULL;

select e.num_matricula, e.nom_empregado, d.nom_depto, g.num_matricula as num_matricula_gerente, g.nom_empregado
from empregado as e
INNER JOIN departamento as d on e.cod_depto = d.cod_depto
INNER JOIN empregado as g on e.num_matricula = g.num_matricula;

select d.nom_depto, e.nom_empregado as gerente, dl.nom_local
from departamento as d
INNER JOIN empregado as e on d.cod_depto = e.cod_depto
INNER JOIN departamento_local as dl on d.cod_depto = dl.cod_depto
where d.num_matricula_gerente = e.num_matricula;

select p.nom_projeto, d.nom_depto 'Depto que controla o projeto', e.nom_empregado, a.num_horas 'Horas alocadas'
from projeto as p
INNER JOIN departamento as d on p.cod_depto = d.cod_depto
INNER JOIN alocacao as a on a.cod_projeto = p.cod_projeto
INNER JOIN empregado as e on e.num_matricula = a.num_matricula;
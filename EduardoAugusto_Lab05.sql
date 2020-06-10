select COUNT(e.num_matricula) 'total_vendas'
from empregado as e
INNER JOIN departamento as d on e.cod_depto = d.cod_depto
where d.nom_depto = 'vendas';

select MAX(e.val_salario) 'maior', MIN(e.val_salario) 'menor', AVG(e.val_salario) 'media', SUM(e.val_salario) 'soma'
from empregado as e
INNER JOIN departamento as d on e.cod_depto = d.cod_depto
where d.nom_depto = 'informática';

select d.nom_depto, AVG(e.val_salario) 'media'
from empregado as e
INNER JOIN departamento as d on e.cod_depto = d.cod_depto
group by d.nom_depto;

select p.nom_projeto, SUM(a.num_horas) 'total', AVG(a.num_horas) 'media'
from alocacao as a
INNER JOIN projeto as p on a.cod_projeto = p.cod_projeto
group by p.nom_projeto;

select e.sig_uf, e.sex_empregado, COUNT(e.num_matricula) 'total'
from empregado as e
group by e.sig_uf, e.sex_empregado
order by e.sig_uf;

select d.nom_depto, g.nom_empregado 'gerente', AVG(e.val_salario) 'media'
from departamento as d
INNER JOIN empregado as g on d.num_matricula_gerente = g.num_matricula
INNER JOIN empregado as e on d.cod_depto = e.cod_depto
group by d.nom_depto, g.nom_empregado;

select top 2 d.nom_depto, AVG(e.val_salario) 'media'
from departamento as d
INNER JOIN empregado as e on d.cod_depto = e.cod_depto
group by d.nom_depto
order by AVG(e.val_salario) desc;

select d.nom_depto
from departamento as d
INNER JOIN empregado as e on d.cod_depto = e.cod_depto
group by d.nom_depto
having COUNT(e.num_matricula) > 1;

select d.nom_depto, AVG(e.val_salario) 'media'
from departamento as d
INNER JOIN empregado as e on d.cod_depto = e.cod_depto
group by d.nom_depto
having AVG(e.val_salario) > 2000.00;

select d.nom_depto
from departamento as d
INNER JOIN empregado as e on d.cod_depto = e.cod_depto
group by d.nom_depto
having AVG(e.val_salario) > 2200.00;

select p.nom_projeto
from alocacao as a
INNER JOIN projeto as p on a.cod_projeto = p.cod_projeto
group by p.nom_projeto
having AVG(a.num_horas) > 8;

select e.nom_empregado, e.val_salario
from empregado as e
where e.val_salario >
	(select MAX(val_salario) from empregado where cod_depto = 2);

select e.nom_empregado, e.val_salario
from empregado as e
INNER JOIN departamento as d on e.cod_depto = d.cod_depto
where e.val_salario <
	(select AVG(val_salario) from empregado where cod_depto = e.cod_depto);

select e.nom_empregado, p.nom_projeto, a.num_horas
from empregado as e
INNER JOIN alocacao as a on e.num_matricula = a.num_matricula
INNER JOIN projeto as p on a.cod_projeto = p.cod_projeto
where a.num_horas >
	(select AVG(num_horas) from alocacao where a.cod_projeto = cod_projeto);

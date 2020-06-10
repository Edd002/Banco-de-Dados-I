select distinct f.nom_funcionario, s.nom_setor
from funcionario as f
INNER JOIN setor as s on f.cod_setor = s.cod_setor
where s.nom_setor = 'RH';

select so.cod_solicitacao, so.dat_abertura, fu.nom_funcionario, se.nom_setor
from solicitacao as so
INNER JOIN funcionario as fu on so.cod_funcionario = fu.cod_funcionario
INNER JOIN setor as se on se.cod_setor = fu.cod_setor
where so.dat_encerramento IS NOT NULL;

select se.nom_setor, COUNT(fu.cod_funcionario) 'total'
from funcionario as fu
INNER JOIN setor as se on se.cod_setor = fu.cod_setor
group by se.nom_setor
having COUNT(fu.cod_funcionario) > 2;

select nom_setor, COUNT(so.cod_solicitacao)
from setor as se
INNER JOIN funcionario as fu on fu.cod_setor = se.cod_setor
LEFT JOIN solicitacao as so on so.cod_funcionario = fu.cod_funcionario
group by nom_setor;

select fun.cod_funcionario, fun.nom_funcionario
from funcionario as fun
where
	EXISTS
	(select * from solicitacao as sol where fun.cod_funcionario = sol.cod_funcionario)
	AND NOT EXISTS
	(select * from atendimento as ate where fun.cod_funcionario = ate.cod_funcionario);

select fun.nom_funcionario, COUNT(sol.cod_funcionario) 'total'
from funcionario as fun
LEFT JOIN solicitacao as sol on fun.cod_funcionario = sol.cod_funcionario
group by fun.nom_funcionario
order by fun.nom_funcionario asc;

select sol.dsc_assunto, AVG(num_horas) 'media'
from solicitacao as sol
INNER JOIN atendimento as ate on sol.cod_solicitacao = ate.cod_solicitacao
group by sol.dsc_assunto;

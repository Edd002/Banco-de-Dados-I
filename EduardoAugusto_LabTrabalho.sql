select ac.dsc_area_conhecimento, COUNT(t.seq_trabalho) 'total'
from trabalho as t
INNER JOIN area_conhecimento as ac on t.cod_area_conhecimento = ac.cod_area_conhecimento
group by ac.dsc_area_conhecimento;

select t.dsc_titulo, s.dsc_situacao
from trabalho as t
INNER JOIN situacao as s on t.cod_situacao = s.cod_situacao
where t.dsc_titulo LIKE '%direito%';

select a.nom_autor
from autor as a
LEFT JOIN trabalho_autor as ta on a.cod_autor = ta.cod_autor
where ta.cod_autor IS NULL;

select a.nom_autor
from autor as a
LEFT JOIN trabalho_autor as ta on a.cod_autor = ta.cod_autor
group by a.nom_autor
having COUNT(ta.cod_autor) >= 3;

select a.nom_autor 'autor', t.dsc_titulo 'titulo', ap.nom_autor 'parceria'
from trabalho as t
INNER JOIN trabalho_autor as ta on t.seq_trabalho = ta.seq_trabalho
INNER JOIN autor as a on ta.cod_autor = a.cod_autor
INNER JOIN trabalho_autor as tap on t.seq_trabalho = tap.seq_trabalho
INNER JOIN autor as ap on tap.cod_autor = ap.cod_autor
where a.cod_autor <> ap.cod_autor
order by a.nom_autor asc;

select top 1 t.dsc_titulo, COUNT(ta.seq_trabalho) 'total'
from trabalho_autor as ta
INNER JOIN trabalho as t on ta.seq_trabalho = t.seq_trabalho
group by t.dsc_titulo
order by COUNT(ta.seq_trabalho) desc;
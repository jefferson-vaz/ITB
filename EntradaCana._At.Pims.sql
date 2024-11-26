select--Entrada de Cana APT_CARGAS
  a.cd_upnivel1 as fazenda,
  b.da_upnivel1 as propriedade,
  a.cd_upnivel2 as bloco,
  a.cd_upnivel3 as talhao,
  to_char(a.dt_movimento, 'dd/mm/yyyy') as data,
  replace(sum(a.qt_liquido/1000),'.',',') as toneladas_cana
from
  pimscs.apt_cargas a
left join
  pimscs.upnivel1 b on
    a.cd_upnivel1 = b.cd_upnivel1
left join
  pimscs.frentransp c on
    a.cd_fren_tran = c.cd_fren_tran
where
  a.instancia = 2604 and
  a.dt_movimento between to_date('20/03/24', 'dd/mm/yy') and to_date('20/12/24', 'dd/mm/yy') and
  a.dt_movimento is not null
group by
  to_char(a.dt_movimento, 'dd/mm/yyyy'),
  a.cd_upnivel1,
  b.da_upnivel1,
  a.cd_upnivel2,
  a.cd_upnivel3

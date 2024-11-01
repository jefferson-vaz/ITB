select--HistProduc
  trim(a.cd_upnivel1)||case when to_number(trim(a.cd_upnivel2)) < 10 then '0'||trim(a.cd_upnivel2) else trim(a.cd_upnivel2) end||trim(a.cd_upnivel3) as "Layer",
  a.cd_safra as "Safra",
  a.cd_upnivel1 as "Fazenda",
  b.da_upnivel1 as "Propriedade",
  a.cd_upnivel2 as "Bloco",
  a.cd_upnivel3 as "Talhao",
  c.da_estagio as "Estagio Corte",
  c.no_corte as "No.Corte",
  a.cd_fren_tran as "No.Frente Colheita",
  case
    when to_number(a.cd_fren_tran) = 2 then 'Frente 1' --Isto foi um erro de registro que ainda não foi ajustado no sistema
    when to_number(a.cd_fren_tran) = 265 then 'Frente 1'
    when to_number(a.cd_fren_tran) = 266 then 'Frente 2'
    when to_number(a.cd_fren_tran) = 267 then 'Frente 3'
    when to_number(a.cd_fren_tran) = 268 then 'Frente 4'
    when to_number(a.cd_fren_tran) = 273 then 'Frente Rizzi'
    when to_number(a.cd_fren_tran) = 278 then 'Frente Pau DAlho'
    when to_number(a.cd_fren_tran) = 279 then 'Frente Marcinho'
    when to_number(a.cd_fren_tran) = 280 then 'Frente Marcinho (CT Extra)'
    when to_number(a.cd_fren_tran) = 283 then 'Frente Frente Caio Junqueira'
    when to_number(a.cd_fren_tran) = 285 then 'Frente ACP'
    when to_number(a.cd_fren_tran) = 419 then 'Frente Spot (Valdir)'
    when to_number(a.cd_fren_tran) = 409 then 'Frente Spot (Walter)'
    when to_number(a.cd_fren_tran) = 420 then 'Frente Spot (Walter)'
    when to_number(a.cd_fren_tran) = 276 then 'Frente Daltro Reis'
  end as "Frente Colheita",
  case
    when to_number(a.cd_fren_tran) in (265,266,267,268) then 'CTT.Usina'
    when to_number(a.cd_fren_tran) in (273,276,278,283,285,409,419,420) then 'CTT.Terceiro'
    when to_number(a.cd_fren_tran) = 279 then 'CT.Terceiro + T.Usina'
    when to_number(a.cd_fren_tran) = 280 then 'CT.Terc.Extra + T.Usina'
  end as "Estrutura Colheita",
  to_date(a.dt_historico,'dd/mm/yyyy') as "Data",
  sum(a.qt_cana_ent/1000) as "Toneladas Cana"
from
  pimscs.histproduc a 
inner join 
    pimscs.upnivel1 b on
      a.cd_upnivel1 = b.cd_upnivel1
inner join
    pimscs.estagios c on
      a.cd_estagio = c.cd_estagio
where
  a.cd_empresa = 2604 and--Filtrando ITB
  a.dt_historico between to_date('26/03/2024','dd/mm/yyyy') and to_date('20/12/2024','dd/mm/yyyy')--Filtrando Datas consideradas da Produção da Safra 2024
group by
  trim(a.cd_upnivel1)||case when to_number(trim(a.cd_upnivel2)) < 10 then '0'||trim(a.cd_upnivel2) else trim(a.cd_upnivel2) end||trim(a.cd_upnivel3),
  a.cd_safra,
  to_date(a.dt_historico,'dd/mm/yyyy'),
  a.cd_upnivel1,
  b.da_upnivel1,
  a.cd_upnivel2,
  a.cd_upnivel3,
  a.dt_historico,
  c.da_estagio,
  c.no_corte,
  a.cd_fren_tran,
  case
    when to_number(a.cd_fren_tran) = 2 then 'Frente 1' 
    when to_number(a.cd_fren_tran) = 265 then 'Frente 1'
    when to_number(a.cd_fren_tran) = 266 then 'Frente 2'
    when to_number(a.cd_fren_tran) = 267 then 'Frente 3'
    when to_number(a.cd_fren_tran) = 268 then 'Frente 4'
    when to_number(a.cd_fren_tran) = 273 then 'Frente Rizzi'
    when to_number(a.cd_fren_tran) = 278 then 'Frente Pau DAlho'
    when to_number(a.cd_fren_tran) = 279 then 'Frente Marcinho'
    when to_number(a.cd_fren_tran) = 280 then 'Frente Marcinho (CT Extra)'
    when to_number(a.cd_fren_tran) = 283 then 'Frente Frente Caio Junqueira'
    when to_number(a.cd_fren_tran) = 285 then 'Frente ACP'
    when to_number(a.cd_fren_tran) = 419 then 'Frente Spot (Valdir)'
    when to_number(a.cd_fren_tran) = 409 then 'Frente Spot (Walter)'
    when to_number(a.cd_fren_tran) = 420 then 'Frente Spot (Walter)'
    when to_number(a.cd_fren_tran) = 276 then 'Frente Daltro Reis'
  end,
  case
    when to_number(a.cd_fren_tran) in (265,266,267,268) then 'CTT.Usina'
    when to_number(a.cd_fren_tran) in (273,276,278,283,285,409,419,420) then 'CTT.Terceiro'
    when to_number(a.cd_fren_tran) in (279,280) then 'CT.Terceiro + T.Usina'
  end

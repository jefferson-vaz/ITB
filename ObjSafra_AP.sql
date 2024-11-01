select--Obj. de Safra Moagem
    trim(a.cd_upnivel1)||case when to_number(trim(a.cd_upnivel2)) < 10 then '0'||trim(a.cd_upnivel2) else trim(a.cd_upnivel2) end||trim(a.cd_upnivel3) as Layer,
    a.cd_safra as Safra,
    a.cd_upnivel1 as Fazenda,
    b.da_upnivel1 as Propriedade,
    d.de_tp_propr as Tipo_Propriedade,
    a.cd_upnivel2 as Bloco,
    a.cd_upnivel3 as Talhao,
    a.cd_hist as Codigo_Estimativa,
    to_char(a.dt_historico, 'dd/mm/yyyy') as Data_Estimativa, 
    c.da_estagio as Estagio_Corte,
    c.no_corte as No_Corte,
    c.fg_ocorren as Ult_Ocorr_Cad,
    to_date(c.dt_ocorren,'dd/mm/yyyy') as Data_Ult_Ocorr_Cad,
    replace(a.qt_cana_entr/1000,'.',',') as Estimativa,
    replace(round(a.qt_area_prod,2),'.',',') as Area_ha  
from
    pimscs.histprepro a
inner join
    pimscs.upnivel1 b on
        a.cd_upnivel1 = b.cd_upnivel1
left join
    pimscs.safrupniv3 c on
        a.cd_safra = c.cd_safra and
        a.cd_upnivel1 = c.cd_upnivel1 and
        a.cd_upnivel2 = c.cd_upnivel2 and
        a.cd_upnivel3 = c.cd_upnivel3
left join
    pimscs.estagios c on
        a.cd_estagio = c.cd_estagio
left join
    pimscs.tipopropri d on
        a.cd_tp_propr = d.cd_tp_propr
where
    a.cd_empresa = 2604 and
    a.cd_safra >= 2024 and
    a.cd_hist not in ('E','S') and
    a.dt_historico = 
        (
            select
                max(a2.dt_historico)
            from
                pimscs.histprepro a2
            where
                a.cd_safra = a2.cd_safra and
                a.cd_upnivel1 = a2.cd_upnivel1 and
                a.cd_upnivel2 = a2.cd_upnivel2 and
                a.cd_upnivel3 = a2.cd_upnivel3 and
                a2.cd_hist not in ('E','S')
    ) and
    c.dt_ocorren = 
        (
            select
                max(c2.dt_ocorren)
            from
                pimscs.safrupniv3 c2
            where
                c.cd_safra = c2.cd_safra and
                c.cd_upnivel1 = c2.cd_upnivel1 and
                c.cd_upnivel2 = c2.cd_upnivel2 and
                c.cd_upnivel3 = c2.cd_upnivel3
    ) and
        a.qt_area_prod > 0

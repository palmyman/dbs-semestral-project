
set pagesize 1000
set echo on
set markup html on spool on head "<title>BI-DBS - Michal Valenta(valenta) - Výstup SQL příkazů </title> <style type ='text/css'><!--body {background: #ffffc6} --></style>" body "<h2>BI-DBS - středa 14:30, lichý týden, paraleka 1 - Michal Valenta - Výstup SQL příkazů</h2>"
spool queries-log.html

       	
          --KOD DOTAZU: d1
 -- Jména zelených lodi.

SELECT DISTINCT JMENOL
FROM LOD
WHERE BARVA = 'zelená';

 

          --KOD DOTAZU: d2
 -- Jména zákazníků, kteří si rezervovali alespoň jeden modrý parník.

SELECT ZAKAZNIK.JMENOZ, zakaznik.prijmeni 
FROM ZAKAZNIK JOIN REZERVACE USING(ZID)
     JOIN LOD USING(LODID)
WHERE LOD.LTYP = 'parník' AND
      LOD.barva= 'modrá';

 

          --KOD DOTAZU: d3
 -- Seznam typů lodí, které byly na plavbě s průvodcem.

SELECT UNIQUE LTYP 
FROM LOD L JOIN PLAVBA_S_PRUVODCEM PSP ON(L.LODID= PSP.ID_LOD);

 

          --KOD DOTAZU: d4
 -- Lodě (všechny atributy), které pokryly nějaké pravidelné spoje a byly také na některé plavbě s průvodcem.

SELECT L.* 
FROM LOD L 
WHERE L.LODID IN (SELECT LODID
                  FROM POKRYTI P)
INTERSECT
SELECT L.* 
FROM LOD L 
WHERE EXISTS (SELECT 1 FROM PLAVBA_S_PRUVODCEM
              WHERE PLAVBA_S_PRUVODCEM.ID_LOD = L.LODID);

 

          --KOD DOTAZU: d5
 -- Lodě, (všechny atributy), které pokryly nějaký pravidelný spj a neby byly na plavbě s průvodcem.

SELECT L.* 
FROM LOD L JOIN POKRYTI P ON (L.LODID = P.LODID)
UNION
SELECT L.* 
FROM LOD L JOIN PLAVBA_S_PRUVODCEM P ON (L.LODID = P.ID_LOD);

 

          --KOD DOTAZU: d6
 -- Lodě (všechny atributy), které nebyly rezervovány

SELECT * 
FROM LOD L
WHERE L.LODID NOT IN (SELECT LODID
                      FROM REZERVACE);

 

          --KOD DOTAZU: d7
 -- Typy lodí, které pokrývají pouze pravidelné spoje.

Select distinct LTYP from
( Select L.*
  FROM LOD L 
  where exists (select LODID from POKRYTI where pokryti.lodid = l.lodid)
  MINUS
  Select L2.*
  FROM LOD L2 
  where exists (select ID_LOD from PLAVBA_S_PRUVODCEM where plavba_s_pruvodcem.id_lod=l2.lodid )
  MINUS 
  Select L.*
  FROM LOD L 
  where exists (select 1 from REZERVACE R where R.LODID=L.LODID)
);

 

          --KOD DOTAZU: d8
 -- Zákazníci (id_z, jméno), kteří si rezervovali každou zelenou loď.

WITH 
T1  AS (SELECT LODID,ZID
        FROM LOD CROSS JOIN ZAKAZNIK
        WHERE BARVA = 'zelená' ),
T2  AS (SELECT UNIQUE LODID,ZID FROM REZERVACE),
T31 AS (SELECT * FROM  T1 MINUS SELECT * FROM T2),
T32 AS (SELECT UNIQUE ZID FROM T31),
T4  AS (SELECT UNIQUE ZID FROM REZERVACE),
T5  AS (SELECT * From T4 Where T4.ZID Not In (Select ZID From T32)) 
Select *
From T5 Join zakaznik Using(ZID);

 

          --KOD DOTAZU: d9
 -- Dvojice zákazníků, kteří bydlí na stejné adrese.

Select cast(Z1.zid||' '||Z1.jmenoz||' '||Z1.prijmeni||' sousedí s '||
            Z2.zid||' '||Z2.jmenoz||' '||Z1.prijmeni as varchar(60)) as sousede
From zakaznik Z1 Join zakaznik Z2 On (Z1.adresa=Z2.adresa and
                                      Z1.zid < Z2.zid);

 

          --KOD DOTAZU: d10
 -- Průměrný věk lodníků.

Select ROUND(AVG(vek),2)
From namornik;

 

          --KOD DOTAZU: d11
 -- Cekový počet typů lodí, počet různých typů lodí a celkový počet míst na všech lodích.

Select count(distinct ltyp) pocet_typu_lodi
     , count(distinct barva) pocet_ruznych_barev
     , sum(pocet_mist) celkovy_pocet_mist 
From LOD;

 

          --KOD DOTAZU: d12
 -- Lodníci, kteří byli na plavbě s průvodcem méně, než 4 krát.

Select *
From namornik N
Where (Select count(*) 
       From PLAVBA_S_PRUVODCEM PSP
       Where N.nid = PSP.nid) < 4;
-- alternativni reseni
Select nid,N.JMENON,N.VEK,N.HODNOST,N.PLAT
From namornik N Left Outer join PLAVBA_S_PRUVODCEM P Using(nid)
GROUP BY nid, N.JMENON, N.VEK, N.HODNOST, N.PLAT
Having  count(ID_LOD) < 4;

 

          --KOD DOTAZU: d13
 -- Lodníci, kteří pokryli méně než 3 různé pravidelné linky včetně těch, kteří nepokryli žádnou.

Select N.*,
       (Select count(DISTINCT LID) 
        From pokryti P
        Where P.nid = N.nid) pocet_ruznych_linek
From namornik N
Where (Select count(DISTINCT LID) 
       From pokryti P
       Where P.nid = N.nid) < 3;
-- alternativni reseni
SELECT NID,N.JMENON,N.VEK,N.HODNOST,N.PLAT,COUNT(LODID)
FROM NAMORNIK N Left Outer Join POKRYTI P Using (Nid)
GROUP BY NID,N.JMENON,N.VEK,N.HODNOST,N.PLAT
Having count (LODID) < 3;

 

          --KOD DOTAZU: d14
 -- Pro každého lodníka počet jeho plaveb s průvodcem.

Select N.*,
       (Select count(*) 
        From PLAVBA_S_PRUVODCEM PSP
        Where N.nid = PSP.nid) pocet_PSP
From namornik N;
-- alternativa
Select nid,N.JMENON,N.VEK,N.HODNOST,N.PLAT,
       count(ID_LOD) pocet_PSP
From namornik N Left Outer join PLAVBA_S_PRUVODCEM P
     Using(nid)
GROUP BY nid, N.JMENON, N.VEK, N.HODNOST, N.PLAT;

 

          --KOD DOTAZU: d15
 -- Jména lodníků mladších 40 let, kteří mají za sebou alespoň 3 plavby s průvodcem na lodi typu klipr. Výstup bude seřazen dle jmen lodníků.

Select N.nid,N.JMENON
From Namornik N 
Where (Select count(*) 
       From PLAVBA_S_PRUVODCEM PSP Join LOD L On(LODID= ID_LOD)
       Where PSP.nid = N.nid 
             and L.Ltyp ='klipr'
      ) >=3
      and  N.vek <40
order by N.JMENON desc;
-- alternativa
Select nid,N.JMENON
From Namornik N Join PLAVBA_S_PRUVODCEM PSP Using (nid)
     Join lod L On (LODID= ID_LOD)
Where L.Ltyp ='klipr' and N.vek <40
Group By nid,N.JMENON
having count(*) >= 3
order by N.JMENON desc;

 

          --KOD DOTAZU: d16
 -- Námořníkům, kteří mají za sebou alespoň 4 pokrytí spoje zvedněte plat o 15%.

Update namornik N
Set plat = plat * 1.15
where (Select count (lodid)
       From pokryti P
       Where P.nid = N.nid) > 4;

 

          --KOD DOTAZU: d17
 -- K tabulce LODNIK přidám sloupec pocet_plaveb_s_pruvodcem a provedu jednorázový dopočet hodnot tohoto sloupce.

-- pridani sloupce
Alter Table NAMORNIK
Add (pocet_plaveb_s_pruvodcem integer Default 0);
-- dopocitani
Update namornik N
Set pocet_plaveb_s_pruvodcem = (Select count(*)
                                From PLAVBA_S_PRUVODCEM PSP
                                Where PSP.nid=N.nid);
Commit;
-- overeni
select *
from namornik;
-- uklid
alter table namornik drop column pocet_plaveb_s_pruvodcem;
select *
from namornik;

 

          --KOD DOTAZU: d18
 -- Zákazníci, kteří si rezervovali každý parník s počtem míst větším než 150.

set echo on
-- podivejme se na data jmenovatele
select * from zakaznik;
select LODID from lod where ltyp='parník' and POCET_MIST > 150;
-- jak vidno, budeme dělit prázdnou relací
with
  T1 as (select distinct zid,lodid from REZERVACE)
, T2 as (select zid,lodid from 
                              (Select ZID from ZAKAZNIK) cross join 
                              (select LODID from lod where LTYP= 'parník'and POCET_MIST > 150)
            )
, T3 as (select zid,lodid from T2 minus select zid,lodid from T1)
, T4 as ( select distinct ZID from rezervace MINUS select distinct zid from T3 )
Select *
from zakaznik Z natural join T4;

 

          --KOD DOTAZU: d19
 -- Vytvoření pohledu se seznamem spojů, u nichž budou podrobnosti jejich linek.

create or replace view vspoj as
       select lid,linka.strt,linka.cil,
              spoj.spid, spoj.scas
       from spoj natural join linka
       order by lid,spoj.scas;
       
       -- vyber vsechny spoje, ktere by jely dnes po 12. hodine
select strt, cil, trunc(current_date) + scas as kdy
from vspoj
where trunc(current_date) + scas > trunc(current_date) + INTERVAL '12' HOUR(2)
order by scas;


 

          --KOD DOTAZU: d20
 -- Kteří lodníci sloužili na jednotlivých lodích?

select distinct lod.lodid,n.nid
From lod 
     left outer join (SELECT distinct NID, LODID FROM POKRYTI 
                       union 
                      SELECT unique NID, id_lod FROM PLAVBA_S_PRUVODCEM) A
          on (lod.lodid=A.lodid)
     right outer join namornik N on (A.nid=N.nid)
order by lodid, nid;     

 

          --KOD DOTAZU: d21
 -- Seznam rezervací včetně lodí, které nebyly rezervovány a zákazníků, kteří si nic nerezervovali.

SELECT REZERVACE.DATUM_RES,
  ZAKAZNIK.ZID,
  ZAKAZNIK.JMENOZ,
  ZAKAZNIK.PRIJMENI,
  ZAKAZNIK.CREDITLIMIT,
  ZAKAZNIK.ADRESA,
  LOD.LODID,
  LOD.JMENOL,
  LOD.BARVA,
  LOD.LTYP,
  LOD.POCET_MIST
FROM ZAKAZNIK LEFT OUTER JOIN REZERVACE ON ZAKAZNIK.ZID = REZERVACE.ZID
     FULL OUTER JOIN LOD ON LOD.LODID = REZERVACE.LODID
order by datum_res, zakaznik.prijmeni,zakaznik.jmenoz,lod.jmenol;
 

          --KOD DOTAZU: d22
 -- Seznam linek, které jsou pokryty pouze autobusem SPZ101

-- Seznam linek, které jsou pokryty pouze autobusem SPZ101 
SELECT distinct LINKA.LID, STRT,CIL
FROM LINKA
           INNER JOIN SPOJ ON LINKA.LID = SPOJ.LID 
           INNER JOIN POKRYTI ON SPOJ.LID  = POKRYTI.LID
                                 AND SPOJ.SPID = POKRYTI.SPID
           INNER JOIN AUTOBUS ON AUTOBUS.INV_CISLO = POKRYTI.INV_CISLO
                                 AND SPZ='SPZ101'
MINUS
SELECT distinct LINKA.LID, STRT,CIL
FROM LINKA
           INNER JOIN SPOJ ON LINKA.LID = SPOJ.LID 
           INNER JOIN POKRYTI ON SPOJ.LID    = POKRYTI.LID
                                 AND SPOJ.SPID = POKRYTI.SPID
           INNER JOIN AUTOBUS ON AUTOBUS.INV_CISLO = POKRYTI.INV_CISLO
                                 AND SPZ != 'SPZ101';
          
 

          --KOD DOTAZU: d23
 -- Seznam námořníků, kteří jsou volní dne 23.09.2013 od 8 do 14 hod.


alter session set nls_date_format = 'dd.mm.yyyy hh24:mi';
select *
from namornik
where nid in ( select distinct nid
               from kalendar_namornika
               where od not in ('23.09.2013 08:00', '23.09.2013 14:00')
             );
          
 

          --KOD DOTAZU: d24
 -- Seznam lodí, které jsou volné dne 23.09.2013 od 8 do 14 hod. a mají kapacitu od 10 do 25 míst.


alter session set nls_date_format = 'dd.mm.yyyy hh24:mi';
select distinct lodid
from lod l1
where lodid not in (select lodid
                    from rezervace 
                    where datum_res = '23.09.2013')
      and not exists (select lodid
                      from pokryti p
                      where l1.lodid = p.lodid
                            and p.DATUM_POKRYTI = '23.09.2013'
                            and ( p.od    in ('23.09.2013 08:00', '23.09.2013 14:00')
                                  or p.do in ('23.09.2013 08:00', '23.09.2013 14:00')
                                )
                     )
      and l1.pocet_mist in (10,25);

 

          --KOD DOTAZU: d25
 -- Přidejte novou plavbu s průvodcem pro zákazníka s příjmením Scott a jménem Scott na 23.09.2013 od 8 do 14 hod.

 -- Nasaďte na to loď, která je na tu dobu volná a má kapacitu 10 až 25 míst.

 -- Nasaďte na to kteréhokoliv námořníka, který je na tuto dobu volný.

alter session set nls_date_format = 'dd.mm.yyyy hh24:mi';
-- set autocommit off
-- nejdrive je nutne vyplnit kalendar namornika
INSERT
INTO KALENDAR_NAMORNIKA (NID,OD,DO)
VALUES( (select  nid 
         from kalendar_namornika
         where od not in ('23.09.2013 08:00', '23.09.2013 14:00') 
               and rownum =1
        ),
        '23.09.2013 08:00', 
        '23.09.2013 14:00'
      );
-- zaplanovani plavby
INSERT
INTO PLAVBA_S_PRUVODCEM( NID,OD,DO,ID_LOD,ZID)
VALUES ( (select  nid 
          from kalendar_namornika
          where od ='23.09.2013 08:00' and do= '23.09.2013 14:00'
                and rownum=1
         ),
         '23.09.2013 08:00',
         '23.09.2013 14:00',
         ( select distinct lodid
           from lod l1
           where lodid not in ( select lodid
                                from rezervace 
                                where datum_res = '23.09.2013')
                 and not exists ( select lodid
                                  from pokryti p
                                  where l1.lodid = p.lodid
                                        and p.DATUM_POKRYTI = '23.09.2013'
                                        and (    p.od in ('23.09.2013 08:00', '23.09.2013 14:00')
                                              or p.do in ('23.09.2013 08:00', '23.09.2013 14:00')
                                            )
                                )                               
                 and l1.pocet_mist in (10,25) 
                 and rownum = 1
         ),
         ( SELECT ZID
           FROM ZAKAZNIK 
           WHERE prijmeni='Scott' and jmenoz='Scott' and rownum=1
         )
       );
rollback;
           
 

set markup html off
spool off

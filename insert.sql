--------------------------------------------------------
--  File created - Čtvrtek-září-12-2013   
--------------------------------------------------------
set echo on
create or replace 
PROCEDURE ZAPNI_CIZI_KLICE AS 
BEGIN
  FOR cur IN (select CONSTRAINT_NAME, TABLE_NAME 
             from USER_CONSTRAINTS
       where CONSTRAINT_TYPE = 'R' ) 
  LOOP
   execute immediate 'ALTER TABLE '||cur.table_name||' MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE ';
  END LOOP;
END ZAPNI_CIZI_KLICE;
/
create or replace 
PROCEDURE VYPNI_CIZI_KLICE AS 
BEGIN
  for CUR in (select CONSTRAINT_NAME , TABLE_NAME 
       from USER_CONSTRAINTS
       where CONSTRAINT_TYPE = 'R' ) 
   LOOP
    execute immediate 'ALTER TABLE '||cur.table_name||' MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE ';
   END LOOP;
END VYPNI_CIZI_KLICE;
/
create or replace 
PROCEDURE VYMAZ_DATA_VSECH_TABULEK IS
BEGIN
  VYPNI_CIZI_KLICE;
  FOR V_REC IN (SELECT DISTINCT(TABLE_NAME) FROM USER_TABLES)
      LOOP
      EXECUTE IMMEDIATE 'truncate table '||V_REC.TABLE_NAME||' drop storage';
      END LOOP;
  ZAPNI_CIZI_KLICE;
END VYMAZ_DATA_VSECH_TABULEK;
/
set echo on
set autocommit on
execute VYMAZ_DATA_VSECH_TABULEK()
--
set autocommit on

SET ECHO ON
SET DEFINE OFF;

REM INSERTING into ZAKAZNIK
SET DEFINE OFF;
Insert into ZAKAZNIK (ZID,PRIJMENI,JMENOZ,ADRESA,CREDITLIMIT) values ('1','Ford','Ford','Fordovice 10','100');
Insert into ZAKAZNIK (ZID,PRIJMENI,JMENOZ,ADRESA,CREDITLIMIT) values ('2','Smith','Smith','Smithovice 10','110');
Insert into ZAKAZNIK (ZID,PRIJMENI,JMENOZ,ADRESA,CREDITLIMIT) values ('3','Blake','Blake','Blakeovice 10','120');
Insert into ZAKAZNIK (ZID,PRIJMENI,JMENOZ,ADRESA,CREDITLIMIT) values ('4','Allen','Allen','Allenovice 10','300');
Insert into ZAKAZNIK (ZID,PRIJMENI,JMENOZ,ADRESA,CREDITLIMIT) values ('5','Ward','Ward','Wardovice 10','310');
Insert into ZAKAZNIK (ZID,PRIJMENI,JMENOZ,ADRESA,CREDITLIMIT) values ('6','Martin','Martin','Martinovice 10','330');
Insert into ZAKAZNIK (ZID,PRIJMENI,JMENOZ,ADRESA,CREDITLIMIT) values ('7','Scott','Scott','Scottovice','400');
Insert into ZAKAZNIK (ZID,PRIJMENI,JMENOZ,ADRESA,CREDITLIMIT) values ('8','Turner','Turner','Turnerovice','440');
Insert into ZAKAZNIK (ZID,PRIJMENI,JMENOZ,ADRESA,CREDITLIMIT) values ('9','Adams','Adams','Adamsovice','550');
Insert into ZAKAZNIK (ZID,PRIJMENI,JMENOZ,ADRESA,CREDITLIMIT) values ('10','James','James','Jamesovice','1000');
Insert into ZAKAZNIK (ZID,PRIJMENI,JMENOZ,ADRESA,CREDITLIMIT) values ('11','Syn Krétheův','Iásón','Iólkos','1500');
Insert into ZAKAZNIK (ZID,PRIJMENI,JMENOZ,ADRESA,CREDITLIMIT) values ('12','Laertiadés ','Odysseus','Ithaka 1','1700');

REM INSERTING into ZAZEMI
Insert into ZAZEMI (ID_ZAZEMI,ADRESA,POCET_STANI,UROVEN_MOZNYCH_OPRAV,POCET_OPRAVNYCH_DOKU,POCET_KOTVIST) values ('199','Depo1','40','5',null,null);
Insert into ZAZEMI (ID_ZAZEMI,ADRESA,POCET_STANI,UROVEN_MOZNYCH_OPRAV,POCET_OPRAVNYCH_DOKU,POCET_KOTVIST) values ('299','Depo2','40','4',null,null);
Insert into ZAZEMI (ID_ZAZEMI,ADRESA,POCET_STANI,UROVEN_MOZNYCH_OPRAV,POCET_OPRAVNYCH_DOKU,POCET_KOTVIST) values ('399','Depo3','20','1',null,null);
Insert into ZAZEMI (ID_ZAZEMI,ADRESA,POCET_STANI,UROVEN_MOZNYCH_OPRAV,POCET_OPRAVNYCH_DOKU,POCET_KOTVIST) values ('499','Depo4','20','1',null,null);
Insert into ZAZEMI (ID_ZAZEMI,ADRESA,POCET_STANI,UROVEN_MOZNYCH_OPRAV,POCET_OPRAVNYCH_DOKU,POCET_KOTVIST) values ('599','Přístaviště5',null,null,'10','5');
Insert into ZAZEMI (ID_ZAZEMI,ADRESA,POCET_STANI,UROVEN_MOZNYCH_OPRAV,POCET_OPRAVNYCH_DOKU,POCET_KOTVIST) values ('699','Přístaviště6',null,null,'5','10');
Insert into ZAZEMI (ID_ZAZEMI,ADRESA,POCET_STANI,UROVEN_MOZNYCH_OPRAV,POCET_OPRAVNYCH_DOKU,POCET_KOTVIST) values ('799','Přístaviště7',null,null,'7','14');
Insert into ZAZEMI (ID_ZAZEMI,ADRESA,POCET_STANI,UROVEN_MOZNYCH_OPRAV,POCET_OPRAVNYCH_DOKU,POCET_KOTVIST) values ('899','Přístaviště2',null,null,'6','15');
Insert into ZAZEMI (ID_ZAZEMI,ADRESA,POCET_STANI,UROVEN_MOZNYCH_OPRAV,POCET_OPRAVNYCH_DOKU,POCET_KOTVIST) values ('999','Přístaviště3',null,null,'6','15');

REM INSERTING into AUTOBUS
Insert into AUTOBUS (INV_CISLO,SPZ,POCET_MIST,DATUM_UVEDENI_DO_PROVOZU,PORIZOVACI_CENA,ID_ZAZEMI) values ('1099','SPZ101','35',to_date('21.10.2005 00:00','DD.MM.YYYY HH24:MI'),'200000','199');
Insert into AUTOBUS (INV_CISLO,SPZ,POCET_MIST,DATUM_UVEDENI_DO_PROVOZU,PORIZOVACI_CENA,ID_ZAZEMI) values ('1199','SPZ102','35',to_date('21.10.2005 00:00','DD.MM.YYYY HH24:MI'),'200000','199');
Insert into AUTOBUS (INV_CISLO,SPZ,POCET_MIST,DATUM_UVEDENI_DO_PROVOZU,PORIZOVACI_CENA,ID_ZAZEMI) values ('1299','SPZ103','35',to_date('21.10.2005 00:00','DD.MM.YYYY HH24:MI'),'200000','299');
Insert into AUTOBUS (INV_CISLO,SPZ,POCET_MIST,DATUM_UVEDENI_DO_PROVOZU,PORIZOVACI_CENA,ID_ZAZEMI) values ('1399','SPZ104','40',to_date('21.10.2007 00:00','DD.MM.YYYY HH24:MI'),'300000','299');
Insert into AUTOBUS (INV_CISLO,SPZ,POCET_MIST,DATUM_UVEDENI_DO_PROVOZU,PORIZOVACI_CENA,ID_ZAZEMI) values ('1499','SPZ105','40',to_date('21.10.2007 00:00','DD.MM.YYYY HH24:MI'),'300000','299');
Insert into AUTOBUS (INV_CISLO,SPZ,POCET_MIST,DATUM_UVEDENI_DO_PROVOZU,PORIZOVACI_CENA,ID_ZAZEMI) values ('1599','SPZ106','40',to_date('21.10.2007 00:00','DD.MM.YYYY HH24:MI'),'300000','399');
Insert into AUTOBUS (INV_CISLO,SPZ,POCET_MIST,DATUM_UVEDENI_DO_PROVOZU,PORIZOVACI_CENA,ID_ZAZEMI) values ('1699','SPZ107','45',to_date('21.10.2009 00:00','DD.MM.YYYY HH24:MI'),'350000','399');
Insert into AUTOBUS (INV_CISLO,SPZ,POCET_MIST,DATUM_UVEDENI_DO_PROVOZU,PORIZOVACI_CENA,ID_ZAZEMI) values ('1799','SPZ108','45',to_date('21.10.2009 00:00','DD.MM.YYYY HH24:MI'),'350000','499');
Insert into AUTOBUS (INV_CISLO,SPZ,POCET_MIST,DATUM_UVEDENI_DO_PROVOZU,PORIZOVACI_CENA,ID_ZAZEMI) values ('1899','SPZ109','45',to_date('21.10.2009 00:00','DD.MM.YYYY HH24:MI'),'350000','499');
Insert into AUTOBUS (INV_CISLO,SPZ,POCET_MIST,DATUM_UVEDENI_DO_PROVOZU,PORIZOVACI_CENA,ID_ZAZEMI) values ('1999','SPZ110','35',to_date('21.10.2005 00:00','DD.MM.YYYY HH24:MI'),'200000','499');

REM INSERTING into LOD
Insert into LOD (LODID,JMENOL,LTYP,BARVA,POCET_MIST,ID_ZAZEMI) values ('1','Chloe','ponorka','žlutá','100','599');
Insert into LOD (LODID,JMENOL,LTYP,BARVA,POCET_MIST,ID_ZAZEMI) values ('2','Mariane','klipr','modrá','50','699');
Insert into LOD (LODID,JMENOL,LTYP,BARVA,POCET_MIST,ID_ZAZEMI) values ('3','Skyla','ponorka','černá','30','599');
Insert into LOD (LODID,JMENOL,LTYP,BARVA,POCET_MIST,ID_ZAZEMI) values ('4','Pooh','plachetnice','hnědá','20','799');
Insert into LOD (LODID,JMENOL,LTYP,BARVA,POCET_MIST,ID_ZAZEMI) values ('5','Shark','ponorka','pink','22','599');
Insert into LOD (LODID,JMENOL,LTYP,BARVA,POCET_MIST,ID_ZAZEMI) values ('6','Carmen','klipr','zelená','100','699');
Insert into LOD (LODID,JMENOL,LTYP,BARVA,POCET_MIST,ID_ZAZEMI) values ('7','Yeanifer','parník','černá','110','899');
Insert into LOD (LODID,JMENOL,LTYP,BARVA,POCET_MIST,ID_ZAZEMI) values ('8','Charibda','parník','modrá','145','899');
Insert into LOD (LODID,JMENOL,LTYP,BARVA,POCET_MIST,ID_ZAZEMI) values ('9','Anne',null,'zelená','100','899');
Insert into LOD (LODID,JMENOL,LTYP,BARVA,POCET_MIST,ID_ZAZEMI) values ('10','Lilien','klipr','modrá','10','699');
Insert into LOD (LODID,JMENOL,LTYP,BARVA,POCET_MIST,ID_ZAZEMI) values ('11','Anička','plachetnice','růžová','10','799');
Insert into LOD (LODID,JMENOL,LTYP,BARVA,POCET_MIST,ID_ZAZEMI) values ('13','LodProPriklad7.1','typProPriklad7','zrzavá','25',null);
Insert into LOD (LODID,JMENOL,LTYP,BARVA,POCET_MIST,ID_ZAZEMI) values ('14','LodProPriklad7.2','typProPriklad7','zelená','25',null);

REM INSERTING into NAMORNIK
Insert into NAMORNIK (NID,JMENON,VEK,HODNOST,PLAT) values ('1','Dustin','45','7','7000');
Insert into NAMORNIK (NID,JMENON,VEK,HODNOST,PLAT) values ('2','Lubber','55','8','3000');
Insert into NAMORNIK (NID,JMENON,VEK,HODNOST,PLAT) values ('3','Rusty','35','10','6000');
Insert into NAMORNIK (NID,JMENON,VEK,HODNOST,PLAT) values ('4','Yuppy','35','9','2000');
Insert into NAMORNIK (NID,JMENON,VEK,HODNOST,PLAT) values ('5','Guppy','35','5','4500');
Insert into NAMORNIK (NID,JMENON,VEK,HODNOST,PLAT) values ('6','Zorba','16','10','7500');
Insert into NAMORNIK (NID,JMENON,VEK,HODNOST,PLAT) values ('7','Horatio','35','7','2500');
Insert into NAMORNIK (NID,JMENON,VEK,HODNOST,PLAT) values ('8','Brutus','33','1','1350');
Insert into NAMORNIK (NID,JMENON,VEK,HODNOST,PLAT) values ('9','Marco','26','2','5200');
Insert into NAMORNIK (NID,JMENON,VEK,HODNOST,PLAT) values ('10','John','118','6','14000');
Insert into NAMORNIK (NID,JMENON,VEK,HODNOST,PLAT) values ('11','Charon','999','4','6800');
Insert into NAMORNIK (NID,JMENON,VEK,HODNOST,PLAT) values ('13','Halaska','12000','1',null);

REM INSERTING into KALENDAR_NAMORNIKA
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('1',to_date('01.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('2',to_date('24.12.2000 14:00','DD.MM.YYYY HH24:MI'),to_date('24.12.2000 22:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('2',to_date('01.01.2001 06:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 14:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('2',to_date('01.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('2',to_date('02.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('02.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('2',to_date('03.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('03.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('2',to_date('04.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('04.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('3',to_date('24.12.2000 06:00','DD.MM.YYYY HH24:MI'),to_date('24.12.2000 14:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('3',to_date('01.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('3',to_date('01.01.2001 14:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 22:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('3',to_date('02.01.2001 14:00','DD.MM.YYYY HH24:MI'),to_date('02.01.2001 22:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('4',to_date('24.12.2000 06:00','DD.MM.YYYY HH24:MI'),to_date('24.12.2000 14:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('4',to_date('01.01.2001 14:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 22:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('6',to_date('01.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('6',to_date('02.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('02.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('6',to_date('03.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('03.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('6',to_date('04.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('04.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('6',to_date('05.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('05.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('6',to_date('06.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('06.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('6',to_date('07.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('07.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('7',to_date('01.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('8',to_date('10.07.2000 06:00','DD.MM.YYYY HH24:MI'),to_date('10.07.2000 14:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('8',to_date('24.12.2000 14:00','DD.MM.YYYY HH24:MI'),to_date('24.12.2000 22:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('8',to_date('01.01.2001 06:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 14:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('8',to_date('02.01.2001 06:00','DD.MM.YYYY HH24:MI'),to_date('02.01.2001 14:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('9',to_date('24.12.2000 06:00','DD.MM.YYYY HH24:MI'),to_date('24.12.2000 14:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('9',to_date('01.01.2001 06:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 14:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('9',to_date('01.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('9',to_date('02.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('02.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('9',to_date('03.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('03.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('9',to_date('04.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('04.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('9',to_date('05.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('05.01.2001 18:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('10',to_date('24.12.2000 06:00','DD.MM.YYYY HH24:MI'),to_date('24.12.2000 14:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('10',to_date('01.01.2001 06:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 14:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('11',to_date('08.09.2000 06:00','DD.MM.YYYY HH24:MI'),to_date('08.09.2000 14:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('11',to_date('24.12.2000 06:00','DD.MM.YYYY HH24:MI'),to_date('24.12.2000 14:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('11',to_date('01.01.2001 06:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 14:00','DD.MM.YYYY HH24:MI'));
Insert into KALENDAR_NAMORNIKA (NID,OD,DO) values ('11',to_date('02.01.2001 14:00','DD.MM.YYYY HH24:MI'),to_date('02.01.2001 22:00','DD.MM.YYYY HH24:MI'));

REM INSERTING into LINKA
Insert into LINKA (LID,STRT,CIL) values ('1','Horní Planá','Hůrka');
Insert into LINKA (LID,STRT,CIL) values ('2','Hůrka','Jestřabí');
Insert into LINKA (LID,STRT,CIL) values ('3','Karlovy Dvory','Radislav');
Insert into LINKA (LID,STRT,CIL) values ('4','Dolní Vlatavice','Kyselov');
Insert into LINKA (LID,STRT,CIL) values ('5','Hrustice','Větrník');
Insert into LINKA (LID,STRT,CIL) values ('6','Lipno','Nové Domky');
Insert into LINKA (LID,STRT,CIL) values ('7','Nová Pec','Hůrka');
Insert into LINKA (LID,STRT,CIL) values ('8','Kyselov','Kovářov');
Insert into LINKA (LID,STRT,CIL) values ('9','Jenišov','Bližší Lhota');
Insert into LINKA (LID,STRT,CIL) values ('10','Zadní Hamry','Olšina');
Insert into LINKA (LID,STRT,CIL) values ('11','Narodní divadlo','Střelecký ostrov');
Insert into LINKA (LID,STRT,CIL) values ('101','Nádraží Hostivař','Tolstého');
Insert into LINKA (LID,STRT,CIL) values ('138','Skalka','Spořilov');
Insert into LINKA (LID,STRT,CIL) values ('177','Chodov','Poliklinika Mazurská');
Insert into LINKA (LID,STRT,CIL) values ('195','Sídliště Čakovice','Jesenická');
Insert into LINKA (LID,STRT,CIL) values ('175','Florenc','Skalka');
Insert into LINKA (LID,STRT,CIL) values ('263','Depo Hostivař','Bezděkovská');
Insert into LINKA (LID,STRT,CIL) values ('131','Bořislavka','Hradčanská');
Insert into LINKA (LID,STRT,CIL) values ('119','Dejvická','Letiště');
Insert into LINKA (LID,STRT,CIL) values ('135','Florenc','Koleje Jižní Město');
Insert into LINKA (LID,STRT,CIL) values ('118','Sídliště Spořilov','Smíchovské nádraží');

REM INSERTING into SPOJ
Insert into SPOJ (LID,SPID,SCAS) values ('1','1','0 5:30:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('1','2','0 7:50:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('1','3','0 11:25:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('1','4','0 15:50:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('1','5','0 18:0:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('2','1','0 12:0:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('2','2','0 13:10:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('2','3','0 22:20:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('3','1','0 9:10:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('3','2','0 18:45:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('3','3','0 23:0:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('4','1','0 2:10:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('4','2','0 5:55:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('4','3','0 19:35:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('5','1','0 8:0:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('6','1','0 9:20:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('7','1','0 12:12:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('8','1','0 19:35:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('9','1','0 23:59:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('101','1','0 4:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('101','2','0 5:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('101','3','0 5:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('101','4','0 5:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('101','5','0 6:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('101','6','0 6:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('101','7','0 6:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('101','8','0 6:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','1','0 4:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','2','0 5:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','3','0 5:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','4','0 5:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','5','0 6:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','6','0 6:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','7','0 6:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','8','0 6:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','9','0 7:9:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','10','0 7:19:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('101','12','0 14:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('101','13','0 15:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('101','14','0 15:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('101','15','0 15:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('101','16','0 16:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('101','17','0 16:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('101','18','0 16:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('101','19','0 16:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','12','0 14:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','13','0 15:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','14','0 15:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','15','0 15:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','16','0 16:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','17','0 16:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','18','0 16:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','19','0 16:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','20','0 17:9:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('138','21','0 17:19:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('118','1','0 4:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('118','2','0 5:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('118','3','0 5:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('118','4','0 5:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('118','5','0 6:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('118','6','0 6:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('118','7','0 6:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('118','8','0 6:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('118','12','0 14:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('118','13','0 15:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('118','14','0 15:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('118','15','0 15:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('118','16','0 16:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('118','17','0 16:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('118','18','0 16:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('118','19','0 16:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('119','1','0 4:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('119','2','0 5:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('119','3','0 5:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('119','4','0 5:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('119','5','0 6:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('119','6','0 6:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('119','7','0 6:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('119','8','0 6:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('119','12','0 14:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('119','13','0 15:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('119','14','0 15:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('119','15','0 15:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('119','16','0 16:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('119','17','0 16:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('119','18','0 16:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('119','19','0 16:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('131','1','0 4:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('131','2','0 5:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('131','3','0 5:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('131','4','0 5:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('131','5','0 6:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('131','6','0 6:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('131','7','0 6:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('131','8','0 6:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('131','12','0 14:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('131','13','0 15:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('131','14','0 15:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('131','15','0 15:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('131','16','0 16:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('131','17','0 16:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('131','18','0 16:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('131','19','0 16:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('135','1','0 4:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('135','2','0 5:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('135','3','0 5:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('135','4','0 5:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('135','5','0 6:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('135','6','0 6:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('135','7','0 6:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('135','8','0 6:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('135','12','0 14:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('135','13','0 15:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('135','14','0 15:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('135','15','0 15:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('135','16','0 16:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('135','17','0 16:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('135','18','0 16:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('135','19','0 16:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('175','1','0 4:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('175','2','0 5:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('175','3','0 5:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('175','4','0 5:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('175','5','0 6:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('175','6','0 6:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('175','7','0 6:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('175','8','0 6:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('175','12','0 14:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('175','13','0 15:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('175','14','0 15:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('175','15','0 15:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('175','16','0 16:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('175','17','0 16:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('175','18','0 16:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('175','19','0 16:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('177','1','0 4:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('177','2','0 5:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('177','3','0 5:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('177','4','0 5:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('177','5','0 6:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('177','6','0 6:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('177','7','0 6:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('177','8','0 6:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('177','12','0 14:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('177','13','0 15:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('177','14','0 15:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('177','15','0 15:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('177','16','0 16:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('177','17','0 16:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('177','18','0 16:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('177','19','0 16:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('195','1','0 4:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('195','2','0 5:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('195','3','0 5:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('195','4','0 5:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('195','5','0 6:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('195','6','0 6:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('195','7','0 6:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('195','8','0 6:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('195','12','0 14:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('195','13','0 15:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('195','14','0 15:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('195','15','0 15:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('195','16','0 16:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('195','17','0 16:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('195','18','0 16:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('195','19','0 16:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('263','1','0 4:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('263','2','0 5:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('263','3','0 5:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('263','4','0 5:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('263','5','0 6:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('263','6','0 6:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('263','7','0 6:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('263','8','0 6:56:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('263','12','0 14:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('263','13','0 15:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('263','14','0 15:31:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('263','15','0 15:51:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('263','16','0 16:11:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('263','17','0 16:26:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('263','18','0 16:41:0.0');
Insert into SPOJ (LID,SPID,SCAS) values ('263','19','0 16:56:0.0');

REM INSERTING into PLAVBA_S_PRUVODCEM
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('1',to_date('01.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 18:00','DD.MM.YYYY HH24:MI'),'8','2');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('2',to_date('01.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 18:00','DD.MM.YYYY HH24:MI'),'9','4');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('2',to_date('02.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('02.01.2001 18:00','DD.MM.YYYY HH24:MI'),'9','4');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('2',to_date('03.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('03.01.2001 18:00','DD.MM.YYYY HH24:MI'),'9','4');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('2',to_date('04.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('04.01.2001 18:00','DD.MM.YYYY HH24:MI'),'9','4');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('3',to_date('01.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 18:00','DD.MM.YYYY HH24:MI'),'2','6');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('6',to_date('01.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 18:00','DD.MM.YYYY HH24:MI'),'1','1');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('6',to_date('02.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('02.01.2001 18:00','DD.MM.YYYY HH24:MI'),'1','1');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('6',to_date('03.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('03.01.2001 18:00','DD.MM.YYYY HH24:MI'),'1','1');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('6',to_date('04.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('04.01.2001 18:00','DD.MM.YYYY HH24:MI'),'1','1');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('6',to_date('05.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('05.01.2001 18:00','DD.MM.YYYY HH24:MI'),'1','1');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('6',to_date('06.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('06.01.2001 18:00','DD.MM.YYYY HH24:MI'),'1','1');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('6',to_date('07.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('07.01.2001 18:00','DD.MM.YYYY HH24:MI'),'1','1');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('7',to_date('01.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 18:00','DD.MM.YYYY HH24:MI'),'6','3');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('9',to_date('01.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 18:00','DD.MM.YYYY HH24:MI'),'10','5');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('9',to_date('02.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('02.01.2001 18:00','DD.MM.YYYY HH24:MI'),'10','5');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('9',to_date('03.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('03.01.2001 18:00','DD.MM.YYYY HH24:MI'),'10','5');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('9',to_date('04.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('04.01.2001 18:00','DD.MM.YYYY HH24:MI'),'10','5');
Insert into PLAVBA_S_PRUVODCEM (NID,OD,DO,ID_LOD,ZID) values ('9',to_date('05.01.2001 07:00','DD.MM.YYYY HH24:MI'),to_date('05.01.2001 18:00','DD.MM.YYYY HH24:MI'),'10','5');

REM INSERTING into POKRYTI
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'8',null,'8',to_date('01.01.2001 06:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 14:00','DD.MM.YYYY HH24:MI'),'1','2');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('08.09.2000 00:00','DD.MM.YYYY HH24:MI'),'1',null,'11',to_date('08.09.2000 06:00','DD.MM.YYYY HH24:MI'),to_date('08.09.2000 14:00','DD.MM.YYYY HH24:MI'),'1','1');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('02.01.2001 00:00','DD.MM.YYYY HH24:MI'),'1',null,'11',to_date('02.01.2001 14:00','DD.MM.YYYY HH24:MI'),to_date('02.01.2001 22:00','DD.MM.YYYY HH24:MI'),'2','3');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('24.12.2000 00:00','DD.MM.YYYY HH24:MI'),'9',null,'3',to_date('24.12.2000 06:00','DD.MM.YYYY HH24:MI'),to_date('24.12.2000 14:00','DD.MM.YYYY HH24:MI'),'4','2');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'2',null,'2',to_date('01.01.2001 06:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 14:00','DD.MM.YYYY HH24:MI'),'1','3');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'5',null,'3',to_date('01.01.2001 14:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 22:00','DD.MM.YYYY HH24:MI'),'1','4');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'9',null,'9',to_date('01.01.2001 06:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 14:00','DD.MM.YYYY HH24:MI'),'2','1');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('02.01.2001 00:00','DD.MM.YYYY HH24:MI'),'2',null,'3',to_date('02.01.2001 14:00','DD.MM.YYYY HH24:MI'),to_date('02.01.2001 22:00','DD.MM.YYYY HH24:MI'),'3','2');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('24.12.2000 00:00','DD.MM.YYYY HH24:MI'),'8',null,'8',to_date('24.12.2000 14:00','DD.MM.YYYY HH24:MI'),to_date('24.12.2000 22:00','DD.MM.YYYY HH24:MI'),'3','3');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('24.12.2000 00:00','DD.MM.YYYY HH24:MI'),'1',null,'2',to_date('24.12.2000 14:00','DD.MM.YYYY HH24:MI'),to_date('24.12.2000 22:00','DD.MM.YYYY HH24:MI'),'4','3');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('24.12.2000 00:00','DD.MM.YYYY HH24:MI'),'5',null,'9',to_date('24.12.2000 06:00','DD.MM.YYYY HH24:MI'),to_date('24.12.2000 14:00','DD.MM.YYYY HH24:MI'),'6','1');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('24.12.2000 00:00','DD.MM.YYYY HH24:MI'),'1',null,'11',to_date('24.12.2000 06:00','DD.MM.YYYY HH24:MI'),to_date('24.12.2000 14:00','DD.MM.YYYY HH24:MI'),'1','1');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('24.12.2000 00:00','DD.MM.YYYY HH24:MI'),'6',null,'10',to_date('24.12.2000 06:00','DD.MM.YYYY HH24:MI'),to_date('24.12.2000 14:00','DD.MM.YYYY HH24:MI'),'7','1');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'6',null,'4',to_date('01.01.2001 14:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 22:00','DD.MM.YYYY HH24:MI'),'1','5');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('10.07.2000 00:00','DD.MM.YYYY HH24:MI'),'8',null,'8',to_date('10.07.2000 06:00','DD.MM.YYYY HH24:MI'),to_date('10.07.2000 14:00','DD.MM.YYYY HH24:MI'),'1','1');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('02.01.2001 00:00','DD.MM.YYYY HH24:MI'),'8',null,'8',to_date('02.01.2001 06:00','DD.MM.YYYY HH24:MI'),to_date('02.01.2001 14:00','DD.MM.YYYY HH24:MI'),'3','1');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('24.12.2000 00:00','DD.MM.YYYY HH24:MI'),'5',null,'11',to_date('24.12.2000 06:00','DD.MM.YYYY HH24:MI'),to_date('24.12.2000 14:00','DD.MM.YYYY HH24:MI'),'4','1');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('24.12.2000 00:00','DD.MM.YYYY HH24:MI'),'2',null,'4',to_date('24.12.2000 06:00','DD.MM.YYYY HH24:MI'),to_date('24.12.2000 14:00','DD.MM.YYYY HH24:MI'),'5','1');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'1',null,'11',to_date('01.01.2001 06:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 14:00','DD.MM.YYYY HH24:MI'),'1','1');
Insert into POKRYTI (DATUM_POKRYTI,LODID,INV_CISLO,NID,OD,DO,LID,SPID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'10',null,'10',to_date('01.01.2001 06:00','DD.MM.YYYY HH24:MI'),to_date('01.01.2001 14:00','DD.MM.YYYY HH24:MI'),'2','2');

REM INSERTING into REZERVACE
Insert into REZERVACE (DATUM_RES,LODID,ZID) values (to_date('24.12.2000 00:00','DD.MM.YYYY HH24:MI'),'1','6');
Insert into REZERVACE (DATUM_RES,LODID,ZID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'1','6');
Insert into REZERVACE (DATUM_RES,LODID,ZID) values (to_date('24.12.2000 00:00','DD.MM.YYYY HH24:MI'),'2','9');
Insert into REZERVACE (DATUM_RES,LODID,ZID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'2','6');
Insert into REZERVACE (DATUM_RES,LODID,ZID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'3','6');
Insert into REZERVACE (DATUM_RES,LODID,ZID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'4','6');
Insert into REZERVACE (DATUM_RES,LODID,ZID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'5','6');
Insert into REZERVACE (DATUM_RES,LODID,ZID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'5','7');
Insert into REZERVACE (DATUM_RES,LODID,ZID) values (to_date('24.12.2000 00:00','DD.MM.YYYY HH24:MI'),'7','7');
Insert into REZERVACE (DATUM_RES,LODID,ZID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'7','6');
Insert into REZERVACE (DATUM_RES,LODID,ZID) values (to_date('24.12.2000 00:00','DD.MM.YYYY HH24:MI'),'8','1');
Insert into REZERVACE (DATUM_RES,LODID,ZID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'8','1');
Insert into REZERVACE (DATUM_RES,LODID,ZID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'8','6');
Insert into REZERVACE (DATUM_RES,LODID,ZID) values (to_date('01.01.2001 00:00','DD.MM.YYYY HH24:MI'),'10','6');


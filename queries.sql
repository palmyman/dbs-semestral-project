
set pagesize 1000
set echo on
set markup html on spool on head "<title>BIK-DBS - Lubomír Čuhel(cuhellub) - Výstup SQL příkazů </title> <style type ='text/css'><!--body {background: #ffffc6} --></style>" body "<h2>BIK-DBS - Kombinované - Lubomír Čuhel - Výstup SQL příkazů</h2>"
spool queries-log.html

       	
          --KOD DOTAZU: d1
 -- Jmenný výpis všech hráčů - mužů.

SELECT DISTINCT FIRSTNAME,
  MIDDLENAME,
  LASTNAME
FROM PLAYER
JOIN MEMBER
ON MEMBER_BIRTH_ID = BIRTH_ID
WHERE GENDER       = 1;
 

          --KOD DOTAZU: d2
 -- Jména hráčů, kteří nehrají za kategorii BA.

SELECT DISTINCT FIRSTNAME,
  MIDDLENAME,
  LASTNAME
FROM PLAYER
JOIN MEMBER
ON MEMBER_BIRTH_ID   = BIRTH_ID
WHERE CATEGORY_NAME != 'BA';
 

          --KOD DOTAZU: d3
 -- Jména trenérů, kteří trénují pouze kategorie do 15 let a starší.

SELECT DISTINCT FIRSTNAME,
  MIDDLENAME,
  LASTNAME
FROM
  (SELECT DISTINCT MEMBER_BIRTH_ID
  FROM TIMESHEET
  JOIN COACH
  ON COACH_ID = COACH.ID
  MINUS
  SELECT DISTINCT MEMBER_BIRTH_ID
  FROM
    (SELECT DISTINCT * FROM CATEGORY WHERE AGELIMIT <
    15
    ) JOIN EVENT ON NAME           = CATEGORY_NAME JOIN TIMESHEET ON EVENT.ID = TIMESHEET.EVENT_ID JOIN COACH ON COACH_ID = COACH.ID
  ) JOIN MEMBER ON MEMBER_BIRTH_ID = BIRTH_ID;
 

          --KOD DOTAZU: d4
 -- Všechny maily na hráče.

SELECT DISTINCT CONTACT
FROM
  (SELECT DISTINCT BIRTH_ID
  FROM PLAYER
  JOIN MEMBER
  ON MEMBER_BIRTH_ID = BIRTH_ID
  )
JOIN CONTACT
ON BIRTH_ID = MEMBER_BIRTH_ID
JOIN CONTACT_TYPE
ON CONTACT_TYPE_SORTNAME = SORTNAME
WHERE CONTACT_TYPE.NAME  = 'Mail';
 

          --KOD DOTAZU: d5
 -- Jména trenérů, kteří byli na všech událostech kategorie BA.

SELECT DISTINCT FIRSTNAME,
  LASTNAME
FROM
  (SELECT DISTINCT ID AS COACH_ID FROM COACH
  MINUS
  SELECT DISTINCT COACH_ID
  FROM
    (SELECT DISTINCT *
    FROM
      (SELECT DISTINCT ID AS COACH_ID FROM COACH
      )
    CROSS JOIN
      (SELECT DISTINCT ID AS EVENT_ID FROM EVENT WHERE CATEGORY_NAME = 'BA'
      )
    MINUS
    SELECT DISTINCT COACH_ID, EVENT_ID FROM TIMESHEET
    )
  ) NATURAL
JOIN MEMBER;
 

          --KOD DOTAZU: d6
 -- Seznam členů, na které není mailový kontakt.

SELECT DISTINCT FIRSTNAME,
  MIDDLENAME,
  LASTNAME
FROM
  (SELECT DISTINCT * FROM MEMBER
  MINUS
  SELECT DISTINCT BIRTH_ID,
    FIRSTNAME,
    LASTNAME,
    MIDDLENAME,
    REGISTRATION_DATE,
    GENDER
  FROM
    (SELECT DISTINCT MEMBER_BIRTH_ID AS BIRTH_ID
    FROM CONTACT
    JOIN CONTACT_TYPE
    ON CONTACT_TYPE_SORTNAME = SORTNAME
    WHERE CONTACT_TYPE.NAME  = 'Mail'
    ) NATURAL
  JOIN MEMBER
  );
 

          --KOD DOTAZU: d7
 -- Jména hráčů, kteří se neomluvili z žádného tréninku.

SELECT DISTINCT BIRTH_ID,
  FIRSTNAME,
  LASTNAME,
  MIDDLENAME,
  REGISTRATION_DATE,
  GENDER
FROM
  (SELECT DISTINCT MEMBER_BIRTH_ID AS BIRTH_ID
  FROM
    (SELECT DISTINCT * FROM PLAYER
    MINUS
    SELECT DISTINCT ID,
      JERSEY_NUMBER,
      MEMBER_BIRTH_ID,
      CATEGORY_NAME
    FROM
      (SELECT DISTINCT PLAYER_ID AS ID
      FROM
        (SELECT DISTINCT PLAYER_ID
        FROM EVENT
        JOIN
          (SELECT DISTINCT * FROM ATTENDANCE WHERE PRESENT = 0
          )
        ON ID = EVENT_ID
        )
      ) NATURAL
    JOIN PLAYER
    )
  ) NATURAL
JOIN MEMBER; 
 

          --KOD DOTAZU: d8
 -- Jména hráčů a jejich čísel dresů, kteří hrají za kategorii BA.

SELECT DISTINCT FIRSTNAME,
  MIDDLENAME,
  LASTNAME,
  JERSEY_NUMBER
FROM
  (SELECT DISTINCT * FROM CATEGORY WHERE NAME = 'BA'
  )
JOIN PLAYER
ON NAME = CATEGORY_NAME
JOIN MEMBER
ON MEMBER_BIRTH_ID = BIRTH_ID;
 

          --KOD DOTAZU: d9
 -- Jména trenérů, kteří působí jako hlavní trenéři.

SELECT DISTINCT FIRSTNAME,
  MIDDLENAME,
  LASTNAME
FROM
  (SELECT DISTINCT * FROM TIMESHEET WHERE HEAD_COACH = '1'
  )
JOIN COACH
ON COACH_ID = ID
JOIN MEMBER
ON MEMBER_BIRTH_ID = BIRTH_ID;
 

          --KOD DOTAZU: d10
 -- Sesnam mailů na hráče kategorie BA.

SELECT DISTINCT CONTACT
FROM
  (SELECT DISTINCT BIRTH_ID
  FROM
    (SELECT DISTINCT * FROM CATEGORY WHERE NAME = 'BA'
    )
  JOIN PLAYER
  ON NAME = CATEGORY_NAME
  JOIN MEMBER
  ON MEMBER_BIRTH_ID = BIRTH_ID
  )
JOIN CONTACT
ON BIRTH_ID = MEMBER_BIRTH_ID
JOIN CONTACT_TYPE
ON CONTACT_TYPE_SORTNAME = SORTNAME
WHERE CONTACT_TYPE.NAME  = 'Mail'; 
 

          --KOD DOTAZU: d11
 -- Jména kategorií, které mají alespoň 10 hráčů.

SELECT C.name
FROM CATEGORY C
WHERE (SELECT COUNT(category_name) FROM PLAYER P WHERE P.category_name=C.name) >= 10;
 

SELECT category_name
FROM PLAYER
GROUP BY category_name
HAVING COUNT(category_name) >= 10;
 

SELECT category_name
FROM
  (SELECT category_name,
    COUNT(category_name) AS C
  FROM PLAYER
  GROUP BY category_name
  )
WHERE C >= 10;
 

          --KOD DOTAZU: d12
 -- Celkově hráčům vyměřeno na poplatcích.

SELECT SUM(F.value) FROM
  (SELECT value FROM FEE WHERE FEE.value > 0
  ) F;
 

          --KOD DOTAZU: d13
 -- Jména nehrajících trenérů.

SELECT FIRSTNAME,
SELECT FIRSTNAME,
  MIDDLENAME,
  LASTNAME
FROM
  (SELECT member_birth_id AS birth_id
  FROM COACH C
  WHERE C.member_birth_id NOT IN
    (SELECT member_birth_id FROM PLAYER
    )
  ) NATURAL
JOIN MEMBER;
 

          --KOD DOTAZU: d14
 -- Jména kategorií, které měly alespoň tolik událostí jako kategorie SA.

SELECT DISTINCT C.name
FROM CATEGORY C
WHERE C.name <> 'SA'
AND (SELECT COUNT(member_birth_id)
  FROM PLAYER P1
  WHERE P1.category_name = C.name ) >=
  (SELECT COUNT(member_birth_id) FROM PLAYER P2 WHERE P2.category_name = 'SA'
  );
 

          --KOD DOTAZU: d15
 -- Jména hráčů a trenérů, kteří se účastnili nějaké události kategorie BA.

SELECT DISTINCT BIRTH_ID,
  FIRSTNAME,
  LASTNAME,
  MIDDLENAME,
  REGISTRATION_DATE,
  GENDER
FROM MEMBER NATURAL
JOIN
  (SELECT DISTINCT MEMBER_BIRTH_ID AS BIRTH_ID
  FROM
    (SELECT DISTINCT ID,
      JERSEY_NUMBER,
      MEMBER_BIRTH_ID,
      CATEGORY_NAME
    FROM PLAYER NATURAL
    JOIN
      (SELECT DISTINCT LATE,
        PRESENT,
        PLAYER_ID,
        EVENT_ID
      FROM ATTENDANCE NATURAL
      JOIN
      (SELECT DISTINCT * FROM EVENT WHERE CATEGORY_NAME = 'BA'
      )
      )
    )
  UNION
  SELECT DISTINCT MEMBER_BIRTH_ID AS BIRTH_ID
  FROM
    (SELECT DISTINCT ID,
      LICENCE,
      MEMBER_BIRTH_ID
    FROM COACH NATURAL
    JOIN
      (SELECT DISTINCT HEAD_COACH,
        COACH_ID,
        EVENT_ID
      FROM TIMESHEET NATURAL
      JOIN
        (SELECT DISTINCT * FROM EVENT WHERE CATEGORY_NAME = 'BA'
        )
      )
    )
  );
 

          --KOD DOTAZU: d16
 -- Přehled bilance dluhů nebo přeplatků všech hráčů.

SELECT firstname,
  middlename,
  lastname,
  balance
FROM
  (SELECT SUM(value) AS balance, player_id AS id FROM FEE GROUP BY player_id
  ) NATURAL
JOIN PLAYER
JOIN MEMBER
ON PLAYER.member_birth_id = MEMBER.birth_id;
 

          --KOD DOTAZU: d17
 -- Přehled úhrad dluhů. (vytvoření pohledu)

CREATE VIEW PAYMENT_OVERVIEW AS
SELECT FEE."date",
  firstname,
  middlename,
  lastname,
  birth_id,
  FEE.value
FROM FEE
JOIN PLAYER
ON PLAYER.ID = FEE.player_id
JOIN MEMBER
ON PLAYER.member_birth_id = MEMBER.birth_id
WHERE value               > 0
ORDER BY FEE."date" DESC;
 

          --KOD DOTAZU: d18
 -- Přehled úhrad dluhů za rok 2015. (dotaz nad pohledem)

SELECT * FROM PAYMENT_OVERVIEW WHERE "date" >= '1-Jan-2015' AND "date" < '1-Jan-2016';
 

          --KOD DOTAZU: d19
 -- Vypsání příspěvků za rok 2016 všem hráčům.

INSERT INTO FEE
  (value, player_id, "comment", "date"
  )
SELECT -2000       AS "value",
  id               AS player_id,
  'prispevky 2016' AS "comment",
  '1-JAN-2016'     AS "date"
FROM PLAYER;
 

          --KOD DOTAZU: d20
 -- Jména členů, kteří působí jako hlavní trenéři a zároveň jsou hráči.

SELECT DISTINCT FIRSTNAME,
  MIDDLENAME,
  LASTNAME
FROM PLAYER
JOIN MEMBER
ON MEMBER_BIRTH_ID = BIRTH_ID
INTERSECT
SELECT DISTINCT FIRSTNAME,
  MIDDLENAME,
  LASTNAME
FROM
  (SELECT DISTINCT * FROM TIMESHEET WHERE HEAD_COACH = '1'
  )
JOIN COACH
ON COACH_ID = ID
JOIN MEMBER
ON MEMBER_BIRTH_ID = BIRTH_ID;
 

          --KOD DOTAZU: d21
 -- Udělení 50% slevy z příspěvků 2016 všem hráčům kategorie BA.

UPDATE FEE F
SET value        = value * 0.5
WHERE player_id         IN
  (SELECT player_id
  FROM PLAYER
  JOIN CATEGORY
  ON PLAYER.category_name = CATEGORY.name
  WHERE name              = 'BA'
  )
AND "date" >= '1-Jan-2016';
 

          --KOD DOTAZU: d22
 -- Smazání dluhů všem hráčům, kteří působí zároveň jako hlavní trenéři.

DELETE
FROM FEE
WHERE player_id IN
  ( SELECT DISTINCT PLAYER.id AS player_id
  FROM TIMESHEET
  JOIN COACH
  ON COACH_ID = COACH.id NATURAL
  JOIN MEMBER
  JOIN PLAYER
  ON MEMBER.birth_id = PLAYER.member_birth_id
  WHERE head_coach   = '1'
  );
 

          --KOD DOTAZU: d23
 -- Jmenný seznam všech členů a čísla jejich dresů, pokud jsou hráči.

SELECT firstname,
  middlename,
  lastname,
  jersey_number
FROM MEMBER
LEFT OUTER JOIN PLAYER
ON MEMBER.birth_id = PLAYER.member_birth_id;
 

          --KOD DOTAZU: d24
 -- Seznam všech hráčů a jejich kategorií a kategorií, které nemají žádné hráče.

SELECT firstname,
  middlename,
  lastname,
name
FROM MEMBER
JOIN PLAYER
ON MEMBER.birth_id = PLAYER.member_birth_id
FULL JOIN CATEGORY
ON PLAYER.category_name = CATEGORY.name
ORDER BY agelimit DESC,
  name;
 

set markup html off
spool off

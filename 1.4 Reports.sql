
-- 1. sa se afiseze numele, anul nasterii si departamentul 
--pentru cei nascuti in anul 1983 si sunt din departamentul IT

select nume, year(data_nasterii) as anulnasterii, departament
FROM angajati where year(data_nasterii)=1983 and departament='IT'

--2. sa se afiseze persoanele din departamentul IT si sales 
 select nume, departament from angajati where departament in('IT','SALES')

 --3. sa se afiseze persoanele din departamentul IT si sales ce au salariul peste 6000
  select id, nume, departament, salariu from angajati where departament in ('IT', 'Sales')
  and salariu >6000;

-- 4.sa se afiseze toti angajatii nascuti inainte de 1990 ce au salariul peste 6000
select id, nume, data_nasterii, salariu from angajati where year(data_nasterii)<1990
and salariu > 6000;

-- 5. sa se afiseze toti angajatii ce isi serbeaza ziua in luna ianuarie
select id, nume, data_nasterii from angajati where month(data_nasterii)=1

--6. sa se afiseze toti angajatii care nu au pozitia ‘Programator’ sau ‘Manager’
select nume, departament from angajati where departament not in ('Programtor', 'Manager')

--7. sa se afiseze datele celui mai batran angajat. 
select * from angajati where data_nasterii=(select min(data_nasterii) from angajati);

--8. sa se afiseze varsta angajatului cu cel mai mic salariu
select id, nume, datediff(year,data_nasterii, GETDATE()) as varsta 
from angajati where salariu=(select min(salariu) from angajati)

--9. eliminati coloana departament din tabelul angajati
alter table angajati drop column departament 

--10. sa se afiseze o lista a departamentelor si numarul de angajati din departamentul respectiv.
select d.nume_departament, count(a.id) from departamente as d left join angajati as a 
on d.id_departament=a.id_departament group by d.nume_departament;

--11. sa se afiseze salariul maxim pe toate departamentele
select max(a.salariu) from angajati a inner join departamente d 
on a.id_departament = d.id_departament;

--12. sa se afiseze salariul maxim pe fiecare departament
select max(a.salariu) as salariu_maxim, d.nume_departament from angajati a join departamente d
on a.id_departament = d.id_departament group by nume_departament

--13. sa se afiseze o lista a departamentelor si salariul mediu, minim si maxim din fiecare departament. 
select d.nume_departament, avg(a.salariu) as salariu_mediu, min(a.salariu) as salariu_minim, max(a.salariu) as salariu_maxim
from angajati a join departamente d on a.id_departament=d.id_departament group by nume_departament

--14. Proiectati o interogare ce va afisa toate departamentele ce au mai putin de 2 angajati
select count(a.id) as nrang, d.nume_departament from angajati a 
right join departamente d on
a.id_departament=d.id_departament 
group by d.nume_departament 
having count(a.id) < 2

-- 16. eliminati coloana salariu din tabelul angajati
alter table angajati drop column salariu

-- 17. Proiectati o interogare ce va afisa o lista a departamentelor, numele intreg al angajatilor
-- din fiecare departament (intr-o singura coloana) si salariul acestora (cu sufixul RON).
select d.nume_departament, concat(a.nume,'',a.nume) as nume_complet, concat(ac.salariu, ' RON')
from departamente d
left join angajati a on a.id_departament = d.id_departament
left join date_confidentiale ac on a.id = ac.id;

-- 18. sa se afiseze numele depart si bugetul acestora
select d.nume_departament, sum(ac.salariu) as buget from departamente d 
left join angajati a on a.id_departament=d.id_departament 
left join date_confidentiale ac on a.id=ac.id group by d.nume_departament;

--19. sa se afisexe departamentele din care fac parte barbatii folosind CNP
select d.nume_departament, ac.cnp from departamente d 
left join angajati a on a.id_departament=d.id_departament 
left join date_confidentiale ac on a.id=ac.id where left(CNP,1) in (1,5);

--20. sa se afiseze media salariilor pentru angajatii ce fac parte din un departament ce incepe cu litara s pe departamente
select avg(ac.salariu) as medie_sal, d.nume_departament from date_confidentiale ac 
inner join angajati a on ac.id = a.id
join departamente d on a.id_departament = d.id_departament
where d.nume_departament like 'S%'
group by d.nume_departament;

--21. sa se afiseze suma salariilor pt angajatii nascuti inainte de 2000 folosind CNPul si a caror data de angajare este dupa 2016
SELECT SUM(ac.salariu) AS suma_salariilor
FROM Angajati a
JOIN date_confidentiale ac ON a.id = ac.id
WHERE 
    YEAR(a.data_nasterii) < 2000
    AND YEAR(a.data_angajarii) > 2016;

--22. Proiectati o interogare ce va afisa salariul mediu, minim si maxim din fiecare departament.
select d.nume_departament as Departament, max(ac.salariu) as Salariul_maxim, min(ac.salariu) as Salariul_minim, avg(ac.salariu) as Salariul_mediu from departamente d 
left join angajati a on a.id_departament = d.id_departament 
left join date_confidentiale ac on a.id = ac.id
group by d.nume_departament;

--23. toti angajatii de sex masculin folosind CNP
select * from angajati a  inner join date_confidentiale ac 
on a.id=ac.id where left(ac.cnp,1)=1 or left(ac.cnp,1)=5;

--24. sa se afiseze numele persoanelor si departamentului din care fac parte si al caror salariu este peste media departamentului
select a.nume, a.prenume, d.nume_departament, ac.salariu
from angajati a
inner join departamente d on a.id_departament = d.id_departament
inner join date_confidentiale ac on a.id = ac.id
where ac.salariu>(
	select avg(ac.salariu)
    from departamente dd
    inner join angajati a on a.id_departament = dd.id_departament
	inner join date_confidentiale ac on a.id = ac.id
    where d.id_departament = dd.id_departament);


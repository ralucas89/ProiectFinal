--1. sa se afiseze numarul angajatilor de sex masculin pe departamente
create or alter view NumarBarbati 
as
SELECT COUNT(a.id) AS numar_barbati, d.nume_departament, d.id_departament
FROM departamente d
INNER JOIN angajati a ON a.id_departament = d.id_departament
INNER JOIN date_confidentiale ac ON a.id = ac.id
WHERE SUBSTRING(ac.cnp, 1, 1) IN ('1', '5')
GROUP BY d.nume_departament, d.id_departament;

select * from NumarBarbati 

--2. sa se afiseze numarul de angajati pe departamente

create or alter view NrAngajatiPerDepartament
as
select count(a.id) as numar_angajati, d.nume_departament, d.id_departament
	from departamente d
		inner join angajati a on a.id_departament = d.id_departament
		inner join date_confidentiale ac on a.id = ac.id
	group by d.nume_departament, d.id_departament;

select * from NrAngajatiPerDepartament

-- 3. creati un view ce va afisa toate datele unui angajat, inclusiv cele confidentiale.

create or alter view vDateAngajat as
select a.id, a.nume, a.prenume, ac.cnp, ac.salariu, a.data_nasterii, a.data_angajarii, a.pozitie, d.nume_departament
		from angajati as a inner join date_confidentiale as ac on a.id=ac.id
							inner join departamente as d on a.id_departament=d.id_departament;

select * from vDateAngajat

-- 4. creati un view ce va afisa bugetul pe departamente

create or alter view vBugetPeDepartamente as
select sum(salariu) as suma, nume_departament from vDateAngajat group by nume_departament;

select * from vBugetPeDepartamente;

-- 5. Creati o vedere ce va afisa numele, prenumele si vechimea angajatilor (in ani).
create or alter view vVechimeAngajat as
select a.nume, a.prenume, DATEDIFF(YEAR, data_angajarii, GETDATE()) as vechime
from angajati a;

select * from vVechimeAngajat;

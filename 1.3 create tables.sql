create table Angajati 
(
	id int primary key identity (1,1) not null,
    prenume varchar(255),
	nume varchar(255),
    data_nasterii date, 
    pozitie varchar(255),
    departament varchar(255),
    salariu money
);
insert into angajati 
values ('Florin', 'Florea', '1978-03-24', 'Programator', 'IT', 5000),
('Dalma', 'Kirr', '2002-12-12', 'Secretara', 'Marketing', 7600.35),
('Loredana', 'Iosif', '1989-07-10', 'Director', 'Management', 8500),
('Anca', 'Stoian', '1983-06-06', 'Vanzator', 'Sales', 5000);

select * from angajati

insert into angajati(data_nasterii,prenume, nume) values
('1999-06-25','Andrei', 'Ion');

update angajati set pozitie = 'Programator' where id=5
update angajati set departament='IT', salariu='8500' where id=5

insert into angajati values
('Elena', 'Dumitriu', '2000-09-09', 'Inspector', 'Sales', 3790.89),
('Ion', 'Ion', '1998-01-19', 'Director', 'Sales', 4567.89),
('Andrea', 'Amota','2000-04-02','Manager','Sales', 7850.3);

alter table angajati add id_departament int;
alter table angajati add data_angajarii date;

UPDATE angajati
SET data_angajarii = DATEADD(DAY, FLOOR(RAND(CHECKSUM(NEWID())) * 2000),
'2015-01-12');
select * from angajati
 
create table departamente 
(id_departament int primary key identity (1,1) not null, 
nume_departament varchar(255)not null );

INSERT INTO departamente (nume_departament)
SELECT distinct a.departament FROM angajati a where departament is not null

update angajati set id_departament=(select d.id_departament from departamente as d 
where d.nume_departament=departament);

alter table angajati add foreign key (id_departament) references departamente(id_departament) 
on delete cascade on update cascade;

create table date_confidentiale (
id int primary key , 
salariu int, 
cnp char(13));
select* from date_confidentiale
INSERT INTO date_confidentiale (id,salariu, cnp)
SELECT id,
    CAST(salariu AS int) AS salariu,
    CONCAT(
        CASE
            WHEN YEAR(data_nasterii) < 2000 AND RIGHT(prenume, 1) != 'a' THEN '1'
            WHEN YEAR(data_nasterii) >= 2000 AND RIGHT(prenume, 1) != 'a' THEN '5'
            WHEN YEAR(data_nasterii) < 2000 AND RIGHT(prenume, 1) = 'a' THEN '2'
            WHEN YEAR(data_nasterii) >= 2000 AND RIGHT(prenume, 1) = 'a' THEN '6'
            ELSE '-'
        END,
        RIGHT(CONVERT(varchar(8), data_nasterii, 112), 6),
        RIGHT('000000' + CAST(id AS varchar(6)), 6)
    ) AS cnp
FROM
    Angajati;

alter table date_confidentiale add foreign key (id)
references angajati(id)
on delete cascade on update cascade

select * from departamente
select * from angajati
select * from date_confidentiale

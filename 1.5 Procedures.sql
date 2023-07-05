--1.Sa se creeze o procedura care actualizeaza salariul pe baza numelui si prenumelui
drop procedure if exists pActualizareSalariu
create procedure pActualizareSalariu
@pnume varchar(255), 
@pprenume varchar(255), 
@psalariu money
as
	begin
		update date_confidentiale set salariu = @psalariu
        where id = (select id from angajati where nume = @pnume and prenume = @pprenume);
    end;

exec pActualizareSalariu @pnume='Florea', @pprenume='Florin', @psalariu='7590';

-- 2.Sa se creeze o procedura care actualizeaza departamentul unui angajat pe baza numelui si prenumelui

drop procedure if exists pActualizareDepartament
create or alter procedure pActualizareDepartament
@pnume varchar(255), 
@pprenume varchar(255),
@pdepartament varchar(255)
as
	begin
		update angajati
        set id_departament = (select id_departament from departamente where nume_departament=@pdepartament)
        where id = (select a.id from (select * from angajati) as a where a.nume = @pnume and a.prenume = @pprenume);
end;

exec pActualizareDepartament @pnume='Kirr',@pprenume='Dalma',@pdepartament='sales'


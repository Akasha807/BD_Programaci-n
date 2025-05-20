-- https://pastebin.com/t9m2jK98
 
CREATE TABLE persona (
    codi INTEGER primary key,
    nom VARCHAR2(50) NOT NULL,
    sou FLOAT CHECK(sou>=1200)
);
 
INSERT INTO persona VALUES (1, 'Jordi', 1200);                      

create or replace procedure alta_persona(
    p_codi integer,
    p_nom varchar2,
    p_sou float
)
is
begin
    if p_nom is not null then
        if p_sou > 1200 then
            insert into persona(codi, nom, sou) values (p_codi, p_nom, p_sou);
        else
            dbms_output.put_line('Error: sou inferior o igual a 1200');
        end if;
    else
        dbms_output.put_line('Error: el nom és nul');
    end if;
end;
/

create or replace procedure baja_persona(
    p_codi integer
)
is
begin
    delete from persona where codi = p_codi;
end;
/

create or replace procedure Consulta_Persona(
    p_codi integer
)
is  
    x integer;
    y varchar2(50);
    z float;
begin
    select codi, nom, sou
    into x, y, z
    from persona
    where codi = p_codi;

    dbms_output.put_line('--- FITXA DE LA PERSONA ---');
    dbms_output.put_line('Codi: ' || x);
    dbms_output.put_line('Nom: ' || y);
    dbms_output.put_line('Sou: ' || z);
    dbms_output.put_line('----------------------------');
end;
/

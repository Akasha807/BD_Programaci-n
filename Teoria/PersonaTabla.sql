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

-- Aquest procediment serveix per fer consultes
create or replace procedure consulta(
    l_titulo varchar2
)
is 
    d varchar2,
    a integer
begin   
    select editorial,any
    into d,a
    from libro
    where titulo = l_editorial;

    dbms_output.put_line('--- FITXA DE LA LLIBRE ---');
    dbms_output.put_line('Editorial: ' || d);
    dbms_output.put_line('Any: ' || a);
    dbms_output.put_line('----------------------------');
end;
/

-- Aquest procedure serveix per mostra mes d'una fila
-- Tambe li passem per parametre la poblacio
create or replace procedure molts (
    p_poblacio varchar2
)
is  
    -- fem serveir el cursor
    cursor mostra is
    -- fem un select amb l'altre tabla
    select titol,nom,poblacio
    from libro 
    -- fem el join per unir libro amb autor AMB EL FOREIGN KEY
    join autor on(nom_autor=titol)
    where  p_poblacio = poblacio;
begin   
    for aux in mostra loop
    dbms_output.put_line('--- FITXA DE LA LLIBRE ---');
    dbms_output.put_line('Editorial: ' || aux.nom);
    dbms_output.put_line('Titol: ' || aux.titol);
    dbms_output.put_line('Poblacio: ' || aux.poblacio);
    dbms_output.put_line('----------------------------');
    end loop;
end;
/ 

    

    dbms_output.p
-- primer problema
create or replace procedure Consulta_Libro(
    l_titol varchar2
)
is 
    l_editorial varchar2,
    l_any integer
begin   
    select titol,editorial,any
    into x,y,z
    from persona
    where titol = l_titol;

     dbms_output.put_line('--- FITXA DE LA LIBROS ---');
    dbms_output.put_line('titol: ' || x);
    dbms_output.put_line('editorial: ' || y);
    dbms_output.put_line('any: ' || z);
    dbms_output.put_line('----------------------------');
end;
/

create or replace procedure Consulta_libros(
    a_poblacio integer
)
    --

    -- Cursor per a les assignatures del professor
    cursor c_autor is
        select *
        from libro join autor on(nom_autor=nom)
        where poblacio = a_poblacio
begin
    -- 
    select poblacio into a_poblacio
    from autor
    where poblacio = a_poblacio;

    -- Agafar el nom de la casa si té casa
    select c.nom into v_nomCasa
    from casa c, profe p
    where p.id = p_profeid
    and p.idcasa = c.id;

    -- Mostrar dades
    dbms_output.put_line('*******************************');
    dbms_output.put_line('       DADES PROFESSOR/A       ');
    dbms_output.put_line('*******************************');
    dbms_output.put_line('Nom Professor: ' || v_nomProfe);
    dbms_output.put_line('Nom Casa: ' || v_nomCasa);
    dbms_output.put_line('Classes que imparteix:');
    dbms_output.put_line('CODI' || chr(9) || 'NOM');

    -- Recórrer les assignatures
    for a in a_poblacio loop
        dbms_output.put_line(a. || chr(9) || a.nom);
    end loop;

exception
    when no_data_found then
        dbms_output.put_line('No existeix el professor o no té casa.');
    when others then
        dbms_output.put_line('S''ha produït un error: ' || sqlerrm);
end;
/



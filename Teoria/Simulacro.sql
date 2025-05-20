-- Crea un procediment anomenat NouAlumne que rebrà 
-- com a paràmetres d’entrada el nom de l’alumne, 
-- l’any i l’id de la casa a la que pertany.
-- l’alumne, l’any i l’id de la casa a la que pertany.
CREATE OR REPLACE PROCEDURE nouAlumne (
                        p_nom estudiant.nom%TYPE,
                        p_anyo estudiant.anyo%TYPE,
                        p_idcasa estudiant.casa_id%TYPE
                    )
IS
    aux INTEGER;
    aux2 INTEGER;
BEGIN
    SELECT MAX(id) 
    INTO aux
    FROM estudiant;   -- Obtenemos el maximo id de la tabla estudiante
    
    aux:=aux+1;     -- El nuevo estudiante será uno más que el máximo
 
    SELECT COUNT(*) 
    INTO aux2
    FROM casa WHERE id=p_idcasa;  -- Miramos si hay alguna casa con el id introducido
 
    IF aux2 = 1 THEN
        IF p_nom IS NOT NULL THEN     -- Verificamos que el nom es obligatori
            IF p_anyo >= 1 AND p_anyo<=7 AND p_anyo IS NOT NULL THEN  -- Verificamos que el anyo es obligatori y que esté entre 1 y 7
                INSERT INTO estudiant VALUES (aux, p_nom, p_anyo, p_idcasa);
                DBMS_OUTPUT.put_line('Tot correcte');
            ELSE
                DBMS_OUTPUT.put_line('Error: anyo');
            END IF;
        ELSE
            DBMS_OUTPUT.put_line('Error: nom obligatori');
        END IF;
    ELSE 
        DBMS_OUTPUT.put_line('Error: La casa no existeix');
    END IF ;
END;
/

-- Crea un procediment anomenat Aprova 
-- que rebrà com a paràmetre d’entrada el codi de l’alumne
-- Crea un procediment anomenat Aprova 
-- que rebrà com a paràmetre d’entrada el codi de l’alumne  
create or replace procedure Aprova ( 
    p_codi integer
)
is
    aux integer;
begin
    -- Intentem obtenir l'any actual de l'alumne
    select anyo into aux from estudiant where codi = p_codi;

    -- Comprovem si l'any és menor que 7
    if aux < 7 then
        update estudiant set anyo = aux + 1 where codi = p_codi;
        dbms_output.put_line('Tot és correcte. Alumne promogut a ' || (aux + 1) || 'è');
    else
        dbms_output.put_line('Error: l''alumne ja està a 7è');
    end if;

exception
    when no_data_found then
        dbms_output.put_line('Error: el codi no existeix');
    when others then
        dbms_output.put_line('Error desconegut: ' || sqlerrm);
end;
/

create or replace procedure ConsProfe(
    p_profeid integer
)
is
    v_nomProfe varchar2(50);
    v_nomCasa varchar2(50);
    v_idCasa integer;
begin
    -- Obtenemos el nombre del profesor
    select nom into v_nomProfe from profe where id = p_profeid;

    -- Obtenemos la casa del profesor
    select idcasa into v_idCasa from profe where id = p_profeid;

    -- Obtenemos el nombre de la casa (solo si tiene casa)
    select nom into v_nomCasa from casa where id = v_idCasa;

    -- Mostramos los datos
    dbms_output.put_line('*************************');
    dbms_output.put_line('   DADES PROFESSOR/A     ');
    dbms_output.put_line('*************************');
    dbms_output.put_line('Nom Professor: ' || v_nomProfe);
    dbms_output.put_line('Nom Casa: ' || v_nomCasa);
    dbms_output.put_line('Classes que imparteix:');
    dbms_output.put_line('CODI  NOM');

    -- Mostramos las clases que imparteix
    for r in (select codi, nom from assignatura where profeid = p_profeid) loop
        dbms_output.put_line(r.codi || ' ' || r.nom);
    end loop;

exception
    when no_data_found then
        dbms_output.put_line('Error: No existeix el professor o no té casa.');
    when others then
        dbms_output.put_line('Error: ' || sqlerrm);
end;
/

create or replace procedure ConsProfe(
    p_profeid integer
)
is
    v_nomProfe varchar2(50);
    v_nomCasa varchar2(50);

    -- Cursor per a les assignatures del professor
    cursor c_assignatures is
        select codi, nom
        from assignatura
        where profeid = p_profeid
        order by codi;
begin
    -- Agafar el nom del professor
    select nom into v_nomProfe
    from profe
    where id = p_profeid;

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
    for a in c_assignatures loop
        dbms_output.put_line(a.codi || chr(9) || a.nom);
    end loop;

exception
    when no_data_found then
        dbms_output.put_line('No existeix el professor o no té casa.');
    when others then
        dbms_output.put_line('S''ha produït un error: ' || sqlerrm);
end;
/

-- problema 1
 create or replace procedure CanviaCasa (
    estudiant_codi in  integer;
    casa_codi in integer;
 )
 as
    aux integer;
    aux1 integer;
 begin 
    -- Condición - Solo se puede actualizar de casa si el estudiante
    -- existe i la casa también

    select count(*) into aux from casa where id=casa_codi;
    select count(*) into aux1 from estudiant where id=estudiant_codi;

    if aux > 0 then
        if aux 1 > 0 then
            update casa set 


-- problema 2
 create or replace function NomAssignatura(
    p_codi integer;
 ) return varchar2
 as
 x varchar2(30);
 begin
    select materia into x where id = p_codi;
    return x
end;
/

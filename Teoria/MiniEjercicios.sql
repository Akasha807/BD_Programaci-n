-- problema 1
create or replace procedure problema1(
    p_nom varchar2,
    p_edat integer,
    id_casa integer
)
as
    aux integer;
begin
    select count(*) into aux from casa where id = id_casa;

    if p_nom is not null then
        if p_edat > 20 then
            if aux > 0 then
                insert into profe(nom, edat, id) values(p_nom, p_edat, id_casa);
                dbms_output.put_line('Tot correcte');
            else
                dbms_output.put_line('Error: Casa');
            end if;
        else
            dbms_output.put_line('Error: Edat');
        end if;
    else
        dbms_output.put_line('Error: Nom');
    end if;
end;
/


-- problema 2
create or replace procedure problema2(
    a_nom varchar2,
    p_codi integer
)
as
    aux integer;
begin
    select count(*) into aux from profe where id = p_codi;

    if aux > 0 then
        insert into assignatura(nom, codi_profe) values(a_nom, p_codi);
        dbms_output.put_line('Assignatura afegida correctament');
    else
        dbms_output.put_line('Error: El professor no existeix');
    end if;
end;
/
   
-- problema 3
create or replace procedure problema3(
    e_codi integer
)
as
    any_actual integer;
begin
    select any into any_actual from estudiant where id = e_codi;

    if any_actual > 1 then
        update estudiant set any = any_actual - 1 where id = e_codi;
        dbms_output.put_line('Any rebaixat correctament');
    else
        dbms_output.put_line('Error: Any no pot ser inferior a 1');
    end if;
end;
/

--- problema4
create or replace procedure problema4(
    e_codi integer;
    nom varchar2(30);
)
as
    aux varchar2(30);
begin
    select nom into aux from estudiant where id=e_codi;
    if nom is not null then 
        if length(nom) >= 3 then
            update estudiant set nom = nom where id= e_codi;
                dbms_output.put_line('Correcte');
            else
                  dbms_output.put_line('Error: Char');
            end if;
        else 
            dbms_output.put_line('Error: nom');
        end if;
end;
/
create or replace procedure InfoAlumne(
    p_id integer
)
as
    v_nom varchar2(50);
    v_any integer;
    v_casa varchar2(50);
begin
    select nom, any, nom into v_nom, v_any, v_casa
    from estudiant 
    where e.id = p_id;

    dbms_output.put_line('Nom: ' || v_nom);
    dbms_output.put_line('Any: ' || v_any);
    dbms_output.put_line('Casa: ' || v_casa);
exception
    when no_data_found then
        dbms_output.put_line('Error: Alumne no trobat');
end;
/

-- problema13
create or replace procedure problema13 as
    cursor n_estudiant is
        select nom, any, id_casa from estudiant;
begin
    dbms_output.put_line('NOM            ANY    CASA');
    for x in n_estudiant loop
        dbms_output.put_line(
            rpad(x.nom, 15) || 
            rpad(x.any, 7) || 
            x.id_casa
        );
    end loop;
end;
/

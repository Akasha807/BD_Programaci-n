
-- problema 1
	
declare
	x integer := 6;
	y integer := 7;
begin 
	if x > y then 
			dbms_output.put_line('és més gran');
	elsif x < y then	
			dbms_output.put_line('és menor que');
	else
		dbms_output.put_line('són iguals');
	end if;
end;
/

-- problema 2
declare 
	x integer := 5;
	y integer := 6;
	z integer := 10;
begin
	if x > y and x > z then
		dbms_output.put_line('es més gran');
	elsif x < y  and x < z then
		dbms_output.put_line('és més petit');
	else 
		dbms_output.put_line('el del mig.');
	end if;
	
	if y > x and y > z then
		dbms_output.put_line('es més gran');
	elsif y < x and y < z then
		dbms_output.put_line('és més petit');
	else 
		dbms_output.put_line('el del mig.');
	end if;
	
	if z > x and  z > y then
		dbms_output.put_line('es més gran');
	elsif z < x and z < y then
		dbms_output.put_line('és més petit');
	else 
		dbms_output.put_line('el del mig.');
	end if;
end;
/

-- problema 3
declare
	dia integer := 1;
	solucion varchar2(20);
begin
	solucion := case dia
		when 1 then 'Dilluns'
		when 2 then 'Dimarts'
		when 3 then 'Dimecres'
		when 4 then 'Dijous'
		when 5 then 'Divindres'
		when 6 then 'Dissabte'
		when 7 them 'Diumenge'
	end;
		dbms_output.put_line(solcion);
end;
/	

-- problema 4
declare 
	aux integer;
begin
	for i in reverse 1..10 loop
		aux:= i ;
		
		dbms_output.put_line(aux);
	end loop;
end;
/

--problema 5 
declare	
	x integer := 3;
	aux integer;
begin
	for i in 1..10 loop	
		aux := x * i;
	dbms_output.put_line(x||'x'||i||'='||aux);
	end loop;
end;
/

-- problema 6
declare 
	i integer := 1;
begin
	while i <= 5 loop
		dbms_output.put_line(substr('12345',1,i));
		i := i + 1;
	end loop;
end;
/

-- problema 7
create or replace procedure problema7 (x integer,y integer) as
	aux integer;
begin 
	aux := x + y;
	dbms_output.put_line(aux);
end;
/

-- resultado 7
begin
    problema7(1, 2);
end;
/

-- problema 8
create or replace procedure problema8(text varchar2) as
begin 
	dbms_output.put_line(text);
end;
/

-- prueba 8
begin
    problema8('Hola');
end;

-- probelema 9
create or replace procedure problema9 (cadena varchar2) as

begin	
	-- el número de caràcters
	dbms_output.put_line( 'El número de caràcter '||length(cadena));
	-- en mayúscula
	dbms_output.put_line( 'En mayúscula  '||upper(cadena));
	-- en minúscula
	dbms_output.put_line( 'En minúscula  '||lower(cadena));
end;
/

-- prueba 9
begin
     problema9('Hola');
end;
/

-- problema 10
CREATE OR REPLACE PROCEDURE problema10(cadena VARCHAR2) AS
  pos INTEGER;
BEGIN
  IF cadena IS NULL OR LENGTH(cadena) = 0 THEN
    DBMS_OUTPUT.PUT_LINE('La cadena és buida');
  ELSE
    pos := INSTR(cadena, ' ');
    IF pos = 0 THEN
      DBMS_OUTPUT.PUT_LINE('No hi ha cap espai en blanc');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Primer espai en blanc a la posició: ' || pos);
    END IF;
  END IF;
END;
/

-- problema 11

CREATE OR REPLACE PROCEDURE problema11(entrada VARCHAR2) IS
    aux VARCHAR2(2500);
    sortida VARCHAR2(2500):='';
BEGIN
    FOR i IN REVERSE 1..LENGTH(entrada) LOOP
        aux:=SUBSTR(entrada, i, 1);
        sortida:=sortida || aux;
    END LOOP;
    DBMS_OUTPUT.put_line(sortida);
END;
/
 
-- problema 13
create or replace procedure problema13(x integer) as
aux integer;
begin	
	for i in 1..10 loop	
		aux:= x * i;
			dbms_output.put_line(x|| 'x'|| i || '='|| aux);
	end loop;
end;
/
-- resol
execute problema13(5);

-- problema 14
create or replace function probelema14(x integer)return integer as
begin
	for i in reverse 1..x loop
		dbms_output.put_line(i);
	end loop;

	return x;
end;
/

-- problema 20
-- Un procediment de pokemon que consulti les DADES dun pokemos a traves de ID

create or replace procedure problema20(
	p_codi in integer
)
as 
	p_nom varchar2(15);
	p_pes integer;
	p_altura integer;
begin
	select nombre,peso,altura
	into p_nom,p_pes,p_altura
	from pokemon
	where numero_pokedex=p_codi;
	
	dbms_output.put_line('Nom:' || p_nom);
	dbms_output.put_line('Pes:' || p_pes);
	dbms_output.put_line('Altura:' || p_altura);
end;
/

-- problema 21
create or replace procedure problema21(
	p_codi in integer
)
as 
	p_nom varchar2(15);
	p_pes integer;
	p_altura integer;
	p_atac integer;
	p_defensa integer;
begin
	select nombre,peso,altura
	into p_nom,p_pes,p_altura
	from pokemon
	where numero_pokedex=p_codi;

	select ataque,defensa
	into p_atac,p_defensa
	from estadisticas_base
	where numero_pokedex=p_codi;

	dbms_output.put_line('Nom:' || p_nom);
	dbms_output.put_line('Pes:' || p_pes);
	dbms_output.put_line('Altura:' || p_altura);
	dbms_output.put_line('Atac:'|| p_atac);
	dbms_output.put_line('Defensa:'||p_defensa);
end;
/
-- resol
execute problema21(2);

-- problema 22
create or replace procedure problema22(
	p_codi in integer
)
as
begin
	delete pokemon where numero_pokedex=p_codi;
	dbms_output.put_line('S''ha eliminat correctamente');
end;
/

-- problema 23
create or replace procedure problema23(
	p_codi in integer
)
as
aux integer;
begin	
	select count(*) into aux from pokemon where numero_pokedex=p_codi;

	if aux = 1 then	
		delete pokemon where numero_pokedex=p_codi;
		dbms_output.put_line('S''ha pogut eliminar');
	else	
		dbms_output.put_line('No existeix');
	end if;
end;
/

-- problema 24
create or replace procedure problema24(
	p_codi  integer,
	p_nom  varchar2,
	p_pes  integer,
	p_altura  integer
)
as

begin	
	insert into pokemon (numero_pokedex,nombre,peso,altura)
	values (p_codi,p_nom,p_pes,p_altura);
	dbms_output.put_line('S''ha pogut crear correctamente');
end;
/

create or replace procedure problema25(
	p_nom  varchar2,
	p_pes  integer,
	p_altura  integer
)
as
	afegir integer;
begin
	select max(numero_pokedex)
	into afegir
	from pokemon;

	afegir:= afegir + 1;

	insert into pokemon (numero_pokedex,nombre,peso,altura)
	values (afegir,p_nom,p_pes,p_altura);
	dbms_output.put_line('S''ha pogut crear correctamente');
end;
/

-- problema 28
create or replace procedure problema28 as
begin	
	
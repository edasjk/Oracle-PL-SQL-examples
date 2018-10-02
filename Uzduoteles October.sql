    
      
--Calculate factorial
Declare
    num number := &num;
    fact number := 1;
    temp number;
Begin
    temp := num;
    while (num > 0)
        loop
            fact := fact * num;
            num := num -1;
        end loop;
    dbms_output.put_line('factorial of ' || temp || ' is: ' || fact);
End;    

--Is prime or not
Create Or Replace Procedure is_primer(num number)
    --Return boolean     
    AS
    root number;
     counter number := 1;
     div_count number := 1;
     is_primer boolean := true;
     moda number;
Begin 
   -- root := round (sqrt(num), 0);
    root := ceil(sqrt(num));
    --dbms_output.put_line('Root ceil is ' || root);
    while (counter <= root)
        loop 
            counter := counter +1;
            moda := mod(num,counter);
            --dbms_output.put_line('mode of  ' || num || ' ' || counter || ' is ' ||  moda);
             if moda = 0 and num != 2 and num != 3 then
                is_primer := false;
                --dbms_output.put_line(counter);
                --dbms_output.put_line(mod(num, counter));
                --dbms_output.put_line(num || ' is NOT prime number');
            end if;
        end loop;
    if is_primer then 
        dbms_output.put_line(num || ' IS prime number');
    else
        dbms_output.put_line(num || ' NOT a prime number');  
    end if;
End;

drop function is_primer;

declare 
    num number := &num;
begin
    is_primer(num);
end;



--Rise exception on Friday
declare 
    e exception;
begin
    if to_char(sysdate, 'DY')='FRI'
        then 
            raise e;
        ELSE
            dbms_output.put_line('Today is not Friday. Continue your job');
    end if;
exception
    when e then
        dbms_output.put_line('exception raised on Friday. Go home');
END;


--salary
declare
    v_sal number(10);
begin
    select max(salary) into v_sal 
    from employees
    where department_id>30;
    
    dbms_output.put_line('Salary is: '  || v_sal);
end;

--greatest number
declare
    A number(10);
    B number(10);
    C number(10);
    D number(10);
begin
    a:=7;
    b:=30;
    c:=15;
    d:=greatest(a,b,c);
    dbms_output.put_line('greatest number is ' || d);
end;

--Write a PL/SQL cursor program which is used to calculate total salary from emp table without using sum() function
declare
    cursor c1 is 
    select salary from employees;
    v_sal number(10);
    n number(10,2) := 0;
    c number(10,2) := 0;
    av number(10,2); 
    
begin
    open c1;
    loop
        fetch c1 into v_sal;
        exit when c1 % notfound;
        n := n + v_sal;
        c := c + 1;
        av := (n) / c;
    end loop;
    dbms_output.put_line('sum of salaries is: ' || n);
    dbms_output.put_line('number of salaries: ' || c);
    dbms_output.put_line('average salary is: ' || av);
end;

--Write a PL/SQL cursor program to display all employee names and their salary from emp table by using % not found attributes
declare
    cursor c1 is
    select first_name, last_name, salary from employees;
    v_name employees.first_name%type;
    v_last employees.last_name%type;
    v_sal number(10);
begin
    open c1;
    loop
        fetch c1 into v_name, v_last, v_sal;
        exit when c1%notfound;
        dbms_output.put_line(v_name || ' ' || v_last || ' ' || v_sal);
    end loop;
end;

--Tas pats su rowtype
declare
    cursor c1 is
    select first_name, last_name, salary from employees;
    myvar c1%rowtype;
begin
    open c1;
    loop
        fetch c1 into myvar;
        exit when c1%notfound;
        dbms_output.put_line(myvar.first_name || ' ' || myvar.last_name || ' ' || myvar.salary);
    end loop;
end;
-- Oracle Database 12c Complete Reference
-- sample SQL statements from book

drop user hr cascade;
grant connect, resource, create view, unlimited tablespace to practice identified by hr;

-- Chapter 12: grouping

select category_name, count(*)
from bookshelf
group by category_name;

select category_name, count(*) from bookshelf;

select category_name, count(*)
from bookshelf
group by category_name
having count(*) > 5;

select category_name, count(*), avg(rating)
from bookshelf
group by category_name;

select avg(rating) from bookshelf;

select category_name, count(*), avg(rating)
from bookshelf
group by category_name
having avg(rating) >
   (select avg(rating) from bookshelf);
   
select category_name, count(*)
from bookshelf
group by category_name
order by category_name desc;

select category_name, count(*)
from bookshelf
group by category_name
order by count(*) desc;

select category_name, count(*) as counter
from bookshelf
group by category_name
having counter > 1
order by count(*) desc;

select category_name, count(*), avg(rating)
from bookshelf
where rating > 1
group by category_name
having category_name like 'A%'
order by count(*) desc;

select category_name, count(*), avg(rating)
from bookshelf
where rating > 1
  and category_name like 'A%'
group by category_name
order by count(*) desc;

select * from invasion;

create or replace view category_count as
select category_name, count(*) as counter
from bookshelf
group by category_name;

desc category_count

select * from category_count;

create or replace view book_count as
select count(*) book_count from bookshelf;

select book_count from book_count;

select category_name, counter, (counter/book_count)*100 as percent
from category_count, book_count
order by category_name;

select category_name, count(*),
   (count(*)/max(book_count))*100 as percent
from bookshelf, book_count
group by category_name
order by category_name;


select category_name, counter, (counter/book_count)*100 as percent
from category_count,
   (select count(*) as book_count from bookshelf)
order by category_name;


create view bookshelf_sorted
as select * from bookshelf
order by title;

select title from bookshelf_sorted
where rownum < 10;

select category_name, count(*),
   (count(*)/max(book_count))*100 as percent
from bookshelf,book_count
group by category_name
having avg(rating) > 4
order by category_name;

select author_name, count(*)
from author
group by author_name
having count(*) > 1
order by author_name;

column title format a40
select title, count(*)
from bookshelf_author
group by title
having count(*) > 1;

column title format a40
column author_name format a30

select title, author_name
from bookshelf_author,
   (select title as grouped_title, count(*) as title_counter
    from bookshelf_author
    group by title
    having count(*) > 1)
where title=grouped_title
order by title, author_name;

column title format a40
column author_name format a30

select title, author_name
from bookshelf_author,
   (select title as grouped_title, count(*) as title_counter
    from bookshelf_author
    group by title
    having count(*) > 1)
where title=grouped_title
order by title_counter desc,title, author_name;

-- Chapter 13: Advanced subqueries

select distinct c.parent_category, c.sub_category
  from category c, bookshelf b, bookshelf_checkout bc
 where c.category_name = b.category_name
   and b.title = bc.title;

select distinct c.parent_category, c.sub_category
from category c
where category_name in
   (select category_name from bookshelf
    where title in
       (select title from bookshelf_checkout)
   );

select title from bookshelf_author
where title in
   (select title from bookshelf
    where author_name = 'Stephen Jay Gould');

select title from bookshelf
where author_name = 'Stephen Jay Gould';

select title from bookshelf_author ba
where title in
   (select title from bookshelf
    where ba.author_name = 'Stephen Jay Gould');

select distinct author_name from bookshelf_author
where title in
  (select title from bookshelf
   where category_name in
      (select distinct category_name from bookshelf
       where title in
          (select title
           from bookshelf_checkout bc
           where bc.name = 'Fred Fuller')));

select distinct author_name
from bookshelf_author ba, bookshelf_checkout bc
where ba.title = bc.title
  and bc.name = 'Fred Fuller';

select distinct author_name from bookshelf_author
where title in
   (select title from bookshelf
    where category_name in
       (select distinct category_name from bookshelf
        where title in
           (select title
            from bookshelf_checkout bc
            where bc.name = 'Fred Fuller')))
      and author_name not in
         (select author_name
          from bookshelf_author ba, bookshelf_checkout bc
          where ba.title = bc.title
            and bc.name = 'Fred Fuller');
column author_name format a25
select author_name, count(*)
from bookshelf_author
group by author_name
having count(*) > 1;


select author_name, title, count(*)
  from bookshelf_author
 group by author_name, title
having count(*) > 1;

column AuthorName format a25
column Title format a30

select author_name, title
  from bookshelf_author ba
 where exists
       (select 'x'
        from bookshelf_author ba2
        where ba.author_name = ba2.author_name
        group by ba2.author_name
        having count(ba2.title) > 1)
order by author_name, title;

select author_name, title
from bookshelf_author ba
where author_name in
    (select author_name
     from bookshelf_author
     group by author_name
     having count(title) > 1)
order by author_name, title;

column title format a40

select distinct title
from bookshelf_checkout;

select distinct b.title
from bookshelf_checkout bc, bookshelf b
where bc.title = b.title;

select b.title, max(bc.returned_date - bc.checkout_date)
         "Most Days Out"
from bookshelf_checkout bc, bookshelf b
where bc.title(+) = b.title
group by b.title;

select b.title, max(bc.returned_date - bc.checkout_date)
        "Most Days Out"
from bookshelf_checkout bc, bookshelf b
where bc.title(+) = b.title
group by b.title;

select b.title, max(bc.returned_date - bc.checkout_date)
         "Most Days Out"
from bookshelf_checkout bc 
   right outer join bookshelf b
      on bc.title = b.title
group by b.title;

select title, max(bc.returned_date - bc.checkout_date)
         "Most Days Out"
from bookshelf_checkout bc 
   right outer join bookshelf b
      using (title)
group by title;

select b.title, max(bc.returned_date - bc.checkout_date)
         "Most Days Out"
from bookshelf_checkout bc 
   left outer join bookshelf b
      on bc.title = b.title
group by b.title;

select b.title, max(bc.returned_date - bc.checkout_date)
         "Most Days Out"
from bookshelf_checkout bc 
   full outer join bookshelf b
      on bc.title = b.title
group by b.title;

select title
from bookshelf
where title not in
   (select title from bookshelf_checkout)
order by title;

select distinct b.title
from bookshelf_checkout bc 
   right outer join bookshelf b
      on bc.title = b.title
where bc.title is null
order by b.title;

select b.title
from bookshelf b
where not exists
   (select 'x' 
    from bookshelf_checkout bc
    where bc.title = b.title)
order by b.title;

select title
from book_order
   natural join bookshelf;

select bo.title
from book_order bo, bookshelf
where bo.title = bookshelf.title
  and bo.publisher = bookshelf.publisher
  and bo.category_name = bookshelf.category_name;

select bo.title
from book_order bo 
   inner join bookshelf b
      on bo.title = b.title;

select title 
from bookshelf
where title < 'M';

select title from book_order;

select title from bookshelf
where title < 'M'
union
select title from book_order;

select title from bookshelf
where title < 'M'
union all
select title from book_order
order by title;

select title from bookshelf
intersect
select title from book_order
order by title;

select title from book_order
minus
select title from bookshelf
order by title;

select title from bookshelf
minus
select title from bookshelf_checkout;


-- Chapter 14: Complex functions

create or replace view category_count as
select category_name, count(*) as counter
from bookshelf
group by category_name;

desc category_count

select * from category_count;

create or replace view book_count as
select count(*) book_count from bookshelf;


create or replace view category_count as
select category_name, COUNT(*) as counter
from bookshelf
group by category_name;


select * 
from category_count
order by category_name;

select * from category_count
order by counter desc;

select rank(3) 
   within group
      (order by counter desc)
from category_count;

select rank(8) 
   within group
      (order by counter desc)
from category_count;

select percent_rank(8)
   within group
      (order by counter desc)
from category_count;

create global temporary table year_rollup (
   year     number(4),
   month    varchar2(9),
   counter  number)
on commit preserve rows;


set headsep !
column name format a20
column title format a20 word_wrapped
column daysout format 999.99 heading 'Days!Out'
column dayslate format 999.99 heading 'Days!Late'

break on name skip 1 on report
compute sum of latefee on name
set linesize 80
set pagesize 60
set newpage 0

select name, title, returned_date,
   returned_date-checkout_date as daysout /*count days*/,
   returned_date-checkout_date -14  dayslate,
  (returned_date-checkout_date -14)*0.20  latefee
from bookshelf_checkout
where returned_date-checkout_date > 14
order by name, checkout_date;

clear compute
clear break
select returned_date, name,
   sum((returned_date-checkout_date -14)*0.20)  latefee
from bookshelf_checkout
where returned_date-checkout_date > 14
group by returned_date, name
order by returned_date, name;

select to_char(returned_date,'MONTH') month, name,
   sum((returned_date-checkout_date -14)*0.20)  latefee
from bookshelf_checkout
where returned_date-checkout_date > 14
group by to_char(returned_date,'MONTH'), name;

select to_char(returned_date,'MONTH') month, name,
   sum((returned_date-checkout_date -14)*0.20)  latefee
from bookshelf_checkout
where returned_date-checkout_date > 14
group by rollup(to_char(returned_date,'MONTH'), name);

select decode(grouping(to_char(returned_date,'MONTH')),1,
   'All months',to_char(returned_date,'MONTH')) month,
   decode(grouping(name),1, 'All names',name) name,
   sum((returned_date-checkout_date -14)*0.20)  latefee
from bookshelf_checkout
where returned_date-checkout_date > 14
group by rollup(to_char(returned_date, 'MONTH'), name);


select decode(grouping(to_char(returned_date,'MONTH')),1,
   'All months',to_char(returned_date,'MONTH')) month,
   decode(grouping(name),1, 'All names',name) name,
   sum((returned_date-checkout_date -14)*0.20) latefee
from bookshelf_checkout
where returned_date-checkout_date > 14
group by cube(to_char(returned_date,'MONTH'), name);

select * 
from breeding
order by birth_date;

column Offspring format a30

select cow, bull, lpad(' ',6*(level-1))||offspring as offspring,
   sex, birth_date
from breeding
start with offspring = 'Eve'
connect by cow = prior offspring;

select cow, bull, lpad(offspring,6*(level-1),' ') as offspring,
   sex, birth_date 
from breeding
start with offspring = 'Eve'
connect by cow = prior offspring;

select cow, bull, lpad(' ',6*(level-1))||offspring as offspring,
   sex, birth_date
from breeding
start with offspring = 'Eve'
connect by cow = prior offspring and offspring != 'Betsy';


select cow, bull, lpad(' ',6*(level-1))||offspring as offspring,
   sex, birth_date
from breeding
where offspring != 'Betsy'
start with offspring = 'Eve'
connect by cow = prior offspring;


select cow, bull, lpad(' ',6*(level-1))||offspring as offspring,
   sex, birth_date
from breeding
start with offspring = 'Della'
connect by offspring = prior cow;

select cow, bull, lpad(' ',6*(level-1))||offspring as offspring,
   sex, birth_date
from breeding
start with offspring = 'Della'
connect by offspring = prior cow
order by birth_date;

select cow, bull, lpad(' ',6*(5-level))||offspring offspring,
    sex, birth_date
from breeding
start with offspring = 'Della'
connect by offspring = prior cow
order by birth_date;

select cow, bull, lpad(' ',6*(level-1))||offspring as offspring,
   sex, birth_date
from breeding
start with offspring = 'Adam'
connect by prior offspring = bull;

select cow, bull, lpad(' ',6*(level-1))||offspring as offspring,
   sex, birth_date
from breeding
start with offspring = 'Bandit'
connect by prior offspring = bull;

select offspring as leaf_offspring,
   cow, bull, sex, birth_date
from breeding
where connect_by_isleaf = 1
start with offspring = 'Eve'
connect by cow = prior offspring;


-- Chapter 15: DML

describe comfort

insert into COMFORT
values ('Walpole', '21-MAR-11',
         56.7, 43.8, 0);

insert into comfort
values ('Walpole', to_date('06/22/2011','MM/DD/YYYY'),
        56.7, 43.8, 0);

insert into comfort
values ('Walpole', to_date('06/22/2011 1:35',
        'MM/DD/YYYY HH24:MI'), 56.7, 43.8, 0);

insert into comfort (sample_date, precipitation, city, noon, midnight)
   values ('23-SEP-11', NULL,'Walpole', 86.3, 72.1);

select * from comfort;

insert into comfort(sample_date,precipitation,city,noon,midnight)
select '22-dec-11', precipitation,'Walpole', noon, midnight
from comfort
where city = 'Keene'
  and sample_date = '22-dec-11';

select * from comfort
where city = 'Walpole';

select city, sample_date,
   to_char(sample_date,'hh24:mi:ss') as timeofday, noon
from comfort
where city = 'Walpole';

insert /*+ append */ into bookshelf (title)
   select title from book_order
   where title not in (select title from bookshelf);


insert into comfort
values ('Walpole', '22-apr-11',50.1, 24.8, 0);

savepoint a;

insert into comfort
values ('Walpole', '27-may-11',63.7, 33.8, 0);

savepoint b;

insert into comfort
values ('Walpole', '07-aug-11',83.0, 43.8, 0);


select * from comfort
where city = 'Walpole';

rollback to savepoint b;

commit;

drop table comfort_test;
create table comfort_test (
  city           varchar2(13) not null,
  sample_date    date not null,
  measure        varchar2(10),
  value          number(3,1)
);

insert all
         into comfort_test (city, sample_date, measure, value)
       values (city, sample_date, 'Noon', noon)
         into comfort_test (city, sample_date, measure, value)
       values (city, sample_date, 'Midnight', midnight)
         into comfort_test (city, sample_date, measure, value)
       values (city, sample_date, 'Precip', precipitation)
select city, sample_date, noon, midnight, precipitation
from comfort
where city = 'Keene';

select * from comfort_test;

delete from comfort_test;
commit;

insert all
       when noon > 80 then
         into comfort_test (city, sample_date, measure, value)
       values (city, sample_date, 'Noon', noon)
       when midnight > 70 then
         into comfort_test (city, sample_date, measure, value)
       values (city, sample_date, 'Midnight', midnight)
       when precipitation is not null then
         into comfort_test (city, sample_date, measure, value)
       values (city, sample_date, 'Precip', precipitation)
select city, sample_date, noon, midnight, precipitation
from comfort
where city = 'Keene';

select * from comfort_test;


delete from comfort_test;
commit;

insert first
       when noon > 80 then
         into comfort_test (city, sample_date, measure, value)
       values (city, sample_date, 'noon', noon)
       when midnight > 70 then
         into comfort_test (city, sample_date, measure, value)
       values (city, sample_date, 'midnight', midnight)
       when precipitation is not null then
         into comfort_test (city, sample_date, measure, value)
       values (city, sample_date, 'precip', precipitation)
select city, sample_date, noon, midnight, precipitation
from comfort
where city = 'Keene';

select * from comfort_test;

drop table comfort2;
create table comfort2 (
city           varchar2(13) not null,
sample_date    date not null,
noon           number(3,1),
midnight       number(3,1),
precipitation  number
);


delete from comfort_test;
delete from comfort2;
commit;

insert first
       when noon > 80 then
         into comfort_test (city, sample_date, measure, value)
       values (city, sample_date, 'Noon', noon)
       when midnight > 100 then
         into comfort_test (city, sample_date, measure, value)
       values (city, sample_date, 'Midnight', midnight)
       when precipitation > 100 then
         into comfort_test (city, sample_date, measure, value)
       values (city, sample_date, 'precip', precipitation)
    else
         into comfort2
select city, sample_date, noon, midnight, precipitation
  from comfort
where city = 'Keene';

select * from comfort_test;

select * from comfort2;

select * from comfort
where city = 'Walpole';

rollback;

update comfort set precipitation = .5, midnight = 73.1
where city = 'Keene'
  and sample_date = '22-dec-11';

select * from comfort
where city = 'Keene';

update comfort set midnight = midnight - 1, noon = noon - 1
where city = 'Keene';

select * from comfort
where city = 'Keene';

update comfort set midnight =
       (select temperature
          from weather
         where city = 'Manchester')
 where city = 'Keene'
   and sample_date = '22-dec-11';

select * from comfort
where city = 'Keene';

update comfort set (noon, midnight) =
       (select humidity, temperature
        from weather
        where city = 'Manchester')
where city = 'Keene'
  and sample_date = '22-dec-11';

select * from comfort
where city = 'Keene';


update comfort set noon = null
where city = 'Keene'
  and sample_date = '22-dec-11';

delete from comfort2;
insert into comfort2
   values ('Keene', '21-mar-11',55, -2.2, 4.4);
insert into comfort2
   values ('Keene', '22-dec-11',55, 66, 0.5);
insert into comfort2
   values ('Keene', '16-may-11', 55, 55, 1);
commit;

select * from comfort2;


select * from comfort where city = 'Keene';

merge into comfort c1
using (select city, sample_date,noon,midnight,precipitation 
       from comfort2)  c2
   on (c1.city = c2.city and c1.sample_date=c2.sample_date)
when matched then
      update set noon = c2.noon
when not matched then
      insert (c1.city, c1.sample_date, c1.noon,
              c1.midnight, c1.precipitation)
      values (c2.city, c2.sample_date, c2.noon,
              c2.midnight, c2.precipitation);

select * from comfort where city = 'Keene';

merge into comfort c1
using (select city, sample_date, noon, midnight,
          precipitation from comfort2)  c2
   on (c1.city = c2.city and c1.sample_date=c2.sample_date)
when matched then
   update set noon = c2.noon
   delete where ( precipitation is null )
 when not matched then
   insert (c1.city, c1.sample_date, c1.noon,
           c1.midnight,c1.precipitation)
   values (c2.city, c2.sample_date, c2.noon,
           c2.midnight,c2.precipitation);

execute dbms_errlog.create_error_log('bookshelf','errlog');
select * from errlog;
insert into bookshelf (title, publisher, categoryname)
   select * from boor_order
   log errors into errlog ('fromorder') reject limit 10;

select * from bookshelf;

select city, temperature 
from weather
order by temperature;

set heading on
column name format a16
column title format a24 word_wrapped
set pagesize 60

select * from BOOKSHELF_CHECKOUT;

describe trouble

select * from trouble;

select * from category;

describe comfort

select * from comfort;

select * from birthday;

select feature, section, page
  from newspaper
 where page = 6;


select city, sample_date, precipitation
from comfort;

select city, country from location;

select city from weather
where condition = 'Cloudy';

select * from author;

select name, title, checkout_date, returned_date,
       returned_date-checkout_date as daysout /*count days*/
from bookshelf_checkout
order by name, checkout_date;

select city, lower(city), lower('CITY') from weather;
select city||country from location;

select city ||', '||country from location;

select rpad(city,35,'.'), temperature from weather;

select title from magazine;

select rtrim(title,'."') from magazine;

select ltrim(rtrim(title,'."'),'"') from magazine;

select ltrim(rtrim(title,'."'),'"theTHE ')
  from magazine;

select trim('"' from title) from magazine;

select name, rpad(ltrim(rtrim(title,'."'),'"'),47,'-^'), page
from magazine;

select name, ltrim(rtrim(title,'"'),'."'), page
from magazine;

select name, rtrim(title,'."'), page
from magazine;

select City, UPPER(City), LOWER(City), INITCAP(LOWER(City))
from WEATHER;

select name, length(name) from magazine;

select substr(name,6,4) from magazine;

select LastName, FirstName, Phone from ADDRESS;

select LastName, FirstName, Phone from ADDRESS
where Phone like '415-%';


select author, instr(author,'o') from magazine;
select author, instr(author,'o',1,2) from magazine;
select author, instr(author,'William') from magazine;

select Author, SUBSTR(Author,INSTR(Author,',')+2)
               ||' '||
               SUBSTR(Author,1,INSTR(Author,',')-1)
               AS ByFirstName
from MAGAZINE;

select chr(70)||chr(83)||chr(79)||chr(85)||chr(71)
    as chrvalues
  from dual;

select REGEXP_SUBSTR('123-456-7890', '-[^-]+' )
       "REGEXP_SUBSTR"
  from DUAL;

select REGEXP_SUBSTR('123-456-7890', '-[^-]+-' )
       "REGEXP_SUBSTR"
  from DUAL;

select SUBSTR('123-456-7890',
              INSTR('123-456-7890', '-',1,1),
              INSTR('123-456-7890', '-',1,2)-
              INSTR('123-456-7890', '-',1,1))
from DUAL;

select substr('123-456-7890',
       instr('123-456-7890', '-',1,1),
      (instr('123-456-7890', '-',1,2)-
       instr('123-456-7890', '-',1,1))+1)
from dual;

select REGEXP_SUBSTR
       ('MY LEDGER: Debits, Credits, and Invoices 1940',
        ':' )   "REGEXP_SUBSTR"
from dual;

select regexp_substr
       ('MY LEDGER: Debits, Credits, and Invoices 1940',
        '[:punct:]' )   "REGEXP_SUBSTR"
  from dual;

select regexp_substr
       ('MY LEDGER: Debits, Credits, and Invoices 1940',
        '[:punct:][^,]+,' )   "REGEXP_SUBSTR"
  from dual;

select REPLACE('GEORGE', 'GE', 'EG') from dual;

select (length('GEORGE')
       - length(replace('GEORGE', 'GE', null)) ) /
         length('GE')  AS counter
from dual;

select regexp_replace (phone,
       '5', '.',
       1, 2
       ) "REGEXP_REPLACE"
from address;

select (length('GEORGE')
       - length(replace('GEORGE', 'GE', NULL)) ) /
       LENGTH('GE')  AS counter
from dual;


select remainder(6,3),mod(6,3) from dual;
select remainder(7,3),mod(7,3) from dual;
select remainder(7.5,3),mod(7.5,3) from dual;
select remainder(4.5,3),mod(4.5,3) from dual;
select remainder(4.8,3),mod(4.8,3) from dual;
select remainder(4.3,3),mod(4.3,3) from dual;


select to_date('Baby Girl on the Twentieth of May, 1949,
       at 3:27 A.M.',
       '"Baby Girl on the" Ddspth "of" fmMonth, YYYY,
       "at" HH:MI P.M.')
       AS formatted
  from birthday
 where first_name = 'Victoria';

select * from holiday;

column feastday heading "Feast Day"

select add_months(celebrated_date,6) AS feastday
from holiday
where holiday like 'Feast%';


select holiday, actual_date, celebrated_date from holiday;

select holiday, actual_date, celebrated_date
from holiday
where celebrated_date-actual_date != 0;

select add_months(celebrated_date,6) AS halfwayover
from holiday
where holiday like 'New Y%';

select add_months(celebrated_date,6) AS "Half Way Over"
from holiday
where holiday like 'New Y%';

select add_months(celebrated_date,-6) - 1 "Last Day"
from holiday
where holiday = 'Columbus Day';

select holiday, least(actual_date, celebrated_date) as first,
       actual_date, celebrated_date
from holiday
where actual_date - celebrated_date != 0;

select least('20-JAN-12','20-DEC-12') from dual;

select least( to_date('20-JAN-12'), to_date('20-DEC-12') )
from dual;

select holiday, celebrated_date
from holiday
where celebrated_date =  least('16-JAN-12', '03-SEP-12');

select holiday, celebrated_date
from holiday
where celebrated_date = 
  least( to_date('16-JAN-12'), to_date('03-SEP-12') );

select cycle_date from payday;


select next_day(cycle_date,'FRIDAY') "Pay Day"
from payday;

select next_day(cycle_date-1,'FRIDAY') "Pay Day"
from payday;

select last_day(cycle_date) "End Month"
from payday;

select first_name, last_name, birthdate from birthday;

select first_name, last_name, birthdate,
       floor(
             months_between(sysdate,birthdate)/12
             ) as age
from birthday;

select sysdate as today,
       last_day(add_months(sysdate,6)) + 1 review
from dual;

select (last_day(add_months(sysdate,6))+ 1)-sysdate  wait
from dual;

select to_date('29-FEB-12') - sysdate from dual;

column Formatted format a30 word_wrapped
select birthdate,
       to_char(birthdate,'MM/DD/YY') as formatted
from birthday
where first_name = 'Victoria';

column Formatted format a30 word_wrapped

select birthdate,
       to_char(birthdate,'YYMM>DD') as formatted
from birthday
where first_name = 'Victoria';

select birthdate,
       to_char(birthdate,'Month, DDth "in, um,"
               YyyY') as formatted
from birthday;

select birthdate, to_char(birthdate,'Month, ddth, YyyY')
        as formatted
from birthday;

select birthdate, to_char(birthdate,'fmMonth, ddth, YyyY')
        as formatted
from birthday;

select first_name, birthdate, to_char(birthdate,
'"Baby Girl on" fmMonth ddth, YYYY, "at" HH:MI "in the Morning"')
       AS formatted
from birthday
where first_name = 'Victoria';


select first_name, birthdate, to_char(birthdate,
'"Baby Girl on the" Ddsp "of" fmMonth, YYYY, "at" HH:MI')
        AS formatted
from birthday
where first_name = 'Victoria';

select first_name, birthdate, to_char(birthdate,
'"Baby Girl on the" Ddspth "of" fmMonth, YYYY, "at" HH:MI')
        AS formatted
from birthday
where first_name = 'Victoria';

select first_name, birthdate, to_char(birthdate,
'"Baby Girl on the" Ddspth "of" fmMonth, YYYY, "at" HH:MI P.M.')
        AS formatted
from birthday
where first_name = 'Victoria';


select birthdate, new_time(birthdate,'EST','HST')
from birthday
where first_name = 'Victoria';


select to_char(birthdate,'fmMonth Ddth, YYYY "at" HH:MI AM') as birth,
       to_char(new_time(birthdate,'EST','HST'),
       'fmMonth ddth, YYYY "at" HH:MI AM') as birth
from birthday
where first_name = 'Victoria';

select to_date('Baby Girl on the Twentieth of May, 1949,
       at 3:27 A.M.',
       '"Baby Girl on the" Ddspth "of" fmMonth, YYYY,
       "at" HH:MI P.M.')
       AS formatted
from birthday
where first_name = 'Victoria';

select holiday, actual_date, celebrated_date
from holiday
where celebrated_date - actual_date != 0;

select holiday, celebrated_date
from holiday
where celebrated_date between
       '01-JAN-12' and '22-FEB-12';


select holiday, celebrated_date
from holiday
where celebrated_date in ('02-JAN-12', '20-FEB-12');

select holiday, celebrated_date
from holiday
where celebrated_date in
       (TO_DATE('02-JAN-2012','DD-MON-YYYY'),
        to_date('20-FEB-2012','DD-MON-YYYY'));

insert into birthday
(first_name, last_name, birthdate)
values
('Alicia', 'Ann', '21-NOV-49');


select to_char(birthdate,'DD-MON-YYYY') AS bday
from birthday
where first_name = 'Alicia'
  and last_name = 'Ann';


select birthdate,
       extract(month from birthdate) as month
from birthday
where first_name = 'Victoria';

-- test COALESCE
select lastname, city, state, zip,
   coalesce(to_char(zip),city||nvl2(state,' ',null)||state,firstname) best_location
from address
where lastname in ('Zack','Yarrow','Adams');

select upper('Fred') from dual;


-- Chapter 20: VPD

connect / as SYSDBA
grant create session to ADAMS identified by john7;
grant create session to BURLINGTON identified by newj2;

grant create session to practice identified by practice;
grant CREATE ANY CONTEXT, CREATE PUBLIC SYNONYM to PRACTICE;
grant create any table to practice;
grant create any procedure to practice;
grant unlimited tablespace to practice;
grant execute on DBMS_RLS to practice;

-- as PRACTICE
create table STOCK_ACCOUNT
(Account         NUMBER(10),
Account_LongName  VARCHAR2(50));

insert into STOCK_ACCOUNT values (
1234, 'ADAMS');
insert into STOCK_ACCOUNT values (
7777, 'BURLINGTON');

create table STOCK_TRX (
Account   NUMBER(10),
Symbol    VARCHAR2(20),
Price     NUMBER(6,2),
Quantity  NUMBER(6),
Trx_Flag  VARCHAR2(1));

insert into STOCK_TRX values (
  1234, 'ADSP', 31.75, 100, 'B');
insert into STOCK_TRX values (
  7777, 'ADSP', 31.50, 300, 'S');
insert into STOCK_TRX values (
  1234, 'ADSP', 31.55, 100, 'B');
insert into STOCK_TRX values (
  7777, 'OCKS', 21.75, 1000, 'B');
commit;

grant select, insert on stock_trx to adams, burlington;
grant select on stock_account to adams, burlington;

create context PRACTICE using PRACTICE.CONTEXT_PACKAGE;

create or replace package context_package as
  procedure set_context;
end;

create or replace package body context_package is
  procedure set_context is
    v_user  varchar2(30);
    v_id    number;
  begin
    dbms_session.set_context('PRACTICE','SETUP','TRUE');
    v_user := sys_context('USERENV','SESSION_USER');
    begin
      select account
        into v_id
        from stock_account
       where account_longname = v_user;
      dbms_session.set_context('PRACTICE','USER_ID', v_id);
    exception
      when no_data_found then
        dbms_session.set_context('PRACTICE','USER_ID', 0);
    end;
    dbms_session.set_context('PRACTICE','SETUP','FALSE');
  end set_context;
end context_package;
/

grant execute on practice.context_package to public;
create public synonym context_package for practice.context_package;

create or replace trigger practice.set_security_context
after logon on database
begin
  practice.context_package.set_context;
end;
/

create or replace package security_package as
  function stock_trx_insert_security(owner varchar2, objname varchar2)
    return varchar2;
  function stock_trx_select_security(owner varchar2, objname varchar2)
    return varchar2;
end security_package;
/

create or replace package body security_package is
  function stock_trx_select_security(owner varchar2, objname varchar2)
  return varchar2 is
    predicate varchar2(2000);
  begin
    predicate := '1=2';
    if (sys_context('USERENV','SESSION_USER') = 'PRACTICE') then
      predicate := null;
    else
      predicate := 'account = sys_context(''PRACTICE'',''USER_ID'')';
    end if;
    return predicate;
  end stock_trx_select_security;

  function stock_trx_insert_security(owner varchar2, objname varchar2)
   return varchar2 is
    predicate varchar2(2000);
  begin
    predicate := '1=2';
    if (sys_context('USERENV','SESSION_USER') = 'PRACTICE') then
      predicate := null;
    else
      predicate := 'account = sys_context(''PRACTICE'',''USER_ID'')';
    end if;
    return predicate;
  end stock_trx_insert_security;
end security_package;
/

grant execute on practice.security_package to public;
create public synonym security_package for practice.security_package;

begin
  dbms_rls.add_policy('PRACTICE', 'STOCK_TRX', 'STOCK_TRX_INSERT_POLICY',
                      'PRACTICE', 'SECURITY_PACKAGE.STOCK_TRX_INSERT_SECURITY',
                      'INSERT', TRUE);
  dbms_rls.add_policy('PRACTICE', 'STOCK_TRX', 'STOCK_TRX_SELECT_POLICY',
                      'PRACTICE', 'SECURITY_PACKAGE.STOCK_TRX_SELECT_SECURITY',
                      'SELECT');
end;
/

begin
   dbms_rls.add_policy
              (object_schema=>'PRACTICE',
                 object_name=>'STOCK_TRX',
                 policy_name=>'STOCK_TRX_SELECT_POLICY2',
             function_schema=>'PRACTICE',
             policy_function=>'SECURITY_PACKAGE.STOCK_TRX_SELECT_SECURITY',
           sec_relevant_cols=>'Price');
end;
/

begin
dbms_rls.create_policy_group('PRACTICE','STOCK_TRX','TRXAUDIT');
dbms_rls.add_grouped_policy('PRACTICE','STOCK_TRX','TRXAUDIT',
'STOCK_TRX_SELECT_POLICY','PRACTICE', 'SECURITY_PACKAGE.STOCK_TRX_SELECT_SECURITY');
end;
/

create context practice2 using practice.context_package;

-- chapter 21: TDE

alter system set encryption key authenticated by "rjb123";

/*
# sqlnet.ora Network Configuration File: /u01/app/product/12.1.0/database/network/admin/sqlnet.ora
# Generated by Oracle configuration tools.

NAMES.DIRECTORY_PATH= (TNSNAMES, EZCONNECT)

encryption_wallet_location=
   (source=
      (method=file)
         (method_data=
            (directory=/u01/app/product/12.1.0/database/network/admin/wallet)))
*/

alter table address modify
(phone encrypt no salt);

alter table address add
   (mobilephone varchar2(20) encrypt no salt);

select distinct encrypted from dba_tablespaces;

-- chapter 27: Oracle Text

select title
  from book_review_context
 where contains(review_text, '?hardest')>0;

select title
  from book_review_context
 where contains(review_text, '{fuzzy(hardest,60,100,w}')>0;

select title
  from book_review_context
 where contains(review_text, '{fuzzy(hardest,60,5,weight}',1)>0;



-- Chapter 29: Flashback

column title format a30
select * from book_order;
delete from book_order; commit;
select COUNT(*) from BOOK_ORDER;

select count(*) from book_order
   as of timestamp (sysdate - 5/1440);

create table book_order_old
as select * from book_order
 as of timestamp (sysdate - 5/1440);

select * from book_order_old;

insert into book_order select * from book_order_old; commit;


variable scn_flash number;
execute :scn_flash := dbms_flashback.get_system_change_number;
print scn_flash

delete from book_order_old; commit;

select count(*) from book_order_old
   as of scn (:scn_flash);

insert into BOOK_ORDER_OLD
select * from BOOK_ORDER_OLD
   as of scn (:scn_flash);
commit;

select title, ora_rowscn from book_order;

insert into book_order
values ('Innumeracy','Vintage Books','ADULTNF');
commit;

select title, ora_rowscn from book_order;

select scn_to_timestamp(2035159) from dual;

select title, scn_to_timestamp(ora_rowscn)
from book_order;

delete from book_order;

select systimestamp from dual;

insert into book_order
select * from book_order_old;

update book_order set category_name = 'ADULTF';

select systimestamp from dual;

select *
from book_order
versions between timestamp
   to_timestamp('29–APR-13 12.35.42','dd-mon-yy hh24.mi.ss')
   and
   to_timestamp('29–APR-13 13.01.08','dd-mon-yy hh24.mi.ss') ;


select *
from book_order
versions between timestamp
   to_timestamp('29–APR-13 12.48.00','dd-mon-yy hh24.mi.ss')
   and
   to_timestamp('29–APR-13 13.01.08','dd-mon-yy hh24.mi.ss') ;


select title, versions_startscn, versions_operation
  from book_order
versions between timestamp
   to_timestamp('29–APR-13 13.06.00','dd-mon-yy hh24.mi.ss')
   and
   to_timestamp('29–APR-13 13.10.08','dd-mon-yy hh24.mi.ss') ;

create or replace procedure anystring(string in varchar2) as
begin
   execute immediate (string);
end;

-- chapter 32 PL/SQL

declare
  pi     constant number(9,7) := 3.1415927;
  area   number(14,2);
  cursor rad_cursor is
      select * from radius_vals;
  rad_val rad_cursor%rowtype;
begin
  open rad_cursor;
  fetch rad_cursor into rad_val;
    area := pi*power(rad_val.radius,2);
    if  area > 30
      then
        insert into areas values (rad_val.radius, area);
    end if;
  close rad_cursor;
end;
/

declare
  pi     constant number(9,7) := 3.1415927;
  radius integer(5);
  area   number(14,2);
begin
  radius := 3;
  loop
    area := pi*power(radius,2);
      insert into areas values (radius, area);
    radius := radius+1;
    exit when area >100;
  end loop;
end;
/

declare
  pi     constant number(9,7) := 3.1415927;
  area   number(14,2);
  cursor rad_cursor is
      select * from radius_vals;
  rad_val rad_cursor%rowtype;
begin
  open rad_cursor;
  loop
    fetch rad_cursor into rad_val;
    exit when rad_cursor%notfound;
      area := pi*power(rad_val.radius,2);
      insert into areas values (rad_val.radius, area);
  end loop;
  close rad_cursor;
end;
/

-- Chapter 28: external tables

create directory book_dir as '/u01/external';
grant read,write on directory book_dir to hr;

/*
connect hr/hr

set pagesize 0 newpage 0 feedback off
select title||'~'||publisher||'~'||category_name||'~'||rating||'~'
from bookshelf
order by title

spool /u01/external/bookshelf_dump.lst
/
spool off

select title||'~'||author_name||'~'
from bookshelf_author
order by title

spool /u01/external/book_auth_dump.lst
/
spool off
*/

-- as HR
create table bookshelf_ext
(title        varchar2(100),
publisher     varchar2(20),
category_name varchar2(20),
rating        varchar2(2)
)
organization external
(type oracle_loader
 default directory book_dir
 access parameters (records delimited by newline
 fields terminated by "~"
                    (title         char(100),
                     publisher     char(20),
                     category_name char(20),
                     rating        char(2)
                   ))
 location ('bookshelf_dump.lst')
);
select * from bookshelf_ext;

drop table bookshelf_author_ext;
create table bookshelf_author_ext
(title       varchar2(100),
author_name   varchar2(50)
)
organization external
(type oracle_loader
 default directory book_dir
 access parameters (records delimited by newline
                     fields terminated by "~"
                    (title        char(100),
                     author_name  char(50)
                   ))
 location ('book_auth_dump.lst')
);
select * from bookshelf_author_ext;

select title from bookshelf
where category_name = 'CHILDRENPIC';

select title from bookshelf_ext
where category_name = 'CHILDRENPIC';

select count(*) from bookshelf_author;

select * from bookshelf_author ba
where not exists
(select null from bookshelf_author_ext bae
 where ba.title = bae.title
 and ba.author_name = bae.author_name);


create table bookshelf_ext_2
(title        varchar2(100),
publisher     varchar2(20),
category_name varchar2(20),
rating        varchar2(2)
)
organization external
(type oracle_loader
 default directory book_dir
 access parameters (records delimited by newline
                    skip 1
                    fields terminated by
                    "~"
                    (title         char(100),
                     publisher     char(20),
                     category_name char(20),
                     rating        char(2)
                   ) )
 location ('bookshelf_dump_2.lst')
)
reject limit 1
;

select count(*) from bookshelf_ext_2;

drop table bookshelf_ext_3;
create table bookshelf_ext_3
(title        varchar2(100),
publisher     varchar2(20),
category_name varchar2(20),
rating        varchar2(2)
)
organization external
(type oracle_loader
 default directory book_dir
 access parameters (records delimited by newline
                    load when category_name = 'CHILDRENPIC'
                                        skip 1
                    fields terminated by "~"
                    (title         char(100),
                     publisher     char(20),
                     category_name char(20),
                     rating        char(2)
                   ) )
 location ('bookshelf_dump_2.lst')
)
reject limit 1
;
select * from bookshelf_ext_3;

create table bookshelf_ext_4
(title        varchar2(100),
publisher     varchar2(20),
category_name varchar2(20),
rating        varchar2(2)
)
organization external
(type oracle_loader
 default directory book_dir
 access parameters (records delimited by newline
                    skip 1
                    fields terminated by "~"
                    (title         char(100),
                     publisher     char(20),
                     category_name  char(20),
                     rating        char(2)
                   ) )
 location ('bookshelf_dump_2.lst', 'bookshelf_dump.lst')
)
reject limit 1
;
select count(*) from bookshelf_ext_4;

alter table bookshelf_ext_4
access parameters (records delimited by newline
                    skip 10
                    fields terminated by "~"
                    (title         char(100),
                     publisher     char(20),
                     category_name char(20),
                     rating        char(2)
                   ) );
select count(*) from bookshelf_ext_4;

column Comments format a35 word_wrapped
column Table_Name format a25

select Table_Name, Comments
  from DICT
 where Table_Name like '%MVIEWS%'
 order by Table_Name;

select table_name
  from dict_columns
 where column_name = 'BLOCKS'
   and table_name like 'USER%'
 order by table_name;

select distinct column_name
  from dict_columns
 order by column_name;

select table_name, table_type
  from user_catalog
 where table_name like 'T%';

describe database_export_objects
describe dba_object_usage
describe user_object_usage
describe v$object_usage

alter index hr.EMP_EMP_ID_PK monitoring usage;
select * from v$object_usage;
select * from hr.employees where employee_id = 107;

-- Chapter 47: result cache

select * from v$result_cache_statistics;
select * from dictionary where table_name like '%RESULT%';

select dbms_result_cache.status from dual;
execute dbms_result_cache.invalidate ('HR','EMPLOYXEES');
select * from dba_objects where object_name like 'V_$%CLIENT%';
select * from CLIENT_RESULT_CACHE_STATS$;

select * from v$spparameter where name like '%open_files%';

-- as another user

create or replace type animal_ty as object
(breed      varchar2(25),
 name       varchar2(25),
 birth_date  date);

create table animal of animal_ty;

insert into animal values
       (ANIMAL_TY('Mule','Frances', '01-APR-12'));
insert into animal values
       (ANIMAL_TY('Dog','Benji''Annie', '03-SEP-11'));
insert into animal values
       (ANIMAL_TY('Crocodile','Lyle', '14-MAY-10'));
commit;

select ref(a)
from animal  a
where name = 'Frances';

create table keeper
(keeper_name     varchar2(25),
 animal_kept     ref  animal_ty);

select * from v$instance;

-- PL/SQL within SQL

drop table order_source;
create table order_source
(order_num      number,
 order_url      varchar2(150));

insert into order_source values(3890782,'http://www.EpikOutfitters.com/kiosk_mdse');
insert into order_source values(4909893,'https://www.rjbMedSuppliesOnline.com/EpiGear');
insert into order_source values(7903442,'http://www.WorldWearhouseDeals.com/SpringFashion');
insert into order_source values(4910875,'https://www.rjbMedSuppliesOnline.com/EpiPen');
commit;

select order_num, order_url from order_source;

drop function get_domain;
create or replace
function get_domain(url varchar2) return varchar2 is
   surl         varchar2(200);
   www_pos      pls_integer;
   page_loc     pls_integer;
begin
   surl := url;
   www_pos := instr(url,'www.');
   if www_pos > 0 then
      surl := substr(surl,www_pos+4);
   end if;
   page_loc := instr(surl,'/');
   if page_loc > 0 then
      surl := substr(surl,1,page_loc-1);
   end if;
   return surl;
end;

with
function get_domain(url varchar2) return varchar2 is
   surl         varchar2(200);
   www_pos      pls_integer;
   page_loc     pls_integer;
begin
   surl := url;
   www_pos := instr(url,'www.');
   if www_pos > 0 then
      surl := substr(surl,www_pos+4);
   end if;
   page_loc := instr(surl,'/');
   if page_loc > 0 then
      surl := substr(surl,1,page_loc-1);
   end if;
   return surl;
end;
select distinct get_domain(order_url)
from order_source;
/


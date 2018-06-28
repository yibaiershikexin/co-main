-- Oracle Database 12c Complete Reference
-- setup for sample tables and other objects
-- run this entire script in the schema
-- of your choice

create or replace type ADDRESS_TY as object
(Street  VARCHAR2(50),
 City    VARCHAR2(25),
 State   CHAR(2),
 Zip     NUMBER);
/

create or replace type ANIMAL_TY as object
(Breed      VARCHAR2(25),
 Name       VARCHAR2(25),
 BirthDate  DATE,
member function AGE (BirthDate IN DATE) return NUMBER);
/

create or replace type body ANIMAL_TY as
member function Age (BirthDate DATE) return NUMBER is
begin
  RETURN ROUND(SysDate - BirthDate);
end;
end;
/

rem  For the Nested Table examples:
create type ANIMALS_NT as table of ANIMAL_TY;
/

rem  Requires that the ADDRESS_TY type already exist.

create type PERSON_TY as object
(Name      VARCHAR2(25),
 Address   ADDRESS_TY);
/

rem  Creates a varying array datatype.

create or replace type TOOLS_VA as varray(5) of VARCHAR2(25);
/

-- drop table ADDRESS;
create table ADDRESS (
LastName   VARCHAR2(25),
FirstName  VARCHAR2(25),
Street     VARCHAR2(50),
City       VARCHAR2(25),
State      CHAR(2),
Zip        NUMBER,
Phone      VARCHAR2(12),
Ext        VARCHAR2(5)
);

insert into ADDRESS values ('Bailey', 'William',
     null,null,null,null,'213-555-0223',null);
insert into ADDRESS values ('Adams', 'Jack',
     null,null,null,null,'415-555-7530',null);
insert into ADDRESS values ('Soda', 'Angelina',
     null,null,null,null,'214-555-8383',null);
insert into ADDRESS values ('De Medeci', 'Lefty',
     null,null,null,null,'312-555-1166',null);
insert into ADDRESS values ('Demiurge', 'Frank',
     null,null,null,null,'707-555-8900',null);
insert into ADDRESS values ('Casey', 'Willis',
     null,null,null,null,'312-555-1414',null);
insert into ADDRESS values ('Zack', 'Jack',
     null,null,null,null,'415-555-6842',null);
insert into ADDRESS values ('Yarrow', 'Mary',
     null,null,null,949414302,'415-555-2178',null);
insert into ADDRESS values ('Werschky', 'Arny',
     null,null,null,null,'415-555-7387',null);
insert into ADDRESS values ('Brant', 'Glen',
     null,null,null,null,'415-555-7512',null);
insert into ADDRESS values ('Edgar', 'Theodore',
     null,null,null,null,'415-555-6252',null);
insert into ADDRESS values ('Hardin', 'Huggy',
     null,null,null,null,'617-555-0125',null);
insert into ADDRESS values ('Hild', 'Phil',
     null,null,null,null,'603-555-2242',null);
insert into ADDRESS values ('Loebel', 'Frank',
     null,null,null,null,'202-555-1414',null);
insert into ADDRESS values ('Moore', 'Mary',
     null,null,null,601262460,'718-555-1638',null);
insert into ADDRESS values ('Szep', 'Felicia',
     null,null,null,null,'214-555-8383',null);
insert into ADDRESS values ('Ziffel', 'Barney',
     null,null,null,null,'503-555-7491',null);

-- drop table AREAS;
create table AREAS
(Radius      NUMBER(5),
 Area        NUMBER(14,2)
);

REMARK No inserts. This table is empty.

-- drop table AUTHOR;
create table AUTHOR
(Author_Name  VARCHAR2(50) primary key,
Comments      VARCHAR2(100));

insert into author values
('Dietrich Bonhoeffer', 'German theologian, killed in a war camp');
insert into author values
('Robert Bretall','Kierkegaard anthologist');
insert into author values
('Alexandra Day','Author of picture books for children');
insert into author values
('Stephen Jay Gould','Science columnist, harvard professor');
insert into author values
('Soren Kierkegaard','Danish philosopher and theologian');
insert into author values
('Harper Lee','American novelist, published only one novel');
insert into author values
('Lucy Maud Montgomery','Canadian novelist');
insert into author values
('John Allen Paulos','Mathematics professor');
insert into author values
('J. Rodale', 'Organic gardening expert');
insert into author values
('Daniel Boorstin', 'Librarian of congress');
insert into author values
('Chris Van Allsburg', 'Illustrator');
insert into author values
('Margaret Wise Brown', 'Editor and author');
insert into author values
('Clement Hurd', 'Illustrator');
insert into author values
('G. B. Talbot', 'Famous ledgerist');
insert into author values
('John Keats', 'Romantic poet');
insert into author values
('John Barnard', 'Keats editor');
insert into author values
('Christopher Nolan', 'Poet and author');
insert into author values
('David McCullough', 'Historian');
insert into author values
('Meriwether Lewis', 'Explorer and journalist');
insert into author values
('William Clark', 'Explorer and journalist');
insert into author values
('Stephen Ambrose',null);
insert into author values
('Bernard de Voto', 'Editor');
insert into author values
('Wilton Barnhardt', 'American author');
insert into author values
('Avi', 'Prolific author of books for children');
insert into author values
('J. K. Rowling', 'Author of harry potter series');
insert into author values
('W. P. Kinsella', 'Author and writing professor');
insert into author values
('E. B. White', 'Author and essayist');
insert into author values
('Beryl Markham', 'Aviator and adventuress');
insert into author values
('Peter Gomes', 'Harvard theologian');
insert into author values
('Thomas Swears', 'Pastor and author');
insert into author values
('E. Annie Proulx',null);
update author set author_name=initcap(author_name);

commit;


-- drop table BIRTHDAY;
create table BIRTHDAY (
First_Name     VARCHAR2(15),
Last_Name      VARCHAR2(15),
BirthDate      DATE,
Age            NUMBER,
constraint PK_BIRTHDAY primary key (First_Name, Last_Name)
);

insert into BIRTHDAY values ('George','Sand',
        TO_DATE('12-MAY-1976','DD-MON-YYYY'),null);
insert into BIRTHDAY values ('Robert','James',
        TO_DATE('23-AUG-1967','DD-MON-YYYY'),null);
insert into BIRTHDAY values ('Nancy','Lee',
        TO_DATE('02-FEB-1977','DD-MON-YYYY'),null);
insert into BIRTHDAY values ('Victoria','Lynn',
        TO_DATE('20-MAY-1979 3:27','DD-MON-YYYY HH24:MI'),null);
insert into BIRTHDAY values ('Frank','Pilot',
        TO_DATE('11-NOV-1972','DD-MON-YYYY'),null);
update birthday set age=trunc((sysdate-birthdate)/365);


-- drop table BOOK_ORDER;
create table BOOK_ORDER
(Title       VARCHAR2(100) primary key,
Publisher    VARCHAR2(20),
Category_Name VARCHAR2(20));


Insert into BOOK_ORDER values
('Shoeless Joe','Mariner','ADULTFIC');
Insert into BOOK_ORDER values
('Gospel','Picador','ADULTFIC');
Insert into BOOK_ORDER values
('Something So Strong','Pandoras','ADULTNF');
Insert into BOOK_ORDER values
('Galileo''s Daughter','Penguin','ADULTNF');
Insert into BOOK_ORDER values
('Longitude','Penguin','ADULTNF');
Insert into BOOK_ORDER values
('Once Removed','Sanctuary Pub','ADULTNF');

commit;



create table BOOK_REVIEW_CONTEXT
(Title       VARCHAR2(100) primary key,
Reviewer     VARCHAR2(25),
Review_Date  DATE,
Review_Text  VARCHAR2(4000));

insert into BOOK_REVIEW_CONTEXT values
('My Ledger', 'Emily Talbot', '01-MAY-12',
'A fascinating look into the transactions and finances of G. B. Talbot and Dora Talbot as they managed a property in New Hampshire around 1900.  The stories come through the purchases – for medicine, doctor visits and gravesites – for workers during harvests – for gifts at the general store at Christmas.  A great read. ');

create index review_context_index
    on book_review_context(review_text)
indextype is ctxsys.context;

create table BOOK_REVIEW_CTXCAT
(Title       VARCHAR2(100) primary key,
Reviewer     VARCHAR2(25),
Review_Date  DATE,
Review_Text  VARCHAR2(4000));

create index review_ctxcat_index
    on book_review_ctxcat(review_text)
indextype is ctxsys.ctxcat;

insert into BOOK_REVIEW_CTXCAT values
('My Ledger', 'Emily Talbot', '01-MAY-12',
'A fascinating look into the transactions and finances of G. B. Talbot and Dora Talbot as they managed a property in New Hampshire around 1900.  The stories come through the purchases – for medicine, doctor visits and gravesites – for workers during harvests – for gifts at the general store at Christmas.  A great read. ');

-- drop table CATEGORY;
create table CATEGORY
(Category_Name    VARCHAR2(12) primary key,
 Parent_Category  VARCHAR2(8),
 Sub_Category     VARCHAR2(20));

Insert into CATEGORY values
('ADULTREF','ADULT','REFERENCE');
Insert into CATEGORY values
('ADULTFIC','ADULT','FICTION');
Insert into CATEGORY values
('ADULTNF','ADULT','NONFICTION');
Insert into CATEGORY values
('CHILDRENPIC','CHILDREN','PICTURE BOOK');
Insert into CATEGORY values
('CHILDRENFIC','CHILDREN','FICTION');
Insert into CATEGORY values
('CHILDRENNF','CHILDREN','NONFICTION');
commit;


REM  The CATFK foreign key requires that the CATEGORY table
REM  is created and populated before BOOKSHELF.

-- drop table BOOKSHELF;
create table BOOKSHELF
(Title        VARCHAR2(100) primary key,
Publisher     VARCHAR2(20),
Category_Name VARCHAR2(20),
Rating        VARCHAR2(2), 
constraint CATFK foreign key (Category_Name) 
references CATEGORY(Category_Name));
alter table bookshelf disable constraint catfk;

insert into bookshelf values
('To Kill a Mockingbird','Harper Collins','adultfic','5');
insert into bookshelf values
 ('Wonderful Life','W.W. Norton','adultnf','5');
insert into bookshelf values
 ('Innumeracy','Vintage Books','adultnf','4');
insert into bookshelf values
 ('Kierkegaard Anthology','Princeton Univ Pr','adultref','3');
insert into bookshelf values
 ('Anne of Green Gables','Grammercy','childrenfic','3');
insert into bookshelf values
 ('Good Dog, Carl','Little Simon','childrenpic','1');
insert into bookshelf values
 ('Letters and Papers from Prison','Scribner','adultnf','4');
insert into bookshelf values
 ('The Discoverers','Random House','adultnf','4');
insert into bookshelf values
 ('The Mismeasure of Man','W.W. Norton','adultnf','5');
insert into bookshelf values
 ('Either/Or','Penguin','adultref','3');
insert into bookshelf values
 ('Polar Express','Houghton Mifflin','childrenpic','1');
insert into bookshelf values
('Runaway Bunny','Harper Festival','childrenpic','1');
insert into bookshelf values
('My Ledger','Bryla Press','adultnf','5');
insert into bookshelf values
('Complete Poems of John Keats','Viking','adultref','2');
insert into bookshelf values
('Under the Eye of the Clock','Arcade Pub','childrennf','3');
insert into bookshelf values
('John Adams','Simon Schuster','adultnf','4');
insert into bookshelf values
('Truman','Simon Schuster','adultnf','4');
insert into bookshelf values
('Journals of Lewis and Clark','Mariner','adultnf','4');
insert into bookshelf values
('Gospel','Picador','adultfic','4');
insert into bookshelf values
('Emma Who Saved My Life','St Martin''s Press','adultfic','3');
insert into bookshelf values
('Midnight Magic','Scholastic','childrenfic','1');
insert into bookshelf values
('Harry Potter and the Goblet of Fire','Scholastic','childrenfic','4');
insert into bookshelf values
('Shoeless Joe','Mariner','adultfic','3');
insert into bookshelf values
('Box Socials','Ballantine','adultfic','3');
insert into bookshelf values
('Trumpet of the Swan','Harper Collins','childrenfic','3');
insert into bookshelf values
('Charlotte''s Web','Harper Trophy','childrenfic','3');
insert into bookshelf values
('West With the Night','North Point Press','adultnf','3');
insert into bookshelf values
('The Good Book','Bard','adultref','4');
insert into bookshelf values
('Preaching to Head and Heart','Abingdon Press','adultref','4');
insert into bookshelf values
('The Cost of Discipleship','Touchstone','adultref','3');
insert into bookshelf values
('The Shipping News','Simon Schuster','adultfic','4');
update bookshelf set category_name = upper(category_name),title=initcap(title),publisher=initcap(publisher);
update bookshelf set title='Charlotte''s Web' where title='Charlotte''S Web';
alter table bookshelf enable constraint catfk;
commit;

-- drop table BOOKSHELF_AUDIT;
create table BOOKSHELF_AUDIT
(Title        VARCHAR2(100),
Publisher     VARCHAR2(20),
Category_Name VARCHAR2(20),
Old_Rating    VARCHAR2(2),
New_Rating    VARCHAR2(2),
Audit_Date    DATE); 


REM    The AUTHOR, CATEGORY, and BOOKSHELF tables 
REM    must be created before BOOKSHELF_AUTHOR.

-- drop table BOOKSHELF_AUTHOR;
create table BOOKSHELF_AUTHOR
(Title       VARCHAR2(100),
Author_Name  VARCHAR2(50),
constraint  TitleFK Foreign key (Title) 
   references BOOKSHELF(Title),
constraint  AuthorNameFK Foreign key (Author_Name) 
   references  AUTHOR(Author_Name));
alter table bookshelf_author disable constraint TitleFK;
alter table bookshelf_author disable constraint AuthorNameFK;

insert into bookshelf_author values
('To Kill a Mockingbird','Harper Lee');
insert into bookshelf_author values
 ('Wonderful Life','Stephen Jay Gould');
insert into bookshelf_author values
 ('Innumeracy','John Allen Paulos');
insert into bookshelf_author values
 ('Kierkegaard Anthology','Robert Bretall');
insert into bookshelf_author values
 ('kierkegaard anthology','soren kierkegaard');
insert into bookshelf_author values
 ('anne of green gables','lucy maud montgomery');
insert into bookshelf_author values
 ('good dog, carl','alexandra day');
insert into bookshelf_author values
 ('letters and papers from prison','dietrich bonhoeffer');
insert into bookshelf_author values
 ('the discoverers','daniel boorstin');
insert into bookshelf_author values
 ('the mismeasure of man','stephen jay gould');
insert into bookshelf_author values
 ('either/or','soren kierkegaard');
insert into bookshelf_author values
 ('polar express','chris van allsburg');
insert into bookshelf_author values
('runaway bunny','margaret wise brown');
insert into bookshelf_author values
('runaway bunny','clement hurd');
insert into bookshelf_author values
('my ledger','g. b. talbot');
insert into bookshelf_author values
('complete poems of john keats','john keats');
insert into bookshelf_author values
('complete poems of john keats','john barnard');
insert into bookshelf_author values
('under the eye of the clock','christopher nolan');
insert into bookshelf_author values
('john adams','david mccullough');
insert into bookshelf_author values
('truman','david mccullough');
insert into bookshelf_author values
('journals of lewis and clark','meriwether lewis');
insert into bookshelf_author values
('journals of lewis and clark','william clark');
insert into bookshelf_author values
('journals of lewis and clark','stephen ambrose');
insert into bookshelf_author values
('journals of lewis and clark','bernard de voto');
insert into bookshelf_author values
('gospel','wilton barnhardt');
insert into bookshelf_author values
('emma who saved my life','wilton barnhardt');
insert into bookshelf_author values
('midnight magic','avi');
insert into bookshelf_author values
('harry potter and the goblet of fire','j. k. rowling');
insert into bookshelf_author values
('shoeless joe','w. p. kinsella');
insert into bookshelf_author values
('box socials','w. p. kinsella');
insert into bookshelf_author values
('trumpet of the swan','e. b. white');
insert into bookshelf_author values
('charlotte''s web','e. b. white');
insert into bookshelf_author values
('west with the night','beryl markham');
insert into bookshelf_author values
('the good book','peter gomes');
insert into bookshelf_author values
('preaching to head and heart','thomas swears');
insert into bookshelf_author values
('the cost of discipleship','dietrich bonhoeffer');
insert into bookshelf_author values
('the shipping news','e. annie proulx');
update bookshelf_author set title=initcap(title), author_name=initcap(author_name);
alter table bookshelf_author enable constraint TitleFK;
alter table bookshelf_author enable constraint AuthorNameFK;
commit;


-- drop table BOOKSHELF_CHECKOUT;
create table BOOKSHELF_CHECKOUT
(Name  VARCHAR2(25),
 Title VARCHAR2(100),
 Checkout_Date  DATE,
 Returned_Date  DATE);

delete from bookshelf_checkout;
alter session set nls_date_format='dd-MON-rr';
insert into BOOKSHELF_CHECKOUT values
('JED HOPKINS','INNUMERACY','01-JAN-02','22-JAN-02');
Insert into BOOKSHELF_CHECKOUT values
('GERHARDT KENTGEN','WONDERFUL LIFE','02-JAN-02','02-FEB-02');
Insert into BOOKSHELF_CHECKOUT values
('DORAH TALBOT','EITHER/OR','02-JAN-02','10-JAN-02');
Insert into BOOKSHELF_CHECKOUT values
('EMILY TALBOT','ANNE OF GREEN GABLES','02-JAN-02','20-JAN-02');
Insert into BOOKSHELF_CHECKOUT values
('PAT LAVAY','THE SHIPPING NEWS','02-JAN-02','12-JAN-02');
Insert into BOOKSHELF_CHECKOUT values
('ROLAND BRANDT','THE SHIPPING NEWS','12-JAN-02','12-MAR-02');
Insert into BOOKSHELF_CHECKOUT values
('ROLAND BRANDT','THE DISCOVERERS','12-JAN-02','01-MAR-02');
Insert into BOOKSHELF_CHECKOUT values
('ROLAND BRANDT','WEST WITH THE NIGHT','12-JAN-02','01-MAR-02');
Insert into BOOKSHELF_CHECKOUT values
('EMILY TALBOT','MIDNIGHT MAGIC','20-JAN-02','03-FEB-02');
Insert into BOOKSHELF_CHECKOUT values
('EMILY TALBOT','HARRY POTTER AND THE GOBLET OF FIRE','03-FEB-02','14-FEB-02');
Insert into BOOKSHELF_CHECKOUT values
('PAT LAVAY','THE MISMEASURE OF MAN','12-JAN-02','12-FEB-02');
Insert into BOOKSHELF_CHECKOUT values
('DORAH TALBOT','POLAR EXPRESS','01-FEB-02','15-FEB-02');
Insert into BOOKSHELF_CHECKOUT values
('DORAH TALBOT','GOOD DOG, CARL','01-FEB-02','15-FEB-02');
Insert into BOOKSHELF_CHECKOUT values
('GERHARDT KENTGEN','THE MISMEASURE OF MAN','13-FEB-02','05-MAR-02');
Insert into BOOKSHELF_CHECKOUT values
('FRED FULLER','JOHN ADAMS','01-FEB-02','01-MAR-02');
Insert into BOOKSHELF_CHECKOUT values
('FRED FULLER','TRUMAN','01-MAR-02','20-MAR-02');
Insert into BOOKSHELF_CHECKOUT values
('JED HOPKINS','TO KILL A MOCKINGBIRD','15-FEB-02','01-MAR-02');
Insert into BOOKSHELF_CHECKOUT values
('DORAH TALBOT','MY LEDGER','15-FEB-02','03-MAR-02');
Insert into BOOKSHELF_CHECKOUT values
('GERHARDT KENTGEN','MIDNIGHT MAGIC','05-FEB-02','10-FEB-02');
update bookshelf_checkout set name=initcap(name),title=initcap(title),
   checkout_date=checkout_date+interval '10' year,returned_date=returned_date+interval '10' year;
commit;

rem  Requires that the TOOLS_VA datatype be created first.

create table BORROWER
(Name          VARCHAR2(25),
 Tools         TOOLS_VA,
constraint BORROWER_PK primary key (Name));

insert into BORROWER values
('Jed Hopkins',
  TOOLS_VA('Hammer','Sledge','Ax'));

rem  Requires that the ANIMAL_TY and ANIMALS_NT types
rem    already exist.

create table BREEDER (
Breeder_Name      VARCHAR2(25),
Animals           ANIMALS_NT)
nested table ANIMALS store as ANIMALS_NT_TAB;

-- drop table BREEDING;
create table BREEDING (
Offspring      VARCHAR2(10),
Sex            CHAR(1),
Cow            VARCHAR2(10),
Bull           VARCHAR2(10),
Birth_date     DATE
);

insert into BREEDING values ('EVE','F',null,null,null);
insert into BREEDING values ('ADAM','M',null,null,null);
insert into BREEDING values ('BANDIT','M',null,null,null);
insert into BREEDING values ('BETSY','F','EVE','ADAM',
   TO_DATE('02-JAN-1900','DD-MON-YYYY'));
insert into BREEDING values ('POCO','M','EVE','ADAM',
   TO_DATE('15-JUL-1900','DD-MON-YYYY'));
insert into BREEDING values ('GRETA','F','EVE','BANDIT',
   TO_DATE('12-MAR-1901','DD-MON-YYYY'));
insert into BREEDING values ('MANDY','F','EVE','POCO',
   TO_DATE('22-AUG-1902','DD-MON-YYYY'));
insert into BREEDING values ('NOVI','F','BETSY','ADAM',
   TO_DATE('30-MAR-1903','DD-MON-YYYY'));
insert into BREEDING values ('GINNY','F','BETSY','BANDIT',
   TO_DATE('04-DEC-1903','DD-MON-YYYY'));
insert into BREEDING values ('CINDY','F','EVE','POCO',
   TO_DATE('09-FEB-1903','DD-MON-YYYY'));
insert into BREEDING values ('DUKE','M','MANDY','BANDIT',
   TO_DATE('24-JUL-1904','DD-MON-YYYY'));
insert into BREEDING values ('TEDDI','F','BETSY','BANDIT',
   TO_DATE('12-AUG-1905','DD-MON-YYYY'));
insert into BREEDING values ('SUZY','F','GINNY','DUKE',
   TO_DATE('03-APR-1906','DD-MON-YYYY'));
insert into BREEDING values ('RUTH','F','GINNY','DUKE',
   TO_DATE('25-DEC-1906','DD-MON-YYYY'));
insert into BREEDING values ('PAULA','F','MANDY','POCO',
   TO_DATE('21-DEC-1906','DD-MON-YYYY'));
insert into BREEDING values ('DELLA','F','SUZY','BANDIT',
   TO_DATE('11-OCT-1908','DD-MON-YYYY'));
update breeding set offspring=initcap(offspring),cow=initcap(cow),bull=initcap(bull);

-- drop table CD;
create table CD (
Account       NUMBER not null,
Amount        NUMBER not null,
Maturity_Date DATE not null
);

insert into CD values (573334, 10000,
   TO_DATE('15-JAN-2009','DD-MON-YYYY'));
insert into CD values (677654, 25000,
   TO_DATE('15-JAN-2001','DD-MON-YYYY'));
insert into CD values (976032, 10000,
   TO_DATE('15-JAN-1995','DD-MON-YYYY'));
insert into CD values (275031, 10000,
   TO_DATE('15-JAN-1997','DD-MON-YYYY'));
insert into CD values (274598, 20000,
   TO_DATE('15-JAN-1999','DD-MON-YYYY'));
insert into CD values (538365, 45000,
   TO_DATE('15-JAN-2001','DD-MON-YYYY'));
insert into CD values (267432, 16500,
   TO_DATE('15-JAN-2004','DD-MON-YYYY'));
update cd set maturity_date=maturity_date+interval '2' year;

-- drop table COMFORT;
create table COMFORT (
City           VARCHAR2(13) NOT NULL,
Sample_Date    DATE NOT NULL,
Noon           NUMBER(3,1),
Midnight       NUMBER(3,1),
Precipitation NUMBER
);

insert into COMFORT values ('SAN FRANCISCO',
   TO_DATE('21-MAR-2003','DD-MON-YYYY'),62.5,42.3,.5);
insert into COMFORT values ('SAN FRANCISCO',
   TO_DATE('22-JUN-2003','DD-MON-YYYY'),51.1,71.9,.1);
insert into COMFORT values ('SAN FRANCISCO',
   TO_DATE('23-SEP-2003','DD-MON-YYYY'),NULL,61.5,.1);
insert into COMFORT values ('SAN FRANCISCO',
   TO_DATE('22-DEC-2003','DD-MON-YYYY'),52.6,39.8,2.3);
insert into COMFORT values ('KEENE',
   TO_DATE('21-MAR-2003','DD-MON-YYYY'),39.9,-1.2,4.4);
insert into COMFORT values ('KEENE',
   TO_DATE('22-JUN-2003','DD-MON-YYYY'),85.1,66.7,1.3);
insert into COMFORT values ('KEENE',
   TO_DATE('23-SEP-2003','DD-MON-YYYY'),99.8,82.6,NULL);
insert into COMFORT values ('KEENE',
   TO_DATE('22-DEC-2003','DD-MON-YYYY'),-7.2,-1.2,3.9);
update comfort set sample_date=sample_date+interval '8' year;
update comfort set city=initcap(city);

-- drop table COMFORT2;
create table COMFORT2 (
City           VARCHAR2(13) NOT NULL,
Sample_Date    DATE NOT NULL,
Noon           NUMBER(3,1),
Midnight       NUMBER(3,1),
Precipitation  NUMBER
);


-- drop table COMFORT_TEST;
create table COMFORT_TEST (
City           VARCHAR2(13) NOT NULL,
Sample_Date    DATE NOT NULL,
Measure        VARCHAR2(10),
Value          NUMBER(3,1)
);

-- drop table CONTINENT;
create table CONTINENT (
 Continent    VARCHAR2(30));


-- drop table COUNTRY;
create table COUNTRY (
Country      VARCHAR2(30) not null,
Continent    VARCHAR2(30));


rem  Requires that the ADDRESS_TY and PERSON_TY types already
rem  exist.

create table CUSTOMER (
Customer_ID    NUMBER,
Person         PERSON_TY
);

insert into CUSTOMER VALUES
(1,
 PERSON_TY('Neil Mullane',
            ADDRESS_TY('57 Mt Pleasant St',
                       'Finn', 'NH', 11111)));
insert into CUSTOMER VALUES
(2,
 PERSON_TY('Seymour Hester',
            ADDRESS_TY('1 Stepahead Rd',
                       'Briant', 'NH', 11111)));

-- drop table EMPTY;
create table EMPTY (
Nothing       VARCHAR2(25),
Less          NUMBER
);

REMARK No inserts. This table is empty.

-- drop table HOLIDAY;
create table HOLIDAY (
Holiday         VARCHAR2(25),
Actual_Date     DATE,
Celebrated_Date DATE
);

insert into HOLIDAY values ('New Year''s Day',
   TO_DATE('01-JAN-2012','DD-MON-YYYY'),
   TO_DATE('02-JAN-2012','DD-MON-YYYY'));
insert into HOLIDAY values ('Martin Luther King, Jr.',
   TO_DATE('16-JAN-2012','DD-MON-YYYY'),
   TO_DATE('16-JAN-2012','DD-MON-YYYY'));
insert into HOLIDAY values ('Lincoln''s Birthday',
   TO_DATE('12-FEB-2012','DD-MON-YYYY'),
   TO_DATE('20-FEB-2012','DD-MON-YYYY'));
insert into HOLIDAY values ('Washington''s Birthday',
   TO_DATE('22-FEB-2012','DD-MON-YYYY'),
   TO_DATE('20-FEB-2012','DD-MON-YYYY'));
insert into HOLIDAY values ('President''s Day',
   TO_DATE('20-FEB-2012','DD-MON-YYYY'),
   TO_DATE('20-FEB-2012','DD-MON-YYYY'));
insert into HOLIDAY values ('Memorial Day',
   TO_DATE('28-MAY-2012','DD-MON-YYYY'),
   TO_DATE('28-MAY-2012','DD-MON-YYYY'));
insert into HOLIDAY values ('Independence Day',
   TO_DATE('04-JUL-2012','DD-MON-YYYY'),
   TO_DATE('04-JUL-2012','DD-MON-YYYY'));
insert into HOLIDAY values ('Labor Day',
   TO_DATE('03-SEP-2012','DD-MON-YYYY'),
   TO_DATE('03-SEP-2012','DD-MON-YYYY'));
insert into HOLIDAY values ('Columbus Day',
   TO_DATE('08-OCT-2012','DD-MON-YYYY'),
   TO_DATE('08-OCT-2012','DD-MON-YYYY'));
insert into HOLIDAY values ('Thanksgiving',
   TO_DATE('25-NOV-2012','DD-MON-YYYY'),
   TO_DATE('25-NOV-2012','DD-MON-YYYY'));
commit;

-- drop table LOCATION;
create table LOCATION (
City       VARCHAR2(25),
Country    VARCHAR2(25),
Continent  VARCHAR2(25),
Latitude   NUMBER,
NorthSouth CHAR(1),
Longitude  NUMBER,
EastWest   CHAR(1)
);

insert into LOCATION values (
  'ATHENS','GREECE','EUROPE',37.58,'N',23.43,'E');
insert into LOCATION values (
  'CHICAGO','UNITED STATES','NORTH AMERICA',41.53,'N',87.38,'W');
insert into LOCATION values (
  'CONAKRY','GUINEA','AFRICA',9.31,'N',13.43,'W');
insert into LOCATION values (
  'LIMA','PERU','SOUTH AMERICA',12.03,'S',77.03,'W');
insert into LOCATION values (
  'MADRAS','INDIA','INDIA',13.05,'N',80.17,'E');
insert into LOCATION values (
  'MANCHESTER','ENGLAND','EUROPE',53.30,'N',2.15,'W');
insert into LOCATION values (
  'MOSCOW','RUSSIA','EUROPE',55.45,'N',37.35,'E');
insert into LOCATION values (
  'PARIS','FRANCE','EUROPE',48.52,'N',2.20,'E');
insert into LOCATION values (
  'SHENYANG','CHINA','CHINA',41.48,'N',123.27,'E');
insert into LOCATION values (
  'ROME','ITALY','EUROPE',41.54,'N',12.29,'E');
insert into LOCATION values (
  'TOKYO','JAPAN','ASIA',35.42,'N',139.46,'E');
insert into LOCATION values (
  'SYDNEY','AUSTRALIA','AUSTRALIA',33.52,'S',151.13,'E');
insert into LOCATION values (
  'SPARTA','GREECE','EUROPE',37.05,'N',22.27,'E');
insert into LOCATION values (
  'MADRID','SPAIN','EUROPE',40.24,'N',3.41,'W');
update location set city=initcap(city),country=initcap(country),continent=initcap(continent);
-- select * from location;

-- drop table magazine;
create table magazine (
Name        VARCHAR2(16),
Title       VARCHAR2(37),
Author      VARCHAR2(25),
Issue_Date  DATE,
Page        NUMBER
);

insert into MAGAZINE values (
  'BERTRAND MONTHLY','THE BARBERS WHO SHAVE THEMSELVES.',
  'BONHOEFFER, DIETRICH',
  TO_DATE('23-MAY-1988','DD-MON-YYYY'),70);
insert into MAGAZINE values (
  'LIVE FREE OR DIE','"HUNTING THOREAU IN NEW HAMPSHIRE"',
  'CHESTERTON, G.K.',
  TO_DATE('26-AUG-1981','DD-MON-YYYY'),320);
insert into MAGAZINE values (
  'PSYCHOLOGICA','THE ETHNIC NEIGHBORHOOD',
  'RUTH, GEORGE HERMAN',
  TO_DATE('18-SEP-1919','DD-MON-YYYY'),246);
insert into MAGAZINE values (
  'FADED ISSUES','RELATIONAL DESIGN AND ENTHALPY',
  'WHITEHEAD, ALFRED',
  TO_DATE('20-JUN-1926','DD-MON-YYYY'),279);
insert into MAGAZINE values (
  'ENTROPY WIT','"INTERCONTINENTAL RELATIONS."',
  'CROOKES, WILLIAM',
  TO_DATE('20-SEP-1950','DD-MON-YYYY'),20);
update magazine set name=initcap(name),title=initcap(title),author=initcap(author),issue_date=issue_date+interval '15' year;

-- drop table MATH;
create table MATH (
Name          VARCHAR2(12),
Above         NUMBER,
Below         NUMBER,
Empty         NUMBER
);

insert into MATH values ('WHOLE NUMBER',11,-22,null);
insert into MATH values ('LOW DECIMAL',33.33,-44.44,null);
insert into MATH values ('MID DECIMAL',55.5,-55.5,null);
insert into MATH values ('HIGH DECIMAL',66.666,-77.777,null);
update math set name=initcap(name);
-- select * from math;

-- drop table NAME;
create table NAME (
Name         VARCHAR2(25)
);

insert into NAME values ('HORATIO NELSON');
insert into NAME values ('VALDO');
insert into NAME values ('MARIE DE MEDICIS');
insert into NAME values ('FLAVIUS JOSEPHUS');
insert into NAME values ('EDYTHE P. M. GAMMIERE');
update name set name=initcap(name);

-- drop table NEWSPAPER;
create table NEWSPAPER (
Feature      VARCHAR2(15) not null,
Section      CHAR(1),
Page         NUMBER
);

insert into NEWSPAPER values ('National News', 'A', 1);
insert into NEWSPAPER values ('Sports', 'D', 1);
insert into NEWSPAPER values ('Editorials', 'A', 12);
insert into NEWSPAPER values ('Business', 'E', 1);
insert into NEWSPAPER values ('Weather', 'C', 2);
insert into NEWSPAPER values ('Television', 'B', 7);
insert into NEWSPAPER values ('Births', 'F', 7);
insert into NEWSPAPER values ('Classified', 'F', 8);
insert into NEWSPAPER values ('Modern Life', 'B', 1);
insert into NEWSPAPER values ('Comics', 'C', 4);
insert into NEWSPAPER values ('Movies', 'B', 4);
insert into NEWSPAPER values ('Bridge', 'B', 2);
insert into NEWSPAPER values ('Obituaries', 'F', 6);
insert into NEWSPAPER values ('Doctor Is In', 'F', 6);

-- drop table NUMBER_TEST;
create table NUMBER_TEST (
Value1        NUMBER,
Value2        NUMBER,
Value3        NUMBER(10,2)
);

insert into NUMBER_TEST values (0,0,0);
insert into NUMBER_TEST values (.0001,.0001,.0001);
insert into NUMBER_TEST values (1234,1234,1234);
insert into NUMBER_TEST values (1234.5,1234.5,1234.5);
insert into NUMBER_TEST values (null,null,null);
insert into NUMBER_TEST values (1234.56,1234.56,1234.56);
insert into NUMBER_TEST values (1234.567,1234.567,1234.567);
insert into NUMBER_TEST values
     (98761234.567,98761234.567,98761234.567);

-- drop table PAYDAY;
create table PAYDAY (
Cycle_Date      DATE
);

insert into PAYDAY values (TO_DATE('15-JAN-2004','DD-MON-YYYY'));
insert into PAYDAY values (TO_DATE('15-FEB-2004','DD-MON-YYYY'));
insert into PAYDAY values (TO_DATE('15-MAR-2004','DD-MON-YYYY'));
insert into PAYDAY values (TO_DATE('15-APR-2004','DD-MON-YYYY'));
insert into PAYDAY values (TO_DATE('15-MAY-2004','DD-MON-YYYY'));
insert into PAYDAY values (TO_DATE('15-JUN-2004','DD-MON-YYYY'));
insert into PAYDAY values (TO_DATE('15-JUL-2004','DD-MON-YYYY'));
insert into PAYDAY values (TO_DATE('15-AUG-2004','DD-MON-YYYY'));
insert into PAYDAY values (TO_DATE('15-SEP-2004','DD-MON-YYYY'));
insert into PAYDAY values (TO_DATE('15-OCT-2004','DD-MON-YYYY'));
insert into PAYDAY values (TO_DATE('15-NOV-2004','DD-MON-YYYY'));
insert into PAYDAY values (TO_DATE('15-DEC-2004','DD-MON-YYYY'));
update payday set cycle_date=cycle_date+interval '8' year;

-- drop table PROPOSAL;
create table PROPOSAL
(Proposal_ID        NUMBER(10) primary key,
 Recipient_Name     VARCHAR2(25),
 Proposal_Name      VARCHAR2(25),
 Short_Description  VARCHAR2(1000),
 Proposal_Text      CLOB,
 Budget             BLOB,
 Cover_Letter       BFILE);

-- drop table RADIUS_VALS;
create table RADIUS_VALS
(Radius      NUMBER(5));

insert into RADIUS_VALS values (3);


-- drop table RATING;
create table RATING
(Rating  VARCHAR2(2),
Rating_Description VARCHAR2(50));

Insert into RATING values ('1','ENTERTAINMENT');
Insert into RATING values ('2','BACKGROUND INFORMATION');
Insert into RATING values ('3','RECOMMENDED');
Insert into RATING values ('4','STRONGLY RECOMMENDED');
Insert into RATING values ('5','REQUIRED READING');
update rating set rating_description=initcap(rating_description);
commit;


-- drop table ROSE;
create table ROSE (
Lodging       VARCHAR2(12)
);

insert into ROSE values ('Roselyn');
insert into ROSE values ('Rose Hill');
insert into ROSE values ('Rose Garden');
insert into ROSE values ('Rose');

-- drop table SHIPPING;
create table SHIPPING (
Client        VARCHAR2(13),
Weight        NUMBER
);

insert into SHIPPING values ('Johnson Tool',59);
insert into SHIPPING values ('Dagg Software',27);
insert into SHIPPING values ('Tully Andover',NULL);

-- drop table STOCK;
create table STOCK (
Company         VARCHAR2(20),
Symbol          VARCHAR2(6),
Industry        VARCHAR2(15),
Close_Yesterday NUMBER(6,2),
Close_Today     NUMBER(6,2),
Volume         NUMBER
);

insert into STOCK values (
  'AD SPECIALTY', 'ADSP', 'ADVERTISING',  31.75, 31.75,
   18333876);
insert into STOCK values (
  'APPLE CANNERY', 'APCN', 'AGRICULTURE',  33.75, 36.50,
   25787229);
insert into STOCK values (
  'AT SPACE', 'ATR' , 'MEDICAL', 46.75, 48.00,
   11398323);
insert into STOCK values (
  'AUGUST ENTERPRISES', 'AGE', 'MEDICAL', 15.00, 15.00,
   12221711);
insert into STOCK values (
  'BRANDON ELLIPSIS', 'BELP', 'SPACE', 32.75, 33.50,
  25789769);
insert into STOCK values (
  'GENERAL ENTROPY','GENT', 'SPACE', 64.25, 66.00,
   7598562);
insert into STOCK values (
  'GENEVA ROCKETRY', 'GENR', 'SPACE', 22.75, 27.25,
   22533944);
insert into STOCK values (
  'HAYWARD ANTISEPTIC',  'HAYW', 'MEDICAL', 104.25,  106.00,
   3358561);
insert into STOCK values (
  'IDK', 'IDK', 'ELECTRONICS',  95.00, 95.25,
   9443523);
insert into STOCK values (
  'INDIA COSMETICS','INDI', 'COSMETICS', 30.75, 30.75,
   8134878);
insert into STOCK values (
  'ISAIAH JAMES STORAGE', 'IJS', 'TRANSPORTATION', 13.25, 13.75,
   22112171);
insert into STOCK values (
  'KDK AIRLINES',  'KDK', 'TRANSPORTATION', 85.00, 85.25,
   7481566);
insert into STOCK values (
  'KENTGEN BIOPHYSICS',  'KENT', 'MEDICAL', 18.25, 19.50,
   6636863);
insert into STOCK values (
  'LAVAY COSMETICS', 'LAVA', 'COSMETICS', 21.50, 22.00,
   3341542);
insert into STOCK values (
  'LOCAL DEVELOPMENT',  'LOCD', 'AGRICULTURE',  26.75, 27.25,
   2596934);
insert into STOCK values (
  'MAXTIDE'  , 'MAXT', 'TRANSPORTATION', 8.25, 8.00,
   2836893);
insert into STOCK values (
  'MBK COMMUNICATIONS', 'MBK', 'ADVERTISING',  43.25, 41.00,
   10022980);
insert into STOCK values (
  'MEMORY GRAPHICS', 'MEMG', 'ELECTRONICS',  15.50, 14.25,
   4557992);
insert into STOCK values (
'MICRO TOKEN', 'MICT', 'ELECTRONICS',  77.00, 76.50,
   25205667);
insert into STOCK values (
  'NANCY LEE FEATURES', 'NLF', 'ADVERTISING',  13.50, 14.25,
   14222692);
insert into STOCK values (
  'NORTHERN BOREAL', 'NBOR', 'SPACE', 26.75, 28.00,
   1348323);
insert into STOCK values (
  'OCKHAM SYSTEMS', 'OCKS', 'SPACE', 21.50, 22.00,
   7052990);
insert into STOCK values (
  'OSCAR COAL DRAYAGE', 'OCD', 'TRANSPORTATION', 87.00, 88.50,
   25798992);
insert into STOCK values (
  'ROBERT JAMES APPAREL', 'RJAP', 'GARMENT', 23.25, 24.00,
   19032481);
insert into STOCK values (
  'SOUP SENSATIONS','SOUP', 'AGRICULTURE',  16.25, 16.75,
   22574879);
insert into STOCK values (
  'WONDER LABS', 'WOND', 'SPACE', 5.00, 5.00,
   2553712);
update stock set company=initcap(company),industry=initcap(industry);

-- drop table STOCK_ACCOUNT;
create table STOCK_ACCOUNT
(Account              NUMBER(10),
Account_Long_Name     VARCHAR2(50));

insert into STOCK_ACCOUNT values (
1234, 'Adams');
insert into STOCK_ACCOUNT values (
7777, 'Burlington');
commit;


-- drop table STOCK_TRX;

create table STOCK_TRX (
Account  NUMBER(10),
Symbol  VARCHAR2(20),
Price  NUMBER(6,2),
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


-- drop table TROUBLE;
create table TROUBLE (
City           VARCHAR2(13) NOT NULL,
Sample_Date    DATE NOT NULL,
Noon           NUMBER(3,1),
Midnight       NUMBER(3,1),
Precipitation  NUMBER
);

insert into TROUBLE values ('Unpleasant Lake',
  '01-JAN-11', 10.1, -15.3, 2.2);
insert into TROUBLE values ('Pleasant Lake',
  '21-MAR-11', 39.99, -1.31, 3.6);
insert into TROUBLE values ('Pleasant Lake',
  '22-JUN-11', 101.44, 86.2, 1.63);
insert into TROUBLE values ('Pleasant Lake',
  '23-SEP-11', 92.85, 79.6, 1.00003);
insert into TROUBLE values ('Pleasant Lake',
  '22-DEC-11', -17.445, -10.4, 2.4);

-- drop table TWONAME;
create table TWONAME (
First_Name    VARCHAR2(25),
Last_Name     VARCHAR2(25)
);

-- drop table WEATHER;
create table WEATHER (
City         VARCHAR2(11),
Temperature  NUMBER,
Humidity     NUMBER,
Condition    VARCHAR2(9)
);

insert into WEATHER values ('LIMA',45,79,'RAIN');
insert into WEATHER values ('PARIS',81,62,'CLOUDY');
insert into WEATHER values ('MANCHESTER',66,98,'FOG');
insert into WEATHER values ('ATHENS',97,89,'SUNNY');
insert into WEATHER values ('CHICAGO',66,88,'RAIN');
insert into WEATHER values ('SYDNEY',69,99,'SUNNY');
insert into WEATHER values ('SPARTA',74,63,'CLOUDY');
update weather set city=initcap(city),condition=initcap(condition);
commit;

-- object views: new user (other than HR or a DBA account)
create table customer
(customer_id number   primary key,
 name        varchar2(25),
 street      varchar2(50),
 city        varchar2(25),
 state       char(2),
 zip         number);

create or replace type address_ty as object
(street  varchar2(50),
 city    varchar2(25),
 state   char(2),
 zip     number);

create or replace type person_ty as object
(name      varchar2(25),
 address   address_ty);

create view customer_ov (customer_id, person) as
select customer_id,
       person_ty(name,
       address_ty(street, city, state, zip))
from customer;

insert into customer values
(123,'Sigmund','47 Haffner Rd','Lewiston','NJ',22222);
commit;

insert into customer_ov values
  (234,
  person_ty('Evelyn',
  address_ty('555 High St','Lowlands Park','NE',33333)));
commit;

create or replace view author_publisher as
select ba.author_name, title, b.publisher
from bookshelf_author ba inner join bookshelf b
using (title);

select author_name, publisher from author_publisher
where author_name = 'W. P. Kinsella';

update author_publisher
set publisher = 'Mariner'
where author_name = 'W. P. Kinsella';

create or replace trigger author_publisher_update
instead of update on author_publisher
for each row
begin
  if :old.publisher <> :new.publisher
  then
    update bookshelf
       set publisher = :new.publisher
     where title = :old.title;
  end if;
  if :old.author_name <> :new.author_name
  then
    update bookshelf_author
       set author_name = :new.author_name
     where title = :old.title;
  end if;
end;
/

update author_publisher
set publisher = 'Mariner'
where author_name = 'W. P. Kinsella';

select publisher from bookshelf
 where title in
   (select title from bookshelf_author
    where author_name = 'W. P. Kinsella');

create or replace type animal_ty as object
(breed      varchar2(25),
 name       varchar2(25),
 birth_date date,
member function age (birth_date in date) return number);
/

create or replace type body animal_ty as
member function age (birth_date date) return number is
   begin
  return round(sysdate - birth_date);
   end;
end;
/

create table animal
(id      number,
 animal  animal_ty);

insert into animal values
(11,animal_ty('Cow','Mimi',to_date('01-JAN-2007','DD-MON-YYYY')));
commit;

select a.animal.age(a.animal.birth_date)
from animal a;

create table borrower
(name          varchar2(25),
 tool          varchar2(25),
constraint borrower_pk primary key (name, tool));

create type tool_ty as object
(toolname  varchar2(25));

create or replace type tools_va as varray(5) of varchar2(25);

drop table borrower;

create table borrower
(name          varchar2(25),
 tools         tools_va,
constraint borrower_pk primary key (name));

select coll_type,
       elem_type_owner,
       elem_type_name,
       upper_bound,
       length
  from user_coll_types
 where type_name = 'TOOLS_VA';

insert into borrower values
('Jed Hopkins',
  tools_va('hammer','sledge','ax'));
commit;

select tools from borrower;

select b.name, n.*
  from borrower b, table(b.tools) n;

insert into borrower values
('Fred Fuller',
  tools_va('hammer'));
commit;

select b.name, n.*
  from borrower b, table(b.tools) n;

select breeder_name, n.name, n.birth_date
from breeder, table(breeder.animals) n;

set describe depth 2
desc breeder

describe animals_nt
describe animal_ty

select breeder_name, n.name, n.birthdate
  from breeder, table(breeder.animals) n;

insert into table(select animals
                    from breeder
                   where breeder_name = 'Jane James')
values
(animal_ty('dog','Marcus','01-aug-11'));

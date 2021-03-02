create database exercice1;
use exercice1;
create table etudiant (id int not null auto_increment primary key,
nom varchar(30), prenom varchar(50), date_de_naissance varchar(15),
niveau varchar(5));

alter table etudiant add matricule int not null after id;

create table cours(id int not null auto_increment primary key, 
code int, nom_cours varchar(15), enseignant varchar(20));

create table examen (id int not null auto_increment primary key,
matricule int, code int not null, notes int);


#RIM-select etudiant.nom, etudiant.prenom from etudiant;
select * from etudiant;
select * from cours;
select * from examen;

select * from etudiant order by date_de_naissance;

SELECT * from etudiant WHERE niveau='bac' AND niveau='cap';

SELECT avg(notes) from examen;

SELECT avg(notes) from examen group by matricule;

SELECT * from examen group by matricule having avg(notes) >= 10;

select count(*) from etudiant;


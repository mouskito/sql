#Creation de la BDD avion
create database avion;
 
#Utilisation de la BDD avion
use avion;

#Creation des tables
show tables;


create table avion(
	numAv int(5) zerofill auto_increment primary key,
    nomAv varchar(10),
    capacite int,
    localisation varchar(15)
);

create table pilote(
	numpil int(8) auto_increment primary key,
    nompil varchar(20), 
    adresse text,
    salaire int
);
drop table vol;



create table vol(
	id int not null auto_increment primary key,
    numvol varchar(10),
    numpil int(8),
    numAv int(5) zerofill,
    ville_dep varchar(50),
    ville_ar varchar(50),
    heure_dep time,
    heure_ar time,
    constraint fk_numpil foreign key (numpil) references pilote(numpil),
    constraint fk_numav foreign key (numAv) references avion(numAv)
);

#alter table vol add constraint fk_numpil foreign key (numpil) references pilote(numpil);
 
#insert into 
insert into avion ( numAV, NomAv, capacite , Localisation) value 
	('00001', 'Alpha', '300', 'Paris'), 
	('00002', 'Delta', '400', 'Milan'), 
    ('00003', 'Beta', '350', 'Rome')
;

insert into pilote (NomPil, NumPil, Adresse, Salaire) value 
	('ZAck', '00005', 'TEst', '500000');
select * from vol;
insert into vol ( numVol, numPil, numAv, ville_dep, ville_ar, heure_dep, heure_ar) value 
				('LH1792', '00002', '00003', 'Paris', 'Canada', '190000', '200000'),
                ('RUS176', '00003', '00003', 'Paris', 'New-york', '160000', '210000');
                
#Les  requetes
#1
select * from pilote;
#2
select numpil, ville_dep from vol;
#3
select * from avion having (capacite > 350);
#3 bis
select * from avion where capacite > 350;
#4
select numAv, nomAv from avion where localisation = 'paris';
#5
select count(localisation) from avion;
#6
select * from pilote where adresse = 'cergy' and salaire > 500000;
#6 bis 
select * from pilote where  Adresse='Cergy' and Salaire > 500000;

#7
select numAv, nomAv from avion where localisation= 'paris' or capacite > 350;
#8
select * from vol where ville_dep = 'paris' and ville_ar = 'new-york' and heure_dep >18;

#8 bis
select * from vol where ville_dep like 'paris' and ville_ar like 'new-york' and heure_dep >18;

select * from commmande where idCient = 1  or idClib=ent=2 or idClient=3;
select * from commmande where idCient not in (2,3,4);

#9
select * from pilote where  nompil  not in (select numpil from vol);

#10
select numVol, ville_dep from vol where numpil = 1 and numpil= 2;
select numVol, ville_dep from vol where numpil in (1,2);

#11
select * from pilote where Nompil like 'Z%';

#12
select * from pilote where Nompil like '__b%';
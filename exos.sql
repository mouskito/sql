create database correction_exos;

use correction_exos;

show tables;

#exercice1
create table representation (
	num_rep int not null auto_increment primary key,
    titre_rep varchar(50),
    lieu varchar(50)
);

select * from representation;
select * from musicien;

create table musicien (
	num_mus int not null auto_increment primary key,
    nom varchar(20),
    num_rep int,
    foreign key (num_rep) references representation(num_rep)
);

create table programmer(
	id int not null auto_increment primary key,
    date datetime,
    num_rep int,
    tarif float,
    foreign key (num_rep) references representation(num_rep)
);

#Les requetes

#1- La liste des titres des représentations.
	select titre_rep from representation;

#2-	La liste des titres des représentations ayant lieu au « théâtre JCC ».
	select titre_rep from representation where lieu like 'théâtre JCC';

#3-	La liste des noms des musiciens et des titres et 
	#les titres des représentations auxquelles ils participent.
	select nom, titre_rep 
    from musicien as m,  representation as r, programmer as p
    where  m.num_rep = r.num_rep
    and m.num_rep = p.num_rep;
    
#4-	La liste des titres des représentations, les lieux et les tarifs du 28/02/2021.
	select titre_rep, lieu, tarif
    from representation as r, programmer as p
    where r.num_rep = p.num_rep
    and p.date = '2021-02-28';
    
#5-	Le nombre des musiciens qui participent à la représentations n°15.
	select count(*) from musicien where num_rep = 15;
    
#6- Les représentations et leurs dates dont le tarif ne dépasse pas 30Euros.
	select r.num_rep, p.date
    from representation as r , programmer as p
    where r.num_rep = p.num_rep
    and p.tarif <= 30;

#EXERCICE 2:
create table departements(
	DNO int not null auto_increment primary key,
    DNOM varchar(20),
    DIR varchar(20),
    VILLE varchar(20)
);

create table employes(
	ENO int not null auto_increment primary key,
    ENOM varchar(20),
    PROF varchar(20),
    DATEEMB date,
    SAL float,
    COMM float,
    DNO int,
    foreign key (DNO) references departements(DNO)
);

#LES REQUETES
#1- Donnez la liste des employés ayant une commission
	select * from employes having COMM;
    
#2-	Donnez les noms, emplois et salaires des employés 
#par emploi croissant, et pour chaque emploi, par salaire décroissant
	select ENOM, PROF, SAL
    from employes
    order by PROF asc, SAL desc;
    
#3- Donnez le salaire moyen des employés
	select avg(SAL) from employes;

#4-	Donnez le salaire moyen du département Production
	select avg(SAL)
    from employes as e, departements as d
    where e.DNO = d.DNO
    and d.DNOM = 'production';
    
#5- Donnez les numéros de département et leur salaire maximum
	select DNO, max(SAL) #min(), sum(),avg(), count()
    from employes;
    
#6- Donnez les différentes professions et leur salaire moyen
	select PROF, avg(SAL)
    from employes group by PROF;
    
#7- Donnez le salaire moyen par profession le plus bas
	select min(avg(SAL)) as 'Salaire moyen', PROF
    from employes
    #group by PROF order by avg(SAL) limit 1;
    group by PROF order by avg(SAL);
    
#8- Donnez le ou les emplois ayant le salaire moyen le plus bas,
# ainsi que ce salaire moyen
	select PROF, avg(SAL)
    from employes
    group by PROF having avg(SAL) = (
		select avg(SAL) from employes group by PROF
        order by avg(SAL) limit 1
    );

#EXERCICE 3:
create table client(
	numCli int not null auto_increment primary key,
    nomCli varchar(20),
    prenomCli varchar(20),
    adresseCli varchar(210),
    mailCli varchar(50) unique
);


create table produit(
	numPro int not null auto_increment primary key,
    designation varchar(20),
    prix float,
    qte_stock int default 0
);

create table vendeur (
	idVendeur int not null auto_increment primary key,
    nomVendeur varchar(50),
    adresse_vend varchar(250)
);


create table commande (
	numCom int not null auto_increment primary key,
    numCli int,
    idVendeur int,
    numPro int,
    date_com date,
    qte_com int,
    foreign key (numCli) references client(numCli),
    foreign key (idVendeur) references vendeur(idVendeur),
    foreign key (numPro) references produit(numPro)
);

#1-Créer les tables : Client, Produit, Vendeur et Commande.

#2- la liste des clients de Paris.
	select * from client where adresseCli like 'Paris';

#3- la liste des produits (Numprod, désignation, prix)
# classés de plus cher au moins cher.
	select numPro, designation, prix
    from produit
    order by prix desc;
    
#4- noms et adresses des vendeurs dont le nom 
#commence par la lettre ‘M’.
	select nomVendeur, adresse_vend
    from vendeur
    where nomVendeur like 'M%';

#5-	la liste des commandes effectuées par le vendeur 
#"Moussa" entre le 1er et 28 février.
	select numCom
    from commande as cmd, vendeur v
	where cmd.idVendeur = v.idVendeur
    and v.nomVendeur like 'Moussa'
    and cmd.date_com between '2021-02-01' and '2021-02-28';
    
    
#6- le nombre des commandes contenant le produit n° 365.
	select count(*)
    from commande
	where numPro = 365;

#EXERCICE 4:

create table  spectacle(
	spectacle_id int not null auto_increment primary key,
    titre varchar(100),
    date_deb date,
    duree int, #datetime HH:mm:ss -- time
    salle_id int,
    chanteur varchar(50),
    foreign key(salle_id) references salle(salle_id)
);

create table salle(
	salle_id int not null auto_increment primary key,
    nom varchar(25),
    adresse text,
    capacite int
);

create table billet(
	billet_id int not null auto_increment primary key,
    concert_id int,
    num_place int,
    categorie varchar(10),
    prix float,
    foreign key (concert_id) references concert(concert_id)
);

create table concert(
	concert_id int not null auto_increment primary key,
    date date,
    heure time,
    spectacle_id int,
    foreign key (spectacle_id) references spectacle(spectacle_id)
);


create table vente(
	vente_id int not null auto_increment primary key,
    date_vente date,
    billet_id int,
    moyenPaiement varchar(30),
    foreign key(billet_id) references billet(billet_id)
);

#LES SQL

#1. Quelles sont les dates du concert de Corneille 
#au Zenith ? 
	select date 
    from concert as c, spectacle s, salle sa
    where c.spectacle_id = s.spectacle_id
    and s.chanteur like 'Corneille'
    and sa.salle_id = s.salle_id
    and sa.nom = 'Zenith';
    
#2. Quels sont les noms des salles ayant la plus 
#grande capacité ? 
	select nom
    from salle
    having max(capacite);
#3. Quels sont les chanteurs n’ayant jamais 
#réalisé de concert à la Cygale ? 
	select distinct chanteur
    from spectacle as s
    where chanteur not in (
		select chanteur
        from spectacle, salle 
        where spectacle.salle_id = salle.salle_id
        and salle.nom ='Cygale'
    ) group by chanteur;
#4. Quels sont les chanteurs ayant réalisé au moins un concert 
#dans toutes les salles ? 
INSERT INTO Salle (nom, adresse,capacite) VALUES ("BBB","bbb",10);
INSERT INTO Spectacle (Titre, date_deb, Duree, Salle_ID, Chanteur) VALUES ("a", NOW(), 15, 1, "TouteSale"), ("b", NOW(), 15, 2, "TouteSale"),("c", NOW(), 15, 3, "TouteSale"),("d", NOW(), 15, 1, "2Salles"),("e", NOW(), 15, 2, "2Salles");
INSERT INTO Concert (Date, Heure,Spectacle_ID) VALUES (NOW(), NOW(),1),(NOW(), NOW(),2),(NOW(), NOW(),3),(NOW(), NOW(),1),(NOW(), NOW(),4)  ;

select * from spectacle;
	select chanteur 
    from spectacle as spect
    where not exists (
		select *
        from salle as sa where not exists
			(select * from spectacle as sp
				where sp.chanteur = spect.chanteur
                and sa.salle_id = sp.salle_id
            )
    );

#5. Quels sont les dates et les identificateurs des concerts pour lesquels il ne reste aucun billet invendu ?
#5 Avec Moussa   Quels sont les dates et les identificateurs des concerts pour lesquels il ne reste aucun billet invendu SELECT Dates, Concert_ID FROM Concert  WHERE NOT EXISTS(     SELECT * FROM Billet      WHERE Billet.Concert_ID = Concert.Concert_ID      AND NOT EXISTS (         SELECT * FROM Vente          WHERE Vente.Billet_ID = Billet.Billet_ID     ) );
#creation de la base de donnée
	create database immobilier;

use immobilier;

#creation des tables - logement - agence - personne - 

create table logement(
	idLogement int(5) zerofill not null auto_increment primary key,
    type varchar(20), check (type in ('maison', 'appartement')),
    ville varchar(100),
    prix float,
    superficie float,
	categorie varchar(20), check (categorie in ('vente', 'location'))
);

create table agence(
	idAgence int(6) zerofill not null auto_increment primary key,
    nom varchar(50),
    adresse varchar(200)
);

create table personne(
	idPersonne int not null auto_increment primary key,
    nom varchar(50),
    prenom varchar(50),
    email varchar(50) unique, check(email like '%@%.__' or email like '%@%.___')
);

create table logement_agence(
	idLogementAgence int not null auto_increment primary key,
    idAgence int (6) zerofill ,
    idLogement int(5) zerofill ,
    frais float,
    foreign key(idAgence) references agence(idAgence),
    foreign key(idLogement) references logement(idLogement)
);

create table logement_personne(
	idLogementPersonne int not null auto_increment primary key,
    idPersonne int,
    idLogement int(5) zerofill ,
    foreign key(idPersonne) references personne(idPersonne),
    foreign key(idLogement) references logement(idLogement)
);

create table demande(
	idDemande int not null auto_increment primary key,
    idPersonne int,
    type varchar(20),
    ville varchar(100),
    budget float,
    superficie float,
	categorie varchar(20),
    foreign key(idPersonne) references personne(idPersonne)
);

#EXERCICE2

	call ps_ajout_agence;
	call ps_logement;
	call ps_ajout_personnne;
	call ps_demande;
	call ps_logement_agence_personne;

#EXERCICE 3:

#	1 . Affichez le nom des agences
	select nom from agence;
    
#	2 . Affichez le numéro de l’agence « Orpi »
	select idAgence from agence where nom like 'orpi';
    
#	3 . Affichez le premier enregistrement de la table logement
		select * from logement order by idLogement asc limit 1;
    #JOSSE:
		select * from logement limit 1;
    
#	4 . Affichez le nombre de logements (Alias : Nombre de logements)
	select count(*) as 'Nombre de logements' from logement;
	
#	5 . Affichez les logements à vendre à moins de 150 000 € dans l’ordre croissant des prix .
		select * from logement where prix < 150000 having categorie like 'vente' order by prix asc ;
    #SONIA
		select * from logement where prix < 150000 and categorie like 'vente' order by prix;
    
#	6 . Affichez le nombre de logements à la location (alias : nombre)
		select count(*) as 'Nombre' from logement where categorie like 'location';
	#Cedric
        select count(*) Nombre from logement where categorie like 'location';

#	7 . Affichez les villes différentes recherchées par les personnes demandeuses d'un logement
	select distinct ville from demande;
    
#	8 . Affichez le nombre de biens à vendre par ville
		select count(*), ville from logement where categorie like 'vente' group by ville;

#	9 . Quelles sont les id des logements destinés à la location ?
		select idLogement from logement where categorie like 'location';
    #GROUP CDA
		select idLogement from logement where categorie = 'location';

	#10 . Quels sont les id des logements entre 20 et 30m² ?
		select idLogement from logement where superficie between 20 and 40;
        #Cedric
			select idLogement from logement where superficie >= 20 and superficie <= 40;
    
	#11 . Quel est le prix vendeur (hors frais) du logement le moins cher à vendre ? (Alias : prix minimum)
		select min(prix) as 'Prix minimum' from logement where categorie like 'vente';
        
		SELECT  MIN(prix) as 'prix minimum 'from logement 
			inner join logement_agence
			on logement.idLogement = logement_agence.idLogement;
    
	#12 . Dans quelles villes se trouve les maisons à vendre ?
		select ville from logement where type like 'maison' and categorie like 'vente';
        #Cedric/Josse
			select distinct ville from logement where type like 'maison' and categorie = 'vente';
    
	#13 . L’agence Orpi souhaite diminuer les frais qu’elle applique sur le logement ayant l'id « 00003 » . 
    #Passer les frais de ce logement de 800 à 730€
	#CAMARA MOUSSA 4
		update logement_agence set frais = 730 where idLogement = 00003;
        
    #14 . Quels sont les logements gérés par l’agence « seloger »
    
		select * from logement as l inner join logement_agence as la
        on l.idLogement = la.idLogement inner join agence 
        on
        agence.idAgence = la.idAgence 
        where agence.nom = 'seloger';
        #SONIA
        select  idLogement from logement_agence
		inner join agence
		on logement_agence.idAgence = agence.idAgence 
		where nom ='seloger';
        
        #Cedric
		SELECT * from logement WHERE idLogement IN (
			SELECT idLogement FROM logement_agence WHERE idAgence IN(
				SELECT idAgence FROM agence WHERE nom = "seloger" )
		);
        #Cedric bis
        #Jointure
		SELECT * FROM logement INNER JOIN logement_agence INNER JOIN agence 
		ON logement.idLogement = logement_agence.idLogement
		AND logement_agence.idAgence = agence.idAgence
		AND nom = "seloger"
		;
        #VLADISLAV
        SELECT * from logement as l, logement_agence as la WHERE idAgence in 
        (SELECT idAgence from agence WHERE nom LIKE 'seloger') and l.idLogement = la.idLogement;
        
        #Josse
        select * from logement, logement_agence inner join  agence on logement_agence.idAgence = agence.idAgence  
        where nom = 'seloger'
        and logement.idLogement = logement_agence.idLogement;

    
	#15 . Affichez le nombre de propriétaires dans la ville de Paris (Alias : Nombre)
		select count(*) Nombre from logement l, logement_personne lp
        where l.idLogement = lp.idLogement and l.ville = 'paris';
	
		#SONIA
        select count(idLogementPersonne) as Nombre from logement_personne 
		inner join logement 
		on logement_personne.idLogement=logement.idLogement
		where ville ='Paris';
        
        #Cedric 
		SELECT COUNT(DISTINCT idPersonne) Nombre 
		FROM logement_personne WHERE idLogement IN(
			SELECT idLogement FROM logement WHERE ville = "paris")
		;
        
        #Nadia
        Select count(idPersonne) as Nombre from logement_personne inner join logement 
       on logement_personne.idLogement=logement.idLogement 
       and logement.ville='Paris';
       
       #Vladislav
       SELECT COUNT(*) Nombre from logement as l, logement_personne as lp 
		WHERE lp.idLogement in (SELECT idLogement from logement where ville LIKE 'Paris') 
        and l.idLogement = lp.idLogement;
        
	#16 . Affichez les informations des trois premières personnes souhaitant acheter un logement
		select * from personne p, demande d
        where p.idPersonne = d.idPersonne
        and d.categorie = 'vente' 
        limit 3;
        
        #Sonia
        select * from personne 
		inner join demande
		on personne.idPersonne=demande.idPersonne
        limit 3;
        
        #VladislavToday at 11:48 AM
		SELECT * from personne as p
		INNER JOIN (SELECT * from demande WHERE categorie = 'vente' LIMIT 3) as d on p.idPersonne = d.idPersonne;
        
        #CédricToday at 11:48 AM
		SELECT * FROM personne 
		WHERE idPersonne IN(
			SELECT idPersonne FROM demande) 
		LIMIT 3;
    
	#17 . Affichez les prénoms, email des personnes souhaitant accéder à un logement en location sur la ville de Paris
		select prenom, email
        from personne p, demande d
        where p.idPersonne = d.idPersonne
        and d.ville like 'paris'
        and d.categorie = 'location';
        
        #soniaToday at 11:51 AM
		select prenom,email FROM personne
		inner join demande
		on personne.idPersonne=demande.idPersonne
		where ville="paris"
		AND categorie ='location';
		
        #VladislavToday at 11:51 AM
		#17
		SELECT prenom, email FROM personne AS p
		INNER JOIN (SELECT * FROM demande WHERE ville LIKE 'Paris' and categorie='location') AS d ON p.idPersonne = d.idPersonne;
		
        #CédricToday at 11:53 AM
		#Simple
		SELECT prenom, email FROM personne
		WHERE idPersonne IN(
			SELECT idPersonne FROM demande WHERE ville = "paris" AND categorie = "location" )
		;
		#Jointure
		SELECT prenom, email FROM personne INNER JOIN demande
		ON personne.idPersonne = demande.idPersonne
		AND ville = "paris"
		AND categorie = "location"
		;
        #Josse
        select prenom, email from personne p, demande d where p.idPersonne = d.idPersonne 
        and ville = 'paris' and categorie = 'location';
        
	#18 . Si l’ensemble des logements étaient vendus ou loués demain, quel serait le bénéfice généré grâce 
    #aux frais d’agence et pour chaque agence (Alias : bénéfice, classement : par ordre croissant des gains)
		select sum(frais) as 'Bénéfice', nom
        from logement_agence la, agence a
        where la.idAgence = a.idAgence group by la.idAgence order by sum(frais) asc;
        
	#CédricToday at 11:58 AM
	SELECT idAgence, SUM(frais) bénéfice FROM logement_agence GROUP BY idAgence ORDER BY bénéfice ;
	#VladislavToday at 11:58 AM
	SELECT a.nom, b.frais as 'bénéfice' FROM agence AS a
	INNER JOIN (SELECT idAgence, SUM(frais) as frais FROM logement_agence GROUP BY idAgence order by frais asc) 
	AS b ON a.idAgence = b.idAgence;
    
    #Josse
    select nom, sum(frais) as bénéfice from agence a, logement_agence la
where a.idAgence = la.idAgence group by la.idAgence order by bénéfice;
    
	#19 . Affichez le prénom et la ville où se trouve le logement de chaque propriétaire
		select prenom, ville from logement_personne lp, logement l , personne p
        where p.idPersonne = lp.idPersonne
		and lp.idLogement = l.idLogement;
        
        #VladislavToday at 12:04 PM
		SELECT p.idPersonne, p.prenom, l.ville FROM
			personne AS p,
			logement AS l,
			logement_personne AS lp
		WHERE l.idLogement = lp.idLogement AND lp.idPersonne = p.idPersonne;
		#CédricToday at 12:04 PM

		#Jointure
		SELECT prenom, ville FROM personne INNER JOIN logement_personne INNER JOIN logement
		ON logement_personne.idPersonne = personne.idPersonne
		AND logement_personne.idLogement = logement.idLogement
		;
		#soniaToday at 12:05 PM
		SELECT prenom,ville from personne 
		inner join logement_personne
		on personne.idPersonne= logement_personne.idPersonne
		inner join logement 
		on logement.idLogement= logement_personne.idLogement;
			
	#20 . Affichez le nombre de logements à la vente dans la ville de recherche de « hugo » (alias : nombre)
		select count(*) as Nombre
        from logement where categorie like 'vente'
        and ville in (
			select ville from demande d, personne p
            where d.idPersonne = p.idPersonne
            and p.prenom like 'bbb'
        );
        
        #Cedric
		SELECT COUNT(*) nombre FROM logement 
		WHERE categorie LIKE "vente" 
		AND ville IN(
			SELECT ville FROM demande WHERE idPersonne IN(
				SELECT idPersonne FROM personne WHERE prenom = "bbb"
			)
		)
		;
		#Jointure
		SELECT COUNT(*) nombre FROM logement INNER JOIN demande INNER JOIN personne
		ON logement.ville = demande.ville
		AND logement.categorie LIKE "vente" 
		AND personne.idPersonne = demande.idPersonne
		AND prenom = "bbb"
		;
        
        #soniaToday at 12:15 PM
		select count(idLogement)from logement 
		inner join demande
		on  demande.ville=logement.ville
        inner join personne
		on demande.idPersonne=personne.idPersonne
		where prenom ='bbb'
		and logement.categorie= 'vente';
#EXERCICE 4:
	#Créer deux utilisateurs ‘afpa’ et ‘cda314’
	create user 'afpa'@'localhost' identified by 'test';
	create user 'cda314'@'localhost' identified by 'test';
    
    #Donner les droits d’afficher et d’ajouter des personnes et logements pour l’utilisateur afpa
		grant select, insert on immobilier.personne to 'afpa@localhost';
		grant select, insert on immobilier.logement to 'afpa@localhost';
        
        #All  = drop , delete, select,insert,udpade,, create, truncate
	#Donner les droits de supprimer des demandes d’achat et logements pour l’utilisateur cda314
		grant delete on immobilier.logement to 'cda314@localhost';
		grant delete on immobilier.demande to 'cda314@localhost';
    
    
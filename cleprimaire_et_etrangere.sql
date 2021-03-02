
/* Nouvelle 
	Tables
*/
#une ligne 

create table client (id int not null auto_increment primary key,
		nom varchar(10));

#Supprimer la table commande
drop table commande;
 
create table commande(
		id int not null auto_increment primary key,
		numeroCommande int, idClient int
    );

select * from client;
select * from commande; 

#Ajour d'une clé étrangére
 alter table commande add constraint fk_client_id foreign key (idClient) references client(id);
 
 insert into client (nom) values ("joss");
 insert into commande (numeroCommande, idClient) values (1234567, 2);
 #Filtre Between
 select distinct nom, numeroCommande as commande from client as c, commande as cmd
	where c.id = cmd.idClient between "2021-02-15" and "2021-02-25";
    
#filtre IN
select distinct nom, numeroCommande as commande from client as c, commande as cmd
	where cmd.id = 2 or cmd.id = 3 or cmd.id=4;
#Operateur de comparaison
select distinct nom, numeroCommande as commande from client as c, commande as cmd
	where cmd.id  = 1 or cmd.id  != 1 or cmd.id  = 1;
#Like --- jocker % _
#filtre sur tous les noms qui commencent par un a
select distinct nom from client
	where nom like "cam%" ;
    
#filtre sur tous les noms qui se terminent par un a
select * from client
	where nom like "%a" ;
    
#filtre sur tous les noms qui contiennent  un a
select * from client
	where nom like "%a%";

select * from client
	where nom like "__o%";
    
show tables;
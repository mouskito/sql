#Voir tous les users
select user from mysql.user;
select * from mysql.user;

drop user 'cda314@localhost';

#Utilisateur courant
	select current_user() from mysql.user;

create user 'rim' identified by 'test123';

grant select on avion.pilote to 'rim', 'Simon', 'Cedric';

create user 'Simon' identified by 'test123';

grant update on avion.pilote to 'Simon';

alter user 'rim' identified by 'rimdu93';
alter user 'Simon' identified by 'rossini9521';






#create user 'cda' identified by 'test';

#alter user 'rim' identified by 'CHANGE TON MOT DE PASSE';

#all = select, insert, update et delete === CRUD

grant all on *.* to 'cda314@localhost';

grant select on cda314.* to 'cda';

grant all on cda314.* to 'cda';

grant select,insert, update on cda314.* to 'cda314@localhost';

show grants for 'cda314@localhost';

#Supprimer des droits
revoke all, grant option from 'cda314@localhost';

#mettre à jour les droits des utilisateurs
flush privileges;
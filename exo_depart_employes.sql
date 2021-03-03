use correction_exos;

create table departements(
        DNO int not null auto_increment primary key,
        DNOM varchar(20),
        DIR varchar(20),
        VILLE varchar(20)
);

#Ajouter des données dans departements
	
    call ps_ajout_departements;
	select * from departements;
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

call ps_ajout_employes;

#LES SQL

#1- Faire le produit cartésien en Employés 
#et Départements
	select * from employes
    cross join departements;
#2- Donnez les noms des employés et 
#les noms de leur département

	select ENOM, DNOM from employes
    inner join departements on
    employes.DNO = departements.DNO;
#3 - Donnez les numéros des employés 
#travaillant à Boston
	select ENO from employes where 
    DNO in (select DNO from departements
		where VILLE = 'Boston'
        );
        
	select ENO from employes s, 
    departements d    
    where s.DNO = d.DNO 
    and VILLE='BOSTON';
    
    select ENO from employes
    inner join departements 
    on VILLE like 'BOSTON' and
    employes.DNO = departements.DNO;

#4-  Donnez les noms des directeurs de département 1 et 3.
	select DIR from departements where DNO in (1,3);
    
#5- Donnez les noms des employés travaillant dans un 
#département avec au moins un ingénieur
	SELECT ENOM FROM employes WHERE DNO IN(
    SELECT DNO FROM employes WHERE PROF = "Ingénieur"
);

select ENOM from employes inner join departements
on employes.DNO = departements.DNO
where PROF = "Ingénieur";

#6- Donnez le salaire et le nom des employés gagnant plus qu'un 
#(au moins un) ingénieur
	select SAL, ENOM from employes 
    where SAL > (
		select MIN(SAL) from employes where PROF = "Ingénieur"
    );

SELECT SAL, ENOM from employes as emp where not exists
    (select * from employes where emp.SAL <= employes.SAL 
    AND employes.PROF = 'Ingenieur');
#7- Donnez les salaires et le nom des employés gagnant plus que 
#tous les ingénieurs
	select SAL, ENOM from employes 
    where SAL > (
		select MAX(SAL) from employes where PROF = "Ingénieur"
    );
#8- Donnez les noms des employés et les noms de leur directeur.
	select ENOM, DIR from employes
    inner join departements
    on employes.DNO = departements.DNO;
    
#9- Trouvez les noms des employés ayant le même directeur que JIM

	#A finir pour vendredi 05/02/2021

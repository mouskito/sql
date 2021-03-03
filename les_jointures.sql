use avion;
#Les JOINTURES
insert into vol (numVol, numPil) values (5,4);
# Les types 

#inner join
select * from avion
	inner join vol
    on avion.numAv = vol.numAv;
#Equivalent
select * from avion, vol
where avion.numAv = vol.numAv;

select * from musicien
inner join representation
on musicien.num_rep = representation.num_rep;

#left join
select * from avion 
left join vol
on avion.numAv = vol.numAv;

#right join
select * from avion 
right join vol
on avion.numAv = vol.numAv;

#full join // union

select * from avion
union
select * from vol;

#cross join
select * from avion
cross join vol;

#EXCEPT // minus
select nom from musicien where id_musicien not in 
( select id_musicien from spectacle);



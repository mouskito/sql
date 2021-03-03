CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_ajout_programmer`()
BEGIN
	insert into programmer (date, num_rep, tarif) values (now(),2,100);
	insert into programmer (date, num_rep, tarif) values (now(),2,100);
	insert into programmer (date, num_rep, tarif) values (now(),2,100);
	insert into programmer (date, num_rep, tarif) values (now(),2,100);
	insert into programmer (date, num_rep, tarif) values (now(),2,100);
	insert into programmer (date, num_rep, tarif) values (now(),2,100);
	insert into programmer (num_rep) values (2);
	insert into programmer (date, num_rep, tarif) values (now(),2,100);
	insert into programmer (date, num_rep, tarif) values (now(),2,100);
	insert into programmer (date, num_rep) values (now(),2);
END
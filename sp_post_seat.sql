CREATE DEFINER=`root`@`localhost` PROCEDURE `post_seat`(IN username varchar(45),
IN pass varchar(45),
In eventname varchar(45),
In locat varchar(45),
in rownumber int,
OUT out_status VARCHAR(45))
BEGIN
DECLARE userid int;
DECLARE eventid int;
DECLARE totalrowscount int;
DECLARE total int;

SELECT id into  userid FROM userInformation as u WHERE 
u.username = username and u.password = pass
and u.role = 'seller';
IF (userid IS NOT NULL)
THEN
    SELECT id,totalrows into  eventid,totalrowscount FROM events as e 
    where e.eventname = eventname 
    and e.location = locat;
    IF (eventid IS NOT NULL)
	    THEN
        BEGIN
            SELECT totalseats into  total FROM seats as s
            where s.eventid = eventid and s.rownumber = rownumber;
            set total = total +1;
            Update seats s set s.totalseats = total where s.eventid = eventid and s.rownumber = rownumber;
            commit;

		    SET  out_status = 'Success';
           
	    END;
    ELSE
       SET  out_status = 'Eventname and location not exist';
       Rollback;
    END IF;
ELSE   
    SET  out_status = 'User name or password wrong or role wrong';
    Rollback;
END IF;
END
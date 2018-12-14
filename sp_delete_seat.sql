CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_seat`(IN username varchar(45),
IN pass varchar(45),
In eventname varchar(45),
In locat varchar(45),
in rownumber int,
OUT out_status VARCHAR(45))
BEGIN
DECLARE userid int;
DECLARE eventid int;
DECLARE total int;
DECLARE usedseats int;

SELECT id into  userid FROM userInformation as u WHERE 
u.username = username and u.password = pass
and u.role = 'seller';
IF (userid IS NOT NULL)
THEN
    SELECT id into  eventid FROM events as e 
    where e.eventname = eventname 
    and e.location = locat;
    IF (eventid IS NOT NULL)
	    THEN
        BEGIN
            SELECT totalseats into  total FROM seats as s
            where s.eventid = eventid and s.rownumber = rownumber;

            SELECT count(*) into  usedseats FROM user_seats_information as us
            where us.eid = eventid and us.uid = userid and us.rownumber = rownumber;

            IF (usedseats < total)
            THEN
                BEGIN
                    Update seat set totalseats = (total-1) where eventid = eventid and rownumber = rownumber;
                    commit;
                    SET  out_status = 'Success';
                END;
            ELSE
                SET  out_status = 'All seats filled in that row unable to delete';
                Rollback;
            END IF;
           
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
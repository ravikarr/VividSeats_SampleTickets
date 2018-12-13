CREATE DEFINER=`root`@`localhost` PROCEDURE `get_availableseats`(IN username varchar(45),
IN pass varchar(45),
In eventname varchar(45),
In locat varchar(45),
OUT out_status VARCHAR(45))
BEGIN
DECLARE userid int;
DECLARE eventid int;
DECLARE total int;
DECLARE usedseats int;

SELECT id into  userid FROM userInformation as u WHERE 
u.username = username and u.password = pass
and u.role = 'customer';

IF (userid IS NOT NULL)
THEN
    SELECT id into  eventid FROM events as e 
    where e.eventname = eventname 
    and e.location = locat;

    IF (eventid is NOT NULL)
	    THEN
        BEGIN
		    SELECT sum(totalseats) into  total FROM seats as s
            where s.eventid = eventid;


            SELECT count(*) into  usedseats FROM user_seats_information as us
            where us.eid = eventid and us.uid = userid;

            IF (usedseats < total)
            THEN
                BEGIN
                    SET out_status = 'Total available seats : ' + total- usedseats;
                END;
            ELSE
                SET  out_status = 'No seats available';
                Rollback;
            END IF;


            
	    END;
    ELSE
        BEGIN
            SET  out_status = 'Eventname and location not exist';
            Rollback;
        END;
    END IF;
ELSE   
    SET  out_status = 'User name or password wrong or role wrong';
    Rollback;
END IF;
END
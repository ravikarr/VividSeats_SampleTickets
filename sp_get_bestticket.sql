CREATE DEFINER=`root`@`localhost` PROCEDURE `best_seat`(IN username varchar(45),
IN pass varchar(45),
In eventname varchar(45),
In locat varchar(45),
OUT out_status VARCHAR(45))
BEGIN
DECLARE userid int;
DECLARE eventid int;
DECLARE totalrowscount int;
DECLARE total int;
DECLARE usedseats int;
DECLARE i int;
DECLARE j int;
DECLARE rowseatscount int;
DECLARE seatprice int;
declare seatstatus bool;
declare checkuser int;

SET seatstatus = false;
SELECT id into  userid FROM userInformation as u WHERE 
u.username = username and u.password = pass
and u.role = 'customer';
IF (userid IS NOT NULL)
THEN
    SELECT id,totalrows into  eventid,totalrowscount FROM events as e 
    where e.eventname = eventname 
    and e.location = locat;
    IF (eventid IS NOT NULL)
	    THEN
            BEGIN
                SELECT sum(totalseats) into  total FROM seats as s
                    where s.eventid = eventid;


                SELECT count(*) into  usedseats FROM user_seats_information as us
                where us.eid = eventid and us.uid = userid;

                IF (usedseats < total)
                    THEN
                        BEGIN
                        SET i =1;
                        myloop1: WHILE i <= totalrowscount DO
						BEGIN
                            set rowseatscount =0;
                            SELECT totalseats,price into rowseatscount, seatprice FROM seats as s
                            where s.eventid = eventid and s.rownumber = i;
                            SET j =1;
                            myloop2: WHILE j <= rowseatscount DO
                                BEGIN
                                    set checkuser = null;
							        SELECT uid into checkuser FROM user_seats_information as us where us.eid = eventid and 
                                    us.uid = userid and us.rownumber = i and us.seatnumber = j;
                                    IF(checkuser IS NULL)
                                    THEN
                                        BEGIN
									    SELECT i as rownumber, j as seatnumber, seatprice as price;
									    set seatstatus = true;
									    leave myloop2;
                                        END;
                                    END IF;

                                    SET j = j+1;
                                 END;
                            END WHILE myloop2;
                            if (seatstatus = true)
                                THEN
                                    leave myloop1;
                            END if;
				            SET i = i+1;
                        END;
                    END WHILE myloop1;
					END;
                ELSE
                    select 'No seats available';
                    Rollback;
                END IF;    
	        END;
        ELSE
            select 'Eventname and location not exist';
            Rollback;
        END IF;
    ELSE   
        select 'User name or password wrong or role wrong';
        Rollback;
    END IF;
END
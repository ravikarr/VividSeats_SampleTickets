CREATE DEFINER=`root`@`localhost` PROCEDURE `update_events`(IN username varchar(45),
IN pass varchar(45),
In eventname varchar(45),
In locat varchar(45),
In totalrows int,
In seats int,
In price int,
OUT out_status VARCHAR(45))
BEGIN
DECLARE i int;
IF (SELECT 1 FROM userInformation as u WHERE u.username = username and u.password = pass and u.role = 'seller')
THEN
    IF (SELECT 1 FROM events as e where e.eventname = eventname and e.location = locat)
	    THEN
        BEGIN
		    SET  out_status = 'Eventname and location already exist';
            Rollback;
	    END;
    ELSE
        BEGIN
            INSERT INTO events (eventname,location,totalrows,eachrowseatsdefault,pricedefault) 
            VALUES (eventname,locat,totalrows,seats,price);
            commit;
            SET @last_id_in_events = LAST_INSERT_ID();
            SET i = 1;
            WHILE i <= totalrows DO
                BEGIN
                  insert into seats(eventid,rownumber,totalseats,price) VALUES (@last_id_in_events,i,seats,price);
				  SET i = i+1;
               END;
            END WHILE;
            commit;
            SET  out_status = 'Success';
        END;
    END IF;
ELSE   
    SET  out_status = 'User name or password wrong or role wrong';
    Rollback;
END IF;
END
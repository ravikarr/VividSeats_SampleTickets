CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user`(IN username varchar(45), IN password varchar(45), IN role varchar(45), OUT out_status VARCHAR(30))
BEGIN
IF (SELECT 1 FROM userInformation as u WHERE u.username = username)
THEN
	BEGIN
		SET  out_status = 'User Already exist';
        Rollback;
	END;
ELSE
    INSERT INTO userInformation (username,password,role) VALUES (username, password, role);
    commit;
    SET  out_status = 'Success';
END IF;
END
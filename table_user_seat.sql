DROP TABLE IF EXISTS `user_seats_information`;
CREATE TABLE `user_seats_information` (
  `uid` int(11) NOT NULL,
  `eid` int(11) NOT NULL,
  `rownumber` int(11) NOT NULL,
  `seatnumber` int(11) NOT NULL,
  PRIMARY KEY (`uid`,`eid`,`rownumber`,`seatnumber`),
  KEY `fk_user_seats_information_2_idx` (`eid`),
  CONSTRAINT `fk_user_seats_information_1` FOREIGN KEY (`uid`) REFERENCES `userInformation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_seats_information_2` FOREIGN KEY (`eid`) REFERENCES `events` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
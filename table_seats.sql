DROP TABLE IF EXISTS `seats`;
CREATE TABLE `seats` (
  `eventid` int(11) NOT NULL,
  `rownumber` int(11) NOT NULL,
  `totalseats` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`eventid`,`rownumber`),
  CONSTRAINT `fk_seats_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
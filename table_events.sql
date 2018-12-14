DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eventname` varchar(45) NOT NULL,
  `location` varchar(45) NOT NULL,
  `totalrows` int(11) NOT NULL,
  `eachrowseatsdefault` int(11) NOT NULL,
  `pricedefault` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
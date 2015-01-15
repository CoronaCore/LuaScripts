-- ----------------------------
-- Table structure for character_bounty
-- ----------------------------
DROP TABLE IF EXISTS `character_bounty`;
CREATE TABLE `character_bounty` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `bounty_name` CHAR(100) NOT NULL DEFAULT '',
  `hunter_name` CHAR(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MYISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

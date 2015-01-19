-- ----------------------------
-- Table structure for account_premium
-- ----------------------------
DROP TABLE IF EXISTS `account_premium`;
CREATE TABLE `account_premium` (
  `id` INT(11) UNSIGNED NOT NULL,
  `rank` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `coins` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `end` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MYISAM DEFAULT CHARSET=latin1;

INSERT INTO `account_premium`  (`id`) SELECT id FROM `account`;

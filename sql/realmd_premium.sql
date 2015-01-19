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

-- ----------------------------
-- Table structure for account_premium_codes
-- ----------------------------
DROP TABLE IF EXISTS `account_premium_codes`;
CREATE TABLE `account_premium_codes` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` CHAR(100) NOT NULL DEFAULT '0',
  `type` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `premium_time` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `premium_rank` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `premium_coins` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `item` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `gold` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `used` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` INT(11) UNSIGNED NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MYISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- Example for Premium Time + 30 Days
INSERT INTO `account_premium_codes` VALUES('1','WBt8fKpW','0','30','0','0','0','0','0','0000-00-00 00:00:00','1');
INSERT INTO `account_premium_codes` VALUES('2','U7MacUUY','0','30','0','0','0','0','0','0000-00-00 00:00:00','1');
INSERT INTO `account_premium_codes` VALUES('3','Dcq7G7A6','0','30','0','0','0','0','0','0000-00-00 00:00:00','1');
INSERT INTO `account_premium_codes` VALUES('4','ya2phXzj','0','30','0','0','0','0','0','0000-00-00 00:00:00','1');
INSERT INTO `account_premium_codes` VALUES('5','xCpEUzY7','0','30','0','0','0','0','0','0000-00-00 00:00:00','1');
INSERT INTO `account_premium_codes` VALUES('6','hNx4rvWX','0','30','0','0','0','0','0','0000-00-00 00:00:00','1');
INSERT INTO `account_premium_codes` VALUES('7','A2RL9W4W','0','30','0','0','0','0','0','0000-00-00 00:00:00','1');
INSERT INTO `account_premium_codes` VALUES('8','9NnFpzao','0','30','0','0','0','0','0','0000-00-00 00:00:00','1');
INSERT INTO `account_premium_codes` VALUES('9','ZHUjvxqA','0','30','0','0','0','0','0','0000-00-00 00:00:00','1');
INSERT INTO `account_premium_codes` VALUES('10','CTPDot64','0','30','0','0','0','0','0','0000-00-00 00:00:00','1');

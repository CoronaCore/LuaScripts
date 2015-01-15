-- ----------------------------
-- Table structure for premium
-- ----------------------------
DROP TABLE IF EXISTS `character_rules`;
CREATE TABLE `character_rules` (
  `guid` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `active` INT(11) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=MYISAM DEFAULT CHARSET=latin1;

INSERT INTO `character_rules`  (`guid`) SELECT guid FROM `characters`;

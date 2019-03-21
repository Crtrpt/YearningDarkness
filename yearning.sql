/*
 Navicat Premium Data Transfer

 Source Server         : yearning
 Source Server Type    : MySQL
 Source Server Version : 50714
 Source Host           : localhost:3306
 Source Schema         : yearning

 Target Server Type    : MySQL
 Target Server Version : 50714
 File Encoding         : 65001

 Date: 20/03/2019 10:52:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for core_account
-- ----------------------------
DROP TABLE IF EXISTS `core_account`;
CREATE TABLE `core_account`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `group` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `department` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `auth_group` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `real_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '请添加真实姓名',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of core_account
-- ----------------------------
INSERT INTO `core_account` VALUES (1, 'pbkdf2_sha256$120000$hi0tpN7ChNbV$B7YdPR1kicVaww9LSp1TTOmdSdm2Po0N0GO+W1XyiRs=', NULL, 0, 'admin', '', 'pass', '', 1, 1, '2018-07-26 07:15:33.931971', 'admin', '', 'admin', '');
INSERT INTO `core_account` VALUES (50, 'pbkdf2_sha256$120000$hi0tpN7ChNbV$B7YdPR1kicVaww9LSp1TTOmdSdm2Po0N0GO+W1XyiRs=', NULL, 0, 'admin_dev', '', '', 'admin@qq.com', 1, 1, '2019-03-16 09:35:52.586833', 'admin', '123456', 'dev,dev_admin,test', 'admin_dev');

-- ----------------------------
-- Table structure for core_account_groups
-- ----------------------------
DROP TABLE IF EXISTS `core_account_groups`;
CREATE TABLE `core_account_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `core_account_groups_account_id_group_id_9e3c433f_uniq`(`account_id`, `group_id`) USING BTREE,
  INDEX `core_account_groups_group_id_ffac212f_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `core_account_groups_account_id_3bd74ec9_fk_core_account_id` FOREIGN KEY (`account_id`) REFERENCES `core_account` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `core_account_groups_group_id_ffac212f_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for core_account_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `core_account_user_permissions`;
CREATE TABLE `core_account_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `core_account_user_permis_account_id_permission_id_5d993b63_uniq`(`account_id`, `permission_id`) USING BTREE,
  INDEX `core_account_user_pe_permission_id_6e106098_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `core_account_user_pe_account_id_9fe697ec_fk_core_acco` FOREIGN KEY (`account_id`) REFERENCES `core_account` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `core_account_user_pe_permission_id_6e106098_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for core_applygrained
-- ----------------------------
DROP TABLE IF EXISTS `core_applygrained`;
CREATE TABLE `core_applygrained`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `permissions` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `work_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `auth_group` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `real_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `core_applygrained_username_01d55fc9`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for core_databaselist
-- ----------------------------
DROP TABLE IF EXISTS `core_databaselist`;
CREATE TABLE `core_databaselist`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `connection_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `computer_room` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `port` int(11) NOT NULL,
  `password` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `before` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `after` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of core_databaselist
-- ----------------------------
INSERT INTO `core_databaselist` VALUES (15, 'local1', 'Other', '192.168.0.146', 'test', 3306, '123456', NULL, NULL);
INSERT INTO `core_databaselist` VALUES (16, 'test', 'Other', '192.168.0.146', 'test', 3306, '123456', NULL, NULL);

-- ----------------------------
-- Table structure for core_env
-- ----------------------------
DROP TABLE IF EXISTS `core_env`;
CREATE TABLE `core_env`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `env_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of core_env
-- ----------------------------
INSERT INTO `core_env` VALUES (1, 'dev');
INSERT INTO `core_env` VALUES (2, 'test');
INSERT INTO `core_env` VALUES (3, 'stg');
INSERT INTO `core_env` VALUES (4, 'prod');

-- ----------------------------
-- Table structure for core_globalpermissions
-- ----------------------------
DROP TABLE IF EXISTS `core_globalpermissions`;
CREATE TABLE `core_globalpermissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorization` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `inception` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `ldap` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `message` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `other` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `core_globalpermissions_authorization_b3bfe975`(`authorization`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of core_globalpermissions
-- ----------------------------
INSERT INTO `core_globalpermissions` VALUES (2, 'global', '{\'host\': \'192.168.0.80\', \'port\': \'6669\', \'user\': \'root\', \'password\': \'\', \'back_host\': \'192.168.0.80\', \'back_port\': \'3306\', \'back_user\': \'root\', \'back_password\': \'bY!1Mk9c9#\'}', '{\'type\': \'1\', \'host\': \'\', \'sc\': \'\', \'domain\': \'\', \'user\': \'\', \'password\': \'\'}', '{\'webhook\': \'https://oapi.dingtalk.com/robot/send?access_token=3e103dd7abcf0ef85bf5c1b4723c94db48771cc226a8caefcc97bd0a5bccd667\', \'smtp_host\': \'\', \'smtp_port\': \'\', \'user\': \'\', \'password\': \'\', \'to_user\': \'\', \'mail\': False, \'ding\': True, \'ssl\': False}', '{\'limit\': \'\', \'con_room\': [\'AWS\', \'Aliyun\', \'Own\', \'Other\', \'local\'], \'foce\': \'\', \'multi\': False, \'query\': False, \'sensitive_list\': [], \'sensitive\': \'\', \'exclued_db_list\': [], \'exclued_db\': \'\', \'email_suffix_list\': [\'qq.com\'], \'email_suffix\': \'\'}');

-- ----------------------------
-- Table structure for core_grained
-- ----------------------------
DROP TABLE IF EXISTS `core_grained`;
CREATE TABLE `core_grained`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `permissions` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `core_grained_username_4cd48d82`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of core_grained
-- ----------------------------
INSERT INTO `core_grained` VALUES (29, 'admin', '{\'ddl\': \'1\', \'ddlcon\': [\'local1\'], \'dml\': \'1\', \'dmlcon\': [\'local1\'], \'dic\': \'0\', \'diccon\': [], \'dicedit\': \'0\', \'user\': \'1\', \'base\': \'1\', \'dicexport\': \'0\', \'person\': [], \'query\': \'1\', \'querycon\': [\'local1\'], \'service\': \'1\', \'env\': \'1\'}');
INSERT INTO `core_grained` VALUES (36, 'dev', '{\'ddl\': \'1\', \'ddlcon\': [\'local1\'], \'dml\': \'1\', \'dmlcon\': [\'local1\'], \'query\': \'1\', \'querycon\': [\'local1\'], \'user\': \'0\', \'base\': \'0\', \'person\': [\'admin_dev\'], \'service\': \'0\', \'env\': \'0\'}');
INSERT INTO `core_grained` VALUES (37, 'test', '{\'ddl\': \'1\', \'ddlcon\': [\'test\', \'local1\'], \'dml\': \'1\', \'dmlcon\': [\'test\', \'local1\'], \'query\': \'1\', \'querycon\': [\'test\', \'local1\'], \'user\': \'0\', \'base\': \'1\', \'person\': [\'admin\'], \'service\': \'0\', \'env\': \'0\'}');
INSERT INTO `core_grained` VALUES (38, 'dev_admin', '{\'ddl\': \'1\', \'ddlcon\': [\'local1\', \'test\'], \'dml\': \'1\', \'dmlcon\': [\'local1\', \'test\'], \'query\': \'1\', \'querycon\': [\'local1\', \'test\'], \'user\': \'0\', \'base\': \'0\', \'person\': [\'admin\'], \'service\': \'0\', \'env\': \'0\'}');

-- ----------------------------
-- Table structure for core_query_order
-- ----------------------------
DROP TABLE IF EXISTS `core_query_order`;
CREATE TABLE `core_query_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `work_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `date` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `instructions` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `query_per` smallint(6) DEFAULT NULL,
  `computer_room` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `connection_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `export` smallint(6) DEFAULT NULL,
  `audit` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `time` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `real_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `core_query_order_work_id_1ae60daa`(`work_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of core_query_order
-- ----------------------------
INSERT INTO `core_query_order` VALUES (86, '201903161020157125', 'jzx', '2019-03-16 10:20', 'select * from test1', 3, 'Other', 'local1', 0, 'admin1', '2019-03-16 10:20', 'jzx');

-- ----------------------------
-- Table structure for core_querypermissions
-- ----------------------------
DROP TABLE IF EXISTS `core_querypermissions`;
CREATE TABLE `core_querypermissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `work_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `statements` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `core_querypermissions_work_id_da29a27b`(`work_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 95 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of core_querypermissions
-- ----------------------------
INSERT INTO `core_querypermissions` VALUES (85, '201903161020157125', 'jzx', 'SELECT *\nFROM test1.user limit 1000;');
INSERT INTO `core_querypermissions` VALUES (86, '201903161020157125', 'jzx', 'SELECT *\nFROM test1.user limit 1000;');
INSERT INTO `core_querypermissions` VALUES (87, '201903161020157125', 'jzx', 'SELECT *\nFROM test1.user limit 1000;');
INSERT INTO `core_querypermissions` VALUES (88, '201903161020157125', 'jzx', 'SELECT *\nFROM test1.user limit 1000;');
INSERT INTO `core_querypermissions` VALUES (89, '201903161020157125', 'jzx', 'SELECT *\nFROM test1.user limit 1000;');
INSERT INTO `core_querypermissions` VALUES (90, '201903161020157125', 'jzx', 'SELECT *\nFROM test1.user limit 1000;');
INSERT INTO `core_querypermissions` VALUES (91, '201903161020157125', 'jzx', 'SELECT *\nFROM test1.user limit 1000;');
INSERT INTO `core_querypermissions` VALUES (92, '201903161020157125', 'jzx', 'SELECT *\nFROM test1.user limit 1000;');
INSERT INTO `core_querypermissions` VALUES (93, '201903161020157125', 'jzx', 'SELECT *\nFROM test1.user limit 1000;');
INSERT INTO `core_querypermissions` VALUES (94, '201903161020157125', 'jzx', 'SELECT *\nFROM test1.user limit 1000;');

-- ----------------------------
-- Table structure for core_service
-- ----------------------------
DROP TABLE IF EXISTS `core_service`;
CREATE TABLE `core_service`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `env_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `env_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of core_service
-- ----------------------------
INSERT INTO `core_service` VALUES (1, '111', 'dev', 1);
INSERT INTO `core_service` VALUES (2, 'local', 'dev', 1);
INSERT INTO `core_service` VALUES (3, 'local', 'test', 2);
INSERT INTO `core_service` VALUES (4, 'local111', 'test', 2);
INSERT INTO `core_service` VALUES (5, 'local22', 'test', 2);
INSERT INTO `core_service` VALUES (6, 'local33', 'test', 2);
INSERT INTO `core_service` VALUES (7, '444', 'test', 2);
INSERT INTO `core_service` VALUES (8, 'abc服务', 'test', 2);
INSERT INTO `core_service` VALUES (9, '订单服务', 'test', 2);
INSERT INTO `core_service` VALUES (10, '订单服务1', 'test', 2);
INSERT INTO `core_service` VALUES (11, '服务呀', 'dev', 1);

-- ----------------------------
-- Table structure for core_sqlorder
-- ----------------------------
DROP TABLE IF EXISTS `core_sqlorder`;
CREATE TABLE `core_sqlorder`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `work_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `status` int(11) NOT NULL,
  `type` smallint(6) NOT NULL,
  `backup` smallint(6) NOT NULL,
  `bundle_id` int(11) DEFAULT NULL,
  `date` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `basename` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `sql` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `text` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `assigned` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `delay` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `rejected` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `real_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `executor` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `version` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '迭代版本',
  `env_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'dev' COMMENT '环境 默认dev环境',
  `service_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `env_id` int(11) DEFAULT 0,
  `service_id` int(11) DEFAULT 0,
  `pre_work_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '前置工单id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `core_sqlorder_bundle_id_3d5581f1`(`bundle_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 133 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of core_sqlorder
-- ----------------------------
INSERT INTO `core_sqlorder` VALUES (78, '201903161340281253', 'jzx', 1, 0, 0, 15, '2019-03-16 13:40', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `age` int(0) NOT NULL DEFAULT 0 COMMENT \'1111111\'', '1111', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (79, '201903161411231279', 'jzx', 1, 0, 1, 15, '2019-03-16 14:11', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `name333` int(0) NOT NULL DEFAULT 0 comment \"测试\"', '1111', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (80, '201903161502161482', 'jzx', 2, 0, 0, 15, '2019-03-16 15:02', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\' AFTER `age`', '修改表结构', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (81, '201903161508272183', 'jzx', 1, 1, 0, 15, '2019-03-16 15:08', 'test1', 'INSERT INTO user1 (`name1`,`age`) VALUES(\"aaa\",        22)', '输入测试', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (82, '201903161524498123', 'jzx', 1, 1, 1, 15, '2019-03-16 15:24', 'test1', 'INSERT INTO user1 (`name`,`age`) VALUES(\"aa111a\",        22)', '输入测试', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (83, '201903161530490167', 'jzx', 1, 0, 1, 15, '2019-03-16 15:30', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark1` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '修改表结构', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (84, '201903161539134698', 'jzx', 4, 0, 1, 15, '2019-03-16 15:39', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark2` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '修改表结构', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (85, '201903161541353981', 'jzx', 4, 0, 1, 15, '2019-03-16 15:41', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark3` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '修改表结构', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (86, '201903161553480496', 'jzx', 1, 0, 0, 15, '2019-03-16 15:53', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark4` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '修改表结构', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (87, '201903161559004760', 'jzx', 1, 0, 0, 15, '2019-03-16 15:59', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark5` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '修改表结构', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (88, '201903161559291592', 'jzx', 4, 0, 1, 15, '2019-03-16 15:59', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark6` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '修改表结构', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (89, '201903161601202104', 'jzx', 4, 0, 1, 15, '2019-03-16 16:01', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark7` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '修改表结构', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (90, '201903161601396429', 'jzx', 4, 0, 1, 15, '2019-03-16 16:01', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark8` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '修改表结构', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (91, '201903161610030853', 'jzx', 4, 0, 1, 15, '2019-03-16 16:10', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark9` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '111', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (92, '201903161610103947', 'jzx', 4, 0, 1, 15, '2019-03-16 16:10', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark10` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '111', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (93, '201903161610155709', 'jzx', 4, 0, 1, 15, '2019-03-16 16:10', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark11` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '111', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (94, '201903161634313695', 'jzx', 4, 0, 1, 15, '2019-03-16 16:34', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark12` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '111', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (95, '201903161642325369', 'jzx', 4, 0, 1, 15, '2019-03-16 16:42', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark14` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '111', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (96, '201903161652566158', 'jzx', 4, 0, 1, 15, '2019-03-16 16:52', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark15` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '111', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (97, '201903161654549364', 'jzx', 4, 0, 1, 15, '2019-03-16 16:54', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark16` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '111', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (98, '201903161656156978', 'jzx', 4, 0, 1, 15, '2019-03-16 16:56', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark17` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '111', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (99, '201903161659106813', 'jzx', 4, 0, 1, 15, '2019-03-16 16:59', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark18` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '111', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (100, '201903161705446415', 'jzx', 4, 0, 1, 15, '2019-03-16 17:05', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark19` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '111', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (101, '201903161708564639', 'jzx', 4, 0, 1, 15, '2019-03-16 17:08', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark20` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '111', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (102, '201903161710200139', 'jzx', 4, 0, 1, 15, '2019-03-16 17:10', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark21` varchar(21) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '111', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (103, '201903161713405379', 'jzx', 1, 0, 1, 15, '2019-03-16 17:13', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark22` varchar(22) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '111', 'admin', '', '', 'jzx', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (104, '201903161718220674', 'admin', 1, 0, 0, 15, '2019-03-16 17:18', 'test1', 'ALTER TABLE `test1`.`user1` DROP COLUMN `remark22`', '111', 'admin', '', '', '', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (105, '201903161739245483', 'admin_dev', 1, 0, 0, 15, '2019-03-16 17:39', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark23` varchar(22) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '发布测试', 'admin_dev', '', '', 'admin_dev', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (106, '201903161828474610', 'admin_dev', 1, 0, 0, 15, '2019-03-16 18:28', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark24` varchar(22) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '发布测试', 'admin_dev', '', '', 'admin_dev', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (107, '201903161832025670', 'admin_dev', 1, 0, 0, 15, '2019-03-16 18:32', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark25` varchar(22) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '0.5.4xxxxxx', 'admin_dev', '', '', 'admin_dev', NULL, '', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (108, '201903180918393980', 'admin_dev', 1, 0, 0, 15, '2019-03-18 09:18', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark26` varchar(22) NOT NULL DEFAULT \'\' COMMENT \'备注\'', '增加迭代版本', 'admin_dev', '', '', 'admin_dev', NULL, '0.0.1', 'dev', '', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (109, '201903181453132457', 'admin_dev', 2, 0, 0, 15, '2019-03-18 14:53', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark27` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '111', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.1', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (110, '201903181500236827', 'admin_dev', 2, 0, 0, 15, '2019-03-18 15:00', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark28` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '111', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.1', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (111, '201903181501335213', 'admin_dev', 2, 0, 0, 15, '2019-03-18 15:01', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark29` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '111', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.1', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (112, '201903181502473742', 'admin_dev', 2, 0, 0, 15, '2019-03-18 15:02', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark29` varchar(21) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '111', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.1', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (113, '201903181503324029', 'admin_dev', 2, 0, 0, 15, '2019-03-18 15:03', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark29` varchar(22) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '111', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.1', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (114, '201903181505219147', 'admin_dev', 2, 0, 0, 15, '2019-03-18 15:05', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark29` varchar(22) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '111', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.1', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (115, '201903181509343125', 'admin_dev', 2, 0, 0, 15, '2019-03-18 15:09', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark29` varchar(22) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '111', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.1', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (116, '201903181510142801', 'admin_dev', 2, 0, 0, 15, '2019-03-18 15:10', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark29` varchar(22) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '111', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.1', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (117, '201903181511382870', 'admin_dev', 2, 0, 0, 15, '2019-03-18 15:11', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark29` varchar(22) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '111', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.1', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (118, '201903181512008063', 'admin_dev', 2, 0, 0, 15, '2019-03-18 15:12', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark29` varchar(22) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '111', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.1', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (119, '201903181514324593', 'admin_dev', 2, 0, 0, 15, '2019-03-18 15:14', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark29` varchar(22) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '111', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.1', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (120, '201903181517081273', 'admin_dev', 2, 0, 0, 15, '2019-03-18 15:17', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark29` varchar(22) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '111', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.1', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (121, '201903181517419170', 'admin_dev', 2, 0, 0, 15, '2019-03-18 15:17', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark29` varchar(22) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '111', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.1', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (122, '201903181519008174', 'admin_dev', 2, 0, 0, 15, '2019-03-18 15:19', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark29` varchar(22) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '111', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.1', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (123, '201903181521003028', 'admin_dev', 2, 0, 0, 15, '2019-03-18 15:21', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark29` varchar(22) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '111', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.1', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (124, '201903181521216739', 'admin_dev', 1, 0, 0, 15, '2019-03-18 15:21', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark29` varchar(22) NOT NULL DEFAULT \"\" COMMENT \'备注\'', '111', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.1', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (127, '201903181544112783', 'admin_dev', 1, 0, 0, 16, '2019-03-18 15:44', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark30` varchar(30) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'local更新', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.4', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (128, '201903181549545472', 'admin_dev', 1, 0, 0, 16, '2019-03-18 15:49', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark31` varchar(30) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'local更新', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.4', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (129, '201903181551081742', 'admin_dev', 1, 0, 0, 16, '2019-03-18 15:51', 'test1', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark32` varchar(30) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'local更新', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.4', 'dev', 'local', 0, 0, '');
INSERT INTO `core_sqlorder` VALUES (130, '201903201049013472', 'admin_dev', 2, 0, 1, 16, '2019-03-20 10:49', 'test1', 'ALTER TABLE `test1`.`user1`   DROP COLUMN `remark31`', '工单更新测试', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.4', 'dev', '', NULL, NULL, '');
INSERT INTO `core_sqlorder` VALUES (131, '201903201051181385', 'admin_dev', 2, 0, 1, 16, '2019-03-20 10:51', 'test1', 'ALTER TABLE `test1`.`user1`   DROP COLUMN `remark30`', '工单更新测试', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.4', 'dev', '', NULL, NULL, '');
INSERT INTO `core_sqlorder` VALUES (132, '201903201051420382', 'admin_dev', 1, 0, 1, 16, '2019-03-20 10:51', 'test1', 'ALTER TABLE `test1`.`user1`   DROP COLUMN `remark30`', '工单更新测试', 'admin_dev', '', '', 'admin_dev', NULL, '0.5.4', 'dev', '', NULL, NULL, '');

-- ----------------------------
-- Table structure for core_sqlrecord
-- ----------------------------
DROP TABLE IF EXISTS `core_sqlrecord`;
CREATE TABLE `core_sqlrecord`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `sql` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `error` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `workid` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `affectrow` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sequence` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SQLSHA1` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `execute_time` varchar(150) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `backup_dbname` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 106 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of core_sqlrecord
-- ----------------------------
INSERT INTO `core_sqlrecord` VALUES (36, 'Execute Successfully', 'use `test1`', 'None', '201903161340281253', '0', '\'1552715013_928_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (37, 'Execute Successfully', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `age` int(0) NOT NULL DEFAULT 0 COMMENT \'1111111\'', 'None', '201903161340281253', '1', '\'1552715013_928_1\'', '', '0.020', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (38, 'Execute Successfully', 'use `test1`', 'None', '201903161411231279', '0', '\'1552716731_1066_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (39, 'Execute Successfully', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `name333` int(0) NOT NULL DEFAULT 0 comment \"测试\"', 'None', '201903161411231279', '1', '\'1552716731_1066_1\'', '', '0.030', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (40, 'Execute Successfully', 'use `test1`', 'None', '201903161508272183', '0', '\'1552720154_1221_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (41, 'Execute Successfully', 'INSERT INTO user1 (`name1`,`age`) VALUES(\"aaa\",        22)', 'None', '201903161508272183', '1', '\'1552720154_1221_1\'', '', '0.000', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (42, 'Execute Successfully', 'use `test1`', 'None', '201903161524498123', '0', '\'1552721206_1271_0\'', '', '0.010', 'None');
INSERT INTO `core_sqlrecord` VALUES (43, 'Execute Successfully', 'INSERT INTO user1 (`name`,`age`) VALUES(\"aa111a\",        22)', 'None', '201903161524498123', '1', '\'1552721206_1271_1\'', '', '0.000', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (44, 'Execute Successfully', 'use `test1`', 'None', '201903161530490167', '0', '\'1552721492_1296_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (45, 'Execute Successfully', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark1` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', 'None', '201903161530490167', '4', '\'1552721492_1296_1\'', '', '0.150', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (46, 'Execute Successfully', 'use `test1`', 'None', '201903161539134698', '0', '\'1552722008_51_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (47, 'Execute Successfully\nBackup failed', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark2` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', 'Backup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)\nBackup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)', '201903161539134698', '4', '\'1552722008_51_1\'', '', '0.130', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (48, 'Execute Successfully', 'use `test1`', 'None', '201903161541353981', '0', '\'1552722155_98_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (49, 'Execute Successfully\nBackup failed', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark3` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', 'Backup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)\nBackup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)', '201903161541353981', '4', '\'1552722155_98_1\'', '', '0.030', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (50, 'Execute Successfully', 'use `test1`', 'None', '201903161553480496', '0', '\'1552722866_139_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (51, 'Execute Successfully', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark4` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', 'None', '201903161553480496', '4', '\'1552722866_139_1\'', '', '0.080', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (52, 'Execute Successfully', 'use `test1`', 'None', '201903161559004760', '0', '\'1552723172_279_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (53, 'Execute Successfully', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark5` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', 'None', '201903161559004760', '4', '\'1552723172_279_1\'', '', '0.120', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (54, 'Execute Successfully', 'use `test1`', 'None', '201903161559291592', '0', '\'1552723205_305_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (55, 'Execute Successfully\nBackup failed', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark6` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', 'Backup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)\nBackup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)', '201903161559291592', '4', '\'1552723205_305_1\'', '', '0.040', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (56, 'Execute Successfully', 'use `test1`', 'None', '201903161601202104', '0', '\'1552723434_339_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (57, 'Execute Successfully\nBackup failed', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark7` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', 'Backup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)\nBackup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)', '201903161601202104', '4', '\'1552723434_339_1\'', '', '0.050', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (58, 'Execute Successfully', 'use `test1`', 'None', '201903161601396429', '0', '\'1552723652_361_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (59, 'Execute Successfully\nBackup failed', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark8` varchar(20) NOT NULL DEFAULT \"\" COMMENT \'备注\'', 'Backup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)\nBackup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)', '201903161601396429', '4', '\'1552723652_361_1\'', '', '0.030', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (60, 'Execute Successfully', 'use `test1`', 'None', '201903161610030853', '0', '\'1552723871_425_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (61, 'Execute Successfully\nBackup failed', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark9` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'Backup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)\nBackup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)', '201903161610030853', '4', '\'1552723871_425_1\'', '', '0.030', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (62, 'Execute Successfully', 'use `test1`', 'None', '201903161610103947', '0', '\'1552724321_449_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (63, 'Execute Successfully\nBackup failed', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark10` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'Backup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)\nBackup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)', '201903161610103947', '4', '\'1552724321_449_1\'', '', '0.030', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (64, 'Execute Successfully', 'use `test1`', 'None', '201903161610155709', '0', '\'1552724524_467_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (65, 'Execute Successfully\nBackup failed', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark11` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'Backup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)\nBackup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)', '201903161610155709', '4', '\'1552724524_467_1\'', '', '0.040', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (66, 'Execute Successfully', 'use `test1`', 'None', '201903161634313695', '0', '\'1552725309_493_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (67, 'Execute Successfully\nBackup failed', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark12` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'Backup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)\nBackup: Access denied for user \'root\'@\'192.168.0.80\' (using password: YES)', '201903161634313695', '4', '\'1552725309_493_1\'', '', '0.030', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (68, 'Execute Successfully', 'use `test1`', 'None', '201903161642325369', '0', '\'1552725795_539_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (69, 'Execute Successfully\nBackup failed', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark14` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'Backup: Access denied for user \'ro\'@\'192.168.0.80\' (using password: YES)\nBackup: Access denied for user \'ro\'@\'192.168.0.80\' (using password: YES)', '201903161642325369', '4', '\'1552725795_539_1\'', '', '0.030', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (70, 'Execute Successfully', 'use `test1`', 'None', '201903161652566158', '0', '\'1552726422_590_0\'', '', '0.010', 'None');
INSERT INTO `core_sqlrecord` VALUES (71, 'Execute Successfully', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark15` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'Backup: Host \'192.168.0.80\' is not allowed to connect to this MySQL server', '201903161652566158', '4', '\'1552726422_590_1\'', '', '0.110', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (72, 'Execute Successfully', 'use `test1`', 'None', '201903161654549364', '0', '\'1552726529_621_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (73, 'Execute Successfully', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark16` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'Backup: Host \'192.168.0.80\' is not allowed to connect to this MySQL server', '201903161654549364', '4', '\'1552726529_621_1\'', '', '0.030', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (74, 'Execute Successfully', 'use `test1`', 'None', '201903161656156978', '0', '\'1552726614_647_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (75, 'Execute Successfully\nBackup failed', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark17` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'Backup: Access denied for user \'root\'@\'localhost\' (using password: YES)\nBackup: Access denied for user \'root\'@\'localhost\' (using password: YES)', '201903161656156978', '4', '\'1552726614_647_1\'', '', '0.030', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (76, 'Execute Successfully', 'use `test1`', 'None', '201903161659106813', '0', '\'1552726787_670_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (77, 'Execute Successfully\nBackup failed', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark18` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'Backup: Access denied for user \'root\'@\'localhost\' (using password: YES)\nBackup: Access denied for user \'root\'@\'localhost\' (using password: YES)', '201903161659106813', '4', '\'1552726787_670_1\'', '', '0.120', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (78, 'Execute Successfully', 'use `test1`', 'None', '201903161705446415', '0', '\'1552727181_701_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (79, 'Execute Successfully\nBackup failed', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark19` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'Backup: Access denied for user \'root\'@\'localhost\' (using password: YES)\nBackup: Access denied for user \'root\'@\'localhost\' (using password: YES)', '201903161705446415', '4', '\'1552727182_701_1\'', '', '0.040', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (80, 'Execute Successfully', 'use `test1`', 'None', '201903161708564639', '0', '\'1552727371_722_0\'', '', '0.010', 'None');
INSERT INTO `core_sqlrecord` VALUES (81, 'Execute Successfully\nBackup failed', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark20` varchar(20) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'Backup: Access denied for user \'root\'@\'localhost\' (using password: YES)\nBackup: Access denied for user \'root\'@\'localhost\' (using password: YES)', '201903161708564639', '4', '\'1552727371_722_1\'', '', '0.080', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (82, 'Execute Successfully', 'use `test1`', 'None', '201903161710200139', '0', '\'1552727460_753_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (83, 'Execute Successfully\nBackup failed', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark21` varchar(21) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'Backup: Access denied for user \'root\'@\'localhost\' (using password: YES)\nBackup: Access denied for user \'root\'@\'localhost\' (using password: YES)', '201903161710200139', '4', '\'1552727460_753_1\'', '', '0.040', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (84, 'Execute Successfully', 'use `test1`', 'None', '201903161713405379', '0', '\'1552727656_850_0\'', '', '0.010', 'None');
INSERT INTO `core_sqlrecord` VALUES (85, 'Execute Successfully\nBackup successfully', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark22` varchar(22) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'None', '201903161713405379', '4', '\'1552727656_850_1\'', '', '0.050', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (86, 'Execute Successfully', 'use `test1`', 'None', '201903161718220674', '0', '\'1552727970_936_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (87, 'Execute Successfully', 'ALTER TABLE `test1`.`user1` DROP COLUMN `remark22`', 'None', '201903161718220674', '4', '\'1552727970_936_1\'', '', '0.040', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (88, 'Execute Successfully', 'use `test1`', 'None', '201903161739245483', '0', '\'1552729206_1165_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (89, 'Execute Successfully', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark23` varchar(22) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'None', '201903161739245483', '4', '\'1552729206_1165_1\'', '', '0.180', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (90, 'Execute Successfully', 'use `test1`', 'None', '201903161828474610', '0', '\'1552732168_2339_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (91, 'Execute Successfully', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark24` varchar(22) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'None', '201903161828474610', '4', '\'1552732168_2339_1\'', '', '0.040', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (92, 'Execute Successfully', 'use `test1`', 'None', '201903161832025670', '0', '\'1552732360_2400_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (93, 'Execute Successfully', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark25` varchar(22) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'None', '201903161832025670', '4', '\'1552732360_2400_1\'', '', '0.140', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (94, 'Execute Successfully', 'use `test1`', 'None', '201903180918393980', '0', '\'1552755978_3904_0\'', '', '0.010', 'None');
INSERT INTO `core_sqlrecord` VALUES (95, 'Execute Successfully', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark26` varchar(22) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'None', '201903180918393980', '4', '\'1552755978_3904_1\'', '', '0.070', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (96, 'Execute Successfully', 'use `test1`', 'None', '201903181521216739', '0', '\'1552759364_4364_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (97, 'Execute Successfully', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark29` varchar(22) NOT NULL DEFAULT \"\" COMMENT \'备注\'', 'None', '201903181521216739', '4', '\'1552759364_4364_1\'', '', '0.160', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (98, 'Execute Successfully', 'use `test1`', 'None', '201903181544112783', '0', '\'1552760848_4473_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (99, 'Execute Successfully', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark30` varchar(30) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'None', '201903181544112783', '4', '\'1552760849_4473_1\'', '', '0.150', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (100, 'Execute Successfully', 'use `test1`', 'None', '201903181549545472', '0', '\'1552761221_4485_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (101, 'Execute Successfully', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark31` varchar(30) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'None', '201903181549545472', '4', '\'1552761221_4485_1\'', '', '0.130', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (102, 'Execute Successfully', 'use `test1`', 'None', '201903181551081742', '0', '\'1552761300_4499_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (103, 'Execute Successfully', 'ALTER TABLE `test1`.`user1`   ADD COLUMN `remark32` varchar(30) NOT NULL DEFAULT \'\' COMMENT \'备注\'', 'None', '201903181551081742', '4', '\'1552761300_4499_1\'', '', '0.030', '192_168_0_146_3306_test1');
INSERT INTO `core_sqlrecord` VALUES (104, 'Execute Successfully', 'use `test1`', 'None', '201903201051420382', '0', '\'1552863789_5946_0\'', '', '0.000', 'None');
INSERT INTO `core_sqlrecord` VALUES (105, 'Execute Successfully\nBackup successfully', 'ALTER TABLE `test1`.`user1`   DROP COLUMN `remark30`', 'None', '201903201051420382', '4', '\'1552863789_5946_1\'', '', '0.060', '192_168_0_146_3306_test1');

-- ----------------------------
-- Table structure for core_todolist
-- ----------------------------
DROP TABLE IF EXISTS `core_todolist`;
CREATE TABLE `core_todolist`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `content` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;

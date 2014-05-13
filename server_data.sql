-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Erstellungszeit: 13. Jul 2013 um 13:59
-- Server Version: 5.5.27
-- PHP-Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `android_im`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `friends`
--

CREATE TABLE IF NOT EXISTS `friends` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `providerId` int(10) unsigned NOT NULL DEFAULT '0',
  `requestId` int(10) unsigned NOT NULL DEFAULT '0',
  `status` binary(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Index_3` (`providerId`,`requestId`),
  KEY `Index_2` (`providerId`,`requestId`,`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='providerId is the Id of the users who wish to be friend with' AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `messages`
--

CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `fromuid` int(255) NOT NULL,
  `touid` int(255) NOT NULL,
  `sentdt` datetime NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `readdt` datetime DEFAULT NULL,
  `messagetext` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `email` varchar(45) NOT NULL DEFAULT '',
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `authenticationTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `userKey` varchar(32) NOT NULL DEFAULT '',
  `IP` varchar(45) NOT NULL DEFAULT '',
  `port` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Index_2` (`username`),
  KEY `Index_3` (`authenticationTime`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

CREATE TABLE server_info (
  server_id VARCHAR(50)
  ); 

CREATE TABLE channel (
  user_count INT,
  name VARCHAR(100),
  createTime DATETIME 
  );
CREATE INDEX idx_channel_name on channel(name);
CREATE INDEX idx_channel_createTime on channel(createTime);


CREATE TABLE user (
  udid VARCHAR(50), 
  name VARCHAR(100),
  createTime DATETIME 
  );
CREATE INDEX idx_user_udid on user(udid);
CREATE INDEX idx_user_name on user(name);
CREATE INDEX idx_user_createTime on user(createTime);


CREATE TABLE user_channel (
  udid VARCHAR(50), 
  channel_name VARCHAR(100)
  );
CREATE INDEX idx_uc_udid on user_channel(udid);
CREATE INDEX idx_uc_channel_name on user_channel(channel_name);



-- wusir add 9 tables about server activity 


##活动时间扩展表
DROP TABLE IF EXISTS act_time;

CREATE TABLE IF NOT EXISTS act_time (
cat_timeid  int(16) unsigned NOT NULL AUTO_INCREMENT COMMENT 'act id 自动增加',
occurtime datetime not null default '0000-00-00 00:00:00'  COMMENT '该条记录插入时间',
begin_date datetime not null default '0000-00-00 00:00:00'  comment '活动开始日期',
end_date datetime not null default '0000-00-00 00:00:00'  comment '活动结束日期',
week varchar(7) not null default '0000000' comment '七位代表周一到周日，全0无效',
##begin_time time,
##end_time time,
extend1 varchar(16) comment  '扩展字段',
 extend2 varchar(32) comment  '扩展字段',
 extend3 varchar(64) comment  '扩展字段',
extendi1 int(16) comment  '扩展字段',
 extendi2 int(32) comment  '扩展字段',
 extenddate int(16) unsigned  default 0 comment '如果如下情况：活动5.15.到6.15 端午节除外，那特殊日期扩展用这个字段关联extend_date表',
`using` tinyint(1) not null default '0'  COMMENT '该条记录是否有用，比如删除并不是删除，而是修改该字段',
   PRIMARY KEY (cat_timeid),
  UNIQUE KEY Index_2 (begin_date)
)ENGINE=InnoDB  AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='activity time data';

-- 活动详情表
DROP TABLE IF EXISTS activity;

CREATE TABLE IF NOT EXISTS activity (
 act_id int(60) unsigned NOT NULL AUTO_INCREMENT COMMENT 'act id 自动增加',
 `occurtime` datetime  not null default '0000-00-00 00:00:00'  COMMENT '该条记录插入时间',
 initiator_id int(30) unsigned NOT NULL DEFAULT 0 comment '发布者id',
 initiator_name varchar(45) NOT NULL DEFAULT '' comment '发布者usename',
 `picuture` int(32) unsigned comment '活动宣传图片',
 address varchar(45) not null default '' comment '活动地点',
 next_time datetime not null default '0000-00-00 00:00:00' comment '活动下一次时间，全天用00:00:00表示',
 act_time int(16) unsigned not null default 0 comment '活动时间补充',
 title varchar(120) not null default '' comment '活动标题',
 context varchar(510) not null default '' comment '活动介绍',
 special varchar(120) not null default '' comment '活动特别说明',
 supplementid int(62) unsigned not null default 0 comment '活动介绍补充',
 max_user_num int(30) not null default 0 comment '活动最大容纳人数 默认0 不限制人数',
 participatenum int(16) comment  '参与人数',
 likenum int(16) comment  '点赞人数',
extend1 varchar(16) comment  '扩展字段',
 extend2 varchar(32) comment  '扩展字段',
 extend3 varchar(64) comment  '扩展字段',
extendi1 int(16) comment  '扩展字段',
 extendi2 int(32) comment  '扩展字段',
 `using` tinyint(1) not null default '0' COMMENT '标明该记录是否对系统依然有效',
   PRIMARY KEY (act_id),
  UNIQUE KEY Index_2 (initiator_name)
 -- KEY `Index_3` (`authenticationTime`)
)ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='activity data 需要按月进行分区' ;

-- 用户和组织详情表
DROP TABLE IF EXISTS users_attestation;

CREATE TABLE IF NOT EXISTS  users_attestation(
  Id int(30) unsigned NOT NULL AUTO_INCREMENT,
  occurtime datetime not null default '0000-00-00 00:00:00' COMMENT '该条记录插入时间',
  username varchar(45) NOT NULL DEFAULT '' comment '用户名',
  `password` varchar(32) NOT NULL DEFAULT '',
  ##limitpic blob comment '16k 以下的用户缩略图',
  `picutureU` int(60) unsigned comment '用户照片 参照picture——user',
  email varchar(45) NOT NULL DEFAULT '',
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 0,
  authenticationTime datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  userKey varchar(32) NOT NULL DEFAULT '',
  IP varchar(45) NOT NULL DEFAULT '' ,
  `port` int(10) unsigned NOT NULL DEFAULT 0,
  attestation varchar(3) not null default '000',
  `using` tinyint(1) not null default 0  COMMENT '该条记录是否有用，比如删除并不是删除，而是修改该字段',
  PRIMARY KEY (Id),
  UNIQUE KEY `Index_2` (username),
  KEY `Index_3` (authenticationTime)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 comment '活动用户，如个人或者是组织';

##待扩展
-- 一个活动有多个管理者 可以尝试建立 act_manager table


-- -用户和活动关联表
DROP TABLE IF EXISTS users_activity;

create table if not exists users_activity(
  Id int(30) unsigned NOT NULL AUTO_INCREMENT,
  occurtime datetime not null default '0000-00-00 00:00:00' COMMENT '该条记录插入时间', 
   partner_id int(30) unsigned NOT NULL DEFAULT 0 comment '参与者id',
   act_id int(60) unsigned not null default 0 comment '活动id',
   status varchar(3) not null default '000' comment '参与状态，如000 表示参加、001 表示参加并被发布者同意参与、010 发布者邀请参与，不需要同意', 
   attitude varchar(6) not null default '000000' comment '第一位点赞，第二位@分享，第三位转发',
  `using` tinyint(1) not null default 0  COMMENT '该条记录是否有用，比如删除并不是删除，而是修改该字段',
    PRIMARY KEY (Id),
	UNIQUE KEY `Index_2` (occurtime)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 comment '用户，活动对应表 应该按月或者是星期 分区';

-- 用户参与的活动列表  --用户很少会看过去参与的活动，所以 数据保存一个月内的就好，更多数据查找活动详情表
DROP TABLE IF EXISTS  use_actLists;

create table if not exists use_actLists(
  Id int(30) unsigned NOT NULL AUTO_INCREMENT,
  occurtime datetime not null default '0000-00-00 00:00:00' COMMENT '该条记录插入时间',
  
  partner_id int(30) unsigned NOT NULL DEFAULT 0 comment '参与者id 或者是待参与者id',
  partner_name varchar(45) not null default '' comment '参与者用户名 或者是待参与者用户名',
    act_id int(60) unsigned not null default 0 comment '活动id',
    title varchar(120) not null default '' comment '活动标题',
	limitpic_act varchar(60) comment '16k 以下的缩略图 活动宣传图片 id ,如果这个id 在Android上面有，就不向服务器发送请求',
	address varchar(45) not null default '' comment '活动地点',
   next_time datetime not null default '0000-00-00 00:00:00' comment '活动下一次时间',
   act_context varchar(510) not null default '' comment '活动内容简介，不超过二百个字',
   release_id int(30) unsigned NOT NULL DEFAULT 0 comment '发布者id',
   release_user varchar(45)  not null default '' comment '发布者username',
   limitpic_user varchar(60) comment '16k 以下的缩略图 发布者图片 id ,如果这个id 在Android上面有，就不向服务器发送请求',

   participatenum int(16) comment  '参与人数',
   likenum int(16) comment  '点赞人数',
   
  `using` tinyint(1) not null default 0  COMMENT '该条记录是否有用，比如删除并不是删除，而是修改该字段',
    PRIMARY KEY (Id),
  UNIQUE KEY `Index_2` (occurtime,partner_name)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 comment '给用户展现推荐的活动列表，以及用户参与的活动列表';

-- 推荐用户感兴趣活动列表  这个表会每十分钟或者订阅更新
DROP TABLE IF EXISTS  use_actLists_tmp;

create table if not exists use_actLists_tmp(
  Id int(30) unsigned NOT NULL AUTO_INCREMENT,
  occurtime datetime not null default '0000-00-00 00:00:00' COMMENT '该条记录插入时间',
  
  partner_id int(30) unsigned NOT NULL DEFAULT 0 comment '参与者id 或者是待参与者id',
  partner_name varchar(45) not null default '' comment '参与者用户名 或者是待参与者用户名',
    act_id int(60) unsigned not null default 0 comment '活动id',
    title varchar(120) not null default '' comment '活动标题',
	limitpic_act varchar(60) comment '16k 以下的缩略图 活动宣传图片 id ,如果这个id 在Android上面有，就不向服务器发送请求',
	address varchar(45) not null default '' comment '活动地点',
   next_time datetime not null default '0000-00-00 00:00:00' comment '活动下一次时间',
   act_context varchar(510) not null default '' comment '活动内容简介，不超过二百个字',
   release_id int(30) unsigned NOT NULL DEFAULT 0 comment '发布者id',
   release_user varchar(45)  not null default '' comment '发布者username',
   limitpic_user varchar(60) comment '16k 以下的缩略图 发布者图片 id ,如果这个id 在Android上面有，就不向服务器发送请求',

   participatenum int(16) comment  '参与人数',
   likenum int(16) comment  '点赞人数',
   
  `using` tinyint(1) not null default 0  COMMENT '该条记录是否有用，比如删除并不是删除，而是修改该字段',
    PRIMARY KEY (Id),
  UNIQUE KEY `Index_2` (occurtime,partner_name)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 comment '推荐用户感兴趣活动列表';


-- -活动图片表
DROP TABLE IF EXISTS `picture_act`;

create table if not exists `picture_act`(
id int(60) unsigned not null auto_increment,
occurtime datetime not null default '0000-00-00 00:00:00' COMMENT '该条记录插入时间',
limitpic blob comment '16k 以下的缩略图',
bigpic MediumBlob comment '几M 的原图，如直接拍照',
picpath varchar(64) comment '存储超大文件，利用文件路径',
extendPicid int(32) unsigned not null default 0 comment '如果有多个图片，通过这种方式扩展',
`using` tinyint(1) not null default 0  COMMENT '该条记录是否有用，比如删除并不是删除，而是修改该字段',
  PRIMARY KEY (Id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 comment '评论图片等，需要安装日期分区';

-- - 用户图片表
DROP TABLE IF EXISTS `picture_user`;

create table if not exists `picture_user`(
id int(60) unsigned not null auto_increment,
occurtime datetime not null default '0000-00-00 00:00:00' COMMENT '该条记录插入时间',
limitpic blob comment '16k 以下的缩略图',
bigpic MediumBlob comment '几M 的原图，如直接拍照',

extendPicid int(32) unsigned not null default 0 comment '如果有多个图片，通过这种方式扩展',
`using` tinyint(1) not null default 0  COMMENT '该条记录是否有用，比如删除并不是删除，而是修改该字段',
  PRIMARY KEY (Id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 comment '存放用户图片';

-- -活动内容介绍扩展表
DROP TABLE IF EXISTS `textword`;

create table if not exists 	`textword`(
id int(32) unsigned not null auto_increment,
occurtime datetime not null default '0000-00-00 00:00:00' COMMENT '该条记录插入时间',
context varchar(510) ,
extendid int(32) unsigned not null default 0 comment '如果还是存储不满，按照这种方式扩展',
`using` tinyint(1) not null default 0  COMMENT '该条记录是否有用，比如删除并不是删除，而是修改该字段',
  PRIMARY KEY (Id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 comment '存放用户发表大段文字';



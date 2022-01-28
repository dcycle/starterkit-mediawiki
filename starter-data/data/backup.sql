-- MariaDB dump 10.19  Distrib 10.6.5-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: localhost    Database: my_wiki
-- ------------------------------------------------------
-- Server version	10.6.5-MariaDB-1:10.6.5+maria~focal

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actor`
--

DROP TABLE IF EXISTS `actor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actor` (
  `actor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `actor_user` int(10) unsigned DEFAULT NULL,
  `actor_name` varbinary(255) NOT NULL,
  PRIMARY KEY (`actor_id`),
  UNIQUE KEY `actor_name` (`actor_name`),
  UNIQUE KEY `actor_user` (`actor_user`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actor`
--

LOCK TABLES `actor` WRITE;
/*!40000 ALTER TABLE `actor` DISABLE KEYS */;
INSERT INTO `actor` VALUES (1,1,'Admin'),(2,2,'MediaWiki default');
/*!40000 ALTER TABLE `actor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `archive`
--

DROP TABLE IF EXISTS `archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archive` (
  `ar_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ar_namespace` int(11) NOT NULL DEFAULT 0,
  `ar_title` varbinary(255) NOT NULL DEFAULT '',
  `ar_comment_id` bigint(20) unsigned NOT NULL,
  `ar_actor` bigint(20) unsigned NOT NULL,
  `ar_timestamp` binary(14) NOT NULL,
  `ar_minor_edit` tinyint(4) NOT NULL DEFAULT 0,
  `ar_rev_id` int(10) unsigned NOT NULL,
  `ar_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ar_len` int(10) unsigned DEFAULT NULL,
  `ar_page_id` int(10) unsigned DEFAULT NULL,
  `ar_parent_id` int(10) unsigned DEFAULT NULL,
  `ar_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`ar_id`),
  UNIQUE KEY `ar_revid_uniq` (`ar_rev_id`),
  KEY `ar_name_title_timestamp` (`ar_namespace`,`ar_title`,`ar_timestamp`),
  KEY `ar_actor_timestamp` (`ar_actor`,`ar_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archive`
--

LOCK TABLES `archive` WRITE;
/*!40000 ALTER TABLE `archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bot_passwords`
--

DROP TABLE IF EXISTS `bot_passwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bot_passwords` (
  `bp_user` int(10) unsigned NOT NULL,
  `bp_app_id` varbinary(32) NOT NULL,
  `bp_password` tinyblob NOT NULL,
  `bp_token` binary(32) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `bp_restrictions` blob NOT NULL,
  `bp_grants` blob NOT NULL,
  PRIMARY KEY (`bp_user`,`bp_app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bot_passwords`
--

LOCK TABLES `bot_passwords` WRITE;
/*!40000 ALTER TABLE `bot_passwords` DISABLE KEYS */;
/*!40000 ALTER TABLE `bot_passwords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `cat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat_title` varbinary(255) NOT NULL,
  `cat_pages` int(11) NOT NULL DEFAULT 0,
  `cat_subcats` int(11) NOT NULL DEFAULT 0,
  `cat_files` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `cat_title` (`cat_title`),
  KEY `cat_pages` (`cat_pages`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorylinks`
--

DROP TABLE IF EXISTS `categorylinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorylinks` (
  `cl_from` int(10) unsigned NOT NULL DEFAULT 0,
  `cl_to` varbinary(255) NOT NULL DEFAULT '',
  `cl_sortkey` varbinary(230) NOT NULL DEFAULT '',
  `cl_sortkey_prefix` varbinary(255) NOT NULL DEFAULT '',
  `cl_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `cl_collation` varbinary(32) NOT NULL DEFAULT '',
  `cl_type` enum('page','subcat','file') NOT NULL DEFAULT 'page',
  PRIMARY KEY (`cl_from`,`cl_to`),
  KEY `cl_sortkey` (`cl_to`,`cl_type`,`cl_sortkey`,`cl_from`),
  KEY `cl_timestamp` (`cl_to`,`cl_timestamp`),
  KEY `cl_collation_ext` (`cl_collation`,`cl_to`,`cl_type`,`cl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorylinks`
--

LOCK TABLES `categorylinks` WRITE;
/*!40000 ALTER TABLE `categorylinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorylinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `change_tag`
--

DROP TABLE IF EXISTS `change_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change_tag` (
  `ct_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ct_rc_id` int(10) unsigned DEFAULT NULL,
  `ct_log_id` int(10) unsigned DEFAULT NULL,
  `ct_rev_id` int(10) unsigned DEFAULT NULL,
  `ct_params` blob DEFAULT NULL,
  `ct_tag_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ct_id`),
  UNIQUE KEY `ct_rc_tag_id` (`ct_rc_id`,`ct_tag_id`),
  UNIQUE KEY `ct_log_tag_id` (`ct_log_id`,`ct_tag_id`),
  UNIQUE KEY `ct_rev_tag_id` (`ct_rev_id`,`ct_tag_id`),
  KEY `ct_tag_id_id` (`ct_tag_id`,`ct_rc_id`,`ct_rev_id`,`ct_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `change_tag`
--

LOCK TABLES `change_tag` WRITE;
/*!40000 ALTER TABLE `change_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `change_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `change_tag_def`
--

DROP TABLE IF EXISTS `change_tag_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change_tag_def` (
  `ctd_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ctd_name` varbinary(255) NOT NULL,
  `ctd_user_defined` tinyint(1) NOT NULL,
  `ctd_count` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`ctd_id`),
  UNIQUE KEY `ctd_name` (`ctd_name`),
  KEY `ctd_count` (`ctd_count`),
  KEY `ctd_user_defined` (`ctd_user_defined`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `change_tag_def`
--

LOCK TABLES `change_tag_def` WRITE;
/*!40000 ALTER TABLE `change_tag_def` DISABLE KEYS */;
/*!40000 ALTER TABLE `change_tag_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `comment_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_hash` int(11) NOT NULL,
  `comment_text` blob NOT NULL,
  `comment_data` blob DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `comment_hash` (`comment_hash`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,0,'',NULL);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `content_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `content_size` int(10) unsigned NOT NULL,
  `content_sha1` varbinary(32) NOT NULL,
  `content_model` smallint(5) unsigned NOT NULL,
  `content_address` varbinary(255) NOT NULL,
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (1,755,'22vz5zlxa2zctewimaum2bf1due8hkl',1,'tt:1'),(2,0,'phoiac9h4m842xq45sp7s6u21eteeq1',1,'tt:2'),(3,838,'8dcitmrdejz4698mewyzq8s7yufaj34',1,'tt:3'),(4,837,'ky7hlou7ly41isu2bbgy8b8dtjktl88',1,'tt:4');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_models`
--

DROP TABLE IF EXISTS `content_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_models` (
  `model_id` int(11) NOT NULL AUTO_INCREMENT,
  `model_name` varbinary(64) NOT NULL,
  PRIMARY KEY (`model_id`),
  UNIQUE KEY `model_name` (`model_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_models`
--

LOCK TABLES `content_models` WRITE;
/*!40000 ALTER TABLE `content_models` DISABLE KEYS */;
INSERT INTO `content_models` VALUES (1,'wikitext');
/*!40000 ALTER TABLE `content_models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `externallinks`
--

DROP TABLE IF EXISTS `externallinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `externallinks` (
  `el_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `el_from` int(10) unsigned NOT NULL DEFAULT 0,
  `el_to` blob NOT NULL,
  `el_index` blob NOT NULL,
  `el_index_60` varbinary(60) NOT NULL,
  PRIMARY KEY (`el_id`),
  KEY `el_from` (`el_from`,`el_to`(40)),
  KEY `el_to` (`el_to`(60),`el_from`),
  KEY `el_index` (`el_index`(60)),
  KEY `el_index_60` (`el_index_60`,`el_id`),
  KEY `el_from_index_60` (`el_from`,`el_index_60`,`el_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `externallinks`
--

LOCK TABLES `externallinks` WRITE;
/*!40000 ALTER TABLE `externallinks` DISABLE KEYS */;
INSERT INTO `externallinks` VALUES (1,1,'https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Contents','https://org.mediawiki.www./wiki/Special:MyLanguage/Help:Contents','https://org.mediawiki.www./wiki/Special:MyLanguage/Help:Cont'),(2,1,'https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Configuration_settings','https://org.mediawiki.www./wiki/Special:MyLanguage/Manual:Configuration_settings','https://org.mediawiki.www./wiki/Special:MyLanguage/Manual:Co'),(3,1,'https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:FAQ','https://org.mediawiki.www./wiki/Special:MyLanguage/Manual:FAQ','https://org.mediawiki.www./wiki/Special:MyLanguage/Manual:FA'),(4,1,'https://lists.wikimedia.org/postorius/lists/mediawiki-announce.lists.wikimedia.org/','https://org.wikimedia.lists./postorius/lists/mediawiki-announce.lists.wikimedia.org/','https://org.wikimedia.lists./postorius/lists/mediawiki-annou'),(5,1,'https://www.mediawiki.org/wiki/Special:MyLanguage/Localisation#Translation_resources','https://org.mediawiki.www./wiki/Special:MyLanguage/Localisation#Translation_resources','https://org.mediawiki.www./wiki/Special:MyLanguage/Localisat'),(6,1,'https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Combating_spam','https://org.mediawiki.www./wiki/Special:MyLanguage/Manual:Combating_spam','https://org.mediawiki.www./wiki/Special:MyLanguage/Manual:Co'),(7,1,'http://github.com/dcycle/starterkit-mediawiki','http://com.github./dcycle/starterkit-mediawiki','http://com.github./dcycle/starterkit-mediawiki');
/*!40000 ALTER TABLE `externallinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filearchive`
--

DROP TABLE IF EXISTS `filearchive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filearchive` (
  `fa_id` int(11) NOT NULL AUTO_INCREMENT,
  `fa_name` varbinary(255) NOT NULL DEFAULT '',
  `fa_archive_name` varbinary(255) DEFAULT '',
  `fa_storage_group` varbinary(16) DEFAULT NULL,
  `fa_storage_key` varbinary(64) DEFAULT '',
  `fa_deleted_user` int(11) DEFAULT NULL,
  `fa_deleted_timestamp` binary(14) DEFAULT NULL,
  `fa_deleted_reason_id` bigint(20) unsigned NOT NULL,
  `fa_size` int(10) unsigned DEFAULT 0,
  `fa_width` int(11) DEFAULT 0,
  `fa_height` int(11) DEFAULT 0,
  `fa_metadata` mediumblob DEFAULT NULL,
  `fa_bits` int(11) DEFAULT 0,
  `fa_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE','3D') DEFAULT NULL,
  `fa_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart','chemical') DEFAULT 'unknown',
  `fa_minor_mime` varbinary(100) DEFAULT 'unknown',
  `fa_description_id` bigint(20) unsigned NOT NULL,
  `fa_actor` bigint(20) unsigned NOT NULL,
  `fa_timestamp` binary(14) DEFAULT NULL,
  `fa_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `fa_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`fa_id`),
  KEY `fa_name` (`fa_name`,`fa_timestamp`),
  KEY `fa_storage_group` (`fa_storage_group`,`fa_storage_key`),
  KEY `fa_deleted_timestamp` (`fa_deleted_timestamp`),
  KEY `fa_actor_timestamp` (`fa_actor`,`fa_timestamp`),
  KEY `fa_sha1` (`fa_sha1`(10))
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filearchive`
--

LOCK TABLES `filearchive` WRITE;
/*!40000 ALTER TABLE `filearchive` DISABLE KEYS */;
/*!40000 ALTER TABLE `filearchive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image` (
  `img_name` varbinary(255) NOT NULL DEFAULT '',
  `img_size` int(10) unsigned NOT NULL DEFAULT 0,
  `img_width` int(11) NOT NULL DEFAULT 0,
  `img_height` int(11) NOT NULL DEFAULT 0,
  `img_metadata` mediumblob NOT NULL,
  `img_bits` int(11) NOT NULL DEFAULT 0,
  `img_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE','3D') DEFAULT NULL,
  `img_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart','chemical') NOT NULL DEFAULT 'unknown',
  `img_minor_mime` varbinary(100) NOT NULL DEFAULT 'unknown',
  `img_description_id` bigint(20) unsigned NOT NULL,
  `img_actor` bigint(20) unsigned NOT NULL,
  `img_timestamp` binary(14) NOT NULL,
  `img_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`img_name`),
  KEY `img_actor_timestamp` (`img_actor`,`img_timestamp`),
  KEY `img_size` (`img_size`),
  KEY `img_timestamp` (`img_timestamp`),
  KEY `img_sha1` (`img_sha1`(10)),
  KEY `img_media_mime` (`img_media_type`,`img_major_mime`,`img_minor_mime`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES ('Badge_burn_badge.png',16887,128,128,'a:6:{s:10:\"frameCount\";i:0;s:9:\"loopCount\";i:1;s:8:\"duration\";d:0;s:8:\"bitDepth\";i:8;s:9:\"colorType\";s:16:\"truecolour-alpha\";s:8:\"metadata\";a:1:{s:15:\"_MW_PNG_VERSION\";i:1;}}',8,'BITMAP','image','png',1,1,'20220128200217','qwin8lf9dbwloywfu2nh7b3lce01yg5');
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagelinks`
--

DROP TABLE IF EXISTS `imagelinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagelinks` (
  `il_from` int(10) unsigned NOT NULL DEFAULT 0,
  `il_to` varbinary(255) NOT NULL DEFAULT '',
  `il_from_namespace` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`il_from`,`il_to`),
  KEY `il_to` (`il_to`,`il_from`),
  KEY `il_backlinks_namespace` (`il_from_namespace`,`il_to`,`il_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagelinks`
--

LOCK TABLES `imagelinks` WRITE;
/*!40000 ALTER TABLE `imagelinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `imagelinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interwiki`
--

DROP TABLE IF EXISTS `interwiki`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interwiki` (
  `iw_prefix` varbinary(32) NOT NULL,
  `iw_url` blob NOT NULL,
  `iw_api` blob NOT NULL,
  `iw_wikiid` varbinary(64) NOT NULL,
  `iw_local` tinyint(1) NOT NULL,
  `iw_trans` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`iw_prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interwiki`
--

LOCK TABLES `interwiki` WRITE;
/*!40000 ALTER TABLE `interwiki` DISABLE KEYS */;
INSERT INTO `interwiki` VALUES ('acronym','https://www.acronymfinder.com/~/search/af.aspx?string=exact&Acronym=$1','','',0,0),('advogato','http://www.advogato.org/$1','','',0,0),('arxiv','https://www.arxiv.org/abs/$1','','',0,0),('c2find','http://c2.com/cgi/wiki?FindPage&value=$1','','',0,0),('cache','https://www.google.com/search?q=cache:$1','','',0,0),('commons','https://commons.wikimedia.org/wiki/$1','https://commons.wikimedia.org/w/api.php','',0,0),('dictionary','http://www.dict.org/bin/Dict?Database=*&Form=Dict1&Strategy=*&Query=$1','','',0,0),('doi','https://dx.doi.org/$1','','',0,0),('drumcorpswiki','http://www.drumcorpswiki.com/$1','http://drumcorpswiki.com/api.php','',0,0),('dwjwiki','http://www.suberic.net/cgi-bin/dwj/wiki.cgi?$1','','',0,0),('elibre','http://enciclopedia.us.es/index.php/$1','http://enciclopedia.us.es/api.php','',0,0),('emacswiki','https://www.emacswiki.org/emacs/$1','','',0,0),('foldoc','https://foldoc.org/?$1','','',0,0),('foxwiki','https://fox.wikis.com/wc.dll?Wiki~$1','','',0,0),('freebsdman','https://www.FreeBSD.org/cgi/man.cgi?apropos=1&query=$1','','',0,0),('gentoo-wiki','http://gentoo-wiki.com/$1','','',0,0),('google','https://www.google.com/search?q=$1','','',0,0),('googlegroups','https://groups.google.com/groups?q=$1','','',0,0),('hammondwiki','http://www.dairiki.org/HammondWiki/$1','','',0,0),('hrwiki','http://www.hrwiki.org/wiki/$1','http://www.hrwiki.org/w/api.php','',0,0),('imdb','http://www.imdb.com/find?q=$1&tt=on','','',0,0),('kmwiki','https://kmwiki.wikispaces.com/$1','','',0,0),('linuxwiki','http://linuxwiki.de/$1','','',0,0),('lojban','https://mw.lojban.org/papri/$1','','',0,0),('lqwiki','http://wiki.linuxquestions.org/wiki/$1','','',0,0),('meatball','http://meatballwiki.org/wiki/$1','','',0,0),('mediawikiwiki','https://www.mediawiki.org/wiki/$1','https://www.mediawiki.org/w/api.php','',0,0),('memoryalpha','http://en.memory-alpha.org/wiki/$1','http://en.memory-alpha.org/api.php','',0,0),('metawiki','http://sunir.org/apps/meta.pl?$1','','',0,0),('metawikimedia','https://meta.wikimedia.org/wiki/$1','https://meta.wikimedia.org/w/api.php','',0,0),('mozillawiki','https://wiki.mozilla.org/$1','https://wiki.mozilla.org/api.php','',0,0),('mw','https://www.mediawiki.org/wiki/$1','https://www.mediawiki.org/w/api.php','',0,0),('oeis','https://oeis.org/$1','','',0,0),('openwiki','http://openwiki.com/ow.asp?$1','','',0,0),('pmid','https://www.ncbi.nlm.nih.gov/pubmed/$1?dopt=Abstract','','',0,0),('pythoninfo','https://wiki.python.org/moin/$1','','',0,0),('rfc','https://tools.ietf.org/html/rfc$1','','',0,0),('s23wiki','http://s23.org/wiki/$1','http://s23.org/w/api.php','',0,0),('seattlewireless','http://seattlewireless.net/$1','','',0,0),('senseislibrary','https://senseis.xmp.net/?$1','','',0,0),('shoutwiki','http://www.shoutwiki.com/wiki/$1','http://www.shoutwiki.com/w/api.php','',0,0),('squeak','http://wiki.squeak.org/squeak/$1','','',0,0),('theopedia','https://www.theopedia.com/$1','','',0,0),('tmbw','http://www.tmbw.net/wiki/$1','http://tmbw.net/wiki/api.php','',0,0),('tmnet','http://www.technomanifestos.net/?$1','','',0,0),('twiki','http://twiki.org/cgi-bin/view/$1','','',0,0),('uncyclopedia','https://en.uncyclopedia.co/wiki/$1','https://en.uncyclopedia.co/w/api.php','',0,0),('unreal','https://wiki.beyondunreal.com/$1','https://wiki.beyondunreal.com/w/api.php','',0,0),('usemod','http://www.usemod.com/cgi-bin/wiki.pl?$1','','',0,0),('wiki','http://c2.com/cgi/wiki?$1','','',0,0),('wikia','http://www.wikia.com/wiki/$1','','',0,0),('wikibooks','https://en.wikibooks.org/wiki/$1','https://en.wikibooks.org/w/api.php','',0,0),('wikidata','https://www.wikidata.org/wiki/$1','https://www.wikidata.org/w/api.php','',0,0),('wikif1','http://www.wikif1.org/$1','','',0,0),('wikihow','https://www.wikihow.com/$1','https://www.wikihow.com/api.php','',0,0),('wikimedia','https://foundation.wikimedia.org/wiki/$1','https://foundation.wikimedia.org/w/api.php','',0,0),('wikinews','https://en.wikinews.org/wiki/$1','https://en.wikinews.org/w/api.php','',0,0),('wikinfo','http://wikinfo.co/English/index.php/$1','','',0,0),('wikipedia','https://en.wikipedia.org/wiki/$1','https://en.wikipedia.org/w/api.php','',0,0),('wikiquote','https://en.wikiquote.org/wiki/$1','https://en.wikiquote.org/w/api.php','',0,0),('wikisource','https://wikisource.org/wiki/$1','https://wikisource.org/w/api.php','',0,0),('wikispecies','https://species.wikimedia.org/wiki/$1','https://species.wikimedia.org/w/api.php','',0,0),('wikiversity','https://en.wikiversity.org/wiki/$1','https://en.wikiversity.org/w/api.php','',0,0),('wikivoyage','https://en.wikivoyage.org/wiki/$1','https://en.wikivoyage.org/w/api.php','',0,0),('wikt','https://en.wiktionary.org/wiki/$1','https://en.wiktionary.org/w/api.php','',0,0),('wiktionary','https://en.wiktionary.org/wiki/$1','https://en.wiktionary.org/w/api.php','',0,0);
/*!40000 ALTER TABLE `interwiki` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ip_changes`
--

DROP TABLE IF EXISTS `ip_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_changes` (
  `ipc_rev_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ipc_rev_timestamp` binary(14) NOT NULL,
  `ipc_hex` varbinary(35) NOT NULL DEFAULT '',
  PRIMARY KEY (`ipc_rev_id`),
  KEY `ipc_rev_timestamp` (`ipc_rev_timestamp`),
  KEY `ipc_hex_time` (`ipc_hex`,`ipc_rev_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip_changes`
--

LOCK TABLES `ip_changes` WRITE;
/*!40000 ALTER TABLE `ip_changes` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip_changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipblocks`
--

DROP TABLE IF EXISTS `ipblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipblocks` (
  `ipb_id` int(11) NOT NULL AUTO_INCREMENT,
  `ipb_address` tinyblob NOT NULL,
  `ipb_user` int(10) unsigned NOT NULL DEFAULT 0,
  `ipb_by_actor` bigint(20) unsigned NOT NULL,
  `ipb_reason_id` bigint(20) unsigned NOT NULL,
  `ipb_timestamp` binary(14) NOT NULL,
  `ipb_auto` tinyint(1) NOT NULL DEFAULT 0,
  `ipb_anon_only` tinyint(1) NOT NULL DEFAULT 0,
  `ipb_create_account` tinyint(1) NOT NULL DEFAULT 1,
  `ipb_enable_autoblock` tinyint(1) NOT NULL DEFAULT 1,
  `ipb_expiry` varbinary(14) NOT NULL,
  `ipb_range_start` tinyblob NOT NULL,
  `ipb_range_end` tinyblob NOT NULL,
  `ipb_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `ipb_block_email` tinyint(1) NOT NULL DEFAULT 0,
  `ipb_allow_usertalk` tinyint(1) NOT NULL DEFAULT 0,
  `ipb_parent_block_id` int(11) DEFAULT NULL,
  `ipb_sitewide` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ipb_id`),
  UNIQUE KEY `ipb_address_unique` (`ipb_address`(255),`ipb_user`,`ipb_auto`),
  KEY `ipb_user` (`ipb_user`),
  KEY `ipb_range` (`ipb_range_start`(8),`ipb_range_end`(8)),
  KEY `ipb_timestamp` (`ipb_timestamp`),
  KEY `ipb_expiry` (`ipb_expiry`),
  KEY `ipb_parent_block_id` (`ipb_parent_block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipblocks`
--

LOCK TABLES `ipblocks` WRITE;
/*!40000 ALTER TABLE `ipblocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipblocks_restrictions`
--

DROP TABLE IF EXISTS `ipblocks_restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipblocks_restrictions` (
  `ir_ipb_id` int(11) NOT NULL,
  `ir_type` tinyint(4) NOT NULL,
  `ir_value` int(11) NOT NULL,
  PRIMARY KEY (`ir_ipb_id`,`ir_type`,`ir_value`),
  KEY `ir_type_value` (`ir_type`,`ir_value`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipblocks_restrictions`
--

LOCK TABLES `ipblocks_restrictions` WRITE;
/*!40000 ALTER TABLE `ipblocks_restrictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipblocks_restrictions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iwlinks`
--

DROP TABLE IF EXISTS `iwlinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iwlinks` (
  `iwl_from` int(10) unsigned NOT NULL DEFAULT 0,
  `iwl_prefix` varbinary(32) NOT NULL DEFAULT '',
  `iwl_title` varbinary(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`iwl_from`,`iwl_prefix`,`iwl_title`),
  KEY `iwl_prefix_title_from` (`iwl_prefix`,`iwl_title`,`iwl_from`),
  KEY `iwl_prefix_from_title` (`iwl_prefix`,`iwl_from`,`iwl_title`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iwlinks`
--

LOCK TABLES `iwlinks` WRITE;
/*!40000 ALTER TABLE `iwlinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `iwlinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job` (
  `job_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `job_cmd` varbinary(60) NOT NULL DEFAULT '',
  `job_namespace` int(11) NOT NULL,
  `job_title` varbinary(255) NOT NULL,
  `job_timestamp` binary(14) DEFAULT NULL,
  `job_params` mediumblob NOT NULL,
  `job_random` int(10) unsigned NOT NULL DEFAULT 0,
  `job_attempts` int(10) unsigned NOT NULL DEFAULT 0,
  `job_token` varbinary(32) NOT NULL DEFAULT '',
  `job_token_timestamp` binary(14) DEFAULT NULL,
  `job_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`job_id`),
  KEY `job_sha1` (`job_sha1`),
  KEY `job_cmd_token` (`job_cmd`,`job_token`,`job_random`),
  KEY `job_cmd_token_id` (`job_cmd`,`job_token`,`job_id`),
  KEY `job_cmd` (`job_cmd`,`job_namespace`,`job_title`,`job_params`(128)),
  KEY `job_timestamp` (`job_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
INSERT INTO `job` VALUES (8,'recentChangesUpdate',-1,'RecentChanges','20220128200252','a:4:{s:4:\"type\";s:11:\"cacheUpdate\";s:9:\"namespace\";i:-1;s:5:\"title\";s:13:\"RecentChanges\";s:9:\"requestId\";s:24:\"a4e9b06fc95213df56b52e38\";}',1407027344,0,'',NULL,'p42glrsl783wj55io7lxhmhxf0e5db5');
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `l10n_cache`
--

DROP TABLE IF EXISTS `l10n_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `l10n_cache` (
  `lc_lang` varbinary(35) NOT NULL,
  `lc_key` varbinary(255) NOT NULL,
  `lc_value` mediumblob NOT NULL,
  PRIMARY KEY (`lc_lang`,`lc_key`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `l10n_cache`
--

LOCK TABLES `l10n_cache` WRITE;
/*!40000 ALTER TABLE `l10n_cache` DISABLE KEYS */;
INSERT INTO `l10n_cache` VALUES ('en-ca','messages:version-software-version','s:7:\"Version\";'),('en-ca','messages:version-specialpages','s:13:\"Special pages\";'),('en-ca','messages:version-summary','s:0:\"\";'),('en-ca','messages:version-variables','s:9:\"Variables\";'),('en-ca','messages:version-version','s:4:\"($1)\";'),('en-ca','messages:versionrequired','s:32:\"Version $1 of MediaWiki required\";'),('en-ca','messages:versionrequiredtext','s:91:\"Version $1 of MediaWiki is required to use this page.\nSee [[Special:Version|version page]].\";'),('en-ca','messages:video-dims','s:12:\"$1, $2 × $3\";'),('en-ca','messages:view','s:4:\"View\";'),('en-ca','messages:view-foreign','s:10:\"View on $1\";'),('en-ca','messages:view-pool-contention','s:15:\"pool contention\";'),('en-ca','messages:view-pool-dirty-output','s:23:\"parser cache is expired\";'),('en-ca','messages:view-pool-error','s:159:\"Sorry, the servers are overloaded at the moment.\nToo many users are trying to view this page.\nPlease wait a while before you try to access this page again.\n\n$1\";'),('en-ca','messages:view-pool-timeout','s:13:\"pool overload\";'),('en-ca','messages:viewcount','s:56:\"This page has been accessed {{PLURAL:$1|once|$1 times}}.\";'),('en-ca','messages:viewdeleted','s:8:\"View $1?\";'),('en-ca','messages:viewdeleted_short','s:52:\"View {{PLURAL:$1|one deleted edit|$1 deleted edits}}\";'),('en-ca','messages:viewdeletedpage','s:18:\"View deleted pages\";'),('en-ca','messages:viewhelppage','s:14:\"View help page\";'),('en-ca','messages:viewinguserrights','s:76:\"Viewing user rights of {{GENDER:$1|user}} <strong>[[User:$1|$1]]</strong> $2\";'),('en-ca','messages:viewpagelogs','s:23:\"View logs for this page\";'),('en-ca','messages:viewpagelogs-lowercase','s:23:\"view logs for this page\";'),('en-ca','messages:viewprevnext','s:40:\"View ($1 {{int:pipe-separator}} $2) ($3)\";'),('en-ca','messages:views','s:5:\"Views\";'),('en-ca','messages:viewsource','s:11:\"View source\";'),('en-ca','messages:viewsource-title','s:18:\"View source for $1\";'),('en-ca','messages:viewsourcelink','s:11:\"view source\";'),('en-ca','messages:viewsourceold','s:11:\"view source\";'),('en-ca','messages:viewsourcetext','s:46:\"You can view and copy the source of this page.\";'),('en-ca','messages:viewtalkpage','s:15:\"View discussion\";'),('en-ca','messages:viewyourtext','s:77:\"You can view and copy the source of <strong>your edits</strong> to this page.\";'),('en-ca','messages:virus-badscanner','s:53:\"Bad configuration: Unknown virus scanner: <em>$1</em>\";'),('en-ca','messages:virus-scanfailed','s:21:\"scan failed (code $1)\";'),('en-ca','messages:virus-unknownscanner','s:18:\"unknown antivirus:\";'),('en-ca','messages:wantedcategories','s:17:\"Wanted categories\";'),('en-ca','messages:wantedcategories-summary','s:0:\"\";'),('en-ca','messages:wantedfiles','s:12:\"Wanted files\";'),('en-ca','messages:wantedfiles-summary','s:0:\"\";'),('en-ca','messages:wantedfiletext-cat','s:244:\"The following files are used but do not exist. Files from foreign repositories may be listed despite existing. Any such false positives will be <del>struck out</del>. Additionally, pages that embed files that do not exist are listed in [[:$1]].\";'),('en-ca','messages:wantedfiletext-cat-noforeign','s:124:\"The following files are used but do not exist. Additionally, pages that embed files that do not exist are listed in [[:$1]].\";'),('en-ca','messages:wantedfiletext-nocat','s:166:\"The following files are used but do not exist. Files from foreign repositories may be listed despite existing. Any such false positives will be <del>struck out</del>.\";'),('en-ca','messages:wantedfiletext-nocat-noforeign','s:46:\"The following files are used but do not exist.\";'),('en-ca','messages:wantedpages','s:12:\"Wanted pages\";'),('en-ca','messages:wantedpages-badtitle','s:31:\"Invalid title in result set: $1\";'),('en-ca','messages:wantedpages-summary','s:251:\"List of non-existing pages with the most links to them, excluding pages which only have redirects linking to them. For a list of non-existent pages that have redirects linking to them, see [[{{#special:BrokenRedirects}}|the list of broken redirects]].\";'),('en-ca','messages:wantedtemplates','s:16:\"Wanted templates\";'),('en-ca','messages:wantedtemplates-summary','s:0:\"\";'),('en-ca','messages:watch','s:5:\"Watch\";'),('en-ca','messages:watching','s:11:\"Watching...\";'),('en-ca','messages:watchlist','s:9:\"Watchlist\";'),('en-ca','messages:watchlist-details','s:74:\"{{PLURAL:$1|$1 page is|$1 pages are}} on your Watchlist (plus talk pages).\";'),('en-ca','messages:watchlist-expires-in-aria-label','s:23:\"Expiring watchlist item\";'),('en-ca','messages:watchlist-expiring-days-full-text','s:50:\"{{PLURAL:$1|1 day|$1 days}} left in your watchlist\";'),('en-ca','messages:watchlist-expiring-hours-full-text','s:34:\"A few hours left in your watchlist\";'),('en-ca','messages:watchlist-expiry-days-left','s:33:\"{{PLURAL:$1|$1 day|$1 days}} left\";'),('en-ca','messages:watchlist-expiry-hours-left','s:16:\"A few hours left\";'),('en-ca','messages:watchlist-expiry-options','s:84:\"Permanent:infinite,1 week:1 week,1 month:1 month,3 months:3 months,6 months:6 months\";'),('en-ca','messages:watchlist-hide','s:4:\"Hide\";'),('en-ca','messages:watchlist-options','s:17:\"Watchlist options\";'),('en-ca','messages:watchlist-submit','s:4:\"Show\";'),('en-ca','messages:watchlist-summary','s:0:\"\";'),('en-ca','messages:watchlist-unwatch','s:2:\"×\";'),('en-ca','messages:watchlist-unwatch-undo','s:1:\"+\";'),('en-ca','messages:watchlistanontext','s:54:\"Please log in to view or edit items on your watchlist.\";'),('en-ca','messages:watchlistedit-clear-done','s:32:\"Your watchlist has been cleared.\";'),('en-ca','messages:watchlistedit-clear-explain','s:53:\"All of the titles will be removed from your watchlist\";'),('en-ca','messages:watchlistedit-clear-jobqueue','s:57:\"Your watchlist is being cleared. This may take some time!\";'),('en-ca','messages:watchlistedit-clear-legend','s:15:\"Clear watchlist\";'),('en-ca','messages:watchlistedit-clear-removed','s:49:\"{{PLURAL:$1|1 title was|$1 titles were}} removed:\";'),('en-ca','messages:watchlistedit-clear-submit','s:40:\"Clear the watchlist (This is permanent!)\";'),('en-ca','messages:watchlistedit-clear-title','s:15:\"Clear watchlist\";'),('en-ca','messages:watchlistedit-clear-titles','s:7:\"Titles:\";'),('en-ca','messages:watchlistedit-normal-done','s:76:\"{{PLURAL:$1|A single title was|$1 titles were}} removed from your watchlist:\";'),('en-ca','messages:watchlistedit-normal-explain','s:197:\"Titles on your watchlist are shown below.\nTo remove a title, check the box next to it, and click \"{{int:Watchlistedit-normal-submit}}\".\nYou can also [[Special:EditWatchlist/raw|edit the raw list]].\";'),('en-ca','messages:watchlistedit-normal-legend','s:28:\"Remove titles from watchlist\";'),('en-ca','messages:watchlistedit-normal-submit','s:13:\"Remove titles\";'),('en-ca','messages:watchlistedit-normal-title','s:14:\"Edit watchlist\";'),('en-ca','messages:watchlistedit-raw-added','s:47:\"{{PLURAL:$1|1 title was|$1 titles were}} added:\";'),('en-ca','messages:watchlistedit-raw-done','s:32:\"Your watchlist has been updated.\";'),('en-ca','messages:watchlistedit-raw-explain','s:241:\"Titles on your watchlist are shown below, and can be edited by adding to and removing from the list;\none title per line.\nWhen finished, click \"{{int:Watchlistedit-raw-submit}}\".\nYou can also [[Special:EditWatchlist|use the standard editor]].\";'),('en-ca','messages:watchlistedit-raw-legend','s:18:\"Edit raw watchlist\";'),('en-ca','messages:watchlistedit-raw-removed','s:49:\"{{PLURAL:$1|1 title was|$1 titles were}} removed:\";'),('en-ca','messages:watchlistedit-raw-submit','s:16:\"Update watchlist\";'),('en-ca','messages:watchlistedit-raw-title','s:18:\"Edit raw watchlist\";'),('en-ca','messages:watchlistedit-raw-titles','s:7:\"Titles:\";'),('en-ca','messages:watchlistedit-too-many','s:41:\"There are too many pages to display here.\";'),('en-ca','messages:watchlistfor2','s:9:\"For $1 $2\";'),('en-ca','messages:watchlistnotwatchable','s:22:\"Page is not watchable.\";'),('en-ca','messages:watchlisttools-clear','s:19:\"Clear the watchlist\";'),('en-ca','messages:watchlisttools-edit','s:23:\"View and edit watchlist\";'),('en-ca','messages:watchlisttools-raw','s:18:\"Edit raw watchlist\";'),('en-ca','messages:watchlisttools-view','s:21:\"View relevant changes\";'),('en-ca','messages:watchnologin','s:13:\"Not logged in\";'),('en-ca','messages:watchthis','s:15:\"Watch this page\";'),('en-ca','messages:watchthispage','s:15:\"Watch this page\";'),('en-ca','messages:watchthisupload','s:15:\"Watch this file\";'),('en-ca','messages:wed','s:3:\"Wed\";'),('en-ca','messages:wednesday','s:9:\"Wednesday\";'),('en-ca','messages:wednesday-at','s:15:\"Wednesday at $1\";'),('en-ca','messages:weeks','s:30:\"{{PLURAL:$1|$1 week|$1 weeks}}\";'),('en-ca','messages:welcomecreation-msg','s:112:\"Your account has been created.\nYou can change your {{SITENAME}} [[Special:Preferences|preferences]] if you wish.\";'),('en-ca','messages:welcomeuser','s:12:\"Welcome, $1!\";'),('en-ca','messages:whatlinkshere','s:15:\"What links here\";'),('en-ca','messages:whatlinkshere-count','s:38:\"Displayed $1 {{PLURAL:$1|item|items}}.\";'),('en-ca','messages:whatlinkshere-filters','s:7:\"Filters\";'),('en-ca','messages:whatlinkshere-hideimages','s:13:\"$1 file links\";'),('en-ca','messages:whatlinkshere-hidelinks','s:8:\"$1 links\";'),('en-ca','messages:whatlinkshere-hideredirs','s:12:\"$1 redirects\";'),('en-ca','messages:whatlinkshere-hidetrans','s:16:\"$1 transclusions\";'),('en-ca','messages:whatlinkshere-links','s:9:\"← links\";'),('en-ca','messages:whatlinkshere-next','s:26:\"{{PLURAL:$1|next|next $1}}\";'),('en-ca','messages:whatlinkshere-page','s:5:\"Page:\";'),('en-ca','messages:whatlinkshere-prev','s:34:\"{{PLURAL:$1|previous|previous $1}}\";'),('en-ca','messages:whatlinkshere-sectionredir','s:24:\"redirect to section \"$1\"\";'),('en-ca','messages:whatlinkshere-submit','s:2:\"Go\";'),('en-ca','messages:whatlinkshere-summary','s:0:\"\";'),('en-ca','messages:whatlinkshere-title','s:23:\"Pages that link to \"$1\"\";'),('en-ca','messages:whitelistedittext','s:24:\"Please $1 to edit pages.\";'),('en-ca','messages:widthheight','s:8:\"$1 × $2\";'),('en-ca','messages:widthheightpage','s:37:\"$1 × $2, $3 {{PLURAL:$3|page|pages}}\";'),('en-ca','messages:windows-nonascii-filename','s:61:\"This wiki does not support filenames with special characters.\";'),('en-ca','messages:withoutinterwiki','s:28:\"Pages without language links\";'),('en-ca','messages:withoutinterwiki-legend','s:6:\"Prefix\";'),('en-ca','messages:withoutinterwiki-submit','s:4:\"Show\";'),('en-ca','messages:withoutinterwiki-summary','s:59:\"The following pages do not link to other language versions.\";'),('en-ca','messages:wlheader-enotif','s:30:\"Email notification is enabled.\";'),('en-ca','messages:wlheader-showupdated','s:92:\"Pages that have been changed since you last visited them are shown in <strong>bold</strong>.\";'),('en-ca','messages:wlnote','s:151:\"Below {{PLURAL:$1|is the last change|are the last <strong>$1</strong> changes}} in the last {{PLURAL:$2|hour|<strong>$2</strong> hours}}, as of $3, $4.\";'),('en-ca','messages:wlshowhideanons','s:15:\"anonymous users\";'),('en-ca','messages:wlshowhidebots','s:4:\"bots\";'),('en-ca','messages:wlshowhidecategorization','s:19:\"page categorization\";'),('en-ca','messages:wlshowhideliu','s:16:\"registered users\";'),('en-ca','messages:wlshowhidemine','s:8:\"my edits\";'),('en-ca','messages:wlshowhideminor','s:11:\"minor edits\";'),('en-ca','messages:wlshowhidepatr','s:15:\"patrolled edits\";'),('en-ca','messages:wlshowtime','s:26:\"Period of time to display:\";'),('en-ca','messages:word-separator','s:5:\"&#32;\";'),('en-ca','messages:wrongpassword','s:57:\"Incorrect username or password entered.\nPlease try again.\";'),('en-ca','messages:wrongpasswordempty','s:45:\"Password entered was blank.\nPlease try again.\";'),('en-ca','messages:xffblockreason','s:158:\"An IP address present in the X-Forwarded-For header, either yours or that of a proxy server you are using, has been blocked. The original block reason was: $1\";'),('en-ca','messages:xml-error-string','s:35:\"$1 at line $2, col $3 (byte $4): $5\";'),('en-ca','messages:year','s:24:\"From year (and earlier):\";'),('en-ca','messages:years','s:30:\"{{PLURAL:$1|$1 year|$1 years}}\";'),('en-ca','messages:yesterday-at','s:15:\"Yesterday at $1\";'),('en-ca','messages:youhavenewmessages','s:31:\"{{PLURAL:$3|You have}} $1 ($2).\";'),('en-ca','messages:youhavenewmessagesfromusers','s:72:\"{{PLURAL:$4|You have}} $1 from {{PLURAL:$3|another user|$3 users}} ($2).\";'),('en-ca','messages:youhavenewmessagesmanyusers','s:33:\"You have $1 from many users ($2).\";'),('en-ca','messages:youhavenewmessagesmulti','s:27:\"You have new messages on $1\";'),('en-ca','messages:yourdiff','s:11:\"Differences\";'),('en-ca','messages:yourdomainname','s:12:\"Your domain:\";'),('en-ca','messages:youremail','s:6:\"Email:\";'),('en-ca','messages:yourgender','s:34:\"How do you prefer to be described?\";'),('en-ca','messages:yourlanguage','s:9:\"Language:\";'),('en-ca','messages:yourname','s:9:\"Username:\";'),('en-ca','messages:yournick','s:14:\"New signature:\";'),('en-ca','messages:yourpassword','s:9:\"Password:\";'),('en-ca','messages:yourpasswordagain','s:16:\"Retype password:\";'),('en-ca','messages:yourrealname','s:10:\"Real name:\";'),('en-ca','messages:yourtext','s:9:\"Your text\";'),('en-ca','messages:yourvariant','s:25:\"Content language variant:\";'),('en-ca','messages:zip-bad','s:99:\"The file is a corrupt or otherwise unreadable ZIP file.\nIt cannot be properly checked for security.\";'),('en-ca','messages:zip-file-open-error','s:62:\"An error was encountered when opening the file for ZIP checks.\";'),('en-ca','messages:zip-unsupported','s:117:\"The file is a ZIP file that uses ZIP features not supported by MediaWiki.\nIt cannot be properly checked for security.\";'),('en-ca','messages:zip-wrong-format','s:38:\"The specified file was not a ZIP file.\";'),('en-ca','minimumGroupingDigits','N;'),('en-ca','namespaceAliases','a:2:{s:5:\"Image\";i:6;s:10:\"Image_talk\";i:7;}'),('en-ca','namespaceGenderAliases','a:0:{}'),('en-ca','namespaceNames','a:17:{i:-2;s:5:\"Media\";i:-1;s:7:\"Special\";i:0;s:0:\"\";i:1;s:4:\"Talk\";i:2;s:4:\"User\";i:3;s:9:\"User_talk\";i:5;s:7:\"$1_talk\";i:6;s:4:\"File\";i:7;s:9:\"File_talk\";i:8;s:9:\"MediaWiki\";i:9;s:14:\"MediaWiki_talk\";i:10;s:8:\"Template\";i:11;s:13:\"Template_talk\";i:12;s:4:\"Help\";i:13;s:9:\"Help_talk\";i:14;s:8:\"Category\";i:15;s:13:\"Category_talk\";}'),('en-ca','originalFallbackSequence','a:1:{i:0;s:2:\"en\";}'),('en-ca','pluralRuleTypes','a:1:{i:0;s:3:\"one\";}'),('en-ca','pluralRules','a:1:{i:0;s:26:\"i = 1 and v = 0 @integer 1\";}'),('en-ca','preload','a:3:{s:8:\"messages\";a:111:{s:9:\"aboutpage\";s:13:\"Project:About\";s:9:\"aboutsite\";s:18:\"About {{SITENAME}}\";s:17:\"accesskey-ca-edit\";s:1:\"e\";s:20:\"accesskey-ca-history\";s:1:\"h\";s:23:\"accesskey-ca-nstab-main\";s:1:\"c\";s:17:\"accesskey-ca-talk\";s:1:\"t\";s:23:\"accesskey-ca-viewsource\";s:1:\"e\";s:25:\"accesskey-n-currentevents\";s:0:\"\";s:16:\"accesskey-n-help\";s:0:\"\";s:32:\"accesskey-n-mainpage-description\";s:1:\"z\";s:18:\"accesskey-n-portal\";s:0:\"\";s:22:\"accesskey-n-randompage\";s:1:\"x\";s:25:\"accesskey-n-recentchanges\";s:1:\"r\";s:16:\"accesskey-p-logo\";s:0:\"\";s:18:\"accesskey-pt-login\";s:1:\"o\";s:26:\"accesskey-pt-createaccount\";s:0:\"\";s:16:\"accesskey-search\";s:1:\"f\";s:25:\"accesskey-search-fulltext\";s:0:\"\";s:19:\"accesskey-search-go\";s:0:\"\";s:16:\"accesskey-t-info\";s:0:\"\";s:21:\"accesskey-t-permalink\";s:0:\"\";s:17:\"accesskey-t-print\";s:1:\"p\";s:31:\"accesskey-t-recentchangeslinked\";s:1:\"k\";s:24:\"accesskey-t-specialpages\";s:1:\"q\";s:25:\"accesskey-t-whatlinkshere\";s:1:\"j\";s:7:\"actions\";s:7:\"Actions\";s:10:\"anonnotice\";s:1:\"-\";s:8:\"brackets\";s:4:\"[$1]\";s:15:\"comma-separator\";s:6:\",&#32;\";s:13:\"currentevents\";s:14:\"Current events\";s:17:\"currentevents-url\";s:22:\"Project:Current events\";s:14:\"disclaimerpage\";s:26:\"Project:General disclaimer\";s:11:\"disclaimers\";s:11:\"Disclaimers\";s:4:\"edit\";s:4:\"Edit\";s:11:\"editsection\";s:4:\"edit\";s:15:\"editsectionhint\";s:16:\"Edit section: $1\";s:4:\"help\";s:4:\"Help\";s:8:\"helppage\";s:63:\"https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Contents\";s:24:\"interlanguage-link-title\";s:9:\"$1 – $2\";s:6:\"jumpto\";s:8:\"Jump to:\";s:16:\"jumptonavigation\";s:10:\"navigation\";s:12:\"jumptosearch\";s:6:\"search\";s:14:\"lastmodifiedat\";s:39:\"This page was last edited on $1, at $2.\";s:8:\"mainpage\";s:9:\"Main Page\";s:20:\"mainpage-description\";s:9:\"Main page\";s:14:\"mainpage-nstab\";s:9:\"Main page\";s:10:\"namespaces\";s:10:\"Namespaces\";s:10:\"navigation\";s:10:\"Navigation\";s:23:\"nav-login-createaccount\";s:23:\"Log in / create account\";s:10:\"nstab-main\";s:4:\"Page\";s:15:\"opensearch-desc\";s:34:\"{{SITENAME}} ({{CONTENTLANGUAGE}})\";s:14:\"pagecategories\";s:33:\"{{PLURAL:$1|Category|Categories}}\";s:18:\"pagecategorieslink\";s:18:\"Special:Categories\";s:9:\"pagetitle\";s:17:\"$1 - {{SITENAME}}\";s:23:\"pagetitle-view-mainpage\";s:12:\"{{SITENAME}}\";s:9:\"permalink\";s:14:\"Permanent link\";s:13:\"personaltools\";s:14:\"Personal tools\";s:6:\"portal\";s:16:\"Community portal\";s:10:\"portal-url\";s:24:\"Project:Community portal\";s:16:\"printableversion\";s:17:\"Printable version\";s:7:\"privacy\";s:14:\"Privacy policy\";s:11:\"privacypage\";s:22:\"Project:Privacy policy\";s:10:\"randompage\";s:11:\"Random page\";s:14:\"randompage-url\";s:14:\"Special:Random\";s:13:\"recentchanges\";s:14:\"Recent changes\";s:27:\"recentchangeslinked-toolbox\";s:15:\"Related changes\";s:17:\"recentchanges-url\";s:21:\"Special:RecentChanges\";s:13:\"retrievedfrom\";s:19:\"Retrieved from \"$1\"\";s:6:\"search\";s:6:\"Search\";s:13:\"searcharticle\";s:2:\"Go\";s:12:\"searchbutton\";s:6:\"Search\";s:20:\"searchsuggest-search\";s:19:\"Search {{SITENAME}}\";s:7:\"sidebar\";s:168:\"\n* navigation\n** mainpage|mainpage-description\n** recentchanges-url|recentchanges\n** randompage-url|randompage\n** helppage|help-mediawiki\n* SEARCH\n* TOOLBOX\n* LANGUAGES\";s:18:\"navigation-heading\";s:15:\"Navigation menu\";s:14:\"site-atom-feed\";s:12:\"$1 Atom feed\";s:10:\"sitenotice\";s:1:\"-\";s:12:\"specialpages\";s:13:\"Special pages\";s:7:\"tagline\";s:17:\"From {{SITENAME}}\";s:4:\"talk\";s:10:\"Discussion\";s:7:\"toolbox\";s:5:\"Tools\";s:15:\"tooltip-ca-edit\";s:14:\"Edit this page\";s:18:\"tooltip-ca-history\";s:27:\"Past revisions of this page\";s:21:\"tooltip-ca-nstab-main\";s:21:\"View the content page\";s:15:\"tooltip-ca-talk\";s:33:\"Discussion about the content page\";s:21:\"tooltip-ca-viewsource\";s:47:\"This page is protected.\nYou can view its source\";s:23:\"tooltip-n-currentevents\";s:45:\"Find background information on current events\";s:14:\"tooltip-n-help\";s:21:\"The place to find out\";s:30:\"tooltip-n-mainpage-description\";s:19:\"Visit the main page\";s:16:\"tooltip-n-portal\";s:56:\"About the project, what you can do, where to find things\";s:20:\"tooltip-n-randompage\";s:18:\"Load a random page\";s:23:\"tooltip-n-recentchanges\";s:36:\"A list of recent changes in the wiki\";s:14:\"tooltip-p-logo\";s:19:\"Visit the main page\";s:16:\"tooltip-pt-login\";s:58:\"You are encouraged to log in; however, it is not mandatory\";s:24:\"tooltip-pt-createaccount\";s:80:\"You are encouraged to create an account and log in; however, it is not mandatory\";s:14:\"tooltip-search\";s:19:\"Search {{SITENAME}}\";s:23:\"tooltip-search-fulltext\";s:30:\"Search the pages for this text\";s:17:\"tooltip-search-go\";s:46:\"Go to a page with this exact name if it exists\";s:14:\"tooltip-t-info\";s:32:\"More information about this page\";s:19:\"tooltip-t-permalink\";s:43:\"Permanent link to this revision of the page\";s:15:\"tooltip-t-print\";s:30:\"Printable version of this page\";s:29:\"tooltip-t-recentchangeslinked\";s:45:\"Recent changes in pages linked from this page\";s:22:\"tooltip-t-specialpages\";s:27:\"A list of all special pages\";s:23:\"tooltip-t-whatlinkshere\";s:39:\"A list of all wiki pages that link here\";s:8:\"variants\";s:8:\"Variants\";s:16:\"vector-view-edit\";s:4:\"Edit\";s:19:\"vector-view-history\";s:12:\"View history\";s:16:\"vector-view-view\";s:4:\"Read\";s:9:\"viewcount\";s:56:\"This page has been accessed {{PLURAL:$1|once|$1 times}}.\";s:5:\"views\";s:5:\"Views\";s:13:\"whatlinkshere\";s:15:\"What links here\";s:14:\"word-separator\";s:5:\"&#32;\";}s:11:\"dateFormats\";a:20:{s:8:\"mdy time\";s:3:\"H:i\";s:8:\"mdy date\";s:6:\"F j, Y\";s:13:\"mdy monthonly\";s:3:\"F Y\";s:8:\"mdy both\";s:11:\"H:i, F j, Y\";s:10:\"mdy pretty\";s:3:\"F j\";s:8:\"dmy time\";s:3:\"H:i\";s:8:\"dmy date\";s:5:\"j F Y\";s:13:\"dmy monthonly\";s:3:\"F Y\";s:8:\"dmy both\";s:10:\"H:i, j F Y\";s:10:\"dmy pretty\";s:3:\"j F\";s:8:\"ymd time\";s:3:\"H:i\";s:8:\"ymd date\";s:5:\"Y F j\";s:13:\"ymd monthonly\";s:3:\"Y F\";s:8:\"ymd both\";s:10:\"H:i, Y F j\";s:10:\"ymd pretty\";s:3:\"F j\";s:13:\"ISO 8601 time\";s:11:\"xnH:xni:xns\";s:13:\"ISO 8601 date\";s:11:\"xnY-xnm-xnd\";s:18:\"ISO 8601 monthonly\";s:7:\"xnY-xnm\";s:13:\"ISO 8601 both\";s:25:\"xnY-xnm-xnd\"T\"xnH:xni:xns\";s:15:\"ISO 8601 pretty\";s:7:\"xnm-xnd\";}s:14:\"namespaceNames\";a:17:{i:-2;s:5:\"Media\";i:-1;s:7:\"Special\";i:0;s:0:\"\";i:1;s:4:\"Talk\";i:2;s:4:\"User\";i:3;s:9:\"User_talk\";i:5;s:7:\"$1_talk\";i:6;s:4:\"File\";i:7;s:9:\"File_talk\";i:8;s:9:\"MediaWiki\";i:9;s:14:\"MediaWiki_talk\";i:10;s:8:\"Template\";i:11;s:13:\"Template_talk\";i:12;s:4:\"Help\";i:13;s:9:\"Help_talk\";i:14;s:8:\"Category\";i:15;s:13:\"Category_talk\";}}'),('en-ca','preloadedMessages','a:111:{i:0;s:9:\"aboutpage\";i:1;s:9:\"aboutsite\";i:2;s:17:\"accesskey-ca-edit\";i:3;s:20:\"accesskey-ca-history\";i:4;s:23:\"accesskey-ca-nstab-main\";i:5;s:17:\"accesskey-ca-talk\";i:6;s:23:\"accesskey-ca-viewsource\";i:7;s:25:\"accesskey-n-currentevents\";i:8;s:16:\"accesskey-n-help\";i:9;s:32:\"accesskey-n-mainpage-description\";i:10;s:18:\"accesskey-n-portal\";i:11;s:22:\"accesskey-n-randompage\";i:12;s:25:\"accesskey-n-recentchanges\";i:13;s:16:\"accesskey-p-logo\";i:14;s:18:\"accesskey-pt-login\";i:15;s:26:\"accesskey-pt-createaccount\";i:16;s:16:\"accesskey-search\";i:17;s:25:\"accesskey-search-fulltext\";i:18;s:19:\"accesskey-search-go\";i:19;s:16:\"accesskey-t-info\";i:20;s:21:\"accesskey-t-permalink\";i:21;s:17:\"accesskey-t-print\";i:22;s:31:\"accesskey-t-recentchangeslinked\";i:23;s:24:\"accesskey-t-specialpages\";i:24;s:25:\"accesskey-t-whatlinkshere\";i:25;s:7:\"actions\";i:26;s:10:\"anonnotice\";i:27;s:8:\"brackets\";i:28;s:15:\"comma-separator\";i:29;s:13:\"currentevents\";i:30;s:17:\"currentevents-url\";i:31;s:14:\"disclaimerpage\";i:32;s:11:\"disclaimers\";i:33;s:4:\"edit\";i:34;s:11:\"editsection\";i:35;s:15:\"editsectionhint\";i:36;s:4:\"help\";i:37;s:8:\"helppage\";i:38;s:24:\"interlanguage-link-title\";i:39;s:6:\"jumpto\";i:40;s:16:\"jumptonavigation\";i:41;s:12:\"jumptosearch\";i:42;s:14:\"lastmodifiedat\";i:43;s:8:\"mainpage\";i:44;s:20:\"mainpage-description\";i:45;s:14:\"mainpage-nstab\";i:46;s:10:\"namespaces\";i:47;s:10:\"navigation\";i:48;s:23:\"nav-login-createaccount\";i:49;s:10:\"nstab-main\";i:50;s:15:\"opensearch-desc\";i:51;s:14:\"pagecategories\";i:52;s:18:\"pagecategorieslink\";i:53;s:9:\"pagetitle\";i:54;s:23:\"pagetitle-view-mainpage\";i:55;s:9:\"permalink\";i:56;s:13:\"personaltools\";i:57;s:6:\"portal\";i:58;s:10:\"portal-url\";i:59;s:16:\"printableversion\";i:60;s:7:\"privacy\";i:61;s:11:\"privacypage\";i:62;s:10:\"randompage\";i:63;s:14:\"randompage-url\";i:64;s:13:\"recentchanges\";i:65;s:27:\"recentchangeslinked-toolbox\";i:66;s:17:\"recentchanges-url\";i:67;s:13:\"retrievedfrom\";i:68;s:6:\"search\";i:69;s:13:\"searcharticle\";i:70;s:12:\"searchbutton\";i:71;s:20:\"searchsuggest-search\";i:72;s:7:\"sidebar\";i:73;s:18:\"navigation-heading\";i:74;s:14:\"site-atom-feed\";i:75;s:10:\"sitenotice\";i:76;s:12:\"specialpages\";i:77;s:7:\"tagline\";i:78;s:4:\"talk\";i:79;s:7:\"toolbox\";i:80;s:15:\"tooltip-ca-edit\";i:81;s:18:\"tooltip-ca-history\";i:82;s:21:\"tooltip-ca-nstab-main\";i:83;s:15:\"tooltip-ca-talk\";i:84;s:21:\"tooltip-ca-viewsource\";i:85;s:23:\"tooltip-n-currentevents\";i:86;s:14:\"tooltip-n-help\";i:87;s:30:\"tooltip-n-mainpage-description\";i:88;s:16:\"tooltip-n-portal\";i:89;s:20:\"tooltip-n-randompage\";i:90;s:23:\"tooltip-n-recentchanges\";i:91;s:14:\"tooltip-p-logo\";i:92;s:16:\"tooltip-pt-login\";i:93;s:24:\"tooltip-pt-createaccount\";i:94;s:14:\"tooltip-search\";i:95;s:23:\"tooltip-search-fulltext\";i:96;s:17:\"tooltip-search-go\";i:97;s:14:\"tooltip-t-info\";i:98;s:19:\"tooltip-t-permalink\";i:99;s:15:\"tooltip-t-print\";i:100;s:29:\"tooltip-t-recentchangeslinked\";i:101;s:22:\"tooltip-t-specialpages\";i:102;s:23:\"tooltip-t-whatlinkshere\";i:103;s:8:\"variants\";i:104;s:16:\"vector-view-edit\";i:105;s:19:\"vector-view-history\";i:106;s:16:\"vector-view-view\";i:107;s:9:\"viewcount\";i:108;s:5:\"views\";i:109;s:13:\"whatlinkshere\";i:110;s:14:\"word-separator\";}'),('en-ca','rtl','b:0;'),('en-ca','separatorTransformTable','N;'),('en-ca','specialPageAliases','a:130:{s:11:\"Activeusers\";a:1:{i:0;s:11:\"ActiveUsers\";}s:11:\"Allmessages\";a:1:{i:0;s:11:\"AllMessages\";}s:12:\"AllMyUploads\";a:2:{i:0;s:12:\"AllMyUploads\";i:1;s:10:\"AllMyFiles\";}s:8:\"Allpages\";a:1:{i:0;s:8:\"AllPages\";}s:12:\"Ancientpages\";a:1:{i:0;s:12:\"AncientPages\";}s:7:\"ApiHelp\";a:1:{i:0;s:7:\"ApiHelp\";}s:10:\"ApiSandbox\";a:1:{i:0;s:10:\"ApiSandbox\";}s:13:\"AutoblockList\";a:2:{i:0;s:13:\"AutoblockList\";i:1;s:14:\"ListAutoblocks\";}s:8:\"Badtitle\";a:1:{i:0;s:8:\"Badtitle\";}s:9:\"Blankpage\";a:1:{i:0;s:9:\"BlankPage\";}s:5:\"Block\";a:3:{i:0;s:5:\"Block\";i:1;s:7:\"BlockIP\";i:2;s:9:\"BlockUser\";}s:9:\"BlockList\";a:3:{i:0;s:9:\"BlockList\";i:1;s:10:\"ListBlocks\";i:2;s:11:\"IPBlockList\";}s:11:\"Booksources\";a:1:{i:0;s:11:\"BookSources\";}s:12:\"BotPasswords\";a:1:{i:0;s:12:\"BotPasswords\";}s:15:\"BrokenRedirects\";a:1:{i:0;s:15:\"BrokenRedirects\";}s:10:\"Categories\";a:1:{i:0;s:10:\"Categories\";}s:18:\"ChangeContentModel\";a:1:{i:0;s:18:\"ChangeContentModel\";}s:17:\"ChangeCredentials\";a:1:{i:0;s:17:\"ChangeCredentials\";}s:11:\"ChangeEmail\";a:1:{i:0;s:11:\"ChangeEmail\";}s:14:\"ChangePassword\";a:3:{i:0;s:14:\"ChangePassword\";i:1;s:9:\"ResetPass\";i:2;s:13:\"ResetPassword\";}s:12:\"ComparePages\";a:1:{i:0;s:12:\"ComparePages\";}s:12:\"Confirmemail\";a:1:{i:0;s:12:\"ConfirmEmail\";}s:13:\"Contributions\";a:2:{i:0;s:13:\"Contributions\";i:1;s:8:\"Contribs\";}s:13:\"CreateAccount\";a:1:{i:0;s:13:\"CreateAccount\";}s:12:\"Deadendpages\";a:1:{i:0;s:12:\"DeadendPages\";}s:20:\"DeletedContributions\";a:1:{i:0;s:20:\"DeletedContributions\";}s:4:\"Diff\";a:1:{i:0;s:4:\"Diff\";}s:15:\"DoubleRedirects\";a:1:{i:0;s:15:\"DoubleRedirects\";}s:8:\"EditPage\";a:2:{i:0;s:8:\"EditPage\";i:1;s:4:\"Edit\";}s:8:\"EditTags\";a:1:{i:0;s:8:\"EditTags\";}s:13:\"EditWatchlist\";a:1:{i:0;s:13:\"EditWatchlist\";}s:9:\"Emailuser\";a:2:{i:0;s:9:\"EmailUser\";i:1;s:5:\"Email\";}s:15:\"ExpandTemplates\";a:1:{i:0;s:15:\"ExpandTemplates\";}s:6:\"Export\";a:1:{i:0;s:6:\"Export\";}s:15:\"Fewestrevisions\";a:1:{i:0;s:15:\"FewestRevisions\";}s:19:\"FileDuplicateSearch\";a:1:{i:0;s:19:\"FileDuplicateSearch\";}s:8:\"Filepath\";a:1:{i:0;s:8:\"FilePath\";}s:13:\"GoToInterwiki\";a:1:{i:0;s:13:\"GoToInterwiki\";}s:6:\"Import\";a:1:{i:0;s:6:\"Import\";}s:15:\"Invalidateemail\";a:1:{i:0;s:15:\"InvalidateEmail\";}s:14:\"JavaScriptTest\";a:1:{i:0;s:14:\"JavaScriptTest\";}s:12:\"LinkAccounts\";a:1:{i:0;s:12:\"LinkAccounts\";}s:10:\"LinkSearch\";a:1:{i:0;s:10:\"LinkSearch\";}s:10:\"Listadmins\";a:1:{i:0;s:10:\"ListAdmins\";}s:8:\"Listbots\";a:1:{i:0;s:8:\"ListBots\";}s:19:\"ListDuplicatedFiles\";a:2:{i:0;s:19:\"ListDuplicatedFiles\";i:1;s:18:\"ListFileDuplicates\";}s:9:\"Listfiles\";a:3:{i:0;s:9:\"ListFiles\";i:1;s:8:\"FileList\";i:2;s:9:\"ImageList\";}s:10:\"Listgrants\";a:1:{i:0;s:10:\"ListGrants\";}s:15:\"Listgrouprights\";a:2:{i:0;s:15:\"ListGroupRights\";i:1;s:15:\"UserGroupRights\";}s:13:\"Listredirects\";a:1:{i:0;s:13:\"ListRedirects\";}s:9:\"Listusers\";a:3:{i:0;s:9:\"ListUsers\";i:1;s:8:\"UserList\";i:2;s:5:\"Users\";}s:6:\"Lockdb\";a:1:{i:0;s:6:\"LockDB\";}s:3:\"Log\";a:2:{i:0;s:3:\"Log\";i:1;s:4:\"Logs\";}s:11:\"Lonelypages\";a:2:{i:0;s:11:\"LonelyPages\";i:1;s:13:\"OrphanedPages\";}s:9:\"Longpages\";a:1:{i:0;s:9:\"LongPages\";}s:15:\"MediaStatistics\";a:1:{i:0;s:15:\"MediaStatistics\";}s:12:\"MergeHistory\";a:1:{i:0;s:12:\"MergeHistory\";}s:10:\"MIMEsearch\";a:1:{i:0;s:10:\"MIMESearch\";}s:14:\"Mostcategories\";a:1:{i:0;s:14:\"MostCategories\";}s:10:\"Mostimages\";a:3:{i:0;s:15:\"MostLinkedFiles\";i:1;s:9:\"MostFiles\";i:2;s:10:\"MostImages\";}s:14:\"Mostinterwikis\";a:1:{i:0;s:14:\"MostInterwikis\";}s:10:\"Mostlinked\";a:2:{i:0;s:15:\"MostLinkedPages\";i:1;s:10:\"MostLinked\";}s:20:\"Mostlinkedcategories\";a:2:{i:0;s:20:\"MostLinkedCategories\";i:1;s:18:\"MostUsedCategories\";}s:19:\"Mostlinkedtemplates\";a:3:{i:0;s:20:\"MostTranscludedPages\";i:1;s:19:\"MostLinkedTemplates\";i:2;s:17:\"MostUsedTemplates\";}s:13:\"Mostrevisions\";a:1:{i:0;s:13:\"MostRevisions\";}s:8:\"Movepage\";a:1:{i:0;s:8:\"MovePage\";}s:4:\"Mute\";a:1:{i:0;s:4:\"Mute\";}s:15:\"Mycontributions\";a:1:{i:0;s:15:\"MyContributions\";}s:10:\"MyLanguage\";a:1:{i:0;s:10:\"MyLanguage\";}s:6:\"Mypage\";a:1:{i:0;s:6:\"MyPage\";}s:6:\"Mytalk\";a:1:{i:0;s:6:\"MyTalk\";}s:9:\"Myuploads\";a:2:{i:0;s:9:\"MyUploads\";i:1;s:7:\"MyFiles\";}s:9:\"Newimages\";a:2:{i:0;s:8:\"NewFiles\";i:1;s:9:\"NewImages\";}s:8:\"Newpages\";a:1:{i:0;s:8:\"NewPages\";}s:10:\"NewSection\";a:2:{i:0;s:10:\"NewSection\";i:1;s:10:\"Newsection\";}s:8:\"PageData\";a:1:{i:0;s:8:\"PageData\";}s:11:\"PageHistory\";a:2:{i:0;s:11:\"PageHistory\";i:1;s:7:\"History\";}s:8:\"PageInfo\";a:2:{i:0;s:8:\"PageInfo\";i:1;s:4:\"Info\";}s:12:\"PageLanguage\";a:1:{i:0;s:12:\"PageLanguage\";}s:13:\"PagesWithProp\";a:4:{i:0;s:13:\"PagesWithProp\";i:1;s:13:\"Pageswithprop\";i:2;s:11:\"PagesByProp\";i:3;s:11:\"Pagesbyprop\";}s:16:\"PasswordPolicies\";a:1:{i:0;s:16:\"PasswordPolicies\";}s:13:\"PasswordReset\";a:1:{i:0;s:13:\"PasswordReset\";}s:13:\"PermanentLink\";a:2:{i:0;s:13:\"PermanentLink\";i:1;s:9:\"PermaLink\";}s:11:\"Preferences\";a:1:{i:0;s:11:\"Preferences\";}s:11:\"Prefixindex\";a:1:{i:0;s:11:\"PrefixIndex\";}s:14:\"Protectedpages\";a:1:{i:0;s:14:\"ProtectedPages\";}s:15:\"Protectedtitles\";a:1:{i:0;s:15:\"ProtectedTitles\";}s:5:\"Purge\";a:1:{i:0;s:5:\"Purge\";}s:16:\"RandomInCategory\";a:1:{i:0;s:16:\"RandomInCategory\";}s:10:\"Randompage\";a:2:{i:0;s:6:\"Random\";i:1;s:10:\"RandomPage\";}s:14:\"Randomredirect\";a:1:{i:0;s:14:\"RandomRedirect\";}s:14:\"Randomrootpage\";a:1:{i:0;s:14:\"RandomRootpage\";}s:13:\"Recentchanges\";a:1:{i:0;s:13:\"RecentChanges\";}s:19:\"Recentchangeslinked\";a:2:{i:0;s:19:\"RecentChangesLinked\";i:1;s:14:\"RelatedChanges\";}s:8:\"Redirect\";a:1:{i:0;s:8:\"Redirect\";}s:17:\"RemoveCredentials\";a:1:{i:0;s:17:\"RemoveCredentials\";}s:11:\"ResetTokens\";a:1:{i:0;s:11:\"ResetTokens\";}s:14:\"Revisiondelete\";a:1:{i:0;s:14:\"RevisionDelete\";}s:7:\"RunJobs\";a:1:{i:0;s:7:\"RunJobs\";}s:6:\"Search\";a:1:{i:0;s:6:\"Search\";}s:10:\"Shortpages\";a:1:{i:0;s:10:\"ShortPages\";}s:12:\"Specialpages\";a:1:{i:0;s:12:\"SpecialPages\";}s:10:\"Statistics\";a:2:{i:0;s:10:\"Statistics\";i:1;s:5:\"Stats\";}s:4:\"Tags\";a:1:{i:0;s:4:\"Tags\";}s:18:\"TrackingCategories\";a:1:{i:0;s:18:\"TrackingCategories\";}s:7:\"Unblock\";a:1:{i:0;s:7:\"Unblock\";}s:23:\"Uncategorizedcategories\";a:1:{i:0;s:23:\"UncategorizedCategories\";}s:19:\"Uncategorizedimages\";a:2:{i:0;s:18:\"UncategorizedFiles\";i:1;s:19:\"UncategorizedImages\";}s:18:\"Uncategorizedpages\";a:1:{i:0;s:18:\"UncategorizedPages\";}s:22:\"Uncategorizedtemplates\";a:1:{i:0;s:22:\"UncategorizedTemplates\";}s:8:\"Undelete\";a:1:{i:0;s:8:\"Undelete\";}s:14:\"UnlinkAccounts\";a:1:{i:0;s:14:\"UnlinkAccounts\";}s:8:\"Unlockdb\";a:1:{i:0;s:8:\"UnlockDB\";}s:16:\"Unusedcategories\";a:1:{i:0;s:16:\"UnusedCategories\";}s:12:\"Unusedimages\";a:2:{i:0;s:11:\"UnusedFiles\";i:1;s:12:\"UnusedImages\";}s:15:\"Unusedtemplates\";a:1:{i:0;s:15:\"UnusedTemplates\";}s:14:\"Unwatchedpages\";a:1:{i:0;s:14:\"UnwatchedPages\";}s:6:\"Upload\";a:1:{i:0;s:6:\"Upload\";}s:11:\"UploadStash\";a:1:{i:0;s:11:\"UploadStash\";}s:9:\"Userlogin\";a:2:{i:0;s:9:\"UserLogin\";i:1;s:5:\"Login\";}s:10:\"Userlogout\";a:2:{i:0;s:10:\"UserLogout\";i:1;s:6:\"Logout\";}s:10:\"Userrights\";a:3:{i:0;s:10:\"UserRights\";i:1;s:9:\"MakeSysop\";i:2;s:7:\"MakeBot\";}s:7:\"Version\";a:1:{i:0;s:7:\"Version\";}s:16:\"Wantedcategories\";a:1:{i:0;s:16:\"WantedCategories\";}s:11:\"Wantedfiles\";a:1:{i:0;s:11:\"WantedFiles\";}s:11:\"Wantedpages\";a:2:{i:0;s:11:\"WantedPages\";i:1;s:11:\"BrokenLinks\";}s:15:\"Wantedtemplates\";a:1:{i:0;s:15:\"WantedTemplates\";}s:9:\"Watchlist\";a:1:{i:0;s:9:\"Watchlist\";}s:13:\"Whatlinkshere\";a:1:{i:0;s:13:\"WhatLinksHere\";}s:16:\"Withoutinterwiki\";a:1:{i:0;s:16:\"WithoutInterwiki\";}}');
/*!40000 ALTER TABLE `l10n_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `langlinks`
--

DROP TABLE IF EXISTS `langlinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `langlinks` (
  `ll_from` int(10) unsigned NOT NULL DEFAULT 0,
  `ll_lang` varbinary(35) NOT NULL DEFAULT '',
  `ll_title` varbinary(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`ll_from`,`ll_lang`),
  KEY `ll_lang` (`ll_lang`,`ll_title`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `langlinks`
--

LOCK TABLES `langlinks` WRITE;
/*!40000 ALTER TABLE `langlinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `langlinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_search`
--

DROP TABLE IF EXISTS `log_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_search` (
  `ls_field` varbinary(32) NOT NULL,
  `ls_value` varbinary(255) NOT NULL,
  `ls_log_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`ls_field`,`ls_value`,`ls_log_id`),
  KEY `ls_log_id` (`ls_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_search`
--

LOCK TABLES `log_search` WRITE;
/*!40000 ALTER TABLE `log_search` DISABLE KEYS */;
INSERT INTO `log_search` VALUES ('associated_rev_id','1',1),('associated_rev_id','2',2),('associated_rev_id','2',3);
/*!40000 ALTER TABLE `log_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logging`
--

DROP TABLE IF EXISTS `logging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logging` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log_type` varbinary(32) NOT NULL DEFAULT '',
  `log_action` varbinary(32) NOT NULL DEFAULT '',
  `log_timestamp` binary(14) NOT NULL DEFAULT '19700101000000',
  `log_actor` bigint(20) unsigned NOT NULL,
  `log_namespace` int(11) NOT NULL DEFAULT 0,
  `log_title` varbinary(255) NOT NULL DEFAULT '',
  `log_page` int(10) unsigned DEFAULT NULL,
  `log_comment_id` bigint(20) unsigned NOT NULL,
  `log_params` blob NOT NULL,
  `log_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`log_id`),
  KEY `log_type_time` (`log_type`,`log_timestamp`),
  KEY `log_actor_time` (`log_actor`,`log_timestamp`),
  KEY `log_page_time` (`log_namespace`,`log_title`,`log_timestamp`),
  KEY `log_times` (`log_timestamp`),
  KEY `log_actor_type_time` (`log_actor`,`log_type`,`log_timestamp`),
  KEY `log_page_id_time` (`log_page`,`log_timestamp`),
  KEY `log_type_action` (`log_type`,`log_action`,`log_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logging`
--

LOCK TABLES `logging` WRITE;
/*!40000 ALTER TABLE `logging` DISABLE KEYS */;
INSERT INTO `logging` VALUES (1,'create','create','20220128200044',2,0,'Main_Page',1,1,'a:1:{s:17:\"associated_rev_id\";i:1;}',0),(2,'upload','upload','20220128200217',1,6,'Badge_burn_badge.png',2,1,'a:3:{s:8:\"img_sha1\";s:31:\"qwin8lf9dbwloywfu2nh7b3lce01yg5\";s:13:\"img_timestamp\";s:14:\"20220128200217\";s:17:\"associated_rev_id\";i:2;}',0),(3,'create','create','20220128200217',1,6,'Badge_burn_badge.png',2,1,'a:1:{s:17:\"associated_rev_id\";i:2;}',0);
/*!40000 ALTER TABLE `logging` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_deps`
--

DROP TABLE IF EXISTS `module_deps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_deps` (
  `md_module` varbinary(255) NOT NULL,
  `md_skin` varbinary(32) NOT NULL,
  `md_deps` mediumblob NOT NULL,
  PRIMARY KEY (`md_module`,`md_skin`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_deps`
--

LOCK TABLES `module_deps` WRITE;
/*!40000 ALTER TABLE `module_deps` DISABLE KEYS */;
INSERT INTO `module_deps` VALUES ('mediawiki.helplink','vector|en-ca','[\"resources/src/mediawiki.helplink/images/helpNotice.svg\"]'),('mediawiki.htmlform.styles','vector|en-ca','[\"resources/src/mediawiki.htmlform.styles/images/question.png\",\"resources/src/mediawiki.htmlform.styles/images/question.svg\",\"resources/src/mediawiki.less/mediawiki.mixins.less\"]'),('mediawiki.interface.helpers.styles','vector|en-ca','[\"resources/src/mediawiki.less/mediawiki.mixins.less\"]'),('mediawiki.special','vector|en-ca','[\"resources/src/mediawiki.less/mediawiki.mixins.less\",\"resources/src/mediawiki.less/mediawiki.skin.defaults.less\",\"resources/src/mediawiki.less/mediawiki.ui/variables.less\",\"skins/Vector/resources/mediawiki.less/mediawiki.skin.variables.less\"]'),('oojs-ui-core.styles','vector|en-ca','[\"resources/src/mediawiki.less/mediawiki.skin.defaults.less\",\"resources/src/mediawiki.less/mediawiki.ui/variables.less\",\"skins/Vector/resources/common/variables.less\",\"skins/Vector/resources/mediawiki.less/mediawiki.skin.variables.less\"]'),('skins.vector.styles.legacy','vector|en-ca','[\"resources/src/mediawiki.less/mediawiki.mixins.animation.less\",\"resources/src/mediawiki.less/mediawiki.mixins.less\",\"resources/src/mediawiki.less/mediawiki.mixins.rotation.less\",\"resources/src/mediawiki.less/mediawiki.skin.defaults.less\",\"resources/src/mediawiki.less/mediawiki.ui/variables.less\",\"resources/src/mediawiki.skinning/content.thumbnails-layout.less\",\"resources/src/mediawiki.skinning/i18n-counter-styles.css\",\"resources/src/mediawiki.skinning/images/audio-ltr.svg\",\"resources/src/mediawiki.skinning/images/chat-ltr.svg\",\"resources/src/mediawiki.skinning/images/document-ltr.svg\",\"resources/src/mediawiki.skinning/images/external-ltr.svg\",\"resources/src/mediawiki.skinning/images/ftp-ltr.svg\",\"resources/src/mediawiki.skinning/images/magnify-clip-ltr.svg\",\"resources/src/mediawiki.skinning/images/magnify-clip-rtl.svg\",\"resources/src/mediawiki.skinning/images/mail.svg\",\"resources/src/mediawiki.skinning/images/video.svg\",\"resources/src/mediawiki.skinning/interface-edit-section-links.less\",\"resources/src/mediawiki.skinning/toc/i18n.less\",\"resources/src/mediawiki.skinning/variables.less\",\"skins/Vector/resources/common/components/Footer.less\",\"skins/Vector/resources/common/components/Indicators.less\",\"skins/Vector/resources/common/components/Menu.less\",\"skins/Vector/resources/common/components/MenuDropdown.less\",\"skins/Vector/resources/common/components/MenuPortal.less\",\"skins/Vector/resources/common/components/MenuTabs.less\",\"skins/Vector/resources/common/components/SearchBox.less\",\"skins/Vector/resources/common/components/SidebarLogo.less\",\"skins/Vector/resources/common/components/SiteNotice.less\",\"skins/Vector/resources/common/components/TabWatchstarLink.less\",\"skins/Vector/resources/common/images/arrow-down.svg\",\"skins/Vector/resources/common/images/bullet-icon.svg\",\"skins/Vector/resources/common/images/external-link-ltr-icon.svg\",\"skins/Vector/resources/common/images/portal-separator.png\",\"skins/Vector/resources/common/images/search.svg\",\"skins/Vector/resources/common/images/tab-normal-fade.png\",\"skins/Vector/resources/common/images/tab-separator.png\",\"skins/Vector/resources/common/images/unwatch-icon-hl.svg\",\"skins/Vector/resources/common/images/unwatch-icon.svg\",\"skins/Vector/resources/common/images/unwatch-temp-icon-hl.svg\",\"skins/Vector/resources/common/images/unwatch-temp-icon.svg\",\"skins/Vector/resources/common/images/watch-icon-hl.svg\",\"skins/Vector/resources/common/images/watch-icon.svg\",\"skins/Vector/resources/common/normalize.less\",\"skins/Vector/resources/common/print.less\",\"skins/Vector/resources/common/typography.less\",\"skins/Vector/resources/common/variables.less\",\"skins/Vector/resources/mediawiki.less/mediawiki.skin.variables.less\",\"skins/Vector/resources/skins.vector.styles.legacy/components/MenuDropdown.less\",\"skins/Vector/resources/skins.vector.styles.legacy/components/Sidebar.less\",\"skins/Vector/resources/skins.vector.styles.legacy/components/UserLinks.less\",\"skins/Vector/resources/skins.vector.styles.legacy/images/user-avatar.svg\",\"skins/Vector/resources/skins.vector.styles.legacy/layouts/print.less\",\"skins/Vector/resources/skins.vector.styles.legacy/layouts/screen.less\"]');
/*!40000 ALTER TABLE `module_deps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objectcache`
--

DROP TABLE IF EXISTS `objectcache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objectcache` (
  `keyname` varbinary(255) NOT NULL DEFAULT '',
  `value` mediumblob DEFAULT NULL,
  `exptime` binary(14) NOT NULL,
  `modtoken` varbinary(17) NOT NULL DEFAULT '00000000000000000',
  `flags` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`keyname`),
  KEY `exptime` (`exptime`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objectcache`
--

LOCK TABLES `objectcache` WRITE;
/*!40000 ALTER TABLE `objectcache` DISABLE KEYS */;
INSERT INTO `objectcache` VALUES ('my_wiki:messages:en-ca','�1\n\�0�r/X�\�R��R\�&	6��T�R�4�{\�n�)\�oL�縬\��&�K\��2]\�I\�ⱚ\'\�KD�x�xAuT\���[\�\�E\��z\�\���p�:(l���','99991231235959','00000000000000000',NULL);
/*!40000 ALTER TABLE `objectcache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oldimage`
--

DROP TABLE IF EXISTS `oldimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oldimage` (
  `oi_name` varbinary(255) NOT NULL DEFAULT '',
  `oi_archive_name` varbinary(255) NOT NULL DEFAULT '',
  `oi_size` int(10) unsigned NOT NULL DEFAULT 0,
  `oi_width` int(11) NOT NULL DEFAULT 0,
  `oi_height` int(11) NOT NULL DEFAULT 0,
  `oi_bits` int(11) NOT NULL DEFAULT 0,
  `oi_description_id` bigint(20) unsigned NOT NULL,
  `oi_actor` bigint(20) unsigned NOT NULL,
  `oi_timestamp` binary(14) NOT NULL,
  `oi_metadata` mediumblob NOT NULL,
  `oi_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE','3D') DEFAULT NULL,
  `oi_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart','chemical') NOT NULL DEFAULT 'unknown',
  `oi_minor_mime` varbinary(100) NOT NULL DEFAULT 'unknown',
  `oi_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `oi_sha1` varbinary(32) NOT NULL DEFAULT '',
  KEY `oi_actor_timestamp` (`oi_actor`,`oi_timestamp`),
  KEY `oi_name_timestamp` (`oi_name`,`oi_timestamp`),
  KEY `oi_name_archive_name` (`oi_name`,`oi_archive_name`(14)),
  KEY `oi_sha1` (`oi_sha1`(10)),
  KEY `oi_timestamp` (`oi_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oldimage`
--

LOCK TABLES `oldimage` WRITE;
/*!40000 ALTER TABLE `oldimage` DISABLE KEYS */;
/*!40000 ALTER TABLE `oldimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page`
--

DROP TABLE IF EXISTS `page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_namespace` int(11) NOT NULL,
  `page_title` varbinary(255) NOT NULL,
  `page_restrictions` tinyblob DEFAULT NULL,
  `page_is_redirect` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `page_is_new` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `page_random` double unsigned NOT NULL,
  `page_touched` binary(14) NOT NULL,
  `page_links_updated` varbinary(14) DEFAULT NULL,
  `page_latest` int(10) unsigned NOT NULL,
  `page_len` int(10) unsigned NOT NULL,
  `page_content_model` varbinary(32) DEFAULT NULL,
  `page_lang` varbinary(35) DEFAULT NULL,
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `page_name_title` (`page_namespace`,`page_title`),
  KEY `page_random` (`page_random`),
  KEY `page_len` (`page_len`),
  KEY `page_redirect_namespace_len` (`page_is_redirect`,`page_namespace`,`page_len`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page`
--

LOCK TABLES `page` WRITE;
/*!40000 ALTER TABLE `page` DISABLE KEYS */;
INSERT INTO `page` VALUES (1,0,'Main_Page','',0,0,0.144214114318,'20220128200404','20220128200404',4,837,'wikitext',NULL),(2,6,'Badge_burn_badge.png','',0,1,0.499670632043,'20220128200217','20220128200217',2,0,'wikitext',NULL);
/*!40000 ALTER TABLE `page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_props`
--

DROP TABLE IF EXISTS `page_props`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_props` (
  `pp_page` int(11) NOT NULL,
  `pp_propname` varbinary(60) NOT NULL,
  `pp_value` blob NOT NULL,
  `pp_sortkey` float DEFAULT NULL,
  PRIMARY KEY (`pp_page`,`pp_propname`),
  UNIQUE KEY `pp_propname_page` (`pp_propname`,`pp_page`),
  UNIQUE KEY `pp_propname_sortkey_page` (`pp_propname`,`pp_sortkey`,`pp_page`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_props`
--

LOCK TABLES `page_props` WRITE;
/*!40000 ALTER TABLE `page_props` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_props` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_restrictions`
--

DROP TABLE IF EXISTS `page_restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_restrictions` (
  `pr_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pr_page` int(11) NOT NULL,
  `pr_type` varbinary(60) NOT NULL,
  `pr_level` varbinary(60) NOT NULL,
  `pr_cascade` tinyint(4) NOT NULL,
  `pr_user` int(10) unsigned DEFAULT NULL,
  `pr_expiry` varbinary(14) DEFAULT NULL,
  PRIMARY KEY (`pr_id`),
  UNIQUE KEY `pr_pagetype` (`pr_page`,`pr_type`),
  KEY `pr_typelevel` (`pr_type`,`pr_level`),
  KEY `pr_level` (`pr_level`),
  KEY `pr_cascade` (`pr_cascade`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_restrictions`
--

LOCK TABLES `page_restrictions` WRITE;
/*!40000 ALTER TABLE `page_restrictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_restrictions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagelinks`
--

DROP TABLE IF EXISTS `pagelinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagelinks` (
  `pl_from` int(10) unsigned NOT NULL DEFAULT 0,
  `pl_namespace` int(11) NOT NULL DEFAULT 0,
  `pl_title` varbinary(255) NOT NULL DEFAULT '',
  `pl_from_namespace` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`pl_from`,`pl_namespace`,`pl_title`),
  KEY `pl_namespace` (`pl_namespace`,`pl_title`,`pl_from`),
  KEY `pl_backlinks_namespace` (`pl_from_namespace`,`pl_namespace`,`pl_title`,`pl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagelinks`
--

LOCK TABLES `pagelinks` WRITE;
/*!40000 ALTER TABLE `pagelinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagelinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `protected_titles`
--

DROP TABLE IF EXISTS `protected_titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `protected_titles` (
  `pt_namespace` int(11) NOT NULL,
  `pt_title` varbinary(255) NOT NULL,
  `pt_user` int(10) unsigned NOT NULL,
  `pt_reason_id` bigint(20) unsigned NOT NULL,
  `pt_timestamp` binary(14) NOT NULL,
  `pt_expiry` varbinary(14) NOT NULL,
  `pt_create_perm` varbinary(60) NOT NULL,
  PRIMARY KEY (`pt_namespace`,`pt_title`),
  KEY `pt_timestamp` (`pt_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `protected_titles`
--

LOCK TABLES `protected_titles` WRITE;
/*!40000 ALTER TABLE `protected_titles` DISABLE KEYS */;
/*!40000 ALTER TABLE `protected_titles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `querycache`
--

DROP TABLE IF EXISTS `querycache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `querycache` (
  `qc_type` varbinary(32) NOT NULL,
  `qc_value` int(10) unsigned NOT NULL DEFAULT 0,
  `qc_namespace` int(11) NOT NULL DEFAULT 0,
  `qc_title` varbinary(255) NOT NULL DEFAULT '',
  KEY `qc_type` (`qc_type`,`qc_value`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `querycache`
--

LOCK TABLES `querycache` WRITE;
/*!40000 ALTER TABLE `querycache` DISABLE KEYS */;
/*!40000 ALTER TABLE `querycache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `querycache_info`
--

DROP TABLE IF EXISTS `querycache_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `querycache_info` (
  `qci_type` varbinary(32) NOT NULL DEFAULT '',
  `qci_timestamp` binary(14) NOT NULL DEFAULT '19700101000000',
  PRIMARY KEY (`qci_type`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `querycache_info`
--

LOCK TABLES `querycache_info` WRITE;
/*!40000 ALTER TABLE `querycache_info` DISABLE KEYS */;
INSERT INTO `querycache_info` VALUES ('activeusers','20220128200223');
/*!40000 ALTER TABLE `querycache_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `querycachetwo`
--

DROP TABLE IF EXISTS `querycachetwo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `querycachetwo` (
  `qcc_type` varbinary(32) NOT NULL,
  `qcc_value` int(10) unsigned NOT NULL DEFAULT 0,
  `qcc_namespace` int(11) NOT NULL DEFAULT 0,
  `qcc_title` varbinary(255) NOT NULL DEFAULT '',
  `qcc_namespacetwo` int(11) NOT NULL DEFAULT 0,
  `qcc_titletwo` varbinary(255) NOT NULL DEFAULT '',
  KEY `qcc_type` (`qcc_type`,`qcc_value`),
  KEY `qcc_title` (`qcc_type`,`qcc_namespace`,`qcc_title`),
  KEY `qcc_titletwo` (`qcc_type`,`qcc_namespacetwo`,`qcc_titletwo`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `querycachetwo`
--

LOCK TABLES `querycachetwo` WRITE;
/*!40000 ALTER TABLE `querycachetwo` DISABLE KEYS */;
INSERT INTO `querycachetwo` VALUES ('activeusers',1643400137,2,'Admin',0,'');
/*!40000 ALTER TABLE `querycachetwo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recentchanges`
--

DROP TABLE IF EXISTS `recentchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recentchanges` (
  `rc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rc_timestamp` binary(14) NOT NULL,
  `rc_actor` bigint(20) unsigned NOT NULL,
  `rc_namespace` int(11) NOT NULL DEFAULT 0,
  `rc_title` varbinary(255) NOT NULL DEFAULT '',
  `rc_comment_id` bigint(20) unsigned NOT NULL,
  `rc_minor` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_bot` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_new` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_cur_id` int(10) unsigned NOT NULL DEFAULT 0,
  `rc_this_oldid` int(10) unsigned NOT NULL DEFAULT 0,
  `rc_last_oldid` int(10) unsigned NOT NULL DEFAULT 0,
  `rc_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_source` varbinary(16) NOT NULL DEFAULT '',
  `rc_patrolled` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_ip` varbinary(40) NOT NULL DEFAULT '',
  `rc_old_len` int(11) DEFAULT NULL,
  `rc_new_len` int(11) DEFAULT NULL,
  `rc_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_logid` int(10) unsigned NOT NULL DEFAULT 0,
  `rc_log_type` varbinary(255) DEFAULT NULL,
  `rc_log_action` varbinary(255) DEFAULT NULL,
  `rc_params` blob DEFAULT NULL,
  PRIMARY KEY (`rc_id`),
  KEY `rc_timestamp` (`rc_timestamp`),
  KEY `rc_namespace_title_timestamp` (`rc_namespace`,`rc_title`,`rc_timestamp`),
  KEY `rc_cur_id` (`rc_cur_id`),
  KEY `rc_new_name_timestamp` (`rc_new`,`rc_namespace`,`rc_timestamp`),
  KEY `rc_ip` (`rc_ip`),
  KEY `rc_ns_actor` (`rc_namespace`,`rc_actor`),
  KEY `rc_actor` (`rc_actor`,`rc_timestamp`),
  KEY `rc_name_type_patrolled_timestamp` (`rc_namespace`,`rc_type`,`rc_patrolled`,`rc_timestamp`),
  KEY `rc_this_oldid` (`rc_this_oldid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recentchanges`
--

LOCK TABLES `recentchanges` WRITE;
/*!40000 ALTER TABLE `recentchanges` DISABLE KEYS */;
INSERT INTO `recentchanges` VALUES (1,'20220128200217',1,6,'Badge_burn_badge.png',1,0,0,0,2,2,0,3,'mw.log',2,'172.27.0.1',NULL,NULL,0,2,'upload','upload','a:2:{s:8:\"img_sha1\";s:31:\"qwin8lf9dbwloywfu2nh7b3lce01yg5\";s:13:\"img_timestamp\";s:14:\"20220128200217\";}'),(2,'20220128200252',1,0,'Main_Page',1,0,0,0,1,3,1,0,'mw.edit',2,'172.27.0.1',755,838,0,0,NULL,'',''),(3,'20220128200404',1,0,'Main_Page',1,0,0,0,1,4,3,0,'mw.edit',2,'172.27.0.1',838,837,0,0,NULL,'','');
/*!40000 ALTER TABLE `recentchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `redirect`
--

DROP TABLE IF EXISTS `redirect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `redirect` (
  `rd_from` int(10) unsigned NOT NULL DEFAULT 0,
  `rd_namespace` int(11) NOT NULL DEFAULT 0,
  `rd_title` varbinary(255) NOT NULL DEFAULT '',
  `rd_interwiki` varbinary(32) DEFAULT NULL,
  `rd_fragment` varbinary(255) DEFAULT NULL,
  PRIMARY KEY (`rd_from`),
  KEY `rd_ns_title` (`rd_namespace`,`rd_title`,`rd_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `redirect`
--

LOCK TABLES `redirect` WRITE;
/*!40000 ALTER TABLE `redirect` DISABLE KEYS */;
/*!40000 ALTER TABLE `redirect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revision`
--

DROP TABLE IF EXISTS `revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revision` (
  `rev_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rev_page` int(10) unsigned NOT NULL,
  `rev_comment_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `rev_actor` bigint(20) unsigned NOT NULL DEFAULT 0,
  `rev_timestamp` binary(14) NOT NULL,
  `rev_minor_edit` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rev_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rev_len` int(10) unsigned DEFAULT NULL,
  `rev_parent_id` int(10) unsigned DEFAULT NULL,
  `rev_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`rev_id`),
  KEY `rev_page_id` (`rev_page`,`rev_id`),
  KEY `rev_timestamp` (`rev_timestamp`),
  KEY `rev_page_timestamp` (`rev_page`,`rev_timestamp`),
  KEY `rev_actor_timestamp` (`rev_actor`,`rev_timestamp`,`rev_id`),
  KEY `rev_page_actor_timestamp` (`rev_page`,`rev_actor`,`rev_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revision`
--

LOCK TABLES `revision` WRITE;
/*!40000 ALTER TABLE `revision` DISABLE KEYS */;
INSERT INTO `revision` VALUES (1,1,0,0,'20220128200044',0,0,755,0,'22vz5zlxa2zctewimaum2bf1due8hkl'),(2,2,0,0,'20220128200217',0,0,0,0,'phoiac9h4m842xq45sp7s6u21eteeq1'),(3,1,0,0,'20220128200252',0,0,838,1,'8dcitmrdejz4698mewyzq8s7yufaj34'),(4,1,0,0,'20220128200404',0,0,837,3,'ky7hlou7ly41isu2bbgy8b8dtjktl88');
/*!40000 ALTER TABLE `revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revision_actor_temp`
--

DROP TABLE IF EXISTS `revision_actor_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revision_actor_temp` (
  `revactor_rev` int(10) unsigned NOT NULL,
  `revactor_actor` bigint(20) unsigned NOT NULL,
  `revactor_timestamp` binary(14) NOT NULL,
  `revactor_page` int(10) unsigned NOT NULL,
  PRIMARY KEY (`revactor_rev`,`revactor_actor`),
  UNIQUE KEY `revactor_rev` (`revactor_rev`),
  KEY `actor_timestamp` (`revactor_actor`,`revactor_timestamp`),
  KEY `page_actor_timestamp` (`revactor_page`,`revactor_actor`,`revactor_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revision_actor_temp`
--

LOCK TABLES `revision_actor_temp` WRITE;
/*!40000 ALTER TABLE `revision_actor_temp` DISABLE KEYS */;
INSERT INTO `revision_actor_temp` VALUES (3,1,'20220128200252',1),(4,1,'20220128200404',1),(1,2,'20220128200044',1),(2,1,'20220128200217',2);
/*!40000 ALTER TABLE `revision_actor_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revision_comment_temp`
--

DROP TABLE IF EXISTS `revision_comment_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revision_comment_temp` (
  `revcomment_rev` int(10) unsigned NOT NULL,
  `revcomment_comment_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`revcomment_rev`,`revcomment_comment_id`),
  UNIQUE KEY `revcomment_rev` (`revcomment_rev`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revision_comment_temp`
--

LOCK TABLES `revision_comment_temp` WRITE;
/*!40000 ALTER TABLE `revision_comment_temp` DISABLE KEYS */;
INSERT INTO `revision_comment_temp` VALUES (1,1),(2,1),(3,1),(4,1);
/*!40000 ALTER TABLE `revision_comment_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `si_page` int(10) unsigned NOT NULL,
  `si_title` varchar(255) NOT NULL DEFAULT '',
  `si_text` mediumtext NOT NULL,
  UNIQUE KEY `si_page` (`si_page`),
  FULLTEXT KEY `si_title` (`si_title`),
  FULLTEXT KEY `si_text` (`si_text`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
INSERT INTO `searchindex` VALUES (2,'badge burn badgeu82epngu800',' '),(1,'main page',' mediawiki hasu800 been installed using dcycle mediawiki starterkit . consult theu800 user user\'su800 guide foru800 information onu800 using theu800 wiki software. getting started getting started getting started * configuration settings list * mediawiki faqu800 * mediawiki release mailing list * localise mediawiki foru800 your language * learn howu800 tou800 combat spam onu800 your wiki ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_identifiers`
--

DROP TABLE IF EXISTS `site_identifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_identifiers` (
  `si_type` varbinary(32) NOT NULL,
  `si_key` varbinary(32) NOT NULL,
  `si_site` int(10) unsigned NOT NULL,
  PRIMARY KEY (`si_type`,`si_key`),
  KEY `si_site` (`si_site`),
  KEY `si_key` (`si_key`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_identifiers`
--

LOCK TABLES `site_identifiers` WRITE;
/*!40000 ALTER TABLE `site_identifiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_identifiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_stats`
--

DROP TABLE IF EXISTS `site_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_stats` (
  `ss_row_id` int(10) unsigned NOT NULL,
  `ss_total_edits` bigint(20) unsigned DEFAULT NULL,
  `ss_good_articles` bigint(20) unsigned DEFAULT NULL,
  `ss_total_pages` bigint(20) unsigned DEFAULT NULL,
  `ss_users` bigint(20) unsigned DEFAULT NULL,
  `ss_active_users` bigint(20) unsigned DEFAULT NULL,
  `ss_images` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`ss_row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_stats`
--

LOCK TABLES `site_stats` WRITE;
/*!40000 ALTER TABLE `site_stats` DISABLE KEYS */;
INSERT INTO `site_stats` VALUES (1,3,0,1,1,0,1);
/*!40000 ALTER TABLE `site_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `site_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_global_key` varbinary(64) NOT NULL,
  `site_type` varbinary(32) NOT NULL,
  `site_group` varbinary(32) NOT NULL,
  `site_source` varbinary(32) NOT NULL,
  `site_language` varbinary(35) NOT NULL,
  `site_protocol` varbinary(32) NOT NULL,
  `site_domain` varbinary(255) NOT NULL,
  `site_data` blob NOT NULL,
  `site_forward` tinyint(1) NOT NULL,
  `site_config` blob NOT NULL,
  PRIMARY KEY (`site_id`),
  UNIQUE KEY `site_global_key` (`site_global_key`),
  KEY `site_type` (`site_type`),
  KEY `site_group` (`site_group`),
  KEY `site_source` (`site_source`),
  KEY `site_language` (`site_language`),
  KEY `site_protocol` (`site_protocol`),
  KEY `site_domain` (`site_domain`),
  KEY `site_forward` (`site_forward`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slot_roles`
--

DROP TABLE IF EXISTS `slot_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slot_roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varbinary(64) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slot_roles`
--

LOCK TABLES `slot_roles` WRITE;
/*!40000 ALTER TABLE `slot_roles` DISABLE KEYS */;
INSERT INTO `slot_roles` VALUES (1,'main');
/*!40000 ALTER TABLE `slot_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slots`
--

DROP TABLE IF EXISTS `slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slots` (
  `slot_revision_id` bigint(20) unsigned NOT NULL,
  `slot_role_id` smallint(5) unsigned NOT NULL,
  `slot_content_id` bigint(20) unsigned NOT NULL,
  `slot_origin` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`slot_revision_id`,`slot_role_id`),
  KEY `slot_revision_origin_role` (`slot_revision_id`,`slot_origin`,`slot_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slots`
--

LOCK TABLES `slots` WRITE;
/*!40000 ALTER TABLE `slots` DISABLE KEYS */;
INSERT INTO `slots` VALUES (1,1,1,1),(2,1,2,2),(3,1,3,3),(4,1,4,4);
/*!40000 ALTER TABLE `slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatelinks`
--

DROP TABLE IF EXISTS `templatelinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatelinks` (
  `tl_from` int(10) unsigned NOT NULL DEFAULT 0,
  `tl_namespace` int(11) NOT NULL DEFAULT 0,
  `tl_title` varbinary(255) NOT NULL DEFAULT '',
  `tl_from_namespace` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`tl_from`,`tl_namespace`,`tl_title`),
  KEY `tl_namespace` (`tl_namespace`,`tl_title`,`tl_from`),
  KEY `tl_backlinks_namespace` (`tl_from_namespace`,`tl_namespace`,`tl_title`,`tl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatelinks`
--

LOCK TABLES `templatelinks` WRITE;
/*!40000 ALTER TABLE `templatelinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatelinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `text`
--

DROP TABLE IF EXISTS `text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `text` (
  `old_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `old_text` mediumblob NOT NULL,
  `old_flags` tinyblob NOT NULL,
  PRIMARY KEY (`old_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `text`
--

LOCK TABLES `text` WRITE;
/*!40000 ALTER TABLE `text` DISABLE KEYS */;
INSERT INTO `text` VALUES (1,'<strong>MediaWiki has been installed.</strong>\n\nConsult the [https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Contents User\'s Guide] for information on using the wiki software.\n\n== Getting started ==\n* [https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Configuration_settings Configuration settings list]\n* [https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:FAQ MediaWiki FAQ]\n* [https://lists.wikimedia.org/postorius/lists/mediawiki-announce.lists.wikimedia.org/ MediaWiki release mailing list]\n* [https://www.mediawiki.org/wiki/Special:MyLanguage/Localisation#Translation_resources Localise MediaWiki for your language]\n* [https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Combating_spam Learn how to combat spam on your wiki]','utf-8'),(2,'','utf-8'),(3,'<strong>MediaWiki has been installed using [Dcycle Mediawiki Starterkit](http://github.com/dcycle/starterkit-mediawiki).</strong>\n\nConsult the [https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Contents User\'s Guide] for information on using the wiki software.\n\n== Getting started ==\n* [https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Configuration_settings Configuration settings list]\n* [https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:FAQ MediaWiki FAQ]\n* [https://lists.wikimedia.org/postorius/lists/mediawiki-announce.lists.wikimedia.org/ MediaWiki release mailing list]\n* [https://www.mediawiki.org/wiki/Special:MyLanguage/Localisation#Translation_resources Localise MediaWiki for your language]\n* [https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Combating_spam Learn how to combat spam on your wiki]','utf-8'),(4,'<strong>MediaWiki has been installed using [http://github.com/dcycle/starterkit-mediawiki Dcycle Mediawiki Starterkit].</strong>\n\nConsult the [https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Contents User\'s Guide] for information on using the wiki software.\n\n== Getting started ==\n* [https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Configuration_settings Configuration settings list]\n* [https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:FAQ MediaWiki FAQ]\n* [https://lists.wikimedia.org/postorius/lists/mediawiki-announce.lists.wikimedia.org/ MediaWiki release mailing list]\n* [https://www.mediawiki.org/wiki/Special:MyLanguage/Localisation#Translation_resources Localise MediaWiki for your language]\n* [https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Combating_spam Learn how to combat spam on your wiki]','utf-8');
/*!40000 ALTER TABLE `text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `updatelog`
--

DROP TABLE IF EXISTS `updatelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updatelog` (
  `ul_key` varbinary(255) NOT NULL,
  `ul_value` blob DEFAULT NULL,
  PRIMARY KEY (`ul_key`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `updatelog`
--

LOCK TABLES `updatelog` WRITE;
/*!40000 ALTER TABLE `updatelog` DISABLE KEYS */;
INSERT INTO `updatelog` VALUES ('PingBack','32e9c55a10ea44390f564cb4ad3a565d'),('Pingback-1.37.1','1643400074'),('filearchive-fa_major_mime-patch-fa_major_mime-chemical.sql',NULL),('image-img_major_mime-patch-img_major_mime-chemical.sql',NULL),('oldimage-oi_major_mime-patch-oi_major_mime-chemical.sql',NULL),('user_former_groups-ufg_group-patch-ufg_group-length-increase-255.sql',NULL),('user_groups-ug_group-patch-ug_group-length-increase-255.sql',NULL),('user_properties-up_property-patch-up_property.sql',NULL);
/*!40000 ALTER TABLE `updatelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uploadstash`
--

DROP TABLE IF EXISTS `uploadstash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uploadstash` (
  `us_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `us_user` int(10) unsigned NOT NULL,
  `us_key` varbinary(255) NOT NULL,
  `us_orig_path` varbinary(255) NOT NULL,
  `us_path` varbinary(255) NOT NULL,
  `us_source_type` varbinary(50) DEFAULT NULL,
  `us_timestamp` binary(14) NOT NULL,
  `us_status` varbinary(50) NOT NULL,
  `us_chunk_inx` int(10) unsigned DEFAULT NULL,
  `us_props` blob DEFAULT NULL,
  `us_size` int(10) unsigned NOT NULL,
  `us_sha1` varbinary(31) NOT NULL,
  `us_mime` varbinary(255) DEFAULT NULL,
  `us_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE','3D') DEFAULT NULL,
  `us_image_width` int(10) unsigned DEFAULT NULL,
  `us_image_height` int(10) unsigned DEFAULT NULL,
  `us_image_bits` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`us_id`),
  UNIQUE KEY `us_key` (`us_key`),
  KEY `us_user` (`us_user`),
  KEY `us_timestamp` (`us_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uploadstash`
--

LOCK TABLES `uploadstash` WRITE;
/*!40000 ALTER TABLE `uploadstash` DISABLE KEYS */;
/*!40000 ALTER TABLE `uploadstash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varbinary(255) NOT NULL DEFAULT '',
  `user_real_name` varbinary(255) NOT NULL DEFAULT '',
  `user_password` tinyblob NOT NULL,
  `user_newpassword` tinyblob NOT NULL,
  `user_newpass_time` binary(14) DEFAULT NULL,
  `user_email` tinyblob NOT NULL,
  `user_touched` binary(14) NOT NULL,
  `user_token` binary(32) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `user_email_authenticated` binary(14) DEFAULT NULL,
  `user_email_token` binary(32) DEFAULT NULL,
  `user_email_token_expires` binary(14) DEFAULT NULL,
  `user_registration` binary(14) DEFAULT NULL,
  `user_editcount` int(11) DEFAULT NULL,
  `user_password_expires` varbinary(14) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `user_email_token` (`user_email_token`),
  KEY `user_email` (`user_email`(50))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Admin','',':pbkdf2:sha512:30000:64:dcR26MB5PTwAtoYmnuk/Rg==:FkcL+c8qDdeek27vljw4mKIfwL2kNLgyty5R/iQdCSztnXwL21nS3Y8J3ENu6XnWCVfdall7h+wCLV0i7jwGkQ==','',NULL,'admin@example.com','20220128200045','dff656bc8f307c2b13c872e32cb246dd',NULL,NULL,NULL,'20220128200044',3,NULL),(2,'MediaWiki default','','','',NULL,'','20220128200044','*** INVALID ***\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,NULL,NULL,'20220128200044',0,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_former_groups`
--

DROP TABLE IF EXISTS `user_former_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_former_groups` (
  `ufg_user` int(10) unsigned NOT NULL DEFAULT 0,
  `ufg_group` varbinary(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`ufg_user`,`ufg_group`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_former_groups`
--

LOCK TABLES `user_former_groups` WRITE;
/*!40000 ALTER TABLE `user_former_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_former_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_groups`
--

DROP TABLE IF EXISTS `user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_groups` (
  `ug_user` int(10) unsigned NOT NULL DEFAULT 0,
  `ug_group` varbinary(255) NOT NULL DEFAULT '',
  `ug_expiry` varbinary(14) DEFAULT NULL,
  PRIMARY KEY (`ug_user`,`ug_group`),
  KEY `ug_group` (`ug_group`),
  KEY `ug_expiry` (`ug_expiry`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_groups`
--

LOCK TABLES `user_groups` WRITE;
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;
INSERT INTO `user_groups` VALUES (1,'bureaucrat',NULL),(1,'interface-admin',NULL),(1,'sysop',NULL);
/*!40000 ALTER TABLE `user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_newtalk`
--

DROP TABLE IF EXISTS `user_newtalk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_newtalk` (
  `user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `user_ip` varbinary(40) NOT NULL DEFAULT '',
  `user_last_timestamp` binary(14) DEFAULT NULL,
  KEY `un_user_id` (`user_id`),
  KEY `un_user_ip` (`user_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_newtalk`
--

LOCK TABLES `user_newtalk` WRITE;
/*!40000 ALTER TABLE `user_newtalk` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_newtalk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_properties`
--

DROP TABLE IF EXISTS `user_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_properties` (
  `up_user` int(10) unsigned NOT NULL,
  `up_property` varbinary(255) NOT NULL,
  `up_value` blob DEFAULT NULL,
  PRIMARY KEY (`up_user`,`up_property`),
  KEY `up_property` (`up_property`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_properties`
--

LOCK TABLES `user_properties` WRITE;
/*!40000 ALTER TABLE `user_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watchlist`
--

DROP TABLE IF EXISTS `watchlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchlist` (
  `wl_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `wl_user` int(10) unsigned NOT NULL,
  `wl_namespace` int(11) NOT NULL DEFAULT 0,
  `wl_title` varbinary(255) NOT NULL DEFAULT '',
  `wl_notificationtimestamp` binary(14) DEFAULT NULL,
  PRIMARY KEY (`wl_id`),
  UNIQUE KEY `wl_user` (`wl_user`,`wl_namespace`,`wl_title`),
  KEY `wl_namespace_title` (`wl_namespace`,`wl_title`),
  KEY `wl_user_notificationtimestamp` (`wl_user`,`wl_notificationtimestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watchlist`
--

LOCK TABLES `watchlist` WRITE;
/*!40000 ALTER TABLE `watchlist` DISABLE KEYS */;
INSERT INTO `watchlist` VALUES (1,1,6,'Badge_burn_badge.png',NULL),(2,1,7,'Badge_burn_badge.png',NULL),(3,1,0,'Main_Page',NULL),(4,1,1,'Main_Page',NULL);
/*!40000 ALTER TABLE `watchlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watchlist_expiry`
--

DROP TABLE IF EXISTS `watchlist_expiry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchlist_expiry` (
  `we_item` int(10) unsigned NOT NULL,
  `we_expiry` binary(14) NOT NULL,
  PRIMARY KEY (`we_item`),
  KEY `we_expiry` (`we_expiry`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watchlist_expiry`
--

LOCK TABLES `watchlist_expiry` WRITE;
/*!40000 ALTER TABLE `watchlist_expiry` DISABLE KEYS */;
/*!40000 ALTER TABLE `watchlist_expiry` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-28 20:05:27
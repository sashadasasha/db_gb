CREATE DATABASE `countries_cities` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
CREATE TABLE `country` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
CREATE TABLE `region` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `country_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`name`,`country_id`),
  KEY `fk_region_country_idx` (`country_id`),
  CONSTRAINT `fk_region_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
CREATE TABLE `district` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(127) NOT NULL,
  `region_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`name`,`region_id`),
  KEY `fk_region_district_idx` (`region_id`),
  CONSTRAINT `fk_region_district` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
CREATE TABLE `city` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `district_id` int unsigned NOT NULL,
  `type` enum('CITY','TOWN','VILLAGE') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`name`,`district_id`,`type`),
  KEY `fk_city_district_idx` (`district_id`),
  CONSTRAINT `fk_city_district` FOREIGN KEY (`district_id`) REFERENCES `district` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;



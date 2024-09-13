-- If you already have the old dealerships SQL don't need to run this

CREATE TABLE `dealership_stock` (
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`model` MEDIUMTEXT,
	`stock` INT(10) DEFAULT 0,
	`job` MEDIUMTEXT,
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `id` (`id`) USING BTREE
);

CREATE TABLE `dealership_sells` (
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`description` LONGTEXT,
	`job` MEDIUMTEXT,
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `id` (`id`) USING BTREE
);

CREATE TABLE `dealership_imports` (
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`description` LONGTEXT,
	`job` MEDIUMTEXT,
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `id` (`id`) USING BTREE
);

CREATE TABLE `dealership_showroom` (
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`vehicleID` LONGTEXT,
	`vehicle` MEDIUMTEXT,
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `id` (`id`) USING BTREE
);
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`ACTIVITY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ACTIVITY` (
  `ID_activity` CHAR(3) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID_activity`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`REGION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`REGION` (
  `id_region` CHAR(2) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `surface` INT NOT NULL,
  `inhabitants` INT NOT NULL,
  PRIMARY KEY (`id_region`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`HOLIDAY_CAMP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`HOLIDAY_CAMP` (
  `Reference` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `capacity` INT NOT NULL,
  `REGION_id_region` CHAR(2) NOT NULL,
  PRIMARY KEY (`Reference`),
  INDEX `fk_HOLIDAY_CAMP_REGION1_idx` (`REGION_id_region` ASC) VISIBLE,
  CONSTRAINT `fk_HOLIDAY_CAMP_REGION1`
    FOREIGN KEY (`REGION_id_region`)
    REFERENCES `mydb`.`REGION` (`id_region`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CHILDREN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CHILDREN` (
  `id_card` INT NOT NULL,
  `firstname` VARCHAR(30) NOT NULL,
  `lastname` VARCHAR(60) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `HOLIDAY_CAMP_Reference` INT NULL,
  `REGION_id_region` CHAR(2) NOT NULL,
  PRIMARY KEY (`id_card`),
  INDEX `fk_CHILDREN_HOLIDAY_CAMP1_idx` (`HOLIDAY_CAMP_Reference` ASC) VISIBLE,
  INDEX `fk_CHILDREN_REGION1_idx` (`REGION_id_region` ASC) VISIBLE,
  CONSTRAINT `fk_CHILDREN_HOLIDAY_CAMP1`
    FOREIGN KEY (`HOLIDAY_CAMP_Reference`)
    REFERENCES `mydb`.`HOLIDAY_CAMP` (`Reference`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CHILDREN_REGION1`
    FOREIGN KEY (`REGION_id_region`)
    REFERENCES `mydb`.`REGION` (`id_region`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ACTIVITY_has_HOLIDAY_CAMP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ACTIVITY_has_HOLIDAY_CAMP` (
  `ACTIVITY_idACTIVITY` CHAR(3) NOT NULL,
  `HOLIDAY_CAMP_idHOLIDAY_CAMP` INT NOT NULL,
  `level` INT NOT NULL,
  PRIMARY KEY (`ACTIVITY_idACTIVITY`, `HOLIDAY_CAMP_idHOLIDAY_CAMP`),
  INDEX `fk_ACTIVITY_has_HOLIDAY_CAMP_HOLIDAY_CAMP1_idx` (`HOLIDAY_CAMP_idHOLIDAY_CAMP` ASC) VISIBLE,
  INDEX `fk_ACTIVITY_has_HOLIDAY_CAMP_ACTIVITY_idx` (`ACTIVITY_idACTIVITY` ASC) VISIBLE,
  CONSTRAINT `fk_ACTIVITY_has_HOLIDAY_CAMP_ACTIVITY`
    FOREIGN KEY (`ACTIVITY_idACTIVITY`)
    REFERENCES `mydb`.`ACTIVITY` (`ID_activity`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ACTIVITY_has_HOLIDAY_CAMP_HOLIDAY_CAMP1`
    FOREIGN KEY (`HOLIDAY_CAMP_idHOLIDAY_CAMP`)
    REFERENCES `mydb`.`HOLIDAY_CAMP` (`Reference`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`ACTIVITY`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`ACTIVITY` (`ID_activity`, `name`) VALUES ('1OT', 'Outdoor');
INSERT INTO `mydb`.`ACTIVITY` (`ID_activity`, `name`) VALUES ('2ST', 'Stargazing');
INSERT INTO `mydb`.`ACTIVITY` (`ID_activity`, `name`) VALUES ('3TD', 'Tie-dying');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`REGION`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`REGION` (`id_region`, `name`, `surface`, `inhabitants`) VALUES ('1', 'k2', 86211, 91);
INSERT INTO `mydb`.`REGION` (`id_region`, `name`, `surface`, `inhabitants`) VALUES ('2', 'man island', 572, 75000);
INSERT INTO `mydb`.`REGION` (`id_region`, `name`, `surface`, `inhabitants`) VALUES ('3', 'nordschleife', 28300, 114052);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`HOLIDAY_CAMP`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`HOLIDAY_CAMP` (`Reference`, `name`, `capacity`, `REGION_id_region`) VALUES (1, 'Jesko', 25, '1');
INSERT INTO `mydb`.`HOLIDAY_CAMP` (`Reference`, `name`, `capacity`, `REGION_id_region`) VALUES (2, 'R1M', 30, '2');
INSERT INTO `mydb`.`HOLIDAY_CAMP` (`Reference`, `name`, `capacity`, `REGION_id_region`) VALUES (3, 'GP', 20, '2');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`CHILDREN`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`CHILDREN` (`id_card`, `firstname`, `lastname`, `phone`, `HOLIDAY_CAMP_Reference`, `REGION_id_region`) VALUES (11111111, 'Joan', 'Sanchez', '666777888', 2, '3');
INSERT INTO `mydb`.`CHILDREN` (`id_card`, `firstname`, `lastname`, `phone`, `HOLIDAY_CAMP_Reference`, `REGION_id_region`) VALUES (22222222, 'Marc', 'Sans', '222888555', 3, '3');
INSERT INTO `mydb`.`CHILDREN` (`id_card`, `firstname`, `lastname`, `phone`, `HOLIDAY_CAMP_Reference`, `REGION_id_region`) VALUES (33333333, 'Andreu', 'Garcia', '111222333', 2, '2');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`ACTIVITY_has_HOLIDAY_CAMP`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`ACTIVITY_has_HOLIDAY_CAMP` (`ACTIVITY_idACTIVITY`, `HOLIDAY_CAMP_idHOLIDAY_CAMP`, `level`) VALUES ('1OT', 2, 2);
INSERT INTO `mydb`.`ACTIVITY_has_HOLIDAY_CAMP` (`ACTIVITY_idACTIVITY`, `HOLIDAY_CAMP_idHOLIDAY_CAMP`, `level`) VALUES ('3TD', 1, 5);
INSERT INTO `mydb`.`ACTIVITY_has_HOLIDAY_CAMP` (`ACTIVITY_idACTIVITY`, `HOLIDAY_CAMP_idHOLIDAY_CAMP`, `level`) VALUES ('2ST', 3, 8);

COMMIT;


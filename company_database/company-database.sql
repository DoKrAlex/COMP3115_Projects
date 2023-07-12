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
-- Table `mydb`.`DEPARTMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DEPARTMENT` (
  `Dname` VARCHAR(25) NOT NULL,
  `Mgr_ssn` CHAR(9) NOT NULL,
  `Mgr_start_date` DATE NULL,
  `Dnumber` INT NOT NULL,
  `BookOrder` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Dnumber`),
  INDEX `fk_DEPARTMENT_EMPLOYEE1_idx` (`Mgr_ssn` ASC) VISIBLE,
  UNIQUE INDEX `BookOrder_UNIQUE` (`BookOrder` ASC) VISIBLE,
  CONSTRAINT `fk_DEPARTMENT_EMPLOYEE1`
    FOREIGN KEY (`Mgr_ssn`)
    REFERENCES `mydb`.`EMPLOYEE` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EMPLOYEE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EMPLOYEE` (
  `Fname` VARCHAR(15) NOT NULL,
  `Minit` CHAR NULL,
  `Lname` VARCHAR(15) NOT NULL,
  `Ssn` CHAR(9) NOT NULL,
  `Bdate` DATE NULL,
  `Address` VARCHAR(50) NULL,
  `Sex` CHAR NULL,
  `Salary` DECIMAL(10,2) NULL,
  `Super_ssn` CHAR(9) NULL,
  `Dno` INT NOT NULL,
  `BookOrder` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_EMPLOYEE_EMPLOYEE1_idx` (`Super_ssn` ASC, `Ssn` ASC) VISIBLE,
  INDEX `fk_EMPLOYEE_DEPARTMENT1_idx` (`Dno` ASC) VISIBLE,
  PRIMARY KEY (`Ssn`),
  UNIQUE INDEX `BookOrder_UNIQUE` (`BookOrder` ASC) VISIBLE,
  CONSTRAINT `fk_EMPLOYEE_EMPLOYEE1`
    FOREIGN KEY (`Super_ssn` , `Ssn`)
    REFERENCES `mydb`.`EMPLOYEE` (`Ssn` , `Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLOYEE_DEPARTMENT1`
    FOREIGN KEY (`Dno`)
    REFERENCES `mydb`.`DEPARTMENT` (`Dnumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DEPENDENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DEPENDENT` (
  `Essn` CHAR(9) NOT NULL,
  `Dependent_name` VARCHAR(15) NOT NULL,
  `Sex` CHAR NULL,
  `Bdate` DATE NULL,
  `Relationship` VARCHAR(8) NULL,
  `BookOrder` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Essn`, `Dependent_name`),
  UNIQUE INDEX `BookOrder_UNIQUE` (`BookOrder` ASC) VISIBLE,
  CONSTRAINT `fk_DEPENDENT_EMPLOYEE`
    FOREIGN KEY (`Essn`)
    REFERENCES `mydb`.`EMPLOYEE` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PROJECT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PROJECT` (
  `Pname` VARCHAR(25) NOT NULL,
  `Pnumber` INT NOT NULL,
  `Plocation` VARCHAR(15) NULL,
  `Dnum` INT NOT NULL,
  `BookOrder` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Pnumber`),
  INDEX `fk_PROJECT_DEPARTMENT1_idx` (`Dnum` ASC) VISIBLE,
  UNIQUE INDEX `BookOrder_UNIQUE` (`BookOrder` ASC) VISIBLE,
  CONSTRAINT `fk_PROJECT_DEPARTMENT1`
    FOREIGN KEY (`Dnum`)
    REFERENCES `mydb`.`DEPARTMENT` (`Dnumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`WORKS_ON`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`WORKS_ON` (
  `Essn` CHAR(9) NOT NULL,
  `Pno` INT NOT NULL,
  `Hours` DECIMAL(4,1) NULL,
  `BookOrder` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Essn`, `Pno`),
  INDEX `fk_WORKS_ON_PROJECT1_idx` (`Pno` ASC) VISIBLE,
  UNIQUE INDEX `BookOrder_UNIQUE` (`BookOrder` ASC) VISIBLE,
  CONSTRAINT `fk_WORKS_ON_EMPLOYEE1`
    FOREIGN KEY (`Essn`)
    REFERENCES `mydb`.`EMPLOYEE` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_WORKS_ON_PROJECT1`
    FOREIGN KEY (`Pno`)
    REFERENCES `mydb`.`PROJECT` (`Pnumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DEPT_LOCATIONS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DEPT_LOCATIONS` (
  `Dnumber` INT NOT NULL,
  `Dlocation` VARCHAR(15) NOT NULL,
  `BookOrder` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Dnumber`, `Dlocation`),
  UNIQUE INDEX `BookOrder_UNIQUE` (`BookOrder` ASC) VISIBLE,
  CONSTRAINT `fk_DEPT_LOCATIONS_DEPARTMENT1`
    FOREIGN KEY (`Dnumber`)
    REFERENCES `mydb`.`DEPARTMENT` (`Dnumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

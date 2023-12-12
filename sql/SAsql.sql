-- MySQL Script generated by MySQL Workbench
-- Mon Dec  4 10:15:42 2023
-- Model: New Model    Version: 1.0
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
-- Table `mydb`.`tbl_member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_member` (
  `mem_email` VARCHAR(100) NOT NULL,
  `mem_name` VARCHAR(45) NOT NULL,
  `mem_phone_num` VARCHAR(45) NOT NULL,
  `mem_type` VARCHAR(1) NOT NULL,
  `mem_photo` VARCHAR(100) NULL,
  UNIQUE INDEX `mem_email_UNIQUE` (`mem_email` ASC) VISIBLE,
  PRIMARY KEY (`mem_email`),
  UNIQUE INDEX `mem_phone_num_UNIQUE` (`mem_phone_num` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_mem_password`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_mem_password` (
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`email`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  CONSTRAINT `member_to_password_fk`
    FOREIGN KEY (`email`)
    REFERENCES `mydb`.`tbl_member` (`mem_email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_admin` (
  `admin_email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`admin_email`),
  UNIQUE INDEX `admin_email_UNIQUE` (`admin_email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_admin_password`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_admin_password` (
  `admin_email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(45) NULL,
  PRIMARY KEY (`admin_email`),
  UNIQUE INDEX `email_UNIQUE` (`admin_email` ASC) VISIBLE,
  CONSTRAINT `admin_admin_password_email`
    FOREIGN KEY (`admin_email`)
    REFERENCES `mydb`.`tbl_admin` (`admin_email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_shoppingCart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_shoppingCart` (
  `cart_id` INT NOT NULL AUTO_INCREMENT,
  `mem_email` VARCHAR(100) NOT NULL,
  `cart_elements` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`cart_id`),
  UNIQUE INDEX `cart_id_UNIQUE` (`cart_id` ASC) VISIBLE,
  INDEX `shoppinCart_member_mem_email_idx` (`mem_email` ASC) VISIBLE,
  CONSTRAINT `shoppinCart_member_mem_email`
    FOREIGN KEY (`mem_email`)
    REFERENCES `mydb`.`tbl_member` (`mem_email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_shppingCart_elements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_shppingCart_elements` (
  `cart_id` INT NOT NULL,
  `food_id` INT NOT NULL,
  `food_num` INT NOT NULL,
  PRIMARY KEY (`cart_id`, `food_id`),
  UNIQUE INDEX `cart_id_UNIQUE` (`cart_id` ASC) VISIBLE,
  UNIQUE INDEX `food_id_UNIQUE` (`food_id` ASC) VISIBLE,
  CONSTRAINT `shoppingCart_elements_shoppingCart_cart_id`
    FOREIGN KEY (`cart_id`)
    REFERENCES `mydb`.`tbl_shoppingCart` (`cart_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_ratings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_ratings` (
  `mem_email` VARCHAR(100) NOT NULL,
  `ratings_star` INT NOT NULL,
  `ratings_content` VARCHAR(250) NULL,
  `ratings_rest_id` INT NOT NULL,
  PRIMARY KEY (`mem_email`),
  UNIQUE INDEX `mem_email_UNIQUE` (`mem_email` ASC) VISIBLE,
  CONSTRAINT `ratings_member_mem_email`
    FOREIGN KEY (`mem_email`)
    REFERENCES `mydb`.`tbl_member` (`mem_email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_restaurant` (
  `rest_id` INT NOT NULL,
  `rest_name` VARCHAR(45) NOT NULL,
  `rest_location` VARCHAR(45) NOT NULL,
  `rest_price` VARCHAR(45) NOT NULL,
  `rest_openTime` VARCHAR(45) NOT NULL,
  `rest_close_time` VARCHAR(45) NOT NULL,
  `rest_food_type` VARCHAR(45) NOT NULL,
  `rest_diet_constraint` VARCHAR(45) NOT NULL,
  `rest_ratings` FLOAT NOT NULL,
  `rest_photo` VARCHAR(100) NULL,
  `mem_email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`rest_id`),
  UNIQUE INDEX `mem_email_UNIQUE` (`rest_id` ASC) VISIBLE,
  INDEX `restaurant_member_mem_email_idx` (`mem_email` ASC) VISIBLE,
  CONSTRAINT `restaurant_member_mem_email`
    FOREIGN KEY (`mem_email`)
    REFERENCES `mydb`.`tbl_member` (`mem_email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_menu` (
  `rest_id` INT NOT NULL,
  `menu_food_id` INT NOT NULL AUTO_INCREMENT,
  `menu_food_name` VARCHAR(45) NOT NULL,
  `menu_food_price` INT NOT NULL,
  `menu_food_photo` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`menu_food_id`),
  UNIQUE INDEX `menu_foodId_UNIQUE` (`menu_food_id` ASC) VISIBLE,
  CONSTRAINT `restaurant_menu_rest_id`
    FOREIGN KEY (`rest_id`)
    REFERENCES `mydb`.`tbl_restaurant` (`rest_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_favorite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_favorite` (
  `mem_email` VARCHAR(100) NOT NULL,
  `rest_id` INT NOT NULL,
  INDEX `favorite_restaurant_rest_id_idx` (`rest_id` ASC) VISIBLE,
  UNIQUE INDEX `mem_email_UNIQUE` (`mem_email` ASC) VISIBLE,
  CONSTRAINT `favorite_member_mem_email`
    FOREIGN KEY (`mem_email`)
    REFERENCES `mydb`.`tbl_member` (`mem_email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `favorite_restaurant_rest_id`
    FOREIGN KEY (`rest_id`)
    REFERENCES `mydb`.`tbl_restaurant` (`rest_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_order` (
  `order_id` INT NOT NULL,
  `order_food` VARCHAR(45) NOT NULL,
  `order_food_num` INT NOT NULL,
  `order_food_pricce` INT NOT NULL,
  `order_total_price` INT NOT NULL,
  `order_date_time` DATETIME NOT NULL,
  `mem_email` VARCHAR(100) NOT NULL,
  `rest_id` INT NOT NULL,
  `menu_food_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `order_food`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  INDEX `order_member_mem_email_idx` (`mem_email` ASC) VISIBLE,
  INDEX `order_restaurant_rest_id_idx` (`rest_id` ASC) VISIBLE,
  INDEX `orser_menu_food_id_idx` (`menu_food_id` ASC) VISIBLE,
  CONSTRAINT `order_member_mem_email`
    FOREIGN KEY (`mem_email`)
    REFERENCES `mydb`.`tbl_member` (`mem_email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order_restaurant_rest_id`
    FOREIGN KEY (`rest_id`)
    REFERENCES `mydb`.`tbl_restaurant` (`rest_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orser_menu_menu_food_id`
    FOREIGN KEY (`menu_food_id`)
    REFERENCES `mydb`.`tbl_menu` (`menu_food_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

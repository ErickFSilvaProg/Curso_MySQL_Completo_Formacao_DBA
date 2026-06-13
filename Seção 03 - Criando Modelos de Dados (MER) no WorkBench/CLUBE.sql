-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema CLUBE
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CLUBE
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CLUBE` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `CLUBE` ;

-- -----------------------------------------------------
-- Table `CLUBE`.`TipoSocio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLUBE`.`TipoSocio` (
  `idTipoSocio` INT NOT NULL AUTO_INCREMENT,
  `tipoSocio` ENUM('proprietario', 'dependente') NOT NULL,
  PRIMARY KEY (`idTipoSocio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CLUBE`.`TipoDependencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLUBE`.`TipoDependencia` (
  `idTipoDependencia` INT NOT NULL AUTO_INCREMENT,
  `tipoDependencia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoDependencia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CLUBE`.`Socio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLUBE`.`Socio` (
  `idSocio` INT NOT NULL AUTO_INCREMENT,
  `matricula` VARCHAR(10) NOT NULL,
  `nome` VARCHAR(30) NOT NULL,
  `sobrenome` VARCHAR(40) NOT NULL,
  `dataNascimento` DATE NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `id_TipoSocio` INT NOT NULL,
  `id_Socio` INT NOT NULL,
  `id_TipoDependencia` INT NOT NULL,
  PRIMARY KEY (`idSocio`),
  UNIQUE INDEX `matricula_UNIQUE` (`matricula` ASC) VISIBLE,
  INDEX `fk_Socio_TipoSocio_idx` (`id_TipoSocio` ASC) VISIBLE,
  INDEX `fk_Socio_Socio_idx` (`id_Socio` ASC) VISIBLE,
  INDEX `fk_Socio_TipoDependencia_idx` (`id_TipoDependencia` ASC) VISIBLE,
  CONSTRAINT `fk_Socio_TipoSocio`
    FOREIGN KEY (`id_TipoSocio`)
    REFERENCES `CLUBE`.`TipoSocio` (`idTipoSocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Socio_Socio`
    FOREIGN KEY (`id_Socio`)
    REFERENCES `CLUBE`.`Socio` (`idSocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Socio_TipoDependencia`
    FOREIGN KEY (`id_TipoDependencia`)
    REFERENCES `CLUBE`.`TipoDependencia` (`idTipoDependencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CLUBE`.`TipoContato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLUBE`.`TipoContato` (
  `idTipoContato` INT NOT NULL AUTO_INCREMENT,
  `tipoContato` ENUM('telefone', 'email') NOT NULL,
  PRIMARY KEY (`idTipoContato`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CLUBE`.`Contato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLUBE`.`Contato` (
  `idContato` INT NOT NULL AUTO_INCREMENT,
  `contato` VARCHAR(50) NOT NULL,
  `id_Socio` INT NOT NULL,
  `id_TipoContato` INT NOT NULL,
  PRIMARY KEY (`idContato`),
  INDEX `fk_Contato_Socio_idx` (`id_Socio` ASC) INVISIBLE,
  INDEX `fk_Contato_TipoContato_idx` (`id_TipoContato` ASC) VISIBLE,
  CONSTRAINT `fk_Contato_Socio`
    FOREIGN KEY (`id_Socio`)
    REFERENCES `CLUBE`.`Socio` (`idSocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contato_TipoContato`
    FOREIGN KEY (`id_TipoContato`)
    REFERENCES `CLUBE`.`TipoContato` (`idTipoContato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CLUBE`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLUBE`.`Endereco` (
  `idEndereco` INT NOT NULL AUTO_INCREMENT,
  `rua` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(6) NULL DEFAULT 's/n',
  `bairro` VARCHAR(45) NOT NULL,
  `cep` VARCHAR(8) NOT NULL,
  `municipio` VARCHAR(45) NOT NULL,
  `uf` CHAR(2) NOT NULL,
  `pais` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`idEndereco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CLUBE`.`TipoEndereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLUBE`.`TipoEndereco` (
  `idTipoEndereco` INT NOT NULL AUTO_INCREMENT,
  `tipoEndereco` ENUM('casa', 'apartamento') NOT NULL DEFAULT 'casa',
  `complemento` VARCHAR(30) NULL,
  `Endereco_idEndereco` INT NOT NULL,
  PRIMARY KEY (`idTipoEndereco`),
  INDEX `fk_TipoEndereco_Endereco1_idx` (`Endereco_idEndereco` ASC) VISIBLE,
  CONSTRAINT `fk_TipoEndereco_Endereco1`
    FOREIGN KEY (`Endereco_idEndereco`)
    REFERENCES `CLUBE`.`Endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CLUBE`.`Socio_Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLUBE`.`Socio_Endereco` (
  `idSocio` INT NOT NULL,
  `idEndereco` INT NOT NULL,
  `enderecoPrincipal` VARCHAR(1) NULL,
  PRIMARY KEY (`idSocio`, `idEndereco`),
  INDEX `fk_Socio_Endereco_Endereco_idx` (`idEndereco` ASC) INVISIBLE,
  CONSTRAINT `fk_Socio_Endereco_Socio`
    FOREIGN KEY (`idSocio`)
    REFERENCES `CLUBE`.`Socio` (`idSocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Socio_Endereco_Endereco`
    FOREIGN KEY (`idEndereco`)
    REFERENCES `CLUBE`.`Endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CLUBE`.`tipoPagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLUBE`.`tipoPagamento` (
  `idTipoPagamento` INT NOT NULL AUTO_INCREMENT,
  `tipoPagamento` ENUM('dinheiro', 'cartão', 'pix', 'cheque') NOT NULL DEFAULT 'cartão',
  PRIMARY KEY (`idTipoPagamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CLUBE`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLUBE`.`Pagamento` (
  `idPagamento` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `valor` DECIMAL(6,2) NOT NULL,
  `id_Socio` INT NOT NULL,
  `tipoPagamento_idTipoPagamento` INT NOT NULL,
  PRIMARY KEY (`idPagamento`),
  INDEX `fk_Pagamento_Socio_idx` (`id_Socio` ASC) VISIBLE,
  INDEX `fk_Pagamento_tipoPagamento1_idx` (`tipoPagamento_idTipoPagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_Socio`
    FOREIGN KEY (`id_Socio`)
    REFERENCES `CLUBE`.`Socio` (`idSocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pagamento_tipoPagamento1`
    FOREIGN KEY (`tipoPagamento_idTipoPagamento`)
    REFERENCES `CLUBE`.`tipoPagamento` (`idTipoPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

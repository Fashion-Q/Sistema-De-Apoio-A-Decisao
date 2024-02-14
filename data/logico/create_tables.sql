-- MySQL Workbench Synchronization
-- Generated: 2024-01-21 21:28
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: profe

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `hawkmart` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `hawkmart`.`avaliacao` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'O valor \'0\' significa que a pessoa não quis avaliar.',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`categoria` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `codigo` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `index_categoria` (`nome` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`cliente` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(120) NOT NULL,
  `cpf` VARCHAR(12) NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `cep` VARCHAR(8) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  `cidade` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `index_cliente` (`nome` ASC, `estado` ASC, `cidade` ASC, `cpf` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`estoque` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `produto_id` INT(11) NOT NULL,
  `loja_id` INT(11) NOT NULL,
  `quantidadeEstoque` INT(11) NOT NULL,
  `quantidadeVendida` INT(11) NOT NULL DEFAULT '0',
  `reajustes` INT(11) NOT NULL DEFAULT '0',
  `data` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_estoque_produto1_idx` (`produto_id` ASC),
  INDEX `fk_estoque_loja1_idx` (`loja_id` ASC),
  CONSTRAINT `fk_estoque_loja1`
    FOREIGN KEY (`loja_id`)
    REFERENCES `hawkmart`.`loja` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estoque_produto1`
    FOREIGN KEY (`produto_id`)
    REFERENCES `hawkmart`.`produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`loja` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `cnpj` VARCHAR(14) NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `cep` VARCHAR(8) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  `cidade` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `index_loja` (`nome` ASC, `estado` ASC, `cidade` ASC, `cnpj` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`pagamento` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `pagamento` ENUM('DEBITO', 'CREDITO', 'PIX', 'BOLETO') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`produto` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `codigo` INT(11) NOT NULL,
  `id_subcategoria` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `index_produto` (`nome` ASC),
  INDEX `fk_dim_produto_dim_subcategoria1_idx` (`id_subcategoria` ASC),
  CONSTRAINT `fk_dim_produto_dim_subcategoria1`
    FOREIGN KEY (`id_subcategoria`)
    REFERENCES `hawkmart`.`subcategoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`produtovenda` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `codigo` INT(11) NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `desconto` DECIMAL(3,2) NOT NULL DEFAULT '1.00' COMMENT 'Para dar desconto de 15%, multiplique por 0,85. Se não tem desconto, o valor padrão permanecerá 1',
  `acao` ENUM('VENDIDO', 'DEVOLVIDO') NOT NULL DEFAULT 'VENDIDO',
  `Venda_id` INT(11) NOT NULL,
  `estoque_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_produtovenda_Venda1_idx` (`Venda_id` ASC),
  INDEX `fk_produtovenda_estoque1_idx` (`estoque_id` ASC),
  CONSTRAINT `fk_produtovenda_Venda1`
    FOREIGN KEY (`Venda_id`)
    REFERENCES `hawkmart`.`venda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produtovenda_estoque1`
    FOREIGN KEY (`estoque_id`)
    REFERENCES `hawkmart`.`estoque` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`status` (
  `id` INT(11) NOT NULL,
  `status` ENUM('AGUARDANDO PAGAMENTO', 'PAGAMENTO EFETUADO', 'PRODUTO EM ANDAMENTO', 'PRODUTO ENTREGUE', 'CANCELADO') NOT NULL DEFAULT 'AGUARDANDO PAGAMENTO',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`subcategoria` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `codigo` INT(11) NOT NULL,
  `id_categoria` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_dim_subcategoria_dim_categoria1_idx` (`id_categoria` ASC),
  INDEX `index_subcategoria` (`nome` ASC),
  CONSTRAINT `fk_dim_subcategoria_dim_categoria1`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `hawkmart`.`categoria` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`venda` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` INT(11) NOT NULL,
  `avaliacao_id` INT(11) NOT NULL,
  `pagamento_id` INT(11) NOT NULL,
  `status_id` INT(11) NOT NULL,
  `data` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_Venda_cliente1_idx` (`cliente_id` ASC),
  INDEX `fk_Venda_avaliacao1_idx` (`avaliacao_id` ASC),
  INDEX `fk_Venda_pagamento1_idx` (`pagamento_id` ASC),
  INDEX `fk_Venda_status1_idx` (`status_id` ASC),
  CONSTRAINT `fk_Venda_avaliacao1`
    FOREIGN KEY (`avaliacao_id`)
    REFERENCES `hawkmart`.`avaliacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `hawkmart`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_pagamento1`
    FOREIGN KEY (`pagamento_id`)
    REFERENCES `hawkmart`.`pagamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `hawkmart`.`status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COMMENT = '	';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

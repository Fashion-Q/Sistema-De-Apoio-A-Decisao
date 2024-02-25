-- MySQL Workbench Synchronization
-- Generated: 2024-02-25 10:55
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: profe

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `hawkmart` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `hawkmart`.`dim_categoria` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `codigo` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `index_categoria` (`nome` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`dim_cliente` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(120) NOT NULL,
  `cpf` VARCHAR(12) NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `cep` VARCHAR(8) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  `cidade` VARCHAR(80) NOT NULL,
  `sexo` ENUM("M", "F") NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `index_cliente` (`nome` ASC, `estado` ASC, `cidade` ASC, `cpf` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`fato_estoque` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `produto_id` INT(11) NOT NULL,
  `loja_id` INT(11) NOT NULL,
  `data_inserido` INT(11) NOT NULL,
  `data_validade` INT(11) NOT NULL,
  `categoria_id` INT(11) NOT NULL,
  `subcategoria_id` INT(11) NOT NULL,
  `quantidadeEstoque` INT(11) NOT NULL,
  `quantidadeVendida` INT(11) NOT NULL DEFAULT '0',
  `reajustes` INT(11) NOT NULL DEFAULT '0',
  `valor` DECIMAL(10,2) NOT NULL,
  `nome` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_estoque_produto1_idx` (`produto_id` ASC),
  INDEX `fk_estoque_loja1_idx` (`loja_id` ASC),
  INDEX `fk_fato_estoque_dim_tempo1_idx` (`data_inserido` ASC),
  INDEX `fk_fato_estoque_dim_tempo2_idx` (`data_validade` ASC),
  INDEX `fk_fato_estoque_dim_categoria1_idx` (`categoria_id` ASC),
  INDEX `fk_fato_estoque_dim_subcategoria1_idx` (`subcategoria_id` ASC),
  CONSTRAINT `fk_estoque_loja1`
    FOREIGN KEY (`loja_id`)
    REFERENCES `hawkmart`.`dim_loja` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estoque_produto1`
    FOREIGN KEY (`produto_id`)
    REFERENCES `hawkmart`.`dim_produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_estoque_dim_tempo1`
    FOREIGN KEY (`data_inserido`)
    REFERENCES `hawkmart`.`dim_tempo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_estoque_dim_tempo2`
    FOREIGN KEY (`data_validade`)
    REFERENCES `hawkmart`.`dim_tempo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_estoque_dim_categoria1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `hawkmart`.`dim_categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_estoque_dim_subcategoria1`
    FOREIGN KEY (`subcategoria_id`)
    REFERENCES `hawkmart`.`dim_subcategoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`dim_loja` (
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

CREATE TABLE IF NOT EXISTS `hawkmart`.`dim_pagamento` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `pagamento` ENUM('DEBITO', 'CREDITO', 'PIX', 'BOLETO') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`dim_produto` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `codigo` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `index_produto` (`nome` ASC, `codigo` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`dim_produtovenda` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `Venda_id` INT(11) NOT NULL,
  `estoque_id` INT(11) NOT NULL,
  `codigo` INT(11) NOT NULL,
  `desconto` DECIMAL(3,2) NOT NULL DEFAULT '1.00' COMMENT 'Para dar desconto de 15%, multiplique por 0,85. Se não tem desconto, o valor padrão permanecerá 1',
  `acao` ENUM('VENDIDO', 'DEVOLVIDO') NOT NULL DEFAULT 'VENDIDO',
  `nome_produto` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_produtovenda_Venda1_idx` (`Venda_id` ASC),
  INDEX `fk_produtovenda_estoque1_idx` (`estoque_id` ASC),
  CONSTRAINT `fk_produtovenda_Venda1`
    FOREIGN KEY (`Venda_id`)
    REFERENCES `hawkmart`.`fato_venda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produtovenda_estoque1`
    FOREIGN KEY (`estoque_id`)
    REFERENCES `hawkmart`.`fato_estoque` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`dim_status` (
  `id` INT(11) NOT NULL,
  `status` ENUM('AGUARDANDO PAGAMENTO', 'PAGAMENTO EFETUADO', 'PRODUTO EM ANDAMENTO', 'PRODUTO ENTREGUE', 'CANCELADO') NOT NULL DEFAULT 'AGUARDANDO PAGAMENTO',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`dim_subcategoria` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `codigo` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `index_subcategoria` (`nome` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `hawkmart`.`fato_venda` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `data_aguardando_pagamento` INT(11) NOT NULL,
  `data_pagamento_efetuado` INT(11) NULL DEFAULT NULL,
  `data_produto_em_andamento` INT(11) NULL DEFAULT NULL,
  `data_produto_entregue` INT(11) NULL DEFAULT NULL,
  `data_cancelado` INT(11) NULL DEFAULT NULL,
  `cliente_id` INT(11) NOT NULL,
  `pagamento_id` INT(11) NOT NULL,
  `status_id` INT(11) NOT NULL,
  `loja_id` INT(11) NOT NULL,
  `estoque_id` INT(11) NOT NULL,
  `subcategoria_id` INT(11) NOT NULL,
  `categoria_id` INT(11) NOT NULL,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `descricao_loja` VARCHAR(100) NULL DEFAULT NULL,
  `count` INT(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_Venda_cliente1_idx` (`cliente_id` ASC),
  INDEX `fk_Venda_pagamento1_idx` (`pagamento_id` ASC),
  INDEX `fk_Venda_status1_idx` (`status_id` ASC),
  INDEX `fk_fato_venda_dim_tempo1_idx` (`data_aguardando_pagamento` ASC),
  INDEX `fk_fato_venda_dim_tempo2_idx` (`data_pagamento_efetuado` ASC),
  INDEX `fk_fato_venda_dim_tempo3_idx` (`data_produto_em_andamento` ASC),
  INDEX `fk_fato_venda_dim_tempo4_idx` (`data_produto_entregue` ASC),
  INDEX `fk_fato_venda_dim_tempo5_idx` (`data_cancelado` ASC),
  INDEX `fk_fato_venda_dim_loja1_idx` (`loja_id` ASC),
  INDEX `fk_fato_venda_fato_estoque1_idx` (`estoque_id` ASC),
  INDEX `fk_fato_venda_dim_subcategoria1_idx` (`subcategoria_id` ASC),
  INDEX `fk_fato_venda_dim_categoria1_idx` (`categoria_id` ASC),
  CONSTRAINT `fk_Venda_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `hawkmart`.`dim_cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_pagamento1`
    FOREIGN KEY (`pagamento_id`)
    REFERENCES `hawkmart`.`dim_pagamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `hawkmart`.`dim_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_venda_dim_tempo1`
    FOREIGN KEY (`data_aguardando_pagamento`)
    REFERENCES `hawkmart`.`dim_tempo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_venda_dim_tempo2`
    FOREIGN KEY (`data_pagamento_efetuado`)
    REFERENCES `hawkmart`.`dim_tempo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_venda_dim_tempo3`
    FOREIGN KEY (`data_produto_em_andamento`)
    REFERENCES `hawkmart`.`dim_tempo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_venda_dim_tempo4`
    FOREIGN KEY (`data_produto_entregue`)
    REFERENCES `hawkmart`.`dim_tempo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_venda_dim_tempo5`
    FOREIGN KEY (`data_cancelado`)
    REFERENCES `hawkmart`.`dim_tempo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_venda_dim_loja1`
    FOREIGN KEY (`loja_id`)
    REFERENCES `hawkmart`.`dim_loja` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_venda_fato_estoque1`
    FOREIGN KEY (`estoque_id`)
    REFERENCES `hawkmart`.`fato_estoque` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_venda_dim_subcategoria1`
    FOREIGN KEY (`subcategoria_id`)
    REFERENCES `hawkmart`.`dim_subcategoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_venda_dim_categoria1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `hawkmart`.`dim_categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COMMENT = '	';

CREATE TABLE IF NOT EXISTS `hawkmart`.`dim_tempo` (
  `id` INT(11) NOT NULL,
  `dia` INT(11) NOT NULL,
  `mes` INT(11) NOT NULL,
  `ano` INT(11) NOT NULL,
  `semestre` INT(11) NOT NULL,
  `trimestre` INT(11) NOT NULL,
  `data` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

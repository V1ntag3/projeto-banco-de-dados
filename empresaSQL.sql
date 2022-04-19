-- MySQL Script generated by MySQL Workbench
-- Thu Nov 11 22:24:29 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema empresa
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema empresa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `empresa` DEFAULT CHARACTER SET utf8 ;
USE `empresa` ;

-- -----------------------------------------------------
-- Table `empresa`.`empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`empresa` (
  `cnpj` BIGINT NOT NULL,
  PRIMARY KEY (`cnpj`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`funcionario` (
  `cpf` BIGINT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `dataEntradaNaEmpresa` DATETIME NOT NULL,
  `salario` DOUBLE NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `dataUltimoPagamento` VARCHAR(45) NOT NULL,
  `cargo` VARCHAR(45) NOT NULL,
  `empresa_cnpj` BIGINT NOT NULL,
  PRIMARY KEY (`cpf`),
  INDEX `fk_funcionarios_empresa1_idx` (`empresa_cnpj` ASC) VISIBLE,
  CONSTRAINT `fk_funcionarios_empresa1`
    FOREIGN KEY (`empresa_cnpj`)
    REFERENCES `empresa`.`empresa` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`cliente` (
  `cpf` BIGINT NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`cpf`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`pedidoAVista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`pedidoAVista` (
  `idpedidoAVista` INT NOT NULL,
  `valor` DOUBLE NOT NULL,
  `data` DATE NOT NULL,
  `empresa_cnpj` BIGINT NOT NULL,
  `cliente_cpf` BIGINT NOT NULL,
  PRIMARY KEY (`idpedidoAVista`),
  INDEX `fk_pedidoAVista_empresa1_idx` (`empresa_cnpj` ASC) VISIBLE,
  INDEX `fk_pedidoAVista_cliente1_idx` (`cliente_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_pedidoAVista_empresa1`
    FOREIGN KEY (`empresa_cnpj`)
    REFERENCES `empresa`.`empresa` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidoAVista_cliente1`
    FOREIGN KEY (`cliente_cpf`)
    REFERENCES `empresa`.`cliente` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`pedidoAPrazo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`pedidoAPrazo` (
  `idpedidoAPrazo` INT NOT NULL,
  `parcelas` INT NOT NULL,
  `valor` DOUBLE NOT NULL,
  `data` DATE NOT NULL,
  `empresa_cnpj` BIGINT NOT NULL,
  `cliente_cpf` BIGINT NOT NULL,
  PRIMARY KEY (`idpedidoAPrazo`),
  INDEX `fk_pedidoAPrazo_empresa1_idx` (`empresa_cnpj` ASC) VISIBLE,
  INDEX `fk_pedidoAPrazo_cliente1_idx` (`cliente_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_pedidoAPrazo_empresa1`
    FOREIGN KEY (`empresa_cnpj`)
    REFERENCES `empresa`.`empresa` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidoAPrazo_cliente1`
    FOREIGN KEY (`cliente_cpf`)
    REFERENCES `empresa`.`cliente` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`fornecedor` (
  `cnpj` BIGINT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cnpj`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`produto` (
  `idproduto` INT NOT NULL,
  `valor` DOUBLE NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `fornecedor_cnpj` BIGINT NOT NULL,
  PRIMARY KEY (`idproduto`),
  INDEX `fk_produto_fornecedor1_idx` (`fornecedor_cnpj` ASC) VISIBLE,
  CONSTRAINT `fk_produto_fornecedor1`
    FOREIGN KEY (`fornecedor_cnpj`)
    REFERENCES `empresa`.`fornecedor` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`pontoBatido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`pontoBatido` (
  `funcionario_cpf` BIGINT NOT NULL,
  `data` DATE NOT NULL,
  `horario` TIME NOT NULL,
  `observacao` VARCHAR(100) NULL,
  INDEX `fk_pontoBatido_funcionarios1_idx` (`funcionario_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_pontoBatido_funcionarios1`
    FOREIGN KEY (`funcionario_cpf`)
    REFERENCES `empresa`.`funcionario` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`parcelaPaga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`parcelaPaga` (
  `idparcelaspagas` INT NOT NULL,
  `valorpago` VARCHAR(45) NOT NULL,
  `data` DATE NOT NULL,
  `pedidoAPrazo_idpedidoAPrazo` INT NOT NULL,
  PRIMARY KEY (`idparcelaspagas`),
  INDEX `fk_table1_pedidoAPrazo1_idx` (`pedidoAPrazo_idpedidoAPrazo` ASC) VISIBLE,
  CONSTRAINT `fk_table1_pedidoAPrazo1`
    FOREIGN KEY (`pedidoAPrazo_idpedidoAPrazo`)
    REFERENCES `empresa`.`pedidoAPrazo` (`idpedidoAPrazo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`produto_has_pedidoAVista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`produto_has_pedidoAVista` (
  `produto_idproduto` INT NOT NULL,
  `pedidoAVista_idpedidoAVista` INT NOT NULL,
  `quantidade` INT NOT NULL,
  PRIMARY KEY (`produto_idproduto`, `pedidoAVista_idpedidoAVista`),
  INDEX `fk_produto_has_pedidoAVista_pedidoAVista1_idx` (`pedidoAVista_idpedidoAVista` ASC) VISIBLE,
  INDEX `fk_produto_has_pedidoAVista_produto1_idx` (`produto_idproduto` ASC) VISIBLE,
  CONSTRAINT `fk_produto_has_pedidoAVista_produto1`
    FOREIGN KEY (`produto_idproduto`)
    REFERENCES `empresa`.`produto` (`idproduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_has_pedidoAVista_pedidoAVista1`
    FOREIGN KEY (`pedidoAVista_idpedidoAVista`)
    REFERENCES `empresa`.`pedidoAVista` (`idpedidoAVista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`produto_has_pedidoAPrazo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`produto_has_pedidoAPrazo` (
  `produto_idproduto` INT NOT NULL,
  `pedidoAPrazo_idpedidoAPrazo` INT NOT NULL,
  `quantidade` INT NOT NULL,
  PRIMARY KEY (`produto_idproduto`, `pedidoAPrazo_idpedidoAPrazo`),
  INDEX `fk_produto_has_pedidoAPrazo_pedidoAPrazo1_idx` (`pedidoAPrazo_idpedidoAPrazo` ASC) VISIBLE,
  INDEX `fk_produto_has_pedidoAPrazo_produto1_idx` (`produto_idproduto` ASC) VISIBLE,
  CONSTRAINT `fk_produto_has_pedidoAPrazo_produto1`
    FOREIGN KEY (`produto_idproduto`)
    REFERENCES `empresa`.`produto` (`idproduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_has_pedidoAPrazo_pedidoAPrazo1`
    FOREIGN KEY (`pedidoAPrazo_idpedidoAPrazo`)
    REFERENCES `empresa`.`pedidoAPrazo` (`idpedidoAPrazo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
INSERT INTO empresa (cnpj) values (17);
INSERT INTO fornecedor (cnpj, nome, telefone, email, endereco) VALUES (2, 'Rosa dos Ventos Distribuidora', '9234141012', 'rosadosventosdistruibuidora@gmail.com','Quadra 40 São Paulo - SP');
INSERT INTO fornecedor (cnpj, nome, telefone, email, endereco) VALUES (3, 'Azul Distribuidora', '93458141012', 'azuldistruibuidora@gmail.com','Quadra 40 São Paulo - SP');
INSERT INTO fornecedor (cnpj, nome, telefone, email, endereco) VALUES (4, 'ANC Distribuidora', '9985145682', 'ancdistruibuidora@gmail.com','Quadra 40 São Paulo - SP');
INSERT INTO fornecedor (cnpj, nome, telefone, email, endereco) VALUES (5, 'ABC Distribuidora', '999781012', 'abcdistruibuidora@gmail.com','Quadra 40 São Paulo - SP');
INSERT INTO fornecedor (cnpj, nome, telefone, email, endereco) VALUES (6, 'Caxias Distribuidora', '2436741012', 'caxiasdistruibuidora@gmail.com','Quadra 40 São Paulo – SP');
INSERT INTO fornecedor (cnpj, nome, telefone, email, endereco) VALUES (1, 'Cabral Distribuidora', '9985141012', 'cabraldistruibuidora@gmail.com','Quadra 40 São Paulo – SP');
INSERT INTO produto (idproduto, valor, nome, descricao, fornecedor_cnpj) VALUES (8, 15.5, 'Creme Capilar', 'Creme para cabelo',1);
INSERT INTO produto (idproduto, valor, nome, descricao, fornecedor_cnpj) VALUES (9, 112.70, 'Papel A4', 'Papel gramatura 90g/m2',2);
INSERT INTO produto (idproduto, valor, nome, descricao, fornecedor_cnpj) VALUES (10, 11.5, 'Caneta Bic', 'Caneta preta
 Bic',3);
INSERT INTO produto (idproduto, valor, nome, descricao, fornecedor_cnpj) VALUES (11, 113.5, 'Pasta A4', 'Pasta para pepale A4',4);
INSERT INTO produto (idproduto, valor, nome, descricao, fornecedor_cnpj) VALUES (12, 4.15, 'Grampeador', 'Grampeador grampo 106/8',5);
INSERT INTO produto (idproduto, valor, nome, descricao, fornecedor_cnpj) VALUES (13, 142.5, 'Caixa de Papelão', 'Caixa de Papelao 23x35x12',6);
INSERT INTO produto (idproduto, valor, nome, descricao, fornecedor_cnpj) VALUES (7, 15, 'Shampoo Capilar', 'Shampoo para cabelo',1);
INSERT INTO cliente (cpf, telefone, nome, endereco, email) VALUES (14, '2342342341', 'Marcos Vinicius Ribeiro Alencar', 'Quandra 10, Parque Piaui, Teresina - PI','marcus1302@gmail.com');
INSERT INTO cliente (cpf, telefone, nome, endereco, email) VALUES (15, '3492830441', 'Guilherme Santiago', 'Quadra 14, Bela Vista, Teresina - PI','guisantiago@gmail.com');
INSERT INTO cliente (cpf, telefone, nome, endereco, email) VALUES (16, '323420441', 'Hilson dos Santos Silva', 'Quadra 17, Saci, Teresina - PI','silvasantas@gmail.com');
INSERT INTO funcionario(cpf,nome,email,dataEntradaNaEmpresa,salario,telefone,dataUltimoPagamento,cargo,empresa_cnpj) VALUES (18,'Juscelino Terezo','juscelinoterezo@gmail.com', 20181203, 1200,'23423422', 20211212,'Gerente de Vendas',17 );
INSERT INTO funcionario(cpf,nome,email,dataEntradaNaEmpresa,salario,telefone,dataUltimoPagamento,cargo,empresa_cnpj) VALUES (19,'Hilson Gerferson','hilson@gmail.com', 20181203, 2200,'91283222', 20211212,'Vendedor',17 );
INSERT INTO pontobatido (funcionario_cpf, data,horario) VALUES (19,'20211111', '100000' );
INSERT INTO pontobatido (funcionario_cpf,data,horario) VALUES (19,'20211110','100000');
INSERT INTO pontobatido(funcionario_cpf,data,horario) VALUES (19,'20211109','100000');
INSERT INTO pontobatido(funcionario_cpf,data,horario) VALUES (18,'20211109','100000');
INSERT INTO pontobatido(funcionario_cpf,data,horario) VALUES (18,'20211111','100000');
INSERT INTO pontobatido(funcionario_cpf,data,horario) VALUES (18,'20211110','100000');
INSERT INTO pontobatido(funcionario_cpf,data,horario) VALUES (19,'20211111','170000');
INSERT INTO pontobatido(funcionario_cpf,data,horario) VALUES (19,'20211110','170000');
INSERT INTO pontobatido(funcionario_cpf,data,horario) VALUES (19,'20211109','170000');
INSERT INTO pontobatido(funcionario_cpf,data,horario) VALUES (18,'20211109','170000');
INSERT INTO pontobatido(funcionario_cpf,data,horario) VALUES (18,'20211111','170000');
INSERT INTO pontobatido(funcionario_cpf,data,horario) VALUES (18,'20211110','170000');
INSERT INTO pontobatido(funcionario_cpf,data,horario,observacao) VALUES (18,'20211108','170000','Não veio');
INSERT INTO pedidoavista(idpedidoAVista,valor,data,empresa_cnpj,cliente_cpf) VALUES (50,45,20211203,17,14);
INSERT INTO produto_has_pedidoavista (produto_idproduto,pedidoAVista_idpedidoAVista,quantidade) VALUES (7,50,3);
INSERT INTO pedidoaprazo(idpedidoAPrazo,parcelas,valor,data,empresa_cnpj,cliente_cpf) VALUES (51,10,1135,20191011,17,14);
INSERT INTO parcelapaga(idparcelaspagas,valorpago,data,pedidoAPrazo_idpedidoAPrazo) VALUES (70,113.5,20191112,51); 
INSERT INTO produto_has_pedidoaprazo (produto_idproduto, pedidoAPrazo_idpedidoAPrazo, quantidade) VALUES (11,51,10);
select * from empresa.cliente;
select * from empresa.empresa;
select * from empresa.fornecedor;
select * from empresa.funcionario;
select * from empresa.parcelapaga;
select * from empresa.pedidoaprazo;
select * from empresa.pedidoavista;
select * from empresa.pontobatido;
select * from empresa.produto;
select * from produto_has_pedidoaprazo;
select * from produto_has_pedidoavista;

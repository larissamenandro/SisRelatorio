CREATE TABLE IF NOT EXISTS `Paciente` (
  `id_numeroSus` VARCHAR(20),
  `sexo` VARCHAR(1) NULL,
  `registro` VARCHAR(20) NULL,
  `nome` VARCHAR(100) NULL,
  `idade` INT NULL,
  PRIMARY KEY (`id_numeroSus`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Biopsia` (
  `id_numeroBiopsia` VARCHAR(10) NOT NULL,
  `numero_blocos` INT NULL,
  `data` DATE NULL,
  `descricao` TEXT(1000) NULL,
  `Paciente_id_numeroSus` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_numeroBiopsia`),
  INDEX `fk_Biopsia_Paciente1_idx` (`Paciente_id_numeroSus` ASC),
  CONSTRAINT `fk_Biopsia_Paciente1`
    FOREIGN KEY (`Paciente_id_numeroSus`)
    REFERENCES `Paciente` (`id_numeroSus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Material` (
  `idMaterial` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  PRIMARY KEY (`idMaterial`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Biopsia_has_Material` (
  `Biopsia_id_numeroBiopsia` VARCHAR(10) NOT NULL,
  `Material_idMaterial` INT NOT NULL,
  PRIMARY KEY (`Biopsia_id_numeroBiopsia`, `Material_idMaterial`),
  INDEX `fk_Biopsia_has_Material_Material1_idx` (`Material_idMaterial` ASC),
  INDEX `fk_Biopsia_has_Material_Biopsia1_idx` (`Biopsia_id_numeroBiopsia` ASC),
  CONSTRAINT `fk_Biopsia_has_Material_Biopsia1`
    FOREIGN KEY (`Biopsia_id_numeroBiopsia`)
    REFERENCES `Biopsia` (`id_numeroBiopsia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Biopsia_has_Material_Material1`
    FOREIGN KEY (`Material_idMaterial`)
    REFERENCES `Material` (`idMaterial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
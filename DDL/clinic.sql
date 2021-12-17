USE joaby;

DELIMITER $$
DROP PROCEDURE IF EXISTS create_hospital$$
CREATE PROCEDURE create_hospital()
BEGIN
  SET FOREIGN_KEY_CHECKS = 0; 

  DROP TABLE IF EXISTS pacient;
  CREATE TABLE IF NOT EXISTS pacient (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(80),
    gender ENUM('M', 'F'),
    email VARCHAR(80),
    birthdate DATE
  );

  DROP TABLE IF EXISTS doctor;
  CREATE TABLE IF NOT EXISTS doctor (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(80),
    gender ENUM('M', 'F'),
    specialty VARCHAR(30),
    employee TINYINT(1)
  );

  DROP TABLE IF EXISTS hospital;
  CREATE TABLE IF NOT EXISTS hospital (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(80),
    district VARCHAR(80),
    city VARCHAR(80),
    state CHAR(2)
  );

  DROP TABLE IF EXISTS appointment;
  CREATE TABLE IF NOT EXISTS appointment (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_pacient INT UNSIGNED,
    id_doctor INT UNSIGNED,
    id_hospital INT UNSIGNED,
    appointment_date DATETIME,
    diagnosis TEXT
  );

  DROP TABLE IF EXISTS hospitalization;
  CREATE TABLE IF NOT EXISTS hospitalization (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_appointment INT UNSIGNED,
    entry_time DATETIME,
    exit_time DATETIME,
    room INT,
    observations TEXT
  );

  ALTER TABLE appointment
  ADD CONSTRAINT FK_appointment_pacient
  FOREIGN KEY (id_pacient) REFERENCES pacient(id);

  ALTER TABLE appointment
  ADD CONSTRAINT FK_appointment_doctor
  FOREIGN KEY (id_doctor) REFERENCES doctor(id);

  ALTER TABLE appointment
  ADD CONSTRAINT FK_appointment_hospital
  FOREIGN KEY (id_hospital) REFERENCES hospital(id);

  ALTER TABLE hospitalization
  ADD CONSTRAINT FK_hospitalization_appointment
  FOREIGN KEY (id_appointment) REFERENCES appointment(id);

  SET FOREIGN_KEY_CHECKS = 1; 
END$$
DELIMITER ;

call create_hospital()
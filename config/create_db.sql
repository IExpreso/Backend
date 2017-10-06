DROP TABLE IF EXISTS iexpresso_test;
DROP TABLE IF EXISTS iexpresso_production;
DROP TABLE IF EXISTS iexpresso_development;

CREATE DATABASE IF NOT EXISTS iexpresso_test;
CREATE DATABASE IF NOT EXISTS iexpresso_production;
CREATE DATABASE IF NOT EXISTS iexpresso_development;

CREATE TABLE IF NOT EXISTS `Users` (`email` VARCHAR(255) , `password` VARCHAR(255) NOT NULL, `createdAt` DATETIME DEFAULT now(), `updatedAt` DATETIME DEFAULT now(), PRIMARY KEY (`email`)) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS `Alumns` (`id` VARCHAR(255) , `name` VARCHAR(255) NOT NULL, `startDate` DATETIME NOT NULL, `endDate` DATETIME NOT NULL, `createdAt` DATETIME DEFAULT now(), `updatedAt` DATETIME DEFAULT now(), `UserEmail` VARCHAR(255), PRIMARY KEY (`id`), FOREIGN KEY (`UserEmail`) REFERENCES `Users` (`email`) ON DELETE SET NULL ON UPDATE CASCADE) ENGINE=InnoDB;

-- Create alumns for development
USE iexpresso_development;
INSERT INTO Alumns(id, name, startDate, endDate) VALUES(
  'A01631677',
  'Hermes Espínola González',
  '2015-05-02 13:05:22',
  '2020-10-13 13:05:22'
), (
  'A01225152',
  'Dennis Jesús Kingston Godinez',
  '2015-05-02 13:05:22',
  '2020-10-13 13:05:22'
), (
  'A01228802',
  'German Daniel Treviño Taboada',
  '2015-05-02 13:05:22',
  '2020-10-13 13:05:22'
), (
  'A01421882',
  'Jose Ramon Garcia Gonzalez',
  '2015-05-02 13:05:22',
  '2020-10-13 13:05:22'
), (
  'A01226132',
  'Miguel Angel Cabral Ramírez',
  '2015-05-02 13:05:22',
  '2020-10-13 13:05:22'
);

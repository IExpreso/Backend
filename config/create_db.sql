CREATE DATABASE IF NOT EXISTS iexpresso_test;
CREATE DATABASE IF NOT EXISTS iexpresso_production;
CREATE DATABASE IF NOT EXISTS iexpresso_development;

DROP TABLE IF EXISTS `Alumns`;
DROP TABLE IF EXISTS `Users`;
DROP TABLE IF EXISTS `RouteStop`;
DROP TABLE IF EXISTS `Routes`;
DROP TABLE IF EXISTS `Stops`;

USE iexpresso_development;

CREATE TABLE IF NOT EXISTS `Users` (`email` VARCHAR(255) , `password` VARCHAR(255) NOT NULL, `createdAt` DATETIME DEFAULT now(), `updatedAt` DATETIME DEFAULT now(), PRIMARY KEY (`email`));
CREATE TABLE IF NOT EXISTS `Alumns` (`id` VARCHAR(255) , `name` VARCHAR(255) NOT NULL, `startDate` DATETIME NOT NULL, `endDate` DATETIME NOT NULL, `createdAt` DATETIME DEFAULT now(), `updatedAt` DATETIME DEFAULT now(), `UserEmail` VARCHAR(255), PRIMARY KEY (`id`), FOREIGN KEY (`UserEmail`) REFERENCES `Users` (`email`) ON DELETE SET NULL ON UPDATE CASCADE);
CREATE TABLE IF NOT EXISTS `Routes` (`name` VARCHAR(255) , `createdAt` DATETIME DEFAULT now(), `updatedAt` DATETIME DEFAULT now(), PRIMARY KEY (`name`));
CREATE TABLE IF NOT EXISTS `Stops` (`name` VARCHAR(255) , `time` VARCHAR(255) , `createdAt` DATETIME DEFAULT now(), `updatedAt` DATETIME DEFAULT now(), PRIMARY KEY (`name`, `time`));
CREATE TABLE IF NOT EXISTS `RouteStop` (`createdAt` DATETIME DEFAULT now(), `updatedAt` DATETIME DEFAULT now(), `StopName` VARCHAR(255) , `RouteName` VARCHAR(255) , PRIMARY KEY (`StopName`, `RouteName`), FOREIGN KEY (`StopName`) REFERENCES `Stops` (`name`) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (`RouteName`) REFERENCES `Routes` (`name`) ON DELETE CASCADE ON UPDATE CASCADE);

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
INSERT INTO Routes(name) VALUES('Tránsito'), ('Chapultepec'), ('Cañadas'), ('Ciudadela'), ('Santa Anita'), ('Guadalupe'), ('Bugambilias'), ('Sur 2');

 -- RUTA TRÁNSITO
INSERT INTO Stops(name, time) VALUES('Tránsito',	'05:40'),
                                 ('Circunvalación y Ávila Camacho',	'05:45'),
                                 ('Plaza Patria',	'05:50'),
                                 ('Glorieta Colón',	'05:54'),
                                 ('López Mateos y Manuel Acuña',	'06:00'),
                                 ('Hospital Terranova',	'06:02'),
                                 ('Restaurante La Mar',	'06:05'),
                                 ('Soriana Pablo Neruda',	'06:07'),
                                 ('Glorieta Olímpica',	'06:10'),
                                 ('Chedraui',	'06:15');

-- RUTA CHAPULTEPEC
INSERT INTO Stops(name, time) VALUES('Glorieta Chapultepec', '05:40'),
                                 ('Vallarta y Progreso',	'05:44'),
                                 ('Centro Magno',	'05:48'),
                                 ('Plaza Bonita',	'05:55'),
                                 ('Plaza Galerías',	'06:02'),
                                 ('Naciones Unidas y Patria',	'06:07'),
                                 ('Plaza Universidad',	'06:10'),
                                 ('Paseo Madrigal',	'06:11'),
                                 ('Paseo Royal Country',	'06:13'),
                                 ('Plaza Pabellón',	'06:15');

-- RUTA CAÑADAS
INSERT INTO Stops(name, time) VALUES('Cañadas',	'06:05'),
                                 ('Punto San Isidro',	'06:08'),
                                 ('Valle de San Isidro',	'06:10'),
                                 ('Jabil',	'06:15');

-- RUTA SUR
INSERT INTO Stops(name, time) VALUES('El Palomar', '05:20'),
                                 ('Bugambilias', '05:30'),
                                 ('Las Fuentes', '05:37'),
                                 ('Las Águilas', '05:40'),
                                 ('La Calma', '05:43'),
                                 ('Plaza del Sol', '05:48'),
                                 ('Hotel Hilton',	'05:53'),
                                 ('Glorieta Chapalita',	'06:00'),
                                 ('Guadalupe y Niño Obrero',	'06:02'),
                                 ('Guadalupe y San Nicolás de Bari',	'06:05'),
                                 ('Guadalupe y Patria',	'06:08'),
                                 ('Toreros',	'06:10'),
                                 ('SRE',	'06:12'),
                                 ('Super La Playa',	'06:15'),
                                 ('Guadalupe y Santo Tomás',	'06:16'),
                                 ('Guadalupe y San Lorenzo',	'06:18'),
                                 ('Ciudad Judicial',	'06:25');

-- RUTA CIUDADELA
INSERT INTO Stops(name, time) VALUES('Plaza Ciudadela',	'06:00'),
                                 ('Cordilleras',	'06:05'),
                                 ('Patria y Beethoven',	'06:07'),
                                 ('Patria y Sebastian Bach',	'06:19'),
                                 ('Galerías',	'06:13'),
                                 ('Los Tules',	'06:20');

-- RUTA SANTA ANITA
INSERT INTO Stops(name, time) VALUES('XÓCHITL Y NETZAHUALCÓYOTL',	'06:22'),
                                 ('Cuahutémoc y Mariano Otero',	'06:25'),
                                 ('López  Mateos Y Pegaso',	'06:30'),
                                 ('López  Mateos Y Orión',	'06:33'),
                                 ('López Mateos Y Copérnico',	'06:35'),
                                 ('López  Mateos Y Las Fuentes',	'06:38'),
                                 ('Bugambilias',	'06:46'),
                                 ('El Palomar',	'06:56'),
                                 ('San José el Tajo',	'07:00'),
                                 ('NUEVA GALICIA',	'07:02'),
                                 ('San Martín el Tajo',	'07:07'),
                                 ('Manantial',	'07:10'),
                                 ('Club de Golf Santa Anita',	'07:12');

-- RUTA GUADALUPE
INSERT INTO Stops(name, time) VALUES('Glorieta Chapalita', '06:15'),
                                 ('Guadalupe y Niño Obrero',	'06:18'),
                                 ('Guadalupe  y San Nicolás de Bari',	'06:20'),
                                 ('Guadalupe y Patria',	'06:22'),
                                 ('Guadalupe y Toreros',	'06:24'),
                                 ('Plaza Alegra',	'06:26'),
                                 ('Super La Playa',	'06:28'),
                                 ('Guadalupe y Santo Tomás',	'06:29'),
                                 ('Guadalupe y San Lorenzo',	'06:30'),
                                 ('Ciudad Judicial',	'06:38');

-- RUTA BUGAMBILIAS
INSERT INTO Stops(name, time) VALUES('Palomar',	'05:55'),
                                 ('Bugambilias',	'06:06'),
                                 ('Las Fuentes',	'06:16'),
                                 ('Las Águilas',	'06:19'),
                                 ('Copérnico y Clouthier',	'06:26'),
                                 ('Mariano Otero y Jesús S. Carrillo',	'06:30');

-- RUTA SUR 2
INSERT INTO Stops(name, time) VALUES('Bugambilias',	'06:35'),
                                 ('Las Fuentes',	'06:45'),
                                 ('Las Águilas',	'06:48'),
                                 ('La Calma',	'06:51'),
                                 ('Plaza del Sol',	'06:57'),
                                 ('Plaza del Ángel',	'07:00'),
                                 ('Glorieta Chapalita',	'07:06'),
                                 ('Guadalupe y Niño Obrero',	'07:10'),
                                 ('Guadalupe/s Nicolás de Bari',	'07:12'),
                                 ('Guadalupe y Patria',	'07:15'),
                                 ('Toreros',	'07:18'),
                                 ('SRE',	'07:21'),
                                 ('Super la Playa',	'07:24'),
                                 ('Guadalupe y Santo Tomás',	'07:25'),
                                 ('Guadalupe y San Lorenzo',	'07:26');

CREATE DATABASE IF NOT EXISTS iexpresso_test;
CREATE DATABASE IF NOT EXISTS iexpresso_production;
CREATE DATABASE IF NOT EXISTS iexpresso_development;

USE iexpresso_development;

DROP TABLE IF EXISTS `Students`;
DROP TABLE IF EXISTS `Users`;
DROP TABLE IF EXISTS `RouteStop`;
DROP TABLE IF EXISTS `Routes`;
DROP TABLE IF EXISTS `Stops`;


CREATE TABLE IF NOT EXISTS `Routes` (`name` VARCHAR(255) , `createdAt` DATETIME DEFAULT now(), `updatedAt` DATETIME DEFAULT now(), PRIMARY KEY (`name`));
CREATE TABLE IF NOT EXISTS `Stops` (`name` VARCHAR(255) , `location` POINT, `createdAt` DATETIME DEFAULT now(), `updatedAt` DATETIME DEFAULT now(), PRIMARY KEY (`name`));
CREATE TABLE IF NOT EXISTS `Users` (`email` VARCHAR(255) , `role` VARCHAR(255) NOT NULL DEFAULT 'student', `password` VARCHAR(255) NOT NULL, `createdAt` DATETIME DEFAULT now(), `updatedAt` DATETIME DEFAULT now(), PRIMARY KEY (`email`));
CREATE TABLE IF NOT EXISTS `Students` (`id` VARCHAR(255) , `name` VARCHAR(255) NOT NULL, `startDate` DATETIME NOT NULL, `endDate` DATETIME NOT NULL, `createdAt` DATETIME DEFAULT now(), `updatedAt` DATETIME DEFAULT now(), `UserEmail` VARCHAR(255), PRIMARY KEY (`id`), FOREIGN KEY (`UserEmail`) REFERENCES `Users` (`email`) ON DELETE SET NULL ON UPDATE CASCADE);
CREATE TABLE IF NOT EXISTS `RouteStop` (`createdAt` DATETIME DEFAULT now(), `updatedAt` DATETIME DEFAULT now(), `StopName` VARCHAR(255) , `RouteName` VARCHAR(255) , PRIMARY KEY (`StopName`, `RouteName`), FOREIGN KEY (`StopName`) REFERENCES `Stops` (`name`) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (`RouteName`) REFERENCES `Routes` (`name`) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO Users(email, role, password) VALUES(
  'hermes.espinola@gmail.com',
  'admin',
  '$2a$10$Gw8WGWz0b96M/NTDaf7e9e0VRnyv2YpKh8ftT2QcsPmr1UfBftK5G'
), (
  'gertrevtabb@gmail.com',
  'admin',
  '$2a$10$Gw8WGWz0b96M/NTDaf7e9e0VRnyv2YpKh8ftT2QcsPmr1UfBftK5G'
), (
  'miguelcbrm@gmail.com',
  'admin',
  '$2a$10$Gw8WGWz0b96M/NTDaf7e9e0VRnyv2YpKh8ftT2QcsPmr1UfBftK5G'
), (
  'd.kingston12@gmail.com',
  'admin',
  '$2a$10$Gw8WGWz0b96M/NTDaf7e9e0VRnyv2YpKh8ftT2QcsPmr1UfBftK5G'
), (
  'a01421882@itesm.mx',
  'admin',
  '$2a$10$Gw8WGWz0b96M/NTDaf7e9e0VRnyv2YpKh8ftT2QcsPmr1UfBftK5G'
);

-- Create students for development
INSERT INTO Students(id, name, startDate, endDate) VALUES(
  'A01631385',
  'Lucía Velasco',
  '2015-05-02 13:05:22',
  '2020-10-13 13:05:22'
);

-- Create admins
INSERT INTO Students(id, name, startDate, endDate, UserEmail) VALUES(
  'A01631677',
  'Hermes Espínola González',
  '2015-05-02 13:05:22',
  '2020-10-13 13:05:22',
  'hermes.espinola@gmail.com'
), (
  'A01225152',
  'Dennis Jesús Kingston Godinez',
  '2015-05-02 13:05:22',
  '2020-10-13 13:05:22',
  'd.kingston12@gmail.com'
), (
  'A01228802',
  'German Daniel Treviño Taboada',
  '2015-05-02 13:05:22',
  '2020-10-13 13:05:22',
  'gertrevtabb@gmail.com'
), (
  'A01421882',
  'Jose Ramon Garcia Gonzalez',
  '2015-05-02 13:05:22',
  '2020-10-13 13:05:22',
  'a01421882@itesm.mx'
), (
  'A01226132',
  'Miguel Angel Cabral Ramírez',
  '2015-05-02 13:05:22',
  '2020-10-13 13:05:22',
  'miguelcbrm@gmail.com'
);
INSERT INTO Routes(name) VALUES('Chapultepec'), ('Cañadas'), ('Ciudadela'), ('SantaAnita'), ('Guadalupe'), ('Palomar'), ('Sur'), ('Sur2');

--  -- RUTA TRÁNSITO [Not available]
-- INSERT INTO Stops(name, location) VALUES('Tránsito', GeomFromText('POINT()')),
--                                  ('Circunvalación y Ávila Camacho', GeomFromText('POINT()')),
--                                  ('Plaza Patria', GeomFromText('POINT()')),
--                                  ('Glorieta Colón', GeomFromText('POINT()')),
--                                  ('López Mateos y Manuel Acuña', GeomFromText('POINT()')),
--                                  ('Hospital Terranova', GeomFromText('POINT()')),
--                                  ('Restaurante La Mar', GeomFromText('POINT()')),
--                                  ('Soriana Pablo Neruda', GeomFromText('POINT()')),
--                                  ('Glorieta Olímpica', GeomFromText('POINT()')),
--                                  ('Chedraui', GeomFromText('POINT()'));

-- RUTA CHAPULTEPEC
INSERT IGNORE INTO Stops(name, location) VALUES('Glorieta Chapultepec', GeomFromText('POINT(20.6665073 -103.368906)')),
                                 ('Vallarta y Progreso', GeomFromText('POINT(20.6746732 -103.3670381)')),
                                 ('Centro Magno', GeomFromText('POINT(20.674495 -103.3793593)')),
                                 ('Plaza Bonita', GeomFromText('POINT(20.6779714 -103.4048787)')),
                                 ('Plaza Galerías', GeomFromText('POINT(20.68765 -103.4197713)')),
                                 ('Naciones Unidas y Patria', GeomFromText('POINT(20.6913151 -103.4150630)')),
                                 ('Plaza Universidad', GeomFromText('POINT(20.7000469 -103.4156384)')),
                                 ('Paseo Madrigal', GeomFromText('POINT(20.7058903 -103.4130326)')),
                                 ('Paseo Royal Country', GeomFromText('POINT(20.7094489 -103.4073544)')),
                                 ('Plaza Pabellón', GeomFromText('POINT(20.7313918 -103.4530056)'));

INSERT INTO RouteStop(RouteName, StopName) VALUES('Chapultepec', 'Glorieta Chapultepec'),
                                 ('Chapultepec', 'Vallarta y Progreso'),
                                 ('Chapultepec', 'Centro Magno'),
                                 ('Chapultepec', 'Plaza Bonita'),
                                 ('Chapultepec', 'Plaza Galerías'),
                                 ('Chapultepec', 'Naciones Unidas y Patria'),
                                 ('Chapultepec', 'Plaza Universidad'),
                                 ('Chapultepec', 'Paseo Madrigal'),
                                 ('Chapultepec', 'Paseo Royal Country'),
                                 ('Chapultepec', 'Plaza Pabellón');

-- RUTA CAÑADAS
INSERT IGNORE INTO Stops(name, location) VALUES('Cañadas', GeomFromText('POINT(20.7631766 -103.382678)')),
                                 ('Punto San Isidro', GeomFromText('POINT(20.7537261 -103.3842981)')),
                                 ('Valle de San Isidro', GeomFromText('POINT(20.7485492 -103.3855534)')),
                                 ('Jabil', GeomFromText('POINT(20.7406179 -103.3991146)'));

INSERT INTO RouteStop(RouteName, StopName) VALUES('Cañadas', 'Cañadas'),
                                 ('Cañadas', 'Punto San Isidro'),
                                 ('Cañadas', 'Valle de San Isidro'),
                                 ('Cañadas', 'Jabil');

-- RUTA SUR
INSERT IGNORE INTO Stops(name, location) VALUES('Plaza El Palomar', GeomFromText('POINT(20.5905875 -103.4426844)')),
                                 ('Bugambilias', GeomFromText('POINT(20.6819762 -103.4551359)')),
                                 ('Las Fuentes', GeomFromText('POINT(20.6592517 -103.4447256)')),
                                 ('Las Águilas', GeomFromText('POINT(20.6590628 -103.4425322)')),
                                 ('La Calma', GeomFromText('POINT(20.6589536 -103.4405937)')),
                                 ('Plaza del Sol', GeomFromText('POINT(20.6589555 -103.4334978)')),
                                 ('Hotel Hilton', GeomFromText('POINT(20.6617287 -103.4281414)')),
                                 ('Glorieta Chapalita', GeomFromText('POINT(20.6624189 -103.4236032)')),
                                 ('Guadalupe y Niño Obrero', GeomFromText('POINT(20.6640351 -103.4154198)')),
                                 ('Guadalupe y San Nicolás de Bari', GeomFromText('POINT(20.66531 -103.4086284)')),
                                 ('Guadalupe y Patria', GeomFromText('POINT(20.6669781 -103.4024709)')),
                                 ('Toreros', GeomFromText('POINT(20.653828 -103.40096)')),
                                 ('SRE', GeomFromText('POINT(20.6504146 -103.4031379)')),
                                 ('Super La Playa', GeomFromText('POINT(20.6343656 -103.4136656)')),
                                 ('Guadalupe y Santo Tomás', GeomFromText('POINT(20.6211366 -103.4224874)')),
                                 ('Guadalupe y San Lorenzo', GeomFromText('POINT(20.6015545 -103.4495186)')),
                                 ('Ciudad Judicial', GeomFromText('POINT(20.7318935 -103.4534374)'));

INSERT INTO RouteStop(RouteName, StopName) VALUES('Sur', 'Plaza El Palomar'),
                                 ('Sur', 'Bugambilias'),
                                 ('Sur', 'Las Fuentes'),
                                 ('Sur', 'Las Águilas'),
                                 ('Sur', 'La Calma'),
                                 ('Sur', 'Plaza del Sol'),
                                 ('Sur', 'Hotel Hilton'),
                                 ('Sur', 'Glorieta Chapalita'),
                                 ('Sur', 'Guadalupe y Niño Obrero'),
                                 ('Sur', 'Guadalupe y San Nicolás de Bari'),
                                 ('Sur', 'Guadalupe y Patria'),
                                 ('Sur', 'Toreros'),
                                 ('Sur', 'SRE'),
                                 ('Sur', 'Super La Playa'),
                                 ('Sur', 'Guadalupe y Santo Tomás'),
                                 ('Sur', 'Guadalupe y San Lorenzo'),
                                 ('Sur', 'Ciudad Judicial');

-- RUTA CIUDADELA
INSERT IGNORE INTO Stops(name, location) VALUES('Plaza Ciudadela', GeomFromText('POINT(20.6486428 -103.4221042)')),
                                 ('Cordilleras', GeomFromText('POINT(20.6574748 -103.4230721)')),
                                 ('Patria y Beethoven', GeomFromText('POINT(20.668821 -103.4243166)')),
                                 ('Patria y Sebastian Bach', GeomFromText('POINT(20.6725266 -103.4230972)')),
                                 ('Galerías', GeomFromText('POINT(20.67604 -103.4294665)')),
                                 ('Los Tules', GeomFromText('POINT(20.6917617 -103.4503609)'));

INSERT INTO RouteStop(RouteName, StopName) VALUES('Ciudadela', 'Plaza Ciudadela'),
                                 ('Ciudadela', 'Cordilleras'),
                                 ('Ciudadela', 'Patria y Beethoven'),
                                 ('Ciudadela', 'Patria y Sebastian Bach'),
                                 ('Ciudadela', 'Galerías'),
                                 ('Ciudadela', 'Los Tules');

-- RUTA SANTA ANITA
INSERT IGNORE INTO Stops(name, location) VALUES('Plaza Xóchitl', GeomFromText('POINT(20.6545509 -103.406496)')),
                                 ('7 Eleven', GeomFromText('POINT(20.6456044 -103.4081537)')),
                                 ('Office Depot', GeomFromText('POINT(20.6373677 -103.4124881)')),
                                 ('Porsche', GeomFromText('POINT(20.633206 -103.4149343)')),
                                 ('Soriana Las Águilas', GeomFromText('POINT(20.6283663 -103.4182119)')),
                                 ('Starbucks Las Fuentes', GeomFromText('POINT(20.620509 -103.4233001)')),
                                 ('Bugambilias', GeomFromText('POINT(20.6014541 -103.4494114)')),
                                 ('Paseo Del Palomar', GeomFromText('POINT(20.5930782 -103.4465696)')),
                                 ('El Tajo', GeomFromText('POINT(20.581277 -103.4492451)')),
                                 ('Nueva Galicia', GeomFromText('POINT(20.5776309 -103.4441328)'));

INSERT INTO RouteStop(RouteName, StopName) VALUES('SantaAnita', 'Plaza Xóchitl'),
                                  ('SantaAnita', '7 Eleven'),
                                  ('SantaAnita', 'Office Depot'),
                                  ('SantaAnita', 'Porsche'),
                                  ('SantaAnita', 'Soriana Las Águilas'),
                                  ('SantaAnita', 'Starbucks Las Fuentes'),
                                  ('SantaAnita', 'Bugambilias'),
                                  ('SantaAnita', 'Paseo Del Palomar'),
                                  ('SantaAnita', 'El Tajo'),
                                  ('SantaAnita', 'Nueva Galicia');

-- RUTA GUADALUPE
INSERT IGNORE INTO Stops(name, location) VALUES('Glorieta Chapalita', GeomFromText('POINT(20.6662523 -103.4033794)')),
                                 ('Guadalupe y Niño Obrero', GeomFromText('POINT(20.6652692 -103.4086585)')),
                                 ('Guadalupe  y San Nicolás de Bari', GeomFromText('POINT(20.664128 -103.4154224)')),
                                 ('Guadalupe y Patria', GeomFromText('POINT(20.6625017 -103.4235334)')),
                                 ('Guadalupe y Toreros', GeomFromText('POINT(20.6617037 -103.4280919)')),
                                 ('Plaza Alegra', GeomFromText('POINT(20.65870700 -103.4364295)')),
                                 ('Super La Playa', GeomFromText('POINT(20.6589831 -103.4405708)')),
                                 ('Guadalupe y Santo Tomás', GeomFromText('POINT(20.6591086 -103.4425315)')),
                                 ('Guadalupe y San Lorenzo', GeomFromText('POINT(20.6592742 -103.4447846)')),
                                 ('Ciudad Judicial', GeomFromText('POINT(20.681958 -103.4550950)'));

INSERT INTO RouteStop(RouteName, StopName) VALUES('Guadalupe', 'Glorieta Chapalita'),
                                  ('Guadalupe', 'Guadalupe y Niño Obrero'),
                                  ('Guadalupe', 'Guadalupe  y San Nicolás de Bari'),
                                  ('Guadalupe', 'Guadalupe y Patria'),
                                  ('Guadalupe', 'Guadalupe y Toreros'),
                                  ('Guadalupe', 'Plaza Alegra'),
                                  ('Guadalupe', 'Super La Playa'),
                                  ('Guadalupe', 'Guadalupe y Santo Tomás'),
                                  ('Guadalupe', 'Guadalupe y San Lorenzo'),
                                  ('Guadalupe', 'Ciudad Judicial');

-- RUTA PALOMAR
INSERT IGNORE INTO Stops(name, location) VALUES('Paseo Del Palomar', GeomFromText('POINT(20.5930782 -103.4465696)')),
                                 ('Bugambilias', GeomFromText('POINT(20.6014541 -103.4494114)')),
                                 ('Las Fuentes', GeomFromText('POINT(20.6211228 -103.4224284)')),
                                 ('Las Águilas', GeomFromText('POINT(20.628409 -103.4184909)')),
                                 ('Copérnico y Clouthier', GeomFromText('POINT(20.6398126 -103.4304857)')),
                                 ('Mariano Otero y Jesús S. Carrillo', GeomFromText('POINT(20.6317538 -103.4299157)'));

INSERT INTO RouteStop(RouteName, StopName) VALUES('Palomar', 'Paseo Del Palomar'),
                                ('Palomar', 'Bugambilias'),
                                ('Palomar', 'Las Fuentes'),
                                ('Palomar', 'Las Águilas'),
                                ('Palomar', 'Copérnico y Clouthier'),
                                ('Palomar', 'Mariano Otero y Jesús S. Carrillo');

-- RUTA SUR 2
-- FIXME: Revisar coordenadas
INSERT IGNORE INTO Stops(name, location) VALUES('Palomar', GeomFromText('POINT(20.6015094 -103.4494275)')),
                                 ('Bugambilias', GeomFromText('POINT(20.6819762 -103.4551359)')),
                                 ('Las Fuentes', GeomFromText('POINT(20.6592517 -103.4447256)')),
                                 ('Las Águilas', GeomFromText('POINT(20.6590628 -103.4425322)')),
                                 ('La Calma', GeomFromText('POINT(20.6589536 -103.4405937)')),
                                 ('Plaza del Sol', GeomFromText('POINT(20.6589555 -103.4334978)')),
                                 ('Plaza del Ángel', GeomFromText('POINT(20.6617287 -103.4281414)')),
                                 ('Glorieta Chapalita', GeomFromText('POINT(20.6624189 -103.4236032)')),
                                 ('Niño Obrero', GeomFromText('POINT(20.6640351 -103.4154198)')),
                                 ('Nicolás de Bari', GeomFromText('POINT(20.66531 -103.4086284)')),
                                 ('Oxxo Patria', GeomFromText('POINT(20.6669781 -103.4024709)')),
                                 ('Toreros', GeomFromText('POINT(20.653828 -103.40096)')),
                                 ('SRE', GeomFromText('POINT(20.6504146 -103.4031379)')),
                                 ('La Playa', GeomFromText('POINT(20.6343656 -103.4136656)')),
                                 ('Santo Tomás', GeomFromText('POINT(20.6276672 -103.4181234)')),
                                 ('Miguel Ángel', GeomFromText('POINT(20.6211366 -103.4224874)')),
                                 ('Ciudad Judicial', GeomFromText('POINT(20.6015545 -103.4495186)'));

INSERT INTO RouteStop(RouteName, StopName) VALUES('Sur2', 'Palomar'),
                                ('Sur2', 'Bugambilias'),
                                ('Sur2', 'Las Fuentes'),
                                ('Sur2', 'Las Águilas'),
                                ('Sur2', 'La Calma'),
                                ('Sur2', 'Plaza del Sol'),
                                ('Sur2', 'Plaza del Ángel'),
                                ('Sur2', 'Glorieta Chapalita'),
                                ('Sur2', 'Niño Obrero'),
                                ('Sur2', 'Nicolás de Bari'),
                                ('Sur2', 'Oxxo Patria'),
                                ('Sur2', 'Toreros'),
                                ('Sur2', 'SRE'),
                                ('Sur2', 'La Playa'),
                                ('Sur2', 'Santo Tomás'),
                                ('Sur2', 'Miguel Ángel'),
                                ('Sur2', 'Ciudad Judicial');

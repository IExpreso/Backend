CREATE DATABASE IF NOT EXISTS iexpresso_test;
CREATE DATABASE IF NOT EXISTS iexpresso_production;
CREATE DATABASE IF NOT EXISTS iexpresso_development;

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

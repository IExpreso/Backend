'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert('Student', [{
      id: 'A01631677',
      name: 'Hermes Espínola González',
      startDate: new Date(),
      endDate: new Date('October 13, 2020 11:13:00')
    }, {
      id: 'A01225152',
      name: 'Dennis Jesús Kingston Godinez',
      startDate: new Date(),
      endDate: new Date('October 13, 2020 11:13:00')
    }, {
      id: 'A01228802',
      name: 'German Daniel Treviño Taboada',
      startDate: new Date(),
      endDate: new Date('October 13, 2020 11:13:00')
    }, {
      id: 'A01421882',
      name: 'Jose Ramon Garcia Gonzalez',
      startDate: new Date(),
      endDate: new Date('October 13, 2020 11:13:00')
    }, {
      id: 'A01226132',
      name: 'Miguel Angel Cabral Ramírez',
      startDate: new Date(),
      endDate: new Date('October 13, 2020 11:13:00')
    }], {})
  },

  down: (queryInterface, Sequelize) => {
    queryInterface.bulkDelete('Student', [{
      id :'A01631677'
    }])
  }
};

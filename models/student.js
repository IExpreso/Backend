'use strict';

module.exports = function(sequelize, DataTypes) {
  var Student = sequelize.define("Student", {
    id: {type: DataTypes.STRING, primaryKey: true},
    name: {type: DataTypes.STRING, allowNull: false},
    startDate: {type: DataTypes.DATE, allowNull: false},
    endDate: {type: DataTypes.DATE, allowNull: false},
    createdAt: {type: DataTypes.DATE, defaultValue: sequelize.fn('now')},
    updatedAt: {type: DataTypes.DATE, defaultValue: sequelize.fn('now')}
  });

  // Student.associate = function(models) {
  //   Student.hasMany(models.Route);
  // }

  return Student;
};

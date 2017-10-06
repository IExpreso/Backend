'use strict';

module.exports = function(sequelize, DataTypes) {
  var Alumn = sequelize.define("Alumn", {
    id: {type: DataTypes.STRING, primaryKey: true},
    name: {type: DataTypes.STRING, allowNull: false},
    startDate: {type: DataTypes.DATE, allowNull: false},
    endDate: {type: DataTypes.DATE, allowNull: false},
    createdAt: {type: DataTypes.DATE, defaultValue: sequelize.fn('now')},
    updatedAt: {type: DataTypes.DATE, defaultValue: sequelize.fn('now')}
  });

  // Alumn.associate = function(models) {
  //   Alumn.hasMany(models.Route);
  // }

  return Alumn;
};

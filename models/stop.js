'use strict';

module.exports = function(sequelize, DataTypes) {
  var Stop = sequelize.define("Stop", {
    name: {type: DataTypes.STRING, primaryKey: true},
    location: {type: DataTypes.GEOMETRY('POINT')},
    createdAt: {type: DataTypes.DATE, defaultValue: sequelize.fn('now')},
    updatedAt: {type: DataTypes.DATE, defaultValue: sequelize.fn('now')}
  });

  Stop.associate = function(models) {
    Stop.belongsToMany(models.Route, {through: 'RouteStop'});
  }

  return Stop;
};

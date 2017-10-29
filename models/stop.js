'use strict';

module.exports = function(sequelize, DataTypes) {
  var Stop = sequelize.define("Stop", {
    name: {type: DataTypes.STRING, primaryKey: true},
    time: {type: DataTypes.STRING, primaryKey: true},
    createdAt: {type: DataTypes.DATE, defaultValue: sequelize.fn('now')},
    updatedAt: {type: DataTypes.DATE, defaultValue: sequelize.fn('now')},
    trigger: {type: DataTypes.GEOMETRY('LINE')}
  });

  Stop.associate = function(models) {
    Stop.belongsToMany(models.Route, {through: 'RouteStop'});
  }

  return Stop;
};

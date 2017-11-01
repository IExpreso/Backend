'use strict';

module.exports = function(sequelize, DataTypes) {
  var Route = sequelize.define("Route", {
    name: {type: DataTypes.STRING, primaryKey: true},
    createdAt: {type: DataTypes.DATE, defaultValue: sequelize.fn('now')},
    updatedAt: {type: DataTypes.DATE, defaultValue: sequelize.fn('now')}
  });

  Route.associate = function(models) {
    Route.belongsToMany(models.Stop, {through: 'RouteStop'});
  }

  return Route;
};

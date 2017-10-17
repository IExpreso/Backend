'use strict';

module.exports = function(sequelize, DataTypes) {
  var User = sequelize.define("User", {
    email: {type: DataTypes.STRING, primaryKey: true, validate: {
      isEmail: {msg: 'Reason'}
    }},
    password: {type: DataTypes.STRING, allowNull: false},
    createdAt: {type: DataTypes.DATE, defaultValue: sequelize.fn('now')},
    updatedAt: {type: DataTypes.DATE, defaultValue: sequelize.fn('now')}
  });

  User.associate = function(models) {
    User.hasOne(models.Alumn);
  }

  return User;
};

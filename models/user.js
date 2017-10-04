'use strict';

// const bcrypt = require('bcrypt');

module.exports = function(sequelize, DataTypes) {
  var User = sequelize.define("User", {
    email: {type: DataTypes.STRING, primaryKey: true, validate: {
      isEmail: {msg: 'Reason'}
    }},
    password: {type: DataTypes.STRING, allowNull: false}
  });

  User.associate = function(models) {
    User.hasOne(models.Alumn);
  }

  return User;
};

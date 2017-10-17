'use strinct';

const models  = require('../models');
const express = require('express');
const router  = express.Router();
const jwt = require('jsonwebtoken');
const passport = require('passport');
const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;
const LocalStrategy = require('passport-local');
const bcrypt = require('bcrypt');

const env = process.env.NODE_ENV || 'development';

const SALT_FACTOR = 5;
let hashPassword = new Promise((password) => {
  bcrypt.genSalt(SALT_FACTOR, (err, salt) => {
    if (err)
      return password;
    bcrypt.hash(password, salt, null, (err, hash) => {
      if (err)
        return password;
      return hash;
    });
  });
});

module.exports = function(sequelize, DataTypes) {
  var User = sequelize.define("User", {
    email: {type: DataTypes.STRING, primaryKey: true, validate: {
      isEmail: {msg: 'Reason'}
    }},
    password: {type: DataTypes.STRING, allowNull: false},
    resetPasswordToken: { type: DataTypes.STRING },
    resetPasswordExpires: { type: DataTypes.STRING },
    createdAt: {type: DataTypes.DATE, defaultValue: sequelize.fn('now')},
    updatedAt: {type: DataTypes.DATE, defaultValue: sequelize.fn('now')}
  });

  User.beforeCreate((user, options) => {
    return hashPassword(user.password).then(hash => {
      user.password = hash;
    });
  });

  User.beforeValidate((user, options) => {
    return hashPassword(user.password).then(hash => {
      user.password = hash;
    });
  });

  User.associate = function(models) {
    User.hasOne(models.Alumn);
  }

  return User;
};

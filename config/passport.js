'use strinct';

const User  = require('../models').User;
const jwt = require('jsonwebtoken');
const passport = require('passport');
const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;
const LocalStrategy = require('passport-local');
const bcrypt = require('bcrypt');

const env = process.env.NODE_ENV || 'development';
const secret  = require(__dirname + './../config/config.json')[env]['secret'];
const localOptions = { usernameField: 'email' };

function comparePassword(candidate, cb) {
  bcrypt.compare(candidatePassword, this.password, (err, isMatch) => {
    if (err)
      return cb(err);
    cb(null, isMatch);
  });
}

const localLogin = new LocalStrategy(localOptions, (email, password, done) => {
  // TODO: include Student
  User.findOne({ email: email }, (err, user) => {
    if (err)
      return done(err);
    if (!user)
      return done(null, false, { error: 'login credentials could not be verified' });

    comparePassword(user.password, (err, isMatch) => {
      if (err)
        return done(err);
        if (!isMatch)
          return done(null, false, { error: 'login credentials could not be verified' });
      return done(null, user);
    });
  });
});

const jwtOptions = {
  jwtFromRequest: ExtractJwt.fromAuthHeader(),
  secretOrKey: secret
}

const jwtLogin = new JwtStrategy(jwtOptions, (payload, done) => {
  User.findById(payload.email, (err, user) => {
    if (err)
      return done(err, false);
    if (user)
      done(null, user);
    else
      done(null, false);
  });
});

passport.use(jwtLogin);
passport.use(localLogin);

function generateToken(user) {
  return jwt.sign(user, secret, { expiresIn: '48h' });
}

function setUserInfo(request) {
  return {
    email: request.email
  }
}

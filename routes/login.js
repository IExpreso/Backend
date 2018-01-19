'use strict';

const models  = require('../models');
const express = require('express');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');

const router  = express.Router();
const env = process.env.NODE_ENV || 'development';
const secret  = require(__dirname + './../config/config.json')[env]['secret'];

router.post('/', (req, res) => {
  models.User.findById(req.body.email).then(user => {
    if (!user) {
      return res.status(401).json({ error: 'invalid user' });
    }
    bcrypt.compare(req.body.password, user.get('password'), (err, hashed) => {
      if (hashed) {
        let token = jwt.sign({ user: user.get('email'), role: user.get('role') }, secret, { expiresIn: '48h' });
        return res.status(200).json({
          token: token,
          user: user.email,
          role: user.role
        });
      } else return res.status(401).json({ error: 'invalid password' });
    });
  }).catch(err => {
    return res.status(500).json({ error: err });
  });
});

module.exports = router;

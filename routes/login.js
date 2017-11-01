'use strict';

const models  = require('../models');
const express = require('express');
const jwt = require('jsonwebtoken');

const router  = express.Router();
const env = process.env.NODE_ENV || 'development';
const secret  = require(__dirname + './../config/config.json')[env]['secret'];

router.post('/', (req, res) => {
  console.log(req.body);
  models.User.findById(req.body.email).then(user => {
    if (!user) {
      return res.status(401).json({ error: 'invalid user' });
    } else if (req.body.password === user.get('password')) {
      let token = jwt.sign({ user: user.get('email') }, secret, { expiresIn: '48h' });
      return res.status(200).json({
        token: token,
        user: user.email
      });
    } else {
      return res.status(401).json({ error: 'invalid password' });
    }
  }).catch(err => {
    return res.status(500).json({ error: err });
  });
});

module.exports = router;

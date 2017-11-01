'use strict';

var models  = require('../models');
var express = require('express');
const jwt = require('jsonwebtoken');

var router  = express.Router();
const env = process.env.NODE_ENV || 'development';
const secret  = require(__dirname + '/../config/config.json')[env]['secret'];

router.post('/', (req, res, next) => {
  models.Student.findById(req.body.id).then(student => {
    if (!student)
      return res.status(404).json({ error: 'No such id: ' + req.body.id });
    if (student.UserEmail)
      return res.status(422).json({ error: 'Student already registered' });
    models.User.create({
      email: req.body.email,
      password: req.body.password
    }).then(user => {
      user.setStudent(student, {save: true});
      let token = jwt.sign({
        user: user.get('email'),
        role: user.get('role')
      }, secret, { expiresIn: '48h' });
      return res.status(201).json({
        token: token,
        user: user.email
      });
    }).catch(err => {
      console.log(err);
      return res.status(409).json({error: 'Email already in use'});
    });
  }).catch(err => {
    return res.status(500).json({error: err});
  });
});

module.exports = router;

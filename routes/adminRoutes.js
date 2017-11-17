'use strict';

const bcrypt = require('bcrypt');

var models  = require('../models');
var express = require('express');
var router  = express.Router();

router.post('/register', (req, res, next) => {
  if (req.body.role && req.body.role != 'student') {

    // hash password before storing it
    bcrypt.hash(req.body.password, 10, (err, hashed) => {
      if (hashed) {
        models.User.create({
          email: req.body.email,
          password: hashed,
          role: req.body.role
        }).then(user => {
          // Register User
          models.User.create(req.body).then(user => {
            console.log(`created user with role ${req.body.role}`);
            return res.sendStatus(201);
          }).catch(err => {
            return res.status(409).json({error: 'Email already in use'});
          });
        }).catch(err => {
          return res.status(409).json({error: 'Email already in use'});
        });
      } else {
        return res.status(500).json({error: 'Could not create user, Please try again later.'})
      }
    });

  } else {
    models.Student.findOne(req.body.id).then(student => {
      if (!student)
        return res.status(404).json({ error: 'No such id: ' + req.body.id });
      if (student.UserEmail)
        return res.status(422).json({ error: 'Student already registered' });

      // hash password before storing it
      bcrypt.hash(req.body.password, 10, (err, hashed) => {
        if (hashed) {
          models.User.create({
            email: req.body.email,
            password: hashed
          }).then(user => {
            console.log('created user');
            user.setStudent(student, {save: true});
            return res.sendStatus(201);
          }).catch(err => {
            return res.status(409).json({error: 'Email already in use'});
          });
        } else {
          return res.status(500).json({error: 'Could not create user, Please try again later.'})
        }
      });
    }).catch(err => {
      return res.status(500).json({error: err});
    });
  }
});

module.exports = router;

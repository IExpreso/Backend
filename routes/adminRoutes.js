'use strict';

const bcrypt = require('bcrypt');

var models  = require('../models');
var express = require('express');
var router  = express.Router();

function createUser(req, res, student) {
  // hash password before storing it
  bcrypt.hash(req.body.password, 10, (err, hashed) => {
    if (hashed) {
      models.User.create({
        email: req.body.email,
        password: hashed,
        role: req.body.role || 'student'
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
}

router.post('/register', (req, res, next) => {
    models.Student.findById(req.body.id).then(student => {
      console.log(student);
      if (!student)
        // Create student
        models.Student.create({
          id: req.body.id,
          name: req.body.name || req.body.id,
          startDate: '2015-05-02 13:05:22',
          endDate: '2020-10-13 13:05:22'
        }).then(newStudent => {
          console.log('created student');
          createUser(req, res, newStudent);
        }).catch(err => {
          return res.status(409).json({error: 'Email already in use'});
        });
      else if (student.UserEmail)
        return res.status(422).json({ error: 'Student already registered: ' + student.UserEmail });
      else
        createUser(req, res, student);
    }).catch(err => {
      return res.status(500).json({error: err});
    });
});

module.exports = router;

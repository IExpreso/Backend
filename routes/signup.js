var models  = require('../models');
var express = require('express');
var router  = express.Router();

router.post('/', (req, res, next) => {
  models.Alumn.findOne(req.body.id).then(alumn => {
    if (!alumn)
      return res.status(404).json({ error: 'No such id: ' + req.body.id });
    if (alumn.UserEmail)
      return res.status(422).json({ error: 'Alumn already registered' });
    console.log('start creating user');
    models.User.create({
      email: req.body.email,
      password: req.body.password
    }).then(user => {
      console.log('created user');
      user.setAlumn(alumn, {save: true});
      console.log('linked user with alumn');
      console.log(user);
      let token = jwt.sign({ user: user.get('email') }, secret, { expiresIn: '48h' });
      return res.status(201).json({
        token: 'JWT ' + token,
        user: user.email
      });
    }).catch(err => {
      return res.status(409).json({error: 'Email already in use'});
    });
  }).catch(err => {
    return res.status(500).json({error: err});
  });
});

module.exports = router;

const express = require('express');
const models = require('../models');
const router = express.Router();

/* GET users listing. */
router.get('/', (req, res, next) => {
  res.send('respond with a resource');
});

router.post('/', (req, res, next) => {
  models.Alumn.findOne(req.body.id).then(alumn => {
    if (!alumn) return res.status(404).json({ error: 'No such id: ' + req.body.id });
    if (alumn.UserEmail) return res.status(422).json({ error: 'Email address already in use' })
    models.User.create({
      email: req.body.email,
      password: req.body.password
    }).then(user => {
      user.setAlumn(alumn, {save: true});

      let token = jwt.sign({ user: user.get('email') }, secret, { expiresIn: '48h' });
      return res.status(201).json({
        token: 'JWT ' + token,
        user: user.email
      });
    }).catch(err => {
      return res.status(409).json({error: err});
    });
  }).catch(err => {
    return res.status(500).json({error: err});
  });
});

module.exports = router;

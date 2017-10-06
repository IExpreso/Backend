const express = require('express');
const models = require('../models');
const router = express.Router();

/* GET users listing. */
router.get('/', (req, res, next) => {
  res.send('respond with a resource');
});

router.post('/', (req, res, next) => {
  console.log(req.body);
  models.Alumn.findOne(req.body.id).then(alumn => {
    if (!alumn) return res.status(404).json({error: 'No such id: ' + req.body.id});
    models.User.create({
      email: req.body.email,
      password: req.body.password
    }).then(user => {
      user.setAlumn(alumn, {save: true});
      return res.status(200).json(user);
    }).catch(err => {
      return res.status(409).json({error: err});
    });
  }).catch(err => {
    return res.status(500).json({error: err});
  });
});

module.exports = router;

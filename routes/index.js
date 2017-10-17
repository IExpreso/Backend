var models  = require('../models');
var express = require('express');
var router  = express.Router();

router.get('/', (req, res) => {
  models.User.findAll({
    include: [ models.Alumn ]
  }).then(users => {
    res.status(200).json({users: users});
  });
});

module.exports = router;

'use strict';

const express = require('express');
const models = require('../models');
const router = express.Router();

router.get('/', (req, res) => {
  models.Route.findAll({
    include: [ models.Stop ]
  }).then(routes => {
    res.status(200).json({routes: routes});
  });
});

router.get('/listing' , (req, res) => {
  models.Route.findAll().then(routes => {
    res.status(200).json({routes: routes});
  });
});

module.exports = router;

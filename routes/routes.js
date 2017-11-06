'use strict';

const express = require('express');
const models = require('../models');
const router = express.Router();

router.get('/', (req, res) => {
  // res.status(200).json({asdoasindod: 'OK'});
  models.Route.findAll({
    include: [ models.Stop ]
  }).then(routes => {
    res.status(200).json({routes: routes});
  });
});

router.get('/track/:id' , (req, res) => {
  // res.status(200).json({asdoasindod: 'OK'});
  const routeId = req.params.id;

  // req.app.io.emit('tx', {key: 'value'});

  models.Route.findAll({
    include: [ models.Stop ]
  }).then(routes => {
    res.status(200).json({routes: routes});
  });
});

module.exports = router;

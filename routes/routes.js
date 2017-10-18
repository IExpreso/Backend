const express = require('express');
const models = require('../models');
const router = express.Router();

/* GET routes listing. */
router.get('/', (req, res) => {
  // res.status(200).json({asdoasindod: 'OK'});
  models.Route.findAll({
    include: [ models.Stop ]
  }).then(routes => {
    res.status(200).json({routes: routes});
  });
});

module.exports = router;

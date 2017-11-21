const express = require('express');
const models = require('../models');
const router = express.Router();

router.get('/subscribe', (req, res, next) => {
  res.send('respond with a resource');
});

module.exports = router;

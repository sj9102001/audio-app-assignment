const express = require('express');
const router = express.Router();
const programController = require("../controllers/programController");

router.get('/', programController.fetchPrograms);

router.get('/')

module.exports = router;

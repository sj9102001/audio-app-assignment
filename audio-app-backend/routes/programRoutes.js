const express = require('express');
const router = express.Router();
const programController = require("../controllers/programController");

router.get('/', programController.fetchPrograms);

module.exports = router;

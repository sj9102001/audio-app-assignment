const express = require('express');
const router = express.Router();

const trackController = require("../controllers/trackController");

router.get('/:programId', trackController.fetchTracks);

module.exports = router;

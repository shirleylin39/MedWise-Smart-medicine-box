const express = require('express');
const router = express.Router();
const backlogController = require('../controllers/backlogController');

router.post('/create-schedule/:id', backlogController.createSchedule);
router.get('/backlogs', backlogController.fetchBacklogs);
router.get('/backlogs/:deviceId', backlogController.fetchBacklogByDevice);

module.exports = router;

const express = require('express');
const router = express.Router();
const medwiseController = require('../controllers/medwiseController');

router.get('/medwises', medwiseController.fetchDevices);
router.post('/medwises', medwiseController.submitDevice);
router.put('/medwises/:id', medwiseController.updateDevice);
router.get('/medwises/:id', medwiseController.fetchDeviceById);

module.exports = router;

const MedWise = require('../models/medwise');
const Backlog = require('../models/backlog');
const { createSchedule } = require('../controllers/backlogController');

exports.fetchDevices = async (req, res) => {
    try {
        const devices = await MedWise.find().sort({ updatedAt: -1 });
        res.json(devices);
    } catch (error) {
        res.status(500).send({ message: 'Error fetching devices', error: error.message });
    }
};

exports.submitDevice = async (req, res) => {
    try {
        const newDevice = new MedWise(req.body);
        const savedDevice = await newDevice.save();
        res.status(200).send({
            message: 'Device info stored successfully in MongoDB',
            device_id: savedDevice._id,
        });
    } catch (error) {
        res.status(500).send({ message: 'Error storing device info', error: error.message });
    }
};

exports.updateDevice = async (req, res) => {
    const { id } = req.params;
    const updateData = req.body;
    

    try {
        const updatedDevice = await MedWise.findByIdAndUpdate(id, updateData, { new: true });
        if (!updatedDevice) {
            return res.status(404).send({ message: 'Device not found' });
        }

        if (updateData.start_date) {
            console.log('Pass to createSchedule from updateDevice');
            await createSchedule(updatedDevice);
        }
        
        res.status(200).send({
            message: 'Device updated successfully',
            device: updatedDevice
        });
    } catch (error) {
        res.status(500).send({ message: 'Error updating device', error: error.message });
    }
};

exports.fetchDeviceById = async (req, res) => {
    const { id } = req.params;
    
    try {
        const device = await MedWise.findById(id);
        if (!device) {
            return res.status(404).send({ message: 'Device not found' });
        }
        res.status(200).json(device);
    } catch (error) {
        res.status(500).send({ message: 'Error fetching device', error: error.message });
    }
    
};





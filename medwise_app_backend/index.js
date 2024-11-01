const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

mongoose.connect('mongodb://localhost:27017/medwise_database', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  });

const app = express();
const PORT = 3000;

// Middleware to parse JSON requests
app.use(bodyParser.json());

// Define a schema for device
const medwiseSchema = new mongoose.Schema({
    is_paired: { type: Boolean, required: true },
    serial_number: { type: String },
    taker_name: { type: String },
    box_mode: { type: String },
    carer_name: { type: String },
    intake_times: { type: Number },
    start_date: { type: Date }, 
    layer1_name: { type: String },
    layer1_time: { type: String }, 
    layer2_name: { type: String },
    layer2_time: { type: String },
    layer3_name: { type: String },
    layer3_time: { type: String },
    reminder_setting: { type: String },
    reminder_sound: { type: String },
    reminder_note: { type: String },
    led_color: { type: String },
    is_door_open: { type: Boolean, default: false },
    is_lid_open: { type: Boolean, default: false },
    complete_intake: { type: Number, default: 0},
    complete_percentage: { type: Number, default: 0.0}
}, { timestamps: true });
  

const MedWise = mongoose.model('MedWise', medwiseSchema);

// Initial route
app.get('/', (req, res) => {
    res.send('Hello from Node.js Backend!');
});

// Route to send sample data
app.get('/api/data', (req, res) => {
    res.json({ message: 'This is data from Node.js' });
});

// In-memory storage for devices

app.post('/devices', async (req, res) => {
    const {is_paired, serial_number, taker_name, box_mode, carer_name, intake_times } = req.body;
    console.log(req.body)
  
    try {
        const newDevice = new MedWise({
            is_paired,
            serial_number,
            taker_name,
            box_mode,
            carer_name,
            intake_times
        });
  
        const savedDevice = await newDevice.save();

        res.status(200).send({
            message: 'Device info stored successfully in MongoDB',
            device_id: savedDevice._id,
        });
    } catch (error) {
        console.error('Error storing device info:', error);
        res.status(500).send({ message: 'Error storing device info', error: error.message });
    }
       
});
  
  // Route to get all stored devices from MongoDB
app.get('/devices', async (req, res) => {
    try {
        const devices = await MedWise.find();
        res.json(devices);
    } catch (error) {
        res.status(500).send({ message: 'Error fetching devices', error: error.message });
    }
});

// Start the server
app.listen(PORT, () => {
console.log(`Server running at http://localhost:${PORT}`);
});
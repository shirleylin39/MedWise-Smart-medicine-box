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
    reminder_setting: { type: String,
        default: function() {
          return this.box_mode === 'self' ? 'only app' : 'both';
        },
      },
    reminder_sound: { type: String, default: 'soft music'},
    reminder_note: { type: String },
    led_color: { type: String, default: 'red' },
    is_door_open: { type: Boolean, default: false },
    is_lid_open: { type: Boolean, default: false },
    complete_intake: { type: Number, default: 0},
    complete_percentage: { type: Number, default: 0.0},
    scheduled_intake: [
      {
          date: { type: Date, required: true }, 
          medication: { type: String, required: true }, 
          amount: { type: String }, 
      }
  ],
    medication_history: [
      {
          date: { type: Date, default: Date.now }, 
          medication: { type: String, required: true }, 
          amount: { type: String }, 
      }
  ]
}, { timestamps: true });




  

const MedWise = mongoose.model('MedWise', medwiseSchema);

// Start the server
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});

// Initial route
app.get('/', (req, res) => {
    res.send('Hello from Node.js Backend!');
});

// Route to send sample data
app.get('/api/data', (req, res) => {
    res.json({ message: 'This is data from Node.js' });
});


 // Route to get all stored devices from MongoDB
app.get('/devices', async (req, res) => {
    try {
        const devices = await MedWise.find().sort({ updatedAt: -1 });
        res.json(devices);
    } catch (error) {
        res.status(500).send({ message: 'Error fetching devices', error: error.message });
    }
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
  

//Update device info to backend
app.put('/devices/:id', async (req, res) => {
    const { id } = req.params;
    const updateData = req.body;
  
    try {
      
      const updatedDevice = await MedWise.findByIdAndUpdate(id, updateData, { new: true });
  
      if (!updatedDevice) {
        return res.status(404).send({ message: 'Device not found' });
      }
  
      res.status(200).send({
        message: 'Device updated successfully',
        device: updatedDevice
      });
    } catch (error) {
      console.error('Error updating device:', error);
      res.status(500).send({ message: 'Error updating device', error: error.message });
    }
});

// Fetch updated device by id
app.get('/devices/:id', async (req, res) => {
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
 });


medwiseSchema.pre('save', async function(next) {
    try {
        if (this.is_door_open) {
            this.complete_intake += 1;
        } 
   
        if (this.is_lid_open || this.isModified('start_date')) {
            this.complete_intake = 0;
        }

        const divisor = this.intake_times === 1 ? 7 : this.intake_times === 2 ? 14 : 21;
        this.complete_percentage = parseFloat((this.complete_intake / divisor).toFixed(1));

        next();
    } catch (error) {
    next(error);
    }   
});

app.put('/devices/:id/record', async (req, res) => {
  const { id } = req.params;
  const { medication, amount } = req.body;

  try {
      const updatedDevice = await MedWise.findByIdAndUpdate(
          id,
          {
              $push: {
                  medication_history: {
                      medication,
                      amount,
                      date: new Date() // 自動添加當前時間
                  }
              }
          },
          { new: true }
      );

      if (!updatedDevice) {
          return res.status(404).send({ message: 'Device not found' });
      }

      res.status(200).send({
          message: 'Medication record added successfully',
          device: updatedDevice
      });
  } catch (error) {
      console.error('Error updating medication record:', error);
      res.status(500).send({ message: 'Error updating medication record', error: error.message });
  }
});

app.get('/devices/:id/medication-history', async (req, res) => {
  const { id } = req.params;

  try {
      const device = await MedWise.findById(id, 'medication_history');
      if (!device) {
          return res.status(404).send({ message: 'Device not found' });
      }

      res.status(200).json(device.medication_history);
  } catch (error) {
      res.status(500).send({ message: 'Error fetching medication history', error: error.message });
  }
});

medwiseSchema.pre('save', async function(next) {
  if (this.isModified('start_date') && this.start_date) {
      const currentDate = new Date(this.start_date);
      const daysToSchedule = 7; // 排程天數
      const intakeTimes = [
          { time: this.layer1_time, name: this.layer1_name },
          { time: this.layer2_time, name: this.layer2_name },
          { time: this.layer3_time, name: this.layer3_name }
      ];

      for (let i = 0; i < daysToSchedule; i++) {
          intakeTimes.forEach(({ time, name }) => {
              if (time) {
                  const [hour, minute] = time.split(':').map(Number);
                  const scheduledDate = new Date(currentDate);
                  scheduledDate.setDate(currentDate.getDate() + i);
                  scheduledDate.setHours(hour, minute, 0, 0);

                  this.scheduled_intake.push({
                      date: scheduledDate,
                      medication: name,
                      amount: 'default amount' // 可根據需求設置
                  });
              }
          });
      }
  }
  next();
});

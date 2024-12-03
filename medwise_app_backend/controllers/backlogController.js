const MedWise = require('../models/medwise');
const Backlog = require('../models/backlog');
const mongoose = require('mongoose');

exports.createSchedule = async (medWise) => {

    try {     
        const startDate = new Date(medWise.start_date);
        const daysToSchedule = 7; 
        const intakeDetails = [
            { time: medWise.layer1_time, name: medWise.layer1_name },
            { time: medWise.layer2_time, name: medWise.layer2_name },
            { time: medWise.layer3_time, name: medWise.layer3_name }
        ];

        for (let i = 0; i < daysToSchedule; i++) {
            for (const { time, name } of intakeDetails) {
                if (time) {
                    const [timePart, modifier] = time.split(' '); // 分離 "3:08" 和 "PM"
                    let [hour, minute] = timePart.split(':').map(Number); // 分離小時和分鐘
                           
                    if (modifier === 'PM' && hour !== 12) {
                        hour += 12;
                    } else if (modifier === 'AM' && hour === 12) {
                        hour = 0;
                    }

                    const intakeDate = new Date(startDate);
                    intakeDate.setDate(intakeDate.getDate() + i);
                    const intakeDateTime = new Date(intakeDate)
                    intakeDateTime.setHours(hour, minute, 0, 0);


                    const newBacklog = new Backlog({
                        device_id: medWise._id,
                        intake_date: intakeDate,
                        intake_time: time,
                        intake_date_time: intakeDateTime,
                        medication: name,
                        reminder_note: medWise.reminder_note,
                        status: 'scheduled'
                    });

                    await newBacklog.save();
                }
            }
        }
        console.log('Schedule created successfully' );
        return true; 
    } catch (error) {
        console.error('Error creating schedule:', error);
        throw error; 
    }
};

exports.fetchBacklogs = async (req, res) => {
    try {
        const backlogs = await Backlog.find().populate('device_id', 'taker_name');
        res.status(200).json(backlogs);
    } catch (error) {
        console.error('Error fetching backlogs:', error);
        res.status(500).send({ message: 'Error fetching backlogs', error: error.message });
    }
};

exports.fetchBacklogByDevice = async (req, res) => {
    const { deviceId } = req.params;

    try {
        const backlogs = await Backlog.find({ device_id: new mongoose.Types.ObjectId(deviceId) }).populate('device_id', 'taker_name');
        
        if (backlogs.length === 0) {
            return res.status(404).send({ message: 'No backlogs found for this device' });
        }

        res.status(200).json(backlogs);
    } catch (error) {
        console.error('Error fetching backlogs by deviceId:', error);
        res.status(500).send({ message: 'Error fetching backlogs', error: error.message });
    }
};


const MedWise = require('../models/medwise');

setInterval(async () => {
    try {
        const now = new Date();
        const devices = await MedWise.find({ 'scheduled_intake.date': { $lte: now } });

        devices.forEach(async (device) => {
            const intakesToMove = device.scheduled_intake.filter(intake => intake.date <= now);
            device.medication_history.push(...intakesToMove);
            device.scheduled_intake = device.scheduled_intake.filter(intake => intake.date > now);
            await device.save();
        });
    } catch (error) {
        console.error('Error transferring scheduled intake to medication history:', error);
    }
}, 60000); //1 min


const { transferScheduledToHistory } = require('../controllers/medicationHistoryController');

setInterval(async () => {
    await transferScheduledToHistory();
}, 60000);
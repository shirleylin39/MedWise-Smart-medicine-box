const MedWise = require('../models/medwise');
const Backlog = require('../models/backlog');

const THIRTY_MINUTES = 30 * 60 * 1000;

async function updateIntakeStatus() {
    try {
        const now = new Date();
        const currentIntakes = await Backlog.find({ intake_date_time: { $lte: now }, status: 'scheduled' });

        currentIntakes.forEach(async (intake) => {
            const medDevice = await MedWise.findById(Backlog.device_id);
            const timeDifference = now - Backlog.intake_date_time;

            if (medDevice && medDevice.is_door_open && timeDifference <= THIRTY_MINUTES) {
                Backlog.status = 'completed';
                console.log(`Notification: Complete Intake.`);
            } else {
                Backlog.status = 'incomplete';
                console.log(`Notification: Incomplete Intake.`);
            }

            await intake.save();
        });
    } catch (error) {
        console.error('Error transferring scheduled intake to medication history:', error);
    }
}

setInterval(updateIntakeStatus, 60000);

const MedWise = require('../models/medwise');
const Backlog = require('../models/backlog');

const THIRTY_MINUTES = 30 * 60 * 1000;

async function updateIntakeStatus() {
    try {
        const now = new Date();
        const currentIntakes = await Backlog.find({ intake_date_time: { $lte: now }, status: 'scheduled' });

        console.log(`Found ${currentIntakes.length} intakes to process.`);
        

        currentIntakes.forEach(async (intake) => {
            const medDevice = await MedWise.findById(intake.device_id);
            const timeDifference = now - intake.intake_date_time;

            if (medDevice && medDevice.is_door_open && timeDifference <= THIRTY_MINUTES) {
                intake.status = 'completed';
                console.log(`Notification: Complete Intake.`);
            } else {
                intake.status = 'incomplete';
                console.log(`Notification: Incomplete Intake.`);
            }

            await intake.save();
        });
    } catch (error) {
        console.error('Error transferring scheduled intake to medication history:', error);
    }
}

setInterval(updateIntakeStatus, 60000);

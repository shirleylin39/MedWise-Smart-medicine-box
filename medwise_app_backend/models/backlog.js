const mongoose = require('mongoose');

const backlogSchema = new mongoose.Schema({
    device_id: { type: mongoose.Schema.Types.ObjectId, ref: 'MedWise', required: true },
    intake_date: { type: Date, required: true },
    intake_time: { type: String, required: true},
    intake_date_time: { type: Date, required: true },
    medication: { type: String },
    reminder_note: { type: String },
    status: { type: String, enum: ['scheduled', 'completed', 'incomplete'], required: true, default: 'scheduled' }   
}, { timestamps: true });

module.exports = mongoose.model('Backlog',backlogSchema);

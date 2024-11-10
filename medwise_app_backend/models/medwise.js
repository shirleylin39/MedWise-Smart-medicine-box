const mongoose = require('mongoose');

const medwiseSchema = new mongoose.Schema({
    is_paired: { type: Boolean, required: true },
    serial_number: { type: String },
    taker_name: { type: String, required: true},
    box_mode: { type: String,  enum: ['self', 'others'] },
    carer_name: { type: String },
    intake_times: { type: Number },
    start_date: { type: Date }, 
    layer1_name: { type: String },
    layer1_time: { type: String }, 
    layer2_name: { type: String },
    layer2_time: { type: String },
    layer3_name: { type: String },
    layer3_time: { type: String },
    reminder_setting: { type: String, enum: ['only app', 'only box', 'both'], 
        default: function() {
          return this.box_mode === 'self' ? 'only app' : 'both';
        },
      },
    reminder_sound: { type: String, enum: ['beep', 'soft music', 'chime', 'bell', 'alert', 'melody', 'harp', 'whistle'], default: 'soft music'},
    reminder_note: { type: String },
    led_color: { type: String, default: 'red', enum: ['red', 'white', 'off'] },
    is_door_open: { type: Boolean, default: false },
    is_lid_open: { type: Boolean, default: false },
    complete_intake: { type: Number, default: 0},
    complete_percentage: { type: Number, default: 0.0},
}, { timestamps: true });

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

module.exports = mongoose.model('MedWise', medwiseSchema);
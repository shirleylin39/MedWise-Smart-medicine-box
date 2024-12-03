const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const medwiseRoutes = require('./routes/medwiseRoutes');
const backlogRoutes = require('./routes/backlogRoutes');

const app = express();
const PORT = 3000;

// Connect to MongoDB
mongoose.connect('mongodb://localhost:27017/medwise_database', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
});

app.use(bodyParser.json());
app.use('/api', medwiseRoutes);
app.use('/api', backlogRoutes);

app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});
 

// Schedule checker
require('./utils/dbScheduler');

const express = require('express');
const mongoose = require('mongoose');
const app = express();
const PORT = process.env.PORT || 8080;

require('dotenv').config();

app.use(express.json());

app.use('/programs', require('./routes/programRoutes'));
app.use('/tracks', require('./routes/trackRoutes'));

mongoose.connect(process.env.MONGODB_URI)
.then(() => {
    app.listen(PORT, () => console.log(`Server started on port ${PORT}`));
});
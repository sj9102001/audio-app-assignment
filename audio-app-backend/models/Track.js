const mongoose = require('mongoose');

const TrackSchema = new mongoose.Schema({
  programId: { type: mongoose.Schema.Types.ObjectId, ref: 'Program' },
  title: String,
  description: String,
  audioFileLink: String, 
});

module.exports = mongoose.model('Track', TrackSchema);

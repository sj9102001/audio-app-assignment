const mongoose = require('mongoose');

const ProgramSchema = new mongoose.Schema({
  name: String,
  description: String,
  imageUrl: String,
  duration: String
});

module.exports = mongoose.model('Program', ProgramSchema);

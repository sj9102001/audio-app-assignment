const Program = require('../models/Program');

exports.fetchPrograms =  async (req, res) => {
    try {
      const programs = await Program.find();
      res.json(programs);
    } catch (err) {
      res.status(500).send('Server Error');
    }
}
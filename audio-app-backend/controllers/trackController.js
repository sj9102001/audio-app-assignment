const Track = require('../models/Track');

exports.fetchTracks =  async (req, res) => {
    try {
      const tracks = await Track.find({ programId: req.params.programId });
      res.json(tracks);
    } catch (err) {
      res.status(500).send('Server Error');
    }
}
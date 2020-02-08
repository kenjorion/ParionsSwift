import express from 'express';

const router = express.Router();

router.post('/new', async (req, res) => {
    const db = req.app.get('db');
    db.collection("matchs").add(req.body).then(() => {
        res.sendStatus(200);
    });
    
});


module.exports = router;

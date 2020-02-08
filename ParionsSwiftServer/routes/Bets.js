import express from 'express';

const router = express.Router();

router.post('/new', (req, res) => {
    const db = req.app.get('db');
    const gain = req.body.bets.map(bet => {
        switch(bet.odd){
            case 0: 
                return bet.oddA*req.body.betAmount;
            case 1: 
                return bet.oddB*req.body.betAmount;
            case 2:
                return bet.oddC*req.body.betAmount;
        }
    });

    const totalGain = gain.reduce((acc, curr) => acc + curr);
    let bets = req.body;
    bets.totalGain = totalGain;
    db.collection("bets").add(bets).then((bet) => {
        db.collection('users').doc(req.body.userID).get().then(user => {
            db.collection('users').doc(req.body.userID).update({
                'availableFund': user.data().availableFund - req.body.betAmount
            }).then(() => {
                res.status(200).send({id: bet.id}); 
            });  
        });
    });
});


router.post('/activeBets', async (req, res) => {
    const db = req.app.get('db');
    const bets = await Promise.all(req.body.betsID.map( async bet => {
        return await db.collection('bets').doc(bet.id).get().then(bet => bet.data());
    }));
    res.status(200).send(bets);
});


module.exports = router;

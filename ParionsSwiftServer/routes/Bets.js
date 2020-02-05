import express from 'express';

const router = express.Router();

router.post('/new', (req, res) => {
    console.log(req.body);
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

    db.collection("bets").add(req.body);
    db.collection('users').doc(req.body.userID).get().then(user => {
        db.collection('users').doc(req.body.userID).update({
            'availableFund': user.data().availableFund - req.body.betAmount
        }).then(() => {
            res.sendStatus(200); 
        });  
    });
});


module.exports = router;

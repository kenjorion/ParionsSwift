import express from 'express';

const router = express.Router();

router.post('/', (req, res) => {
    const db = req.app.get('db');
    let user = {};
    db.collection('users').where("username", "==", req.body.username)
    .get()
    .then(users => {
        users.forEach((foundUser) => {
            if (foundUser.data().password == req.body.password) {
                user = foundUser.data();
                user.id = foundUser.id
            }
        });
        res.status(200).send(user);
    })
    .catch(err => {
        console.log(err);
        res.sendStatus(500);
    });
});


module.exports = router;

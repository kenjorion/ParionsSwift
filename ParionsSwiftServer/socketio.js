import io from "socket.io";

const randomIntFromInterval =(min, max) => { // min and max included
  return Math.floor(Math.random() * (max - min + 1) + min);
};

const mockActiveMatchs = [
  {
    id: 'm123456',
    sport: 'football',
    category: 'champions_league',
    teamA: 'PSG',
    teamB: 'OL',
    scoreA: 0,
    scoreB: 0,
    oddA: 1.5,
    oddB: 2,
    oddC: 4,
    duration: 0
  },
  {
    id: 'm12345',
    sport: 'football',
    category: 'champions_league',
    teamA: 'OM',
    teamB: 'FCB',
    scoreA: 0,
    scoreB: 0,
    oddA: 1.5,
    oddB: 2,
    oddC: 4,
    duration: 0
  }
];

const randomMatch = () => {
  mockActiveMatchs.forEach(match => {
    const random = randomIntFromInterval(0, 100);
    match.duration += 5;
    if(random < 3){
      if(random%2 === 0){
        match.scoreA += 1;
        return true;
      } else {
        match.scoreB += 1;
        return true;
      }
    }
    return false;
  });
};

const SocketIO = {
  start: server => {
    const ioServer = io(server);
    ioServer.on('connect', socket => {
      socket.emit('getActiveMatchs', mockActiveMatchs);
      setInterval(() => {
        randomMatch();
        socket.emit('getActiveMatchs', mockActiveMatchs);
      }, 5000);


      socket.on

    });
  }
};

export default SocketIO;
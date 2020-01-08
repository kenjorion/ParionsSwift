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
    rwA: 8, 
    rwB: 2, 
    cwA: 4, 
    cwB: 3, 
    hwA: 5, 
    awB: 2,
    oddA : algoA(8, 4, 4),
    oddB : algoB(2, 3, 2),
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
        match.oddA -= 0.1;
        match.oddB += 0.3;
        return true;
      } else {
        match.scoreB += 1;
        match.oddB -= 0.1; 
        match.oddA += 0.3;
        return true;
      }
    }
    return false;
  });
};
let SocketIO = {
  start: server => {
    const ioServer = io(server);

    

    ioServer.on('connect', socket => {
      setInterval(() => {
        randomMatch();
        socket.emit('getActiveMatchs', mockActiveMatchs);
      }, 5000);
    });


  }
}; 

function algoA (rwA, cwA, hwA) {
  var oddA = 1.5;
    let prwA = (rwA/20)*100;
    prwA = (prwA * oddA) / 100; 
    let rwAT = (oddA/2) - prwA;  

    let pcwA = (cwA/20)*100;
    pcwA = (pcwA * oddA) / 100; 
    let cwAT = (oddA/4) - pcwA;  

    let phwA = (hwA/20)*100;
    phwA = (phwA * oddA) / 100; 
    let hwAT = (oddA/4) - phwA; 

    //let csAT = (oddA/4)*(csA/5); 
    //let hwAT = (oddA/4)*(hwA/5); 

  if (rwA + cwA + hwA != 20 ) {
      oddA += rwAT + cwAT + hwAT;
  } 
  return oddA;

} 

function algoB (rwB, cwB, awB) {
  var oddB = 3;
  let prwB = (rwB/20)*100;
  prwB = (prwB * oddB) / 100; 
  let rwBT = (oddB/2) - prwB;  

  let pcwB = (cwB/20)*100;
  pcwB = (pcwB * oddB) / 100; 
  let cwBT = (oddB/4) - pcwB;  

  let pawB = (awB/20)*100;
  pawB = (pawB * oddB) / 100; 
  let awBT = (oddB/4) - pawB; 

  if (rwB + cwB + awB != 20 ) {
  oddB += rwBT + cwBT + awBT;  
  } 
  return oddB;
}

export default SocketIO;
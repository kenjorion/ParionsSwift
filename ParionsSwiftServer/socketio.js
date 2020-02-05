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
    oddA : algoA(8, 4, 5),
    oddB : algoB(2, 3, 2),
    oddC: algoC(8, 4, 5, 2, 3, 2),
    duration: 0,
    bets: [
      {
        name: "1 N 2 - Live 90 Mins",
        teamA: 'PSG',
        teamB: 'OL',
        oddA : algoA(8, 4, 5),
        oddB : algoB(2, 3, 2),
        oddC: algoC(8, 4, 5, 2, 3, 2),
      },
      {
        name: "1 N 2 - Live Mi-temps",
        teamA: 'PSG',
        teamB: 'OL',
        oddA : algoA(8, 4, 5),
        oddB : algoB(2, 3, 2),
        oddC: algoC(8, 4, 5, 2, 3, 2),
      }
    ]
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
    duration: 0,
    bets: [
      {
        name: "1 N 2 - Live 90 Mins",
        teamA: 'PSG',
        teamB: 'OL',
        oddA : algoA(8, 4, 5),
        oddB : algoB(2, 3, 2),
        oddC: algoC(8, 4, 5, 2, 3, 2),
      },
      {
        name: "1 N 2 - Live Mi-temps",
        teamA: 'PSG',
        teamB: 'OL',
        oddA : algoA(8, 4, 5),
        oddB : algoB(2, 3, 2),
        oddC: algoC(8, 4, 5, 2, 3, 2),
      }
    ]
  }
];

const randomMatch = () => {
  mockActiveMatchs.forEach(match => {
    const random = randomIntFromInterval(0, 100);
    match.duration += 5;
    if(random < 3){
      if(random%2 === 0){
        if (match.scoreA - match.scoreB == 1 || match.scoreB - match.scoreA ==1) { 
          match.oddC += 1;
        }
        match.scoreA += 1;
        match.oddA -= 0.2 
        match.oddA = Math.round(match.oddA*100)/100;
        match.oddB += 0.3;
        match.oddB = Math.round(match.oddB*100)/100; 
        if ( match.oddA <= 1 ) 
          match.oddA = 1.1; 
        return true;
      } else {
        if (match.scoreA === match.scoreB && match.scoreA >= 1 && match.duration < 50) { 
          match.oddC -= 1;
        }
        else if (match.scoreA - match.scoreB == 2 || match.scoreB - match.scoreA ==2) { 
          match.oddC += 1;
        }
        match.scoreB += 1;
        match.oddB -= 0.2; 
        match.oddB = Math.round(match.oddB*100)/100;
        match.oddA += 0.3;
        match.oddA = Math.round(match.oddA*100)/100;
        if ( match.oddB <= 1 ) 
          match.oddB = 1.1; 
        return true;
      }
    }
    while (match.scoreA === match.scoreB && match.scoreA >= 1) { 
      match.oddC -= 1;
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
      }, 5000);
      setInterval(() => {
        socket.emit('getActiveMatchs', mockActiveMatchs);
      }, 5000);

      socket.on('getBetsByID', matchID => {
        const match = mockActiveMatchs.find(match => match.id === matchID);
        console.log(match.bets);
        setInterval(() => {
          socket.emit('receiveBetsByID', match.bets);
        }, 5000);
      });

    });


  }
}; 

function algoA (rwA, cwA, hwA) {
  var oddA = 1.5;
  var oddAFinal; 

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
      if ( oddA <= 1 ) 
      oddA = 1.1; 
  }
  oddAFinal = Math.round(oddA*100)/100;
  return oddAFinal;

} 

function algoB (rwB, cwB, awB) {
  var oddB = 2;
  var oddBFinal; 
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
    if ( oddB <= 1 ) 
      oddB = 1.1; 
  } 
  oddBFinal = Math.round(oddB*100)/100
  return oddBFinal;
} 

function algoC (rwA, cwA, hwA, rwB, cwB, awB) {
  var oddA = algoA(rwA, cwA, hwA);
  var oddB = algoB(rwB, cwB, awB);
  var oddC;
  var oddCFinal;
  let diff = oddB - oddA;

  if ( diff <= 1)
    oddC = 4 * (diff)
  else if ( diff <= 1.5 && diff > 1)
    oddC = 3.5 * (diff); 
  else if ( diff <= 2 && diff > 1.5) 
    oddC = 3 * (diff); 
  else if ( diff <= 2.5 && diff > 2)
    oddC = 2.5 * (diff);
  else if ( diff <= 3 && diff > 2.5)
    oddC = 2 * (diff);
  else if ( diff <= 3.5 && diff > 3)
    oddC = 1.5 * (diff);
  else if ( diff <= 4 && diff > 3.5)
    oddC = 1.25 * (diff);
  else if ( diff > 4)
    oddC = 2;
  
  oddCFinal = Math.round(oddC*100)/100
  return oddCFinal;

}

export default SocketIO;
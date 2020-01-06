import io from "socket.io";

const SocketIO = {
  start: server => {
    const ioServer = io(server);
    let allActiveMatchs = [
      {
        teamA: 'PSG',
        teamB: 'OL',
        scoreA: 2,
        scoreB: 3,
        oddA: 1.5,
        oddB: 2,
        duration: 55
      },
      {
        teamA: 'OM',
        teamB: 'FCB',
        scoreA: 2,
        scoreB: 3,
        oddA: 1.5,
        oddB: 2,
        duration: 55
      }
    ];

    ioServer.on('connect', socket => {
      setInterval(() => {
        socket.emit('getActiveMatchs', allActiveMatchs);
      }, 5000);
    });
  }
};

export default SocketIO;
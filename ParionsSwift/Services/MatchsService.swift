//
//  MatchsService.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 03/01/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import Foundation
import SocketIO

class MatchsServices {

    static let shared = MatchsServices()
    let manager = SocketManager(socketURL: URL(string: "https://parions-swift.herokuapp.com")!, config: [.log(false), .forceWebsockets(true), .compress])
    var socket:SocketIOClient!

    func connect(){
        socket = manager.defaultSocket
        socket.connect()
    }
    
    func disconnect(){
        socket = manager.defaultSocket
        socket.disconnect()
    }
    
    func listenForNewMatchs(completion: @escaping (_ matchs: [Match]) ->  Void){
        socket.on("getActiveMatchs") {data, _ in
            var allMatchs = [Match]()
            guard let matchs = data[0] as? [[String: Any]] else { return }
            matchs.forEach({ match in
                guard
                let id = match["id"] as? String,
                let teamA = match["teamA"] as? String,
                let teamB = match["teamB"] as? String,
                let scoreA = match["scoreA"] as? Int,
                let scoreB = match["scoreB"] as? Int,
                let oddA = match["oddA"] as? Double,
                let oddB = match["oddB"] as? Double,
                let oddC = match["oddC"] as? Double,
                let duration = match["duration"] as? Int,
                let stateMatch = match["duration"] as? Int,
                let result = match["result"] as? Int
                else {
                    return
                }
                
                let newMatch = Match(id: id, teamA: teamA, teamB: teamB, scoreA: scoreA, scoreB: scoreB, oddA: oddA, oddB: oddB, oddC: oddC, duration: duration, stateMatch: stateMatch, result: result)
                allMatchs.append(newMatch)
                if(allMatchs.count == matchs.count) {
                    completion(allMatchs)
                }
        
            })
            if(matchs.count == 0){

                completion([])
            }
            
        }
    }
    
    func getActiveBets(matchID: String, completion: @escaping (_ bets: [Bet]) ->  Void){
        socket.emit("getBetsByID", matchID);
        socket.on("receiveBetsByID") {data, _ in
            var allBets = [Bet]()
            guard let bets = data[0] as? [[String: Any]] else { return }
            bets.forEach({ bet in
                guard
                    let name = bet["name"] as? String,
                    let teamA = bet["teamA"] as? String,
                    let teamB = bet["teamB"] as? String,
                    let oddA = bet["oddA"] as? Double,
                    let oddB = bet["oddB"] as? Double,
                    let oddC = bet["oddC"] as? Double
                else {
                    return
                        
                }
                let newBet = Bet(name: name, teamA: teamA, teamB: teamB, oddA: oddA, oddB: oddB, oddC: oddC)
                allBets.append(newBet)
                if(allBets.count == bets.count) {
                    completion(allBets)
                }
            })
            if(allBets.count == 0){
                completion([])
            }
        }
    }
    
    func getMatchsByID(activeBets: [ActiveBet], completion: @escaping (_ bets: [Match]) ->  Void){
        let matchActiveIndex = activeBets.map { res in
        return [
            "id": res.matchID
        ]}
        socket.emit("getMatchsByID", matchActiveIndex);
        socket.on("receiveMatchsByID") {data, _ in
            var allMatchs = [Match]()
            guard let matchs = data[0] as? [[String: Any]] else { return }
            matchs.forEach({ match in
                guard
                let id = match["id"] as? String,
                let teamA = match["teamA"] as? String,
                let teamB = match["teamB"] as? String,
                let scoreA = match["scoreA"] as? Int,
                let scoreB = match["scoreB"] as? Int,
                let oddA = match["oddA"] as? Double,
                let oddB = match["oddB"] as? Double,
                let oddC = match["oddC"] as? Double,
                let duration = match["duration"] as? Int,
                let stateMatch = match["stateMatch"] as? Int,
                let result = match["result"] as? Int
                else {
                    return
                }
                
                let newMatch = Match(id: id, teamA: teamA, teamB: teamB, scoreA: scoreA, scoreB: scoreB, oddA: oddA, oddB: oddB, oddC: oddC, duration: duration, stateMatch: stateMatch, result: result)
                print(newMatch.duration)
                allMatchs.append(newMatch)
                if(allMatchs.count == matchs.count) {
                    completion(allMatchs)
                }
                
            })
            if(matchs.count == 0){
                
                completion([])
            }
        }
    }
    
}

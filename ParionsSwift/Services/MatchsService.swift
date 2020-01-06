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
    let manager = SocketManager(socketURL: URL(string: "http://localhost:8080")!, config: [.log(true), .forceWebsockets(true), .compress])
    var socket:SocketIOClient!

    func connect(){
        socket = manager.defaultSocket
        socket.connect()
    }
    
    func disconnect(){
        socket = manager.defaultSocket
        socket.disconnect()
    }
    
    func listenForNewMatchs(completion: @escaping (_ matchs: Match) ->  Void){
        socket.on("getActiveMatchs") {data, _ in
            guard let matchs = data[0] as? [[String: Any]] else { return }
            matchs.forEach({ match in
            guard
            let teamA = match["teamA"] as? String,
            let teamB = match["teamB"] as? String,
            let scoreA = match["scoreA"] as? Int,
            let scoreB = match["scoreB"] as? Int,
            let oddA = match["oddA"] as? Double,
            let oddB = match["oddB"] as? Double,
            let duration = match["duration"] as? Int

            else {
                return
                
            }
                
            let newMatch = Match(teamA: teamA, teamB: teamB, scoreA: scoreA, scoreB: scoreB, oddA: oddA, oddB: oddB, duration: duration)
                
            completion(newMatch)
            
        })}
    }
    
}

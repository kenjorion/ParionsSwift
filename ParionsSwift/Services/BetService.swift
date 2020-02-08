//
//  LoginService.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 04/02/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import Foundation
import Alamofire

public class BetService {
    
    public static let `default` = BetService()
    
    public func newBet(matchID: String, selectedBets: [SelectedBet], betAmount: Double, completion: @escaping (String) -> Void) {
        
        let bets = selectedBets.map { res in
        return [
            "name": res.bet.name,
            "teamA": res.bet.teamA,
            "teamB": res.bet.teamB,
            "oddA": res.bet.oddA,
            "oddB": res.bet.oddB,
            "oddC": res.bet.oddC,
            "index": res.index,
            "odd": res.odd
        ]}
        
        let parameters: Parameters = ["matchID": matchID, "bets": bets, "betAmount": betAmount, "userID": UserSingleton.user.id]
        
        Alamofire.request("http://localhost:8080/bets/new", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (res) in
            guard let json = res.result.value as? [String: Any],
            let id = json["id"] as? String
            else {
                return
            }
            print(id)
            completion(id)
        }
    }
    
    
    public func getActiveBets(activeBets: [String], completion: @escaping ([ActiveBet]) -> Void) {
        
        let betsID = activeBets.map { res in return ["id": res]}
        
        let parameters: Parameters = ["betsID": betsID]
        
        Alamofire.request("http://localhost:8080/bets/activeBets", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (res) in
            var allActiveBets = [ActiveBet]()
            guard let activeBets = res.result.value as? [[String: Any]] else { return }
            
            for(index, activeBet) in activeBets.enumerated() {
                guard
                let betAmount = activeBet["betAmount"] as? Double,
                let matchID = activeBet["matchID"] as? String,
                let totalGain = activeBet["totalGain"] as? Double,
                let userID = activeBet["userID"] as? String,
                let bets = activeBet["bets"] as? [[String: Any]]
                else {
                    return
                }
                var allSelectedBets:[SelectedBet] = []
                bets.forEach({ bet in
                    guard
                    let name = bet["name"] as? String,
                    let odd = bet["odd"] as? Int,
                    let index = bet["index"] as? Int,
                    let teamA = bet["teamA"] as? String,
                    let teamB = bet["teamB"] as? String,
                    let oddA = bet["oddA"] as? Double,
                    let oddB = bet["oddB"] as? Double,
                    let oddC = bet["oddC"] as? Double
                    else {
                        return
                    }
                    
                    let newBet = Bet(name: name, teamA: teamA, teamB: teamB, oddA: oddA, oddB: oddB, oddC: oddC)
                    let selectedBet = SelectedBet(bet: newBet, index: index, odd: odd)
                    allSelectedBets.append(selectedBet)
                    if(allSelectedBets.count == bets.count) {
                        return
                    }
                })
                
                let newActiveBet = ActiveBet(betAmount: betAmount, selectedBets: allSelectedBets, matchID: matchID, totalGain: totalGain, userID: userID)
                
                allActiveBets.append(newActiveBet)
                if(allActiveBets.count == activeBets.count) {
                    completion(allActiveBets)
                }
            }
            if(allActiveBets.count == 0){
                completion([])
            }
        }
    }
}

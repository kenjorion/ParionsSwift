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
    
    public func newBet(matchID: String, selectedBets: [SelectedBet], betAmount: Double) {
        
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
            print(res)
        }
    }
}

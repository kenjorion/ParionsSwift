//
//  Bet.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 04/02/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import Foundation


public struct ActiveBet {
    
    var betAmount: Double
    var selectedBets: [SelectedBet]
    var matchID: String
    var totalGain: Double
    var userID: String
    
    init(betAmount: Double, selectedBets: [SelectedBet], matchID: String, totalGain: Double, userID: String) {
        self.betAmount = betAmount
        self.selectedBets = selectedBets
        self.matchID = matchID
        self.totalGain = totalGain
        self.userID = userID
    }
}

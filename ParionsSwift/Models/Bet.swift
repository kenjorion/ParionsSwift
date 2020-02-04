//
//  Bet.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 04/02/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import Foundation

struct Bet {
    
    var name: String
    var teamA: String
    var teamB: String
    var oddA: Double
    var oddB: Double
    var oddC: Double
    
    init(name: String, teamA: String, teamB: String, oddA: Double, oddB: Double, oddC: Double) {
        self.name = name
        self.teamA = teamA
        self.teamB = teamB
        self.oddA = oddA
        self.oddB = oddB
        self.oddC = oddC
    }
}

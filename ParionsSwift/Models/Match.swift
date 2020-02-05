//
//  Match.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 18/12/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import Foundation


public class Match {
    
    var id: String
    var teamA: String
    var teamB: String
    var scoreA: Int
    var scoreB: Int
    var oddA: Double
    var oddB: Double
    var oddC: Double
    var duration: Int
    
    init(id: String, teamA: String, teamB: String, scoreA: Int, scoreB: Int, oddA: Double, oddB: Double, oddC: Double, duration: Int) {
        self.id = id
        self.teamA = teamA
        self.teamB = teamB
        self.scoreA = scoreA
        self.scoreB = scoreB
        self.oddA = oddA
        self.oddB = oddB
        self.oddC = oddC
        self.duration = duration
    }
}

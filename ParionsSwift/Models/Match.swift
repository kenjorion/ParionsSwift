//
//  Match.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 18/12/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import Foundation


struct Match {
    
    var teamA: String
    var teamB: String
    var scoreA: Int
    var scoreB: Int
    var oddA: Double
    var oddB: Double
    var duration: Int
    
    init(teamA: String, teamB: String, scoreA: Int, scoreB: Int, oddA: Double, oddB: Double, duration: Int) {
        self.teamA = teamA
        self.teamB = teamB
        self.scoreA = scoreA
        self.scoreB = scoreB
        self.oddA = oddA
        self.oddB = oddB
        self.duration = duration
    }
}

//
//  Bet.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 04/02/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import Foundation

public class User {
    
    var id: String
    var username: String
    var availableFund: Double
    
    init(id: String, username: String, availableFund: Double){
        self.id = id
        self.username = username
        self.availableFund = availableFund
    }
}


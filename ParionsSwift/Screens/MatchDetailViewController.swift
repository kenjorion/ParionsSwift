//
//  MatchDetailViewController.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 03/01/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import UIKit

class MatchDetailViewController: UIViewController {
    

    @IBOutlet weak var teamB: UILabel!
    @IBOutlet weak var teamA: UILabel!
    @IBOutlet var inputBet: UITextField!
    @IBOutlet weak var Validate: UIButton!
    @IBOutlet weak var totalOdd: UILabel!
    @IBOutlet var totalBet: UILabel!
    @IBOutlet weak var totalProfit: UILabel!
    @IBOutlet weak var homeBet: UIButton!
    @IBOutlet weak var tieBet: UIButton!
    @IBOutlet weak var awayBet: UIButton!
    @IBOutlet weak var walletPrice: UILabel!
    var match: Match!
    var finalOdd: Double! = 0.0
    var finalBet: Double! = 1.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamA.text = match.teamA
        teamB.text = match.teamB
    }
    
    @IBAction func addBet(_ sender: UIButton) {
        if let mText = inputBet.text {
        totalBet.text = mText
            finalBet = Double(mText) }
        if ((finalOdd != nil) && (finalBet != nil)) {
            let final = finalBet * finalOdd
        totalProfit.text = String(final)
        }
    }

    @IBAction func homeBet(_ sender: UIButton) {
        totalOdd.text = String(match.oddA)
        finalOdd = match.oddA
    }
    
    @IBAction func tieBet(_ sender: Any) {
        totalOdd.text = String(match.oddC)
        finalOdd = match.oddC
    }
    
    @IBAction func awayBet(_ sender: UIButton) {
        totalOdd.text = String(match.oddB)
        finalOdd = match.oddB
    }
    
}

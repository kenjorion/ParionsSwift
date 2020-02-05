//
//  MatchDetailViewController.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 03/01/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import UIKit

struct SelectedBet: Equatable {
    var bet: Bet
    var index: Int
    var odd: Int
    
    init(bet: Bet, index: Int, odd: Int) {
        self.bet = bet
        self.index = index
        self.odd = odd
    }
}


class MatchDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SelectOddDelegate {
    
    let cellIdentifier = "cell"
    var bets = [Bet]()
    var selectedBets = [SelectedBet]()
    @IBOutlet var tableView: UITableView!
    @IBOutlet var potentialGainLabel: UILabel!
    @IBOutlet var betTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BetTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        MatchsServices.shared.getActiveBets(matchID: "m12345", completion: { bets in
            self.bets = bets
            self.tableView.reloadData()
        })
        potentialGainLabel.text = "0.00€"
        betTextField.text = "0"
        betTextField.addTarget(self, action: #selector(MatchDetailViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BetTableViewCell
        let borderColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )
        cell.betName.text = bets[indexPath.row].name
        cell.teamALabel.text = bets[indexPath.row].teamA
        cell.teamBLabel.text = bets[indexPath.row].teamB
        cell.oddA.layer.borderWidth = 1
        cell.oddA.layer.borderColor = borderColor.cgColor
        cell.oddA.layer.cornerRadius = 5
        cell.oddA.setTitle(String(bets[indexPath.row].oddA), for: .normal)
        cell.oddB.layer.borderWidth = 1
        cell.oddB.layer.borderColor = borderColor.cgColor
        cell.oddB.layer.cornerRadius = 5
        cell.oddB.setTitle(String(bets[indexPath.row].oddB), for: .normal)
        cell.oddC.layer.borderWidth = 1
        cell.oddC.layer.borderColor = borderColor.cgColor
        cell.oddC.layer.cornerRadius = 5
        cell.oddC.setTitle(String(bets[indexPath.row].oddC), for: .normal)
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
    }
    
    func oddTapped(at index: IndexPath, oddIndex: Int) {
        selectedBets = selectedBets.filter({ $0.index != index[1] && $0.odd != oddIndex })
        selectedBets.append(SelectedBet(bet: bets[index[1]], index: index[1], odd: oddIndex))
        potentialGainLabel.text = String(format: "%.2f", calculPotentialGain()) + "€"
    }
    
    func removeOddTapped(at index: IndexPath, oddIndex: Int){
        selectedBets = selectedBets.filter({ $0.bet != bets[index[1]] })
        potentialGainLabel.text = String(format: "%.2f", calculPotentialGain()) + "€"
    }
    
    func calculPotentialGain() -> Double {
        
        var potentialGain: Double = 0.0;
        let bet: Double? = Double(self.betTextField.text!)
    
        selectedBets.forEach { selectedBet in
            switch selectedBet.odd {
                case 0:
                    potentialGain += bet! * selectedBet.bet.oddA
                case 1:
                    potentialGain += bet! * selectedBet.bet.oddB
                case 2:
                    potentialGain += bet! * selectedBet.bet.oddC
                default:
                    print("Error")
            }
        }
        
        return potentialGain
    }
    
    
}


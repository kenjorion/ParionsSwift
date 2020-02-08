//
//  MatchDetailViewController.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 03/01/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import UIKit

public struct SelectedBet: Equatable, Codable {
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
    var match: Match!
    var bets = [Bet]()
    var selectedBets = [SelectedBet]()
    @IBOutlet var tableView: UITableView!
    @IBOutlet var potentialGainLabel: UILabel!
    @IBOutlet var betTextField: UITextField!
    @IBOutlet var teamA: UILabel!
    @IBOutlet var scoreA: UILabel!
    @IBOutlet var scoreB: UILabel!
    @IBOutlet var teamB: UILabel!
    @IBOutlet var availableFund: UILabel!
    @IBOutlet var fundErrorLabel: UILabel!
    @IBOutlet var betAmountError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BetTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        MatchsServices.shared.getActiveBets(matchID: match.id, completion: { bets in
            self.bets = bets
            self.tableView.reloadData()
        })
        navigationItem.title = "Make a bet"
        fundErrorLabel.isHidden = true
        betAmountError.isHidden = true
        potentialGainLabel.text = "0.00€"
        betTextField.text = "0"
        teamA.text = match.teamA
        teamB.text = match.teamB
        scoreA.text = String(match.scoreA)
        scoreB.text = String(match.scoreB)
        availableFund.text = String(UserSingleton.user.availableFund) + "€ available"
        betTextField.addTarget(self, action: #selector(MatchDetailViewController.betTextFieldChange(_:)), for: UIControl.Event.editingChanged)
        
    }
    
    @objc func betTextFieldChange(_ textField: UITextField) {
        if(betTextField.text!.count > 0){
            potentialGainLabel.text = String(format: "%.2f", calculPotentialGain()) + "€"
        }
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
        if(betTextField.text!.count > 0){
            potentialGainLabel.text = String(format: "%.2f", calculPotentialGain()) + "€"
        }
    }
    
    func removeOddTapped(at index: IndexPath, oddIndex: Int){
        selectedBets = selectedBets.filter({ $0.bet != bets[index[1]] })
        if(betTextField.text!.count > 0){
            potentialGainLabel.text = String(format: "%.2f", calculPotentialGain()) + "€"
        }
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
    
    @IBAction func betButtonTapped(_ sender: Any) {
        
        let bet: Double? = Double(self.betTextField.text!)
        if(betTextField.text!.count > 0 && selectedBets.count > 0 && bet! >= 1.0){
            if(UserSingleton.user.availableFund - bet! >= 0){
                UserSingleton.user.availableFund -= bet!
                self.navigationController?.popViewController(animated: true)
                BetService.default.newBet(matchID: match.id, selectedBets: selectedBets, betAmount: bet!, completion: { betID in UserSingleton.bets.append(betID)
                })
            } else {
                self.fundErrorLabel.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.fundErrorLabel.isHidden = true
                }
            }
        } else {
            self.betAmountError.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.betAmountError.isHidden = true
            }
        }
    }
    
}


//
//  ActiveBetsViewController.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 06/02/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import UIKit

class ActiveBetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let cellIdentifier = "cell"
    @IBOutlet var tableView: UITableView!
    var activeBets: [ActiveBet] = []
    var matchs: [Match] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ActiveBetTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        navigationItem.title = "Bets"
        MatchsServices.shared.getMatchsByID(activeBets: activeBets) { matchs in
            self.matchs = matchs
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeBets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ActiveBetTableViewCell
        cell.betAmount.text = String(format: "%.2f", activeBets[indexPath.row].betAmount) + "€"
        cell.potentialGain.text = String(format: "%.2f", activeBets[indexPath.row].totalGain) + "€"
        if(matchs.count > 0 &&  matchs.count == activeBets.count){
            cell.duration.text = String(Int(matchs[indexPath.row].duration/60)) + " min"
            cell.scoreA.text = String(matchs[indexPath.row].scoreA)
            cell.scoreB.text = String(matchs[indexPath.row].scoreB)
        }
        if(matchs.count > 0 &&  matchs.count == activeBets.count &&  matchs[indexPath.row].stateMatch == 1){
            let result = checkBetIndex(selectedBets: activeBets[indexPath.row].selectedBets)
            switch result {
                case 0:
                    if(self.matchs[indexPath.row].result == result){
                        cell.result.text = "WON"
                        UserSingleton.user.availableFund += activeBets[indexPath.row].betAmount
                        BetService.default.creditFundUser(amount: activeBets[indexPath.row].betAmount)
                        
                    } else {
                        cell.result.text = "LOST"
                    }
                case 1:
                    if(self.matchs[indexPath.row].result == result){
                        cell.result.text = "WON"
                        UserSingleton.user.availableFund += activeBets[indexPath.row].betAmount
                        BetService.default.creditFundUser(amount: activeBets[indexPath.row].betAmount)
                    } else {
                        cell.result.text = "LOST"
                    }
                case 2:
                    if(self.matchs[indexPath.row].result == result){
                        cell.result.text = "WON"
                        UserSingleton.user.availableFund += activeBets[indexPath.row].betAmount
                        BetService.default.creditFundUser(amount: activeBets[indexPath.row].betAmount)
                    } else {
                        cell.result.text = "LOST"
                    }
                default:
                    cell.result.text = "LOST"
            }
        }
        return cell
    }
    
    func checkBetIndex(selectedBets: [SelectedBet]) -> Int{
        var result = selectedBets[0].odd
        for(selectedBet) in selectedBets {
            if(selectedBet.odd != result){
                return 9
            }
        }
        return result
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }

}

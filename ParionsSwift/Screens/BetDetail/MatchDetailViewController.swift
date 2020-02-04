//
//  MatchDetailViewController.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 03/01/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import UIKit

class MatchDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellIdentifier = "cell"
    var bets = [Bet]()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BetTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        MatchsServices.shared.getActiveBets(matchID: "m12345", completion: { bets in
            print(bets)
            self.bets = bets
            self.tableView.reloadData()
        })
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
        cell.oddB.layer.borderWidth = 1
        cell.oddB.layer.borderColor = borderColor.cgColor
        cell.oddB.layer.cornerRadius = 5
        cell.oddC.layer.borderWidth = 1
        cell.oddC.layer.borderColor = borderColor.cgColor
        cell.oddC.layer.cornerRadius = 5


        return cell
    }
}


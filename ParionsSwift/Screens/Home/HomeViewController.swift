//
//  HomeViewController.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 18/12/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit
import SocketIO

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellIdentifier = "cell"
    @IBOutlet weak var tableView: UITableView!
    var matchs: [Match] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MatchTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        let wallet = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigateToWallet))
        let activeBets = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(navigateToActiveBets))
        navigationItem.title = "Parions Swift"
        navigationItem.rightBarButtonItems = [wallet, activeBets]
        MatchsServices.shared.listenForNewMatchs { matchs in
            self.matchs = matchs
            self.tableView.reloadData()
        }
    }
    
    @objc func navigateToWallet () {
        let next = WalletViewController()
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @objc func navigateToActiveBets(){
        BetService.default.getActiveBets(activeBets: UserSingleton.bets) { activeBets in
            let next = ActiveBetsViewController()
            next.activeBets = activeBets
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MatchTableViewCell
        
        cell.teamA.text = matchs[indexPath.row].teamA
        cell.teamB.text = matchs[indexPath.row].teamB
        cell.oddA.text = String(matchs[indexPath.row].oddA)
        cell.oddA.layer.cornerRadius = 5
        cell.oddA.layer.masksToBounds = true
        cell.oddB.text = String(matchs[indexPath.row].oddB)
        cell.oddB.layer.cornerRadius = 5
        cell.oddB.layer.masksToBounds = true
        cell.oddC.text = String(matchs[indexPath.row].oddC)
        cell.oddC.layer.cornerRadius = 5
        cell.oddC.layer.masksToBounds = true
        cell.scoreA.text = String(matchs[indexPath.row].scoreA)
        cell.scoreB.text = String(matchs[indexPath.row].scoreB)
        cell.duration.text = String(Int(matchs[indexPath.row].duration/60)) + " min"

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = MatchDetailViewController()
        next.match = matchs[indexPath.row]
        if(matchs[indexPath.row].id.count > 0){
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
}

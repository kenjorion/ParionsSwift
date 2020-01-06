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
    var matchs = [Match]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MatchTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        MatchsServices.shared.listenForNewMatchs { match in
            self.matchs.append(match)
            self.tableView.reloadData()
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
        cell.oddB.text = String(matchs[indexPath.row].oddB)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = MatchDetailViewController()
        self.navigationController?.pushViewController(next, animated: true)
    }
    
}

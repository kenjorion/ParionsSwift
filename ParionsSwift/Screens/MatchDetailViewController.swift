//
//  MatchDetailViewController.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 03/01/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import UIKit

class MatchDetailViewController: UIViewController {
    
    @IBOutlet weak var inputBet: UITextField!
    @IBOutlet weak var Validate: UIButton!
    @IBOutlet weak var betChoice: UILabel!
    @IBOutlet weak var totalOdd: UILabel!
    @IBOutlet weak var totalBet: UILabel!
    @IBOutlet weak var totalProfit: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

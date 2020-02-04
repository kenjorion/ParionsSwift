//
//  BetTableViewCell.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 04/02/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import UIKit

class BetTableViewCell: UITableViewCell {

    
    @IBOutlet var betName: UILabel!
    @IBOutlet var teamALabel: UILabel!
    @IBOutlet var teamBLabel: UILabel!
    @IBOutlet var oddA: UIButton!
    @IBOutlet var oddB: UIButton!
    @IBOutlet var oddC: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

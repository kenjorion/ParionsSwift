//
//  ActiveBetTableViewCell.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 06/02/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import UIKit

class ActiveBetTableViewCell: UITableViewCell {

    
    @IBOutlet var teamA: UILabel!
    @IBOutlet var teamB: UILabel!
    @IBOutlet var betAmount: UILabel!
    @IBOutlet var potentialGain: UILabel!
    @IBOutlet var result: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

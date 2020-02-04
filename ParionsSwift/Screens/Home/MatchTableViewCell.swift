//
//  MatchTableViewCell.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 03/01/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var teamA: UILabel!
    @IBOutlet weak var teamB: UILabel!
    @IBOutlet weak var oddA: UILabel!
    @IBOutlet weak var oddB: UILabel!
    @IBOutlet weak var oddC: UILabel!
    @IBOutlet weak var scoreA: UILabel!
    @IBOutlet weak var scoreB: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  BetTableViewCell.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 04/02/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import UIKit

protocol SelectOddDelegate{
    func oddTapped(at index:IndexPath, oddIndex: Int)
    func removeOddTapped(at index: IndexPath, oddIndex: Int)
}

class BetTableViewCell: UITableViewCell {

    var delegate: SelectOddDelegate!
    var indexPath: IndexPath!
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
    
    @IBAction func oddA(_ sender: UIButton) {
        
        if(oddA.backgroundColor == UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0)){
            oddA.backgroundColor = UIColor(white: 1, alpha: 1.0)
            self.delegate?.removeOddTapped(at: indexPath, oddIndex: 0)
        } else {
            let backgroundColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )
            resetBackgroundColor()
            oddA.backgroundColor = backgroundColor
            self.delegate?.oddTapped(at: indexPath, oddIndex: 0)
        }
    }
    
    @IBAction func oddB(_ sender: Any) {
        if(oddB.backgroundColor == UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0)){
            oddB.backgroundColor = UIColor(white: 1, alpha: 1.0)
            self.delegate?.removeOddTapped(at: indexPath, oddIndex: 1)
        } else {
        let backgroundColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )
            resetBackgroundColor()
            oddB.backgroundColor = backgroundColor
            self.delegate?.oddTapped(at: indexPath, oddIndex: 1)
        }
        
    }
    
    @IBAction func oddC(_ sender: Any) {
        if(oddC.backgroundColor == UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0)){
            oddC.backgroundColor = UIColor(white: 1, alpha: 1.0)
            self.delegate?.removeOddTapped(at: indexPath, oddIndex: 1)
        } else {
            let backgroundColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )
            resetBackgroundColor()
            oddC.backgroundColor = backgroundColor
            self.delegate?.oddTapped(at: indexPath, oddIndex: 2)
        }
    }
    
    func resetBackgroundColor(){
        oddA.backgroundColor = UIColor(white: 1, alpha: 1.0)
        oddB.backgroundColor = UIColor(white: 1, alpha: 1.0)
        oddC.backgroundColor = UIColor(white: 1, alpha: 1.0)
    }
}

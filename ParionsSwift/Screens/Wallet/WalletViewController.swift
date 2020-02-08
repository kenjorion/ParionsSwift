//
//  WalletViewController.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 07/01/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import UIKit
import Stripe

class WalletViewController: UIViewController, STPAddCardViewControllerDelegate {

    @IBOutlet var fundTextField: UITextField!
    @IBOutlet var availableFund: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        availableFund.text = String(format: "%.2f", UserSingleton.user.availableFund) + "€"
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func fundButton(_ sender: Any) {
        let fund: Double? = Double(self.fundTextField.text!)
        if(fundTextField.text!.count > 0 && fund! >= 1.0){
            let config = STPPaymentConfiguration.shared()
            let addCardViewController = STPAddCardViewController(configuration: config, theme: STPTheme.default())
            addCardViewController.delegate = self
            let navigationController = UINavigationController(rootViewController: addCardViewController)
            present(navigationController, animated: true, completion: nil)
        }
    }
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        dismiss(animated: true)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreatePaymentMethod paymentMethod: STPPaymentMethod, completion: @escaping STPErrorBlock) {
        let fund: Double? = Double(self.fundTextField.text!)
        UserSingleton.user.availableFund += fund!
        availableFund.text = String(UserSingleton.user.availableFund)
        BetService.default.creditFundUser(amount: fund!)
        
        dismiss(animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

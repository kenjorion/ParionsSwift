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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func fundButton(_ sender: Any) {
        let config = STPPaymentConfiguration.shared()
        let addCardViewController = STPAddCardViewController(configuration: config, theme: STPTheme.default())
        addCardViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: addCardViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        dismiss(animated: true)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        dismiss(animated: true)
        let cardObject = token.allResponseFields["card"]
        print("Printing Strip Token:\(token.tokenId)")
       
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

//
//  LoginViewController.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 04/02/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var window: UIWindow?
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    @IBAction func loginButton(_ sender: Any) {
        LoginService.default.login(username: usernameTextField.text!, password: passwordTextField.text!) { user in
            
            if(user.id.count > 0){
                let newMatch = Match(id: "", teamA: "...", teamB: "...", scoreA: 0, scoreB: 0, oddA: 1.0, oddB: 1.0, oddC: 1.0, duration: 0, stateMatch: 0, result: 5)
                let matchs = [newMatch, newMatch, newMatch]
                let hvc = HomeViewController()
                hvc.matchs = matchs
                let navigationController = UINavigationController(rootViewController: hvc)
                let w = UIWindow(frame: UIScreen.main.bounds)
                w.rootViewController = navigationController
                w.makeKeyAndVisible()
                self.window = w
            }
        }
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

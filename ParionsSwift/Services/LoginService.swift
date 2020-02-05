//
//  LoginService.swift
//  ParionsSwift
//
//  Created by Tristan Luong on 04/02/2020.
//  Copyright © 2020 Tristan Luong. All rights reserved.
//

import Foundation
import Alamofire

public class LoginService {
    
    public static let `default` = LoginService()
    
    public func login(username: String, password: String, completion: @escaping (User) -> Void) {
        
        let parameters: Parameters = ["username": username, "password": password]
        
        Alamofire.request("http://localhost:8080/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (res) in
            guard let json = res.result.value as? [String: Any],
            let id = json["id"] as? String,
            let username = json["username"] as? String,
            let availableFund = json["availableFund"] as? Double
            else {
                return
            }
            let user = User(id: id, username: username, availableFund: availableFund)
            UserSingleton.user = user
            completion(user)
        }
    }
}

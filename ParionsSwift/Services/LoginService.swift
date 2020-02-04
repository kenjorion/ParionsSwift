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
    
    public func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        let parameters: Parameters = ["email": email, "password": password]
        
        Alamofire.request("http://localhost:8080/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (res) in
            guard let isConnected = res.result.value as? Bool
                else {
                    return
            }
            completion(isConnected)
        }
    }
}

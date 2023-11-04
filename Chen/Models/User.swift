//
//  User.swift
//  Chen
//
//  Created by iOS on 2023/10/17.
//

import UIKit
import HandyJSON

struct LoginModel: HandyJSON  {
    
    var token: String?
    var user: User?
}

struct User: HandyJSON {
    
    var id: String?
    var mobile: String?
    var userName: String?
    var url: String?
}

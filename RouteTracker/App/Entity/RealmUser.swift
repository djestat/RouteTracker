//
//  RealmUser.swift
//  RouteTracker
//
//  Created by Igor on 13.04.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation
import RealmSwift

class REALMUser: Object {
    @objc dynamic var login: String = ""
    @objc dynamic var password: String = ""
    
    convenience init(login: String, password: String) {
        self.init()
        self.login = login
        self.password = password
    }
        
    override static func primaryKey() -> String? {
        return "login"
    }
}

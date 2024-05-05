//
//  UserInfo.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 05.05.24.
//

import Foundation
import FirebaseAuth

struct UserInfo: Codable {
    var name: String?
    var phone: String?
    var mail: String?
}

struct UserInfoViewModel {
    var model: UserInfo
    init(model: UserInfo) {
        self.model = model
    }
    
    var name: String {
        get { self.model.name ?? "" }
        set { self.model.name = newValue }
    }
    
    var phone: String {
        get { (self.model.phone == nil ? Auth.auth().currentUser?.phoneNumber : self.model.name) ?? "" }
        set { self.model.phone = newValue }
    }
    
    var mail: String {
        get { self.model.mail ?? "" }
        set { self.model.mail = newValue }
    }
}

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
    
    var name: String?           { self.model.name }
    var phone: String?          { self.model.phone == nil ? Auth.auth().currentUser?.phoneNumber : self.model.name }
    var mail: String?           { self.model.mail}
}

//
//  UserInfo.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 05.05.24.
//

import Foundation
import FirebaseAuth

struct UserInfo: Codable {
    var name: String = Auth.auth().currentUser?.displayName ?? ""
    var phone: String = Auth.auth().currentUser?.phoneNumber ?? ""
    var mail: String = Auth.auth().currentUser?.email ?? ""
}

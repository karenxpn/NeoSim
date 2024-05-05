//
//  AccountService.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 05.05.24.
//

import Foundation
import FirebaseFirestore

protocol UserServiceProtocol {
    func fetchUserInfo() async -> Result<UserInfo, Error>
}

class UserService {
    static let shared: UserServiceProtocol = UserService()
    let db = Firestore.firestore()

    private init() { }
}

extension UserService: UserServiceProtocol {
    func fetchUserInfo() async -> Result<UserInfo, any Error> {
        return await APIHelper.shared.authenticatedCodableRequest { userID in
            return try await db.collection(Paths.users.rawValue)
                .document(userID)
                .getDocument(as: UserInfo.self)
        }
    }
}

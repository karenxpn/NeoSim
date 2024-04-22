//
//  AuthService.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 22.04.24.
//

import Foundation
import FirebaseFirestore

protocol AuthServiceProtocol {
    func fetchIntro() async -> Result<[IntroductionModel], Error>
}

class AuthService {
    static let shared: AuthServiceProtocol = AuthService()
    let db = Firestore.firestore()
    private init() { }
}

extension AuthService: AuthServiceProtocol {
    func fetchIntro() async -> Result<[IntroductionModel], any Error> {
        return await APIHelper.shared.codableRequest {
            return try await db.collection(Paths.introduction.rawValue)
                            .getDocuments()
                            .documents.map({ try $0.data(as: IntroductionModel.self)})
        }
    }
}

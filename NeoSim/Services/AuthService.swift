//
//  AuthService.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 22.04.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol AuthServiceProtocol {
    func fetchIntro() async -> Result<[IntroductionModel], Error>
    func sendVerificationCode(phone: String) async -> Result<Void, Error>
    func checkVerificationCode(code: String) async -> Result<String, Error>
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
    
    func sendVerificationCode(phone: String) async -> Result<Void, Error> {
        return await APIHelper.shared.voidRequest {
            let verificationID = try await PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil)
            UserDefaults.standard.set( verificationID, forKey: "authVerificationID")
        }
    }
    
    func checkVerificationCode(code: String) async -> Result<String, Error> {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        guard let verificationID else { return .failure(Error.self as! Error) }
        
        do {
            let credential =  PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
            let uid = try await Auth.auth().signIn(with: credential).user.uid
            return .success(uid)
            
        } catch {
            return .failure(error)
        }
    }
}

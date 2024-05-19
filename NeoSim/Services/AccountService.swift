//
//  AccountService.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 05.05.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol UserServiceProtocol {
    func fetchUserInfo() async -> Result<UserInfo, Error>
    func updateUserInfo(info: UserInfo) async -> Result<Void, Error>
    func extractPhoneModel(with phoneModels: [PhoneModel]) -> (PhoneModel?, String)
}

class UserService {
    static let shared: UserServiceProtocol = UserService()
    let db = Firestore.firestore()

    private init() { }
}

extension UserService: UserServiceProtocol {
    func extractPhoneModel(with phoneModels: [PhoneModel]) -> (PhoneModel?, String) {
        let phoneNumber = Auth.auth().currentUser?.phoneNumber ?? ""
        print("phone number \(phoneNumber)")
        
        for phoneModel in phoneModels {
            if phoneNumber.starts(with: phoneModel.dial_code) {
                let numberWithoutDialCode = phoneNumber.dropFirst(phoneModel.dial_code.count)
                let formattedNumber = formatPhoneNumber(String(numberWithoutDialCode), with: phoneModel.pattern)
                print("formatted \(formattedNumber)")
                return (PhoneModel(
                    id: phoneModel.id,
                    name: phoneModel.name,
                    flag: phoneModel.flag,
                    code: phoneModel.code,
                    dial_code: phoneModel.dial_code,
                    pattern: phoneModel.pattern,
                    limit: phoneModel.limit
                ), formattedNumber)
            }
        }
        
        return (nil, "")
    }
    
    func formatPhoneNumber(_ number: String, with pattern: String) -> String {
        var formattedNumber = ""
        var numberIndex = number.startIndex
        for ch in pattern where numberIndex < number.endIndex {
            if ch == "#" {
                formattedNumber.append(number[numberIndex])
                numberIndex = number.index(after: numberIndex)
            } else {
                formattedNumber.append(ch)
            }
        }
        return formattedNumber
    }
    
    func updateUserInfo(info: UserInfo) async -> Result<Void, any Error> {
        return await APIHelper.shared.voidRequest {
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = info.name
            try await changeRequest?.commitChanges()
            
            try await Auth.auth().currentUser?.updateEmail(to: info.mail)
        }
    }
    
    func fetchUserInfo() async -> Result<UserInfo, any Error> {
        return await APIHelper.shared.authenticatedCodableRequest { userID in
            return try await db.collection(Paths.users.rawValue)
                .document(userID)
                .getDocument(as: UserInfo.self)
        }
    }
}

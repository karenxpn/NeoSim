//
//  AccountViewModel.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 05.05.24.
//

import Foundation
class AccountViewModel: AlertViewModel, ObservableObject {
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var info: UserInfo = UserInfo()
    @Published var phoneModel: PhoneModel = PhoneModel(id: "0012",
                                                        name: "Armenia",
                                                        flag: "🇦🇲",
                                                        code: "AM",
                                                        dial_code: "+374",
                                                        pattern: "## ### ###",
                                                        limit: 17)
    @Published var phone: String = ""
    
    var manager: UserServiceProtocol
    init(manager: UserServiceProtocol = UserService.shared) {
        self.manager = manager
    }
    
    @MainActor func getUserInfo() {
        loading = true
        Task {
            let result = await manager.fetchUserInfo()
            switch result {
            case .failure(let error):
                break
//                self.makeAlert(with: error, message: &alertMessage, alert: &showAlert)
            case .success(let info):
                self.info = info
            }
            
            if !Task.isCancelled {
                loading = false
            }
        }
    }
    
    @MainActor func updateUserInfo() {
        Task {
            let result = await manager.updateUserInfo(info: info)
            switch result {
            case .failure(let error):
                self.makeAlert(with: error, message: &alertMessage, alert: &showAlert)
            case .success(()):
                print("Name and Email updated")
            }
        }
    }
    
    @MainActor func getPhoneNumber() {
        let result = manager.extractPhoneModel(with: PhoneModel.allCountry)
        if let model = result.0 {
            phoneModel = model
        }
        phone = result.1
    }
}

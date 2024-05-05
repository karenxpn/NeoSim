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
    
    @Published var info: UserInfoViewModel?
    
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
                self.makeAlert(with: error, message: &alertMessage, alert: &showAlert)
            case .success(let info):
                self.info = UserInfoViewModel(model: info)
            }
            
            if !Task.isCancelled {
                loading = false
            }
        }
    }
}

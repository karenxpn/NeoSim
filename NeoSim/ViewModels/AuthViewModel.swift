//
//  AuthViewModel.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 22.04.24.
//

import Foundation
import FirebaseAuth

class AuthViewModel: AlertViewModel, ObservableObject {
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var phone = PhoneModel(id: "0012",
                                      name: "Armenia",
                                      flag: "🇦🇲",
                                      code: "AM",
                                      dial_code: "+374",
                                      pattern: "## ### ###",
                                      limit: 17)
    
    @Published var OTP: String = ""
    
    @Published var introductionPages = [IntroductionModel]()
    
    var manager: AuthServiceProtocol
    init(manager: AuthServiceProtocol = AuthService.shared) {
        self.manager = manager
    }
    
    var user: User? {
        didSet {
            objectWillChange.send()
        }
    }
    
    func listenToAuthState() {
        loading = true
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else {
                return
            }
            self.user = user
            self.loading = false
        }
    }
    
    @MainActor func getIntroductionPages() {
        loading = true
        Task {
            
            let result = await manager.fetchIntro()
            switch result {
            case .failure(let error):
                self.makeAlert(with: error, message: &alertMessage, alert: &showAlert)
            case .success(let intro):
                self.introductionPages = intro
            }
            
            if !Task.isCancelled {
                loading = false
            }
        }
    }
}

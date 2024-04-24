//
//  MockAuthService.swift
//  NeoSimTests
//
//  Created by Karen Mirakyan on 24.04.24.
//

import Foundation
@testable import NeoSim

class MockAuthService: AuthServiceProtocol {
    func fetchIntro() async -> Result<[IntroductionModel], any Error> {
        if fetchIntroError {
            return .failure(NSError(domain: "Error",
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: "Error fetching introduction"]))
        } else {
            return .success([PreviewModels.introductionPage])
        }
    }
    
    var sendVerificationError: Bool = false
    var checkVerificationError: Bool = false
    var fetchIntroError: Bool = false
    var signOutError: Bool = false
    
    func sendVerificationCode(phone: String) async -> Result<Void, Error> {
        if sendVerificationError {
            return .failure(NSError(domain: "Error",
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: "Error sending Verification Code"]))
        } else {
            return .success(())
        }
    }
    
    func checkVerificationCode(code: String) async -> Result<String, Error> {
        if checkVerificationError {
            return .failure(NSError(domain: "Error",
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: "Invalid OTP"]))
        } else {
            return .success("userUID")
        }
    }
    
    
    func signOut() async -> Result<Void, Error> {
        if signOutError {
            return .failure(NSError(domain: "Error",
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: "Error signing out"]))
        } else {
            return .success(())
        }
    }
}

//
//  AuthViewModelTests.swift
//  NeoSimTests
//
//  Created by Karen Mirakyan on 24.04.24.
//

import XCTest
@testable import NeoSim

final class AuthViewModelTests: XCTestCase {

    var service: MockAuthService!
    var viewModel: AuthViewModel!
    
    override func setUp() {
        self.service = MockAuthService()
        self.viewModel = AuthViewModel(manager: self.service)
    }
    
    func testSendVerificatioinWithError() async {
        service.sendVerificationError = true
        await wait(for: { await self.viewModel.sendVerificationCode(phone: "", action: { }) })

        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Error sending Verification Code")
    }
    
    func testSendVerificationCodeWithSuccess() async {
        service.sendVerificationError = false
        await wait(for: { await self.viewModel.sendVerificationCode(phone: "", action: { }) })

        XCTAssertFalse(viewModel.showAlert)
        XCTAssertTrue(self.viewModel.alertMessage.isEmpty)
    }
    
    func testCheckVerificationCodeWithError() async {
        service.checkVerificationError = true
        await wait(for: { await self.viewModel.checkVerificationCode() })

        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Invalid OTP")
    }
    
    func testCheckVerificationCodeWithSuccess() async {
        service.checkVerificationError = false
        await wait(for: { await self.viewModel.checkVerificationCode() })
        
        XCTAssertFalse(viewModel.showAlert)
        XCTAssertTrue(self.viewModel.alertMessage.isEmpty)
    }
    
    func testFetchIntroWithError() async {
        service.fetchIntroError = true
        await wait(for: { await self.viewModel.getIntroductionPages() })

        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Error fetching introduction")
    }
    
    func testFetchIntroWithSuccess() async {
        service.fetchIntroError = false
        await wait(for: { await self.viewModel.getIntroductionPages() })
        
        XCTAssertFalse(viewModel.showAlert)
        XCTAssertTrue(self.viewModel.alertMessage.isEmpty)
    }
    
    func testSignOutWithError() async {
        service.signOutError = true
        await wait(for: { await self.viewModel.signOut() })

        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Error signing out")

    }
    
    func testSignOutWithSuccess() async {
        service.signOutError = false
        await wait(for: { await self.viewModel.signOut() })
                
        XCTAssertFalse(viewModel.showAlert)
        XCTAssertTrue(self.viewModel.alertMessage.isEmpty)
    }
}


extension XCTestCase {
    @MainActor func wait(for task: @escaping @Sendable () async throws -> Void, timeout: TimeInterval = 5) async {
        let expectation = XCTestExpectation(description: "Async task completion")
        
        Task {
            do {
                try await task()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
            
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: timeout)
    }
}

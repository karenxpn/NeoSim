//
//  ViewRouter.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 23.04.24.
//

import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    @Published var authPath = [AuthPaths]()
    
    @Published var tab: Int = 0
    
    func pushAuthPath(_ page: AuthPaths) { authPath.append(page) }
    
    @ViewBuilder
    func buildAuthView(page: AuthPaths) -> some View {
        switch page {
        case .enterPhone:
            Authentication()
        case .verifyPhone(let phone):
            VerifyPhoneNumber(phone: phone)
        }
    }
}

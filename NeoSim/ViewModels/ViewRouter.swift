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
    @Published var homePath = [HomePaths]()
    @Published var eSimsPath = [EsimsPaths]()
    @Published var accountPath = [AccountPaths]()
    
    @Published var tab: Int = 0
    
    func pushAuthPath(_ page: AuthPaths) { authPath.append(page) }
    
    // add new view
    func pushHomePath(_ page: HomePaths)                    { homePath.append(page) }
    func pushEsimsPath(_ page: EsimsPaths)                  { eSimsPath.append(page) }
    func pushAccountPath(_ page: AccountPaths)              { accountPath.append(page) }
    
    // pop one view
    func popHomePath()              { homePath.removeLast() }
    func popEsimsPath()             { eSimsPath.removeLast() }
    func popAccountPath()           { accountPath.removeLast() }
    
    // pop root view
    func popToHomeRoot()                { homePath.removeLast(homePath.count) }
    func popToEsimsRoot()               { eSimsPath.removeLast(eSimsPath.count) }
    func popToAccountRoot()             { accountPath.removeLast(accountPath.count) }
    
    @ViewBuilder
    func buildAuthView(page: AuthPaths) -> some View {
        switch page {
        case .enterPhone:
            Authentication()
        case .verifyPhone(let phone):
            VerifyPhoneNumber(phone: phone)
        }
    }
    
    @ViewBuilder
    func buildAccountView(page: AccountPaths) -> some View {
        switch page {
        case .info:
            Text( "Account info" )
        case .cards:
            Text( "Attached cards" )
        case .faq:
            Text( "FAQ" )
        }
    }
}

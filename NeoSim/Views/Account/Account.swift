//
//  Account.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 26.04.24.
//

import SwiftUI

struct Account: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @StateObject private var authVM = AuthViewModel()

    var body: some View {
        NavigationStack(path: $viewRouter.accountPath) {
            Button {
                viewRouter.authPath.removeAll()
                authVM.signOut()
            } label: {
                TextHelper(text: "Authenticated")
            }
        }

    }
}

#Preview {
    Account()
}

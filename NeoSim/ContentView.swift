//
//  ContentView.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 19.04.24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var authVM = AuthViewModel()
    @EnvironmentObject var viewRouter: ViewRouter

    var body: some View {
        
        Group {
            if authVM.loading {
                ProgressView()
            } else if authVM.user != nil {
                MainView()
            } else {
                Introduction()
            }
        }.onAppear {
            authVM.listenToAuthState()
        }
    }
}

#Preview {
    ContentView()
}

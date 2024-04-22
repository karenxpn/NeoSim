//
//  ContentView.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 19.04.24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var authVM = AuthViewModel()
    
    var body: some View {
        
        Group {
            if authVM.loading {
                ProgressView()
            } else if authVM.user != nil {
                TextHelper(text: "Authenticated")
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

//
//  Home.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 26.04.24.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var viewRouter: ViewRouter

    var body: some View {
        NavigationStack(path: $viewRouter.homePath) {
            Text("Home")
        }
    }
}

#Preview {
    Home()
}

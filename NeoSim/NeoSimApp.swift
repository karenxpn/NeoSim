//
//  NeoSimApp.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 19.04.24.
//

import SwiftUI

@main
struct NeoSimApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var viewRouter = ViewRouter()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewRouter)
        }
    }
}

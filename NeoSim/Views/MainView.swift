//
//  MainView.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 26.04.24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        ZStack( alignment: .bottom) {
            
            VStack {
                
                if viewRouter.tab == 0 {
                    Text("Countries")
                        .frame( minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                } else if viewRouter.tab == 1 {
                    Text("My eSims")
                        .frame( minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                } else if viewRouter.tab == 2{
                    Text("Profile")
                        .frame( minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
            }
            
            CustomTabView()
            
        }.edgesIgnoringSafeArea(.bottom)
            .environmentObject(viewRouter)
    }
}

#Preview {
    MainView()
}

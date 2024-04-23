//
//  Introduction.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 22.04.24.
//

import SwiftUI

struct Introduction: View {
    @StateObject var authVM = AuthViewModel()
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationStack(path: $viewRouter.authPath) {
            VStack(spacing: 20) {
                
                if authVM.loading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    TabView{
                        ForEach(authVM.introductionPages, id: \.id){ page in
                            IntroductionPage(page: page)
                        }
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    
                }
                
                
                VStack(spacing: 12) {
                    ButtonHelper(disabled: false, label: NSLocalizedString("createAccount", comment: "")) {
                        viewRouter.pushAuthPath(.enterPhone)
                    }
                    
                    
                    Button {
                        viewRouter.pushAuthPath(.enterPhone)
                    } label: {
                        TextHelper(text: NSLocalizedString("signIn", comment: ""), color: .blue)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 18)
                    }
                }.padding(.horizontal, 32)
                
            }.task {
                authVM.getIntroductionPages()
            }.navigationDestination(for: AuthPaths.self) { page in
                viewRouter.buildAuthView(page: page)
            }
        }.environmentObject(authVM)
        
    }
}

#Preview {
    Introduction()
        .environmentObject(ViewRouter())
}

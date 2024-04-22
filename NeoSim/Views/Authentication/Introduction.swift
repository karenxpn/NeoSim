//
//  Introduction.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 22.04.24.
//

import SwiftUI

struct Introduction: View {
    @StateObject var authVM = AuthViewModel()
    var body: some View {
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
                    
                }
                
                
                Button {
                    
                } label: {
                    TextHelper(text: NSLocalizedString("signIn", comment: ""), color: .blue)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 18)
                }
            }.padding(.horizontal, 32)
            
        }.task {
            authVM.getIntroductionPages()
        }
    }
}

#Preview {
    Introduction()
}

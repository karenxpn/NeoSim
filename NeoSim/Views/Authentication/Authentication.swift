//
//  Authentication.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 23.04.24.
//

import SwiftUI

struct Authentication: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            Image("neominty_logo")
            
            VStack(spacing: 8) {
                TextHelper(text: NSLocalizedString("helloAgain", comment: ""), fontName: .semiBold, fontSize: 24)
                
                TextHelper(text: NSLocalizedString("welcomeBack", comment: ""), fontSize: 16)
                    .lineSpacing(4)
                    .multilineTextAlignment(.center)
            }
            
                        
            VStack(spacing: 45) {
                
                
                ButtonHelper(disabled: false,
                             label: NSLocalizedString("next", comment: "")) {
                    
                }
            }.padding(.top, 16)
                .padding(.horizontal, 32)
            
            Spacer()
        }.padding(.top, 50)
    }
}

#Preview {
    Authentication()
        .environmentObject(AuthViewModel())
}

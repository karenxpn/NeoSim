//
//  Authentication.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 23.04.24.
//

import SwiftUI
import Combine

struct Authentication: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State private var phone: String = ""
    
    
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
                
                PhoneTextField(phoneNumber: $phone,
                               phone: $authVM.phone,
                               flag: authVM.phone.flag,
                               pattern: authVM.phone.pattern)
                
                ButtonHelper(disabled: phone.count != authVM.phone.pattern.count || authVM.loading,
                             label: authVM.loading ? NSLocalizedString("inProgress", comment: "") : NSLocalizedString("next", comment: "")) {
                    print(authVM.phone.dial_code + phone)
                    authVM.sendVerificationCode(phone: authVM.phone.dial_code + phone) {
                        viewRouter.pushAuthPath(.verifyPhone(phone: authVM.phone.dial_code + phone))
                    }
                }
            }.padding(.top, 16)
                .padding(.horizontal, 32)
            
            Spacer()
        }.padding(.top, 50)
            .navigationTitle("")
            .toolbar(.hidden)
            .alert(NSLocalizedString("error", comment: ""), isPresented: $authVM.showAlert, actions: {
                Button(NSLocalizedString("gotIt", comment: ""), role: .cancel) { }
            }, message: {
                Text(authVM.alertMessage)
            })
    }
}

#Preview {
    Authentication()
        .environmentObject(AuthViewModel())
        .environmentObject(ViewRouter())
}

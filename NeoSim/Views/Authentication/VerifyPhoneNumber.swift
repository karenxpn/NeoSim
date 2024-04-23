//
//  VerifyPhoneNumber.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 23.04.24.
//

import SwiftUI

struct VerifyPhoneNumber: View {
    @EnvironmentObject var authVM: AuthViewModel
    let phone: String
    var auth: Bool = true
    
    
    var body: some View {
        Loading(isShowing: $authVM.loading) {
            VStack( alignment: .leading, spacing: 12) {
                
                TextHelper(text: NSLocalizedString("verifyItsYou", comment: ""), color: .appBlue, fontName: .bold, fontSize: 24)
                TextHelper(text: "\(NSLocalizedString("weSentCode", comment: "")) \(phone).\n\(NSLocalizedString("enterItHere", comment: ""))", color: .gray, fontName: .regular, fontSize: 16)
                    .lineSpacing(4)

                OTPTextFieldView(pin: $authVM.OTP) { otp in
                    authVM.OTP = otp
                }.padding(.top, 20)
                
                HStack {
                    Spacer()
                    Button {
                        authVM.sendVerificationCode(send: false, phone: phone, action: { })
                        authVM.OTP = ""
                    } label: {
                        TextHelper(text: NSLocalizedString("resendCode", comment: ""), color: .green, fontName: .bold, fontSize: 16)
                    }

                    Spacer()
                }.padding(.top, 20)
                
                Spacer()
                ButtonHelper(disabled: authVM.OTP.count != 6,
                             label: NSLocalizedString("confirm", comment: "")) {
                    authVM.checkVerificationCode(auth: auth)
                }
            }.ignoresSafeArea(.keyboard, edges: .bottom)
                .padding(24)
        }.navigationBarTitle("", displayMode: .inline)
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .padding(.bottom, UIScreen.main.bounds.height * 0.08)
            .alert(NSLocalizedString("error", comment: ""), isPresented: $authVM.showAlert, actions: {
                Button(NSLocalizedString("gotIt", comment: ""), role: .cancel) { }
            }, message: {
                Text(authVM.alertMessage)
            })
    }
}

#Preview {
    VerifyPhoneNumber(phone: "+37493936313")
        .environmentObject(AuthViewModel())
}

//
//  AccountInfo.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 05.05.24.
//

import SwiftUI

struct AccountInfo: View {
    @StateObject private var accountVM = AccountViewModel()
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Image("navigation_background")
                .resizable()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 130)
                .ignoresSafeArea()
                .scaledToFit()
            
            ScrollView {
                LazyVStack(spacing: 12) {
                    
                    if accountVM.loading {
                        ProgressView()
                    } else {
                        VStack(alignment: .leading, spacing: 12) {
                            TextHelper(text: "fullName"~)
                            TextFieldHelper(placeholder: "enterYourFullName"~, text: $accountVM.info.name)
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 12) {
                            TextHelper(text: "mail"~)
                            TextFieldHelper(placeholder: "enterYourMail"~, keyboardType: .emailAddress, text: $accountVM.info.mail)
                        }
                    }
                }.padding(.top, 50)
                    .padding(.horizontal, 32)

            }.padding(.top, 1)
            
            
            Spacer()
        }.ignoresSafeArea()
            .toolbar { toolbar }
            .task {
                accountVM.getUserInfo()
            }.alert(NSLocalizedString("error", comment: ""), isPresented: $accountVM.showAlert, actions: {
                Button(NSLocalizedString("gotIt", comment: ""), role: .cancel) { }
            }, message: {
                Text(accountVM.alertMessage)
            })
        
    }
    
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            TextHelper(text: "accountInfo"~, color: .white, fontName: .semiBold, fontSize: 16)
        }
    }
}

#Preview {
    AccountInfo()
}

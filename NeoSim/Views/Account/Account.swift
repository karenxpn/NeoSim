//
//  Account.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 26.04.24.
//

import SwiftUI
import StoreKit

struct Account: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Environment(\.requestReview) var requestReview

    var body: some View {
        NavigationStack(path: $viewRouter.accountPath) {
            ScrollView {
                LazyVStack(spacing: 16, content: {
                    AccountCell(title: "accountInfo"~, description: "accountInfoDescription"~) {
                        
                    }
                    
                    AccountCell(title: "attachedCreditCards"~, description: "attachedCreditCardsDescription"~) {
                        
                    }
                    
                    AccountToggleCell(title: "notifications"~, description: "notificationsDescription"~, value: .constant(true)) { value in
                        
                    }
                    
                    AccountToggleCell(title: "emailPromotion"~, description: "emailPromotionDescription"~, value: .constant(false)) { value in
                        
                    }
                    
                    AccountCell(title: "faq"~, description: "faqDescription"~) {
                        
                    }
                    
                    AccountCell(title: "rateUs"~, description: "rateUsDescription"~) {
                        requestReview()
                    }
                }).padding(32)
            }.scrollIndicators(.hidden)
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .padding(.top, 1)
                .toolbar { toolbar }
        }

    }
    
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            TextHelper(text: "profile"~, fontSize: 16)
        }
    }
}

#Preview {
    Account()
}

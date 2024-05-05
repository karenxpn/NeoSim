//
//  AccountInfo.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 05.05.24.
//

import SwiftUI

struct AccountInfo: View {
    var body: some View {
        
        VStack(spacing: 0) {
            
            Image("navigation_background")
                .resizable()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 130)
                .ignoresSafeArea()
                .scaledToFit()
            
            ScrollView {
                LazyVStack {
                    Text( "Account info here" )
                    Text( "Account info here" )
                    Text( "Account info here" )
                    Text( "Account info here" )
                    Text( "Account info here" )
                    Text( "Account info here" )
                }.padding(.top, 50)

            }.padding(.top, 1)
            
            
            Spacer()
        }.ignoresSafeArea().toolbar { toolbar }
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

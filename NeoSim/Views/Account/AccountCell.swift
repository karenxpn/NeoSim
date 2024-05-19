//
//  AccountCell.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 05.05.24.
//

import SwiftUI

struct AccountCell: View {
    let title: String
    let description: String
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    TextHelper(text: title, fontSize: 14)
                    Spacer()

                    Image("arrow-right")
                }
                
                TextHelper(text: description, color: .appSuperLightGray, fontSize: 10)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

#Preview {
    AccountCell(title: "accountInfo"~, description: "accountInfoDescription"~, action: { })
}

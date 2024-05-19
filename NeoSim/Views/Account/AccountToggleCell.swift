//
//  AccountToggleCell.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 05.05.24.
//

import SwiftUI

struct AccountToggleCell: View {
    let title: String
    let description: String
    @Binding var value: Bool
    let action: (Bool) -> ()
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                TextHelper(text: title, fontSize: 14)
                Spacer()
                
                Toggle("", isOn: $value)
                    .frame(height: 20)
                    .scaleEffect(0.8)
                    .labelsHidden()
                    .tint(.appBlue)
                    .onChange(of: value) { oldValue, newValue in
                        print("new value in the toggler is \(newValue)")
                        action(newValue)
                    }
            }
            
            TextHelper(text: description, color: .appSuperLightGray, fontSize: 10)
        }
    }
}

#Preview {
    AccountToggleCell(title: "notifications"~, description: "notificationsDescription"~, value: .constant(true), action: { value in
    })
}

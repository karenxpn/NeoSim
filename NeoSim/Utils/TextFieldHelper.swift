//
//  TextFieldHelper.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 05.05.24.
//

import SwiftUI

struct TextFieldHelper: View {
    
    let placeholder: String
    var keyboardType: UIKeyboardType = .default
    @Binding var text: String
    @FocusState private var keyIsFocused: Bool
    
    var body: some View {
        
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .focused($keyIsFocused)
            .font(.custom(FontEnum.regular.rawValue, size: 16))
            .frame(height: 56)
            .padding(.horizontal, 16)
            .background(RoundedRectangle(cornerRadius: 16)
                .stroke(.appSuperLightGray, lineWidth: 1))
    }
}

#Preview {
    TextFieldHelper(placeholder: "enter you name", text: .constant(""))
}

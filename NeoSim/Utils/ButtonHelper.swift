//
//  ButtonHelper.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 22.04.24.
//

import SwiftUI

struct ButtonHelper: View {
    
    var disabled: Bool
    var height: CGFloat = 56
    let label: String
    var color: Color = .appBlue
    var labelColor: Color = .white
    let action: (() -> Void)

    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                
                Text( label )
                    .font(.custom(FontEnum.regular.rawValue, size: 14))
                    .foregroundColor(labelColor)
                
                Spacer()
            }.frame(height: height)
            .background(color)
                .opacity(disabled ? 0.5 : 1)
                .cornerRadius(16)
        }.disabled(disabled)
    }
}

//
//  TextHelper.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 22.04.24.
//

import SwiftUI

struct TextHelper: View {
    let text: String
    let color: Color
    let fontName: FontEnum
    let fontSize: CGFloat
    let font: Font
    
    init(text: String, color: Color = .primary, fontName: FontEnum = .regular, fontSize: CGFloat = 14) {
        self.text = text
        self.color = color
        self.fontName = fontName
        self.fontSize =  fontSize
        self.font = .custom(fontName.rawValue, size: fontSize)
    }
    
    var body: some View {
        Text(text)
            .foregroundColor(color)
            .font(font)
            .dynamicTypeSize(UIDevice.current.userInterfaceIdiom == .phone ? .large : .xxLarge)
            .fixedSize(horizontal: false, vertical: true)
            .kerning(0.3)
    }
}

#Preview {
    TextHelper(text: "Karen Mirakyan")
}

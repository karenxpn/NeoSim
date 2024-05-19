//
//  PhoneTextField.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 05.05.24.
//

import SwiftUI
import Combine

struct PhoneTextField: View {
    @State private var showPicker: Bool = false
    @Binding var phoneNumber: String
    @Binding var phone: PhoneModel
    let flag: String
    let pattern: String
    @FocusState private var keyIsFocused: Bool

    var body: some View {
        HStack {
            
            Button {
                showPicker.toggle()
            } label: {
                TextHelper(text: flag, fontSize: 30)
                    .padding(.vertical, 12)
                    .padding(.leading, 16)
                    .padding(.trailing, 8)
            }
            
            TextField(pattern, text: $phoneNumber)
                .keyboardType(.phonePad)
                .focused($keyIsFocused)
                .font(.custom(FontEnum.regular.rawValue, size: 16))
                .frame(height: 56)
        }
        .background(RoundedRectangle(cornerRadius: 16)
            .stroke(.appSuperLightGray, lineWidth: 1))
        .compositingGroup()
        .onReceive(Just(phone)) { _ in
            applyPatternOnNumbers(&phoneNumber, pattern: pattern, replacementCharacter: "#")
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                keyIsFocused = true
            }
        }.sheet(isPresented: $showPicker, content: {
            CountryPicker(selection: $phone)
                .presentationDetents([.medium, .large])
                .presentationCornerRadius(40)
        })
    }
    
    func applyPatternOnNumbers(_ stringvar: inout String, pattern: String, replacementCharacter: Character) {
        var pureNumber = stringvar.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else {
                stringvar = pureNumber
                return
            }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        stringvar = pureNumber
    }
}

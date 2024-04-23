//
//  Authentication.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 23.04.24.
//

import SwiftUI
import Combine

struct Authentication: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State private var showPicker: Bool = false
    @State private var phone: String = ""
    @FocusState private var keyIsFocused: Bool
    
    
    var body: some View {
        VStack(spacing: 32) {
            Image("neominty_logo")
            
            VStack(spacing: 8) {
                TextHelper(text: NSLocalizedString("helloAgain", comment: ""), fontName: .semiBold, fontSize: 24)
                
                TextHelper(text: NSLocalizedString("welcomeBack", comment: ""), fontSize: 16)
                    .lineSpacing(4)
                    .multilineTextAlignment(.center)
            }
            
            
            VStack(spacing: 45) {
                
                HStack {
                    
                    Button {
                        showPicker.toggle()
                    } label: {
                        TextHelper(text: authVM.phone.flag, fontSize: 30)
                            .padding(.vertical, 12)
                            .padding(.leading, 16)
                            .padding(.trailing, 8)
                    }
                    
                    TextField(authVM.phone.pattern, text: $phone)
                        .keyboardType(.phonePad)
                        .focused($keyIsFocused)
                        .font(.custom(FontEnum.regular.rawValue, size: 16))
                        .frame(height: 56)
                }
                .background(RoundedRectangle(cornerRadius: 16)
                    .stroke(.appSuperLightGray, lineWidth: 1))
                .compositingGroup()
                .onReceive(Just(phone)) { _ in
                    applyPatternOnNumbers(&phone, pattern: authVM.phone.pattern, replacementCharacter: "#")
                }
                
                ButtonHelper(disabled: phone.count != authVM.phone.pattern.count,
                             label: NSLocalizedString("next", comment: "")) {
                    viewRouter.pushAuthPath(.verifyPhone)
                }
            }.padding(.top, 16)
                .padding(.horizontal, 32)
            
            Spacer()
        }.padding(.top, 50)
            .toolbar(.hidden)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    keyIsFocused = true
                }
            }
            .sheet(isPresented: $showPicker, content: {
                CountryPicker(selection: $authVM.phone)
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

#Preview {
    Authentication()
        .environmentObject(AuthViewModel())
}

//
//  IntroductionPage.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 22.04.24.
//

import SwiftUI

struct IntroductionPage: View {
    let page: IntroductionModel
    var body: some View {
        
        VStack (spacing: 24) {
            ImageHelper(url: page.image, contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width * 0.6,
                       height: UIScreen.main.bounds.height * 0.4)
            
            VStack(spacing: 16) {
                TextHelper(text: page.title, fontName: .semiBold, fontSize: 24)
                    .multilineTextAlignment(.center)
                
                TextHelper(text: page.description, fontName: .regular, fontSize: 16)
                    .multilineTextAlignment(.center)
            }.padding(.horizontal, 40)
        }
    }
}

#Preview {
    IntroductionPage(page: PreviewModels.introductionPage)
}

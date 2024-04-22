//
//  ImageHelper.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 22.04.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageHelper: View {
    let url: String
    let contentMode: ContentMode
    
    var body: some View {
        WebImage(url: URL(string: url)) { image in
            image
        } placeholder: {
            ProgressView()
        }.resizable()
            .aspectRatio(contentMode: contentMode)
    }
}

#Preview {
    ImageHelper(url: "https://firebasestorage.googleapis.com/v0/b/neosim-30e29.appspot.com/o/introduction%2Fintroduction_1.png?alt=media&token=\(Credentials.firebaseImageToken)", contentMode: .fill)
}

//
//  ESims.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 26.04.24.
//

import SwiftUI

struct ESims: View {
    @EnvironmentObject var viewRouter: ViewRouter

    var body: some View {
        NavigationStack(path: $viewRouter.eSimsPath) {
            Text("eSims")
        }
    }
}

#Preview {
    ESims()
}

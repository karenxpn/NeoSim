//
//  CustomTabView.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 25.04.24.
//

import SwiftUI

struct CustomTabView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Environment(\.colorScheme) var colorScheme

    let icons = ["countries_icon", "esims_icon", "profile_icon"]
    let icon_lables = [NSLocalizedString("countries", comment: ""),
                       NSLocalizedString("myEsims", comment: ""),
                       NSLocalizedString("profile", comment: "")]
    @State private var tab: Bool = true
    
    
    var body: some View {
        Group {
            if tab {
                ZStack {
                    
                    GeometryReader(content: { geometry in
                        VStack(spacing: 0) {
                            Ellipse()
                                .trim(from: 0.5, to: 1)
                                .fill(colorScheme == .dark ? .black : .white)
                                .frame(width: geometry.size.width - 80,height: 11)
                                .cornerRadius(10)
                                .offset(y: 6)
                            
                            Rectangle()
                                .fill(colorScheme == .dark ? .black : .white)
                                .cornerRadius(48)
                        }.compositingGroup()
                            .shadow(color: .tabviewShadow, radius: 20, x: 0, y: 0)
                    })

                    
                    HStack {
                        
                        ForEach ( 0..<icons.count, id: \.self ) { id in
                            
                            Spacer()
                            Button {
//                                if viewRouter.tab == id {
//                                    if id == 0 {
//                                        viewRouter.popToHomeRoot()
//                                    } else if id == 1 {
//                                        viewRouter.popToCardRoot()
//                                    } else if id == 2 {
//                                        viewRouter.popToScanRoot()
//                                    } else if id == 3 {
//                                        viewRouter.popToAnalyticsRoot()
//                                    } else if id == 4 {
//                                        viewRouter.popToAccountRoot()
//                                    }
//                                }
                                viewRouter.tab = id
                            } label: {
                                VStack(spacing: 4) {
                                    
                                    Image(icons[id])
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .tint(viewRouter.tab == id ? .appBlue : .primary)
                                        .frame(width: 24, height: 24)
                                    
                                    TextHelper(text: icon_lables[id], color: viewRouter.tab == id ? .appBlue : .primary, fontSize: 12)

                                }
                            }
                            
                            Spacer()
                        }
                        
                    }.frame(minWidth: 0, maxWidth: .infinity)
                        .padding(10)
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 87)
            } else {
                EmptyView()
            }
        }.onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "hideTabBar"))) { _ in
            tab = false
        }.onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "showTabBar"))) { _ in
            withAnimation {
                tab = true
            }
        }
    }
}

#Preview {
    CustomTabView()
        .environmentObject(ViewRouter())
}

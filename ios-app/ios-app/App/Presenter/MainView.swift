//
//  MainView.swift
//  ios-app
//
//  Created by Koji Osugi on 12/01/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

internal struct MainView: View {
    
    @ObservedObject
    private var mainRouter: MainRouter = MainRouter.shared
    
    @State private var showSidebar: Bool = false
    
    private var topBarTitle: String {
        switch mainRouter.navGraph.destination {
        case .konverter: return "Konverter"
        case .settings: return "Settings"
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack() {
                VStack(alignment: .leading) {
                    TopBar()
                    Group {
                        switch mainRouter.navGraph.destination {
                        case .konverter: KonverterView()
                        case .settings: SettingsView()
                        }
                    }
                    .transition(mainRouter.navGraph.animation)
                    .animation(.default, value: mainRouter.navGraph.destination)
                }
                .fullScreen()
                SideMenu(isVisible: $showSidebar) {
                    SideMenuContent()
                }
            }
        }
    }
    
    @ViewBuilder
    private func TopBar() -> some View {
        HStack(spacing: 0) {
            ImageButton(
                .menu,
                color: .accentColor,
                action: { showSidebar.toggle() }
            )
            Text(topBarTitle)
                .style(.title)
                .padding(.leading, 16)
            Spacer()
            Text("11/01/23 23:40")
                .foregroundColor(.grayMain)
                .style(.body)
                .padding(.trailing, 4)
            ImageButton(
                .refresh,
                color: .accentColor,
                action: { showSidebar.toggle() }
            )
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .compositingGroup()
    }
    
    @ViewBuilder
    private func SideMenuContent() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Kurrency")
                .style(.body)
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            Divider()
                .padding(.bottom, 16)
            MenuItem(
                icon: .exchange,
                text: "Konverter",
                destination: .konverter
            )
            Divider()
                .padding(.vertical, 16)
                .padding(.leading, 48)
            MenuItem(
                icon: .settings,
                text: "Settings",
                destination: .settings
            )
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
    
    @ViewBuilder
    private func MenuItem(
        icon: UIImage,
        text: String,
        destination: MainRouter.Destination
    ) -> some View {
        let isSelected: Bool = mainRouter.navGraph.destination == destination
        let bgColor = isSelected ? Color.primaryExtraLight : .background
        let foregroundColor = isSelected ? Color.accentColor : .grayDark
        Button(
            action: {
                mainRouter.replace(destination)
                showSidebar.toggle()
            }
        ) {
            HStack(spacing: 8) {
                Image(uiImage: icon)
                    .renderingMode(.template)
                    .foregroundColor(foregroundColor)
                Text(text)
                    .foregroundColor(foregroundColor)
                    .style(.caption)
                Spacer()
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(bgColor)
            .cornerRadius(20, corners: [.topRight, .bottomRight])
            .padding(.trailing, 16)
        }
    }
}

internal struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

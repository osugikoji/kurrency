//
//  MainRouter.swift
//  ios-app
//
//  Created by Koji Osugi on 12/01/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

internal final class MainRouter: ObservableObject {
    
    static var shared = MainRouter()
    
    private init() {}
    
    enum Destination: Equatable {
        case konverter
        case settings
    }
    
    @Published var navGraph: NavGraph<Destination> = .init(destination: .konverter)
    
    func replace(_ destination: Destination) {
        navGraph.replace(destination, animation: .opacity)
    }
}

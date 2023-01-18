//
//  TransitionAnimation.swift
//  ios-app
//
//  Created by Koji Osugi on 12/01/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

extension AnyTransition {
    
    static var backSlide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .leading),
            removal: .move(edge: .trailing)
        )
    }
    
    static var nextSlide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading)
        )
    }
}

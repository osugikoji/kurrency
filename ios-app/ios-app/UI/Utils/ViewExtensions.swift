//
//  ViewExtensions.swift
//  ios-app
//
//  Created by Koji Osugi on 12/01/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

extension View {
    
    func fullScreen(alignment: Alignment = .top) -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .background(Color.background)
    }
}
